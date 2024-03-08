package com.clubddaegu_admin.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.clubddaegu_admin.common.utils.AWSFileUtil;
import com.clubddaegu_admin.common.utils.Globals;
import com.clubddaegu_admin.common.utils.ResultVO;
import com.clubddaegu_admin.common.utils.Utils;
import com.clubddaegu_admin.model.DailyReport;
import com.clubddaegu_admin.repository.admin.DailyReportMapper;
import com.clubddaegu_admin.security.UserCustom;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class DailyReportService {
	
	@Autowired
	public DailyReportMapper dpMapper;

    public DailyReport getDailyReport(DailyReport dp) {
    	return dpMapper.getDailyReport(dp);
    }

    public DailyReport getYearReport(DailyReport dp) {
    	return dpMapper.getYearReport(dp);
    }
    
    public DailyReport getMonthReport(DailyReport dp) {
    	return dpMapper.getMonthReport(dp);
    }

    /**
     * 일매출 데이터 insert
     * 
     * @param dailyReport
     * @return
     * @throws IllegalStateException
     * @throws IOException
     */
    public ResultVO insertDailyReport(DailyReport dailyReport) throws IllegalStateException, IOException {
       
		ResultVO result = new ResultVO();
		
		try {
			log.debug("[insertDailyReport] dailyReport : {}", dailyReport);
			
			// 이미지 마감여부 변경 
			dpMapper.updateCloseYn(dailyReport);
			
			// 객실단가 
			double tmpRoomPrice = dailyReport.getRoomSales() / dailyReport.getDailyRoomSalesCnt();
			log.debug("tmpRoomPrice : " + tmpRoomPrice);
			long roomPrice = Math.round(tmpRoomPrice);
			log.debug("roomPrice : " + roomPrice);
			
			// 당월실적 
			long monthSales = dailyReport.getRoomSales() + dailyReport.getRestaurantSales() + dailyReport.getEtcSales();
			
			dailyReport.setRoomPrice(roomPrice);
			dailyReport.setMonthSales(monthSales);
					
	        int insCnt = dpMapper.insertDailyReport(dailyReport);
	        dailyReport.setLogDiv("I");
	        dpMapper.insertDailyReportLog(dailyReport);
	       
	        if (insCnt <= 0) {
	        	result.setCode("9999");
	        	result.setMessage("마감 중 오류가 발생했습니다.");
	        }		
		} catch(Exception e) {			
			result.setCode("9999");
			result.setMessage("마감 중 오류가 발생했습니다.");
		}
		return result;
    	
    }
    
    
    /**
     * 일매출리포트 엑셀 파일 읽어오기
	 * >> DB에 insert 하는 작업은 없음
     * 
     * @param file
     * @param dailyReport
     * @return
     * @throws IOException
     * @throws ParseException 
     */
    public DailyReport readDailyReportExcel(MultipartFile file) throws IOException, ParseException {
       
		ResultVO result = new ResultVO();
		DailyReport dailyReport = new DailyReport();
		String fileName = file.getOriginalFilename();
		
        try (InputStream inputStream = file.getInputStream()) {
    		
            // 엑셀 파일을 읽어 XSSFWorkbook으로 로드
            Workbook workbook = new XSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0); // 첫 번째 시트를 가져옴

            Row row_19 = sheet.getRow(18);
            Row row_26 = sheet.getRow(25);
            Row row_43 = sheet.getRow(42);
            Row row_61 = sheet.getRow(60);
            Row row_63 = sheet.getRow(62);
            Row row_76 = sheet.getRow(75);
            Row row_88 = sheet.getRow(87);

            String closeDate = fileName.substring(0, 10).trim().replace(".", "");
            dailyReport.setCloseDate(closeDate);
            log.debug("[uploadDailyReport] 마감일자 : " + closeDate);
            
            // 일 판매객실수 = B77
            Cell cell_1_76 = row_76.getCell(1); 
            String cell_B77 = Utils.getCellValue2(cell_1_76);
            dailyReport.setDailyRoomSalesCnt(Integer.parseInt(cell_B77));
            log.debug("[uploadDailyReport] 일 판매객실수 (B77) : " + cell_B77);
            
            // 매출목표 = F63
            Cell cell_5_63 = row_63.getCell(5); 
            String cell_F63 = Utils.getCellValue2(cell_5_63);
            dailyReport.setDailySalesTarget(Integer.parseInt(cell_F63));
            log.debug("[uploadDailyReport] 매출목표 (F63) : " + cell_F63);
            
            // 매출실적 = B63
            Cell cell_1_63 = row_63.getCell(1); 
            String cell_B63 = Utils.getCellValue2(cell_1_63);
            dailyReport.setDailySalesActual(Integer.parseInt(cell_B63));
            log.debug("[uploadDailyReport] 매출실적 (B63) : " + cell_B63);

            // 객실매출 = B19
            Cell cell_1_19 = row_19.getCell(1); 
            String cell_B19 = Utils.getCellValue2(cell_1_19);
            dailyReport.setRoomSales(Integer.parseInt(cell_B19));
            log.debug("[uploadDailyReport] 객실매출 (B19) : " + cell_B19);

            // 객실단가 = B88
            Cell cell_1_88 = row_88.getCell(1); 
            String cell_B88 = Utils.getCellValue2(cell_1_88);
            dailyReport.setRoomPrice(Integer.parseInt(cell_B88));
            log.debug("[uploadDailyReport] 객실단가 (B88) : " + cell_B88);

            // 식음매출 = B26
            Cell cell_1_26 = row_26.getCell(1); 
            String cell_B26 = Utils.getCellValue2(cell_1_26);
            dailyReport.setRestaurantSales(Integer.parseInt(cell_B26));
            log.debug("[uploadDailyReport] 식음매출 (B26) : " + cell_B26);

            // 기타매출 = B43 + B61
            Cell cell_1_43 = row_43.getCell(1); 
            String cell_B43 = Utils.getCellValue2(cell_1_43);
            
            Cell cell_1_61 = row_61.getCell(1); 
            String cell_B61 = Utils.getCellValue2(cell_1_61);
            
            int etcSales = Integer.parseInt(cell_B43) + Integer.parseInt(cell_B61);
            dailyReport.setEtcSales(etcSales);
            
            log.debug("[uploadDailyReport] 기타매출 (B43 + B61) : " + etcSales);

            // 당월실적 = M63
            Cell cell_12_63 = row_63.getCell(12); 
            String cell_M63 = Utils.getCellValue2(cell_12_63);
            dailyReport.setMonthSales(Integer.parseInt(cell_M63));
            
            log.debug("[uploadDailyReport] 당월실적 (M63) : " + cell_M63);
            
            workbook.close(); // 사용이 끝난 워크북을 닫음
        } catch (IOException e) {
            log.debug("error.." + e.getMessage());
        	e.printStackTrace();
            
            
        }
       
		return dailyReport;
    	
    }
    
    public ResultVO uploadDailyReport(MultipartFile file, DailyReport dailyReport) throws IOException, ParseException {
        
		ResultVO result = new ResultVO();
		String fileName = file.getOriginalFilename();
		
        try (InputStream inputStream = file.getInputStream()) {
    		
            // 엑셀 파일을 읽어 XSSFWorkbook으로 로드
            Workbook workbook = new XSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0); // 첫 번째 시트를 가져옴

            Row row_19 = sheet.getRow(18);
            Row row_26 = sheet.getRow(25);
            Row row_43 = sheet.getRow(42);
            Row row_61 = sheet.getRow(60);
            Row row_63 = sheet.getRow(62);
            Row row_76 = sheet.getRow(75);
            Row row_88 = sheet.getRow(87);

            String closeDate = fileName.substring(0, 10).trim().replace(".", "");
            dailyReport.setCloseDate(closeDate);
            log.debug("[uploadDailyReport] 마감일자 : " + closeDate);
            
            // 일 판매객실수 = B77
            Cell cell_1_76 = row_76.getCell(1); 
            String cell_B77 = Utils.getCellValue2(cell_1_76);
            dailyReport.setDailyRoomSalesCnt(Integer.parseInt(cell_B77));
            log.debug("[uploadDailyReport] 일 판매객실수 (B77) : " + cell_B77);
            
            // 매출목표 = F63
            Cell cell_5_63 = row_63.getCell(5); 
            String cell_F63 = Utils.getCellValue2(cell_5_63);
            dailyReport.setDailySalesTarget(Integer.parseInt(cell_F63));
            log.debug("[uploadDailyReport] 매출목표 (F63) : " + cell_F63);
            
            // 매출실적 = B63
            Cell cell_1_63 = row_63.getCell(1); 
            String cell_B63 = Utils.getCellValue2(cell_1_63);
            dailyReport.setDailySalesActual(Integer.parseInt(cell_B63));
            log.debug("[uploadDailyReport] 매출실적 (B63) : " + cell_B63);

            // 객실매출 = B19
            Cell cell_1_19 = row_19.getCell(1); 
            String cell_B19 = Utils.getCellValue2(cell_1_19);
            dailyReport.setRoomSales(Integer.parseInt(cell_B19));
            log.debug("[uploadDailyReport] 객실매출 (B19) : " + cell_B19);

            // 객실단가 = B88
            Cell cell_1_88 = row_88.getCell(1); 
            String cell_B88 = Utils.getCellValue2(cell_1_88);
            dailyReport.setRoomPrice(Integer.parseInt(cell_B88));
            log.debug("[uploadDailyReport] 객실단가 (B88) : " + cell_B88);

            // 식음매출 = B26
            Cell cell_1_26 = row_26.getCell(1); 
            String cell_B26 = Utils.getCellValue2(cell_1_26);
            dailyReport.setRestaurantSales(Integer.parseInt(cell_B26));
            log.debug("[uploadDailyReport] 식음매출 (B26) : " + cell_B26);

            // 기타매출 = B43 + B61
            Cell cell_1_43 = row_43.getCell(1); 
            String cell_B43 = Utils.getCellValue2(cell_1_43);
            
            Cell cell_1_61 = row_61.getCell(1); 
            String cell_B61 = Utils.getCellValue2(cell_1_61);
            
            int etcSales = Integer.parseInt(cell_B43) + Integer.parseInt(cell_B61);
            dailyReport.setEtcSales(etcSales);
            
            log.debug("[uploadDailyReport] 기타매출 (B43 + B61) : " + etcSales);

            // 당월실적 = M63
            Cell cell_12_63 = row_63.getCell(12); 
            String cell_M63 = Utils.getCellValue2(cell_12_63);
            dailyReport.setMonthSales(Integer.parseInt(cell_M63));
            
            log.debug("[uploadDailyReport] 당월실적 (M63) : " + cell_M63);
            
            dpMapper.insertDailyReport(dailyReport);
            dailyReport.setLogDiv("I");
            dpMapper.insertDailyReportLog(dailyReport);
            
            workbook.close(); // 사용이 끝난 워크북을 닫음
        } catch (IOException e) {
            log.debug("error.." + e.getMessage());
        	e.printStackTrace();
            
            
        }
       
		return result;
    	
    }
    

    public ResultVO uploadDailyReport_old(MultipartFile file) throws IOException {
    	
		ResultVO result = new ResultVO();

        String path = Globals.reportFileRoot;
        UUID randomeUUID = UUID.randomUUID();
                  
        if(file!=null) {
        	String sFileName = file.getOriginalFilename();
        	String sFileNameExtension = sFileName.substring(sFileName.lastIndexOf(".")+1,sFileName.length());
        	  
        	log.debug("[uploadDailyReport] sFileNameExtension : {}", sFileNameExtension);
        	
        	if ( sFileNameExtension.equals("xlsx") ||  sFileNameExtension.equals("xls") ) {
        		
	        	log.debug("[uploadDailyReport] file name : {}", file.getName());
	        	log.debug("[uploadDailyReport] original file name : {}", file.getOriginalFilename());
	
	        	InputStream inputStream = null;
	        	OutputStream outputStream = null;
	
	        	String organizedfilePath="";
	
	        	try {
	        		if (file.getSize() > 0) {
	        			inputStream = file.getInputStream();
	        			File realUploadDir = new File(path);
	
	        			if (!realUploadDir.exists()) {
	        				realUploadDir.mkdirs();	//폴더생성.
	        			}
	
	        			// 저장될 파일명 
	        			organizedfilePath = path + randomeUUID + "_" + file.getOriginalFilename();
	        				
	        			outputStream = new FileOutputStream(organizedfilePath);
	        				
	        			int readByte = 0;
	        			byte[] buffer = new byte[8192];
	        			
	        			while ((readByte = inputStream.read(buffer, 0, 8120)) != -1) {
	        				outputStream.write(buffer, 0, readByte); //파일 생성 ! 
	        				
	        			}
	        			
	        			log.debug("[uploadDailyReport] organizedfilePath : " + organizedfilePath);
	        			// 서버로 파일 경로 전달 
	        			//params.put("excelFile", organizedfilePath);
	        			//params.put("user-id", user.getId().toString());
	        			//String excelResult = httpUtil.restPostStringResult("upload-excel-season-cars", params);

	    	        	//log.debug("[uploadDailyReport] excelResult : {}", excelResult);
	        			
	        			FileInputStream fis = new FileInputStream(organizedfilePath);

	        			HSSFWorkbook workbook = new HSSFWorkbook(fis);

	        			int rowindex = 0;
	        			// int columnindex = 0;
	        			// 시트 수 (첫번째에만 존재하므로 0을 준다)
	        			// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
	        			HSSFSheet sheet = workbook.getSheetAt(0);
	        			// 행의 수
	        			int rows = sheet.getPhysicalNumberOfRows();

	        			log.debug("[uploadDailyReport] rows : {} ", rows);

	        			for (rowindex = 1; rowindex < rows; rowindex++) {
	        				// 행을 읽는다
	        				HSSFRow row = sheet.getRow(rowindex);

	        				if (row != null) {

	    	        			log.debug("[uploadDailyReport] cell : {} ", row.getCell(1).getStringCellValue());
	        				}
	        			}
	        		
	        		}
	
	        	} catch (Exception e) {
	        		// TODO: handle exception
	        		e.printStackTrace();
	
	        	} finally {
	
	        		outputStream.close();
	        		inputStream.close();
	        	}


        	} else {
        		result.setCode("9999");
        		result.setMessage("확장자를 확인해주세요.");
        		
        		return result;
        	}
        }    
		return result;
    	
    }
    
    /**
     * 일매출 삭제
     * 
     * @param dailyReport
     * @return
     */
    public ResultVO deleteDailySales(DailyReport dailyReport) {
        
 		ResultVO result = new ResultVO();

 		// 로그 먼저 쌓고
        dailyReport.setLogDiv("D");
        dpMapper.insertDailyReportLog(dailyReport);
        
        // 삭제 처리 
        int delCnt = dpMapper.deleteDailyReport(dailyReport);
        int delCnt2 = dpMapper.deleteReportPicture(dailyReport);
        
        if (delCnt <= 0 || delCnt2 <= 0) {
        	result.setCode("9999");
        	result.setMessage("마감취소 중 오류가 발생하였습니다.");
        }
        
 		return result;
    }
    
  
    /**
     * 일별마감 이미지 업로드
     * 
     * @param params
     * @param mreq
     * @throws Exception
    	*/
	public ResultVO uploadReportImg(Map<String, Object> params, MultipartHttpServletRequest mreq) throws Exception {

 		ResultVO result = new ResultVO();
 		Iterator<String> iter = mreq.getFileNames();	
 		
		while(iter.hasNext()) {
			// 다음 file[n] 값을 Multipartfile 객체로 생성
			MultipartFile mFile = mreq.getFile(iter.next());			
			 
			// mFile의 파일이름 가져옴
			String orgFileNm = mFile.getOriginalFilename();
			String extNm = orgFileNm.substring(orgFileNm.lastIndexOf(".") + 1, orgFileNm.length()).toLowerCase();
			String newFileNm = System.currentTimeMillis() + "." + extNm;
			
			File sameFile = new File(orgFileNm);					// 똑같은 이름의 파일 객체 생성 (file_name.jpg)
			String filePath = sameFile.getAbsolutePath();			// 실행 중인 working directory + File에 전달한 경로값 (C:\folder_name\file_name.jpg)
			File tmpFile = new File(filePath);						// 절대경로로 다시 파일 객체 생성
			mFile.transferTo(tmpFile);								// 임시파일 객체에 mFile을 복사하면 해당 경로에 파일이 만들어짐
			
			Path srcPath = Paths.get(filePath);						// String을 Path 객체로 만들어줌
		    String mimeType = Files.probeContentType(srcPath);		// 파일 경로에 있는 Content-Type(파일 유형) 확인
		    mimeType = (mimeType == null ? "" : mimeType);			// 확장자가 없는 경우 null을 반환
			
		    String folderNm = "report/" + params.get("closeDate") + "/";			
		    
		    // AWSFileUtil.uploadFile(folderNm, newFileNm, mFile);	// 생성할 폴더명, 새 파일 이름, 복사될 파일 경로
			AWSFileUtil.uploadFile(folderNm, newFileNm, extNm, tmpFile, mimeType);	// 생성할 폴더명, 새 파일 이름, 복사될 파일, 파일타입
									
			// 업로드 후 임시파일 삭제
			if(tmpFile.exists()) tmpFile.delete();
			
			// 이미 같은날짜 이미지 있으면 삭제 후 재업로드..
			DailyReport dailyReport2 = new DailyReport();
			dailyReport2.setCloseYn("N");
			dailyReport2.setCloseDate(params.get("closeDate").toString());
			
			// 해당날짜로 이미지조회 (마감안된)
			dailyReport2 = dpMapper.selectReportPicture(dailyReport2);
			log.debug("[uploadReportImg] 마감되지않은 이미지조회 > " + dailyReport2);
			
			if (dailyReport2 != null) {
				// 삭제
				dpMapper.deleteReportPicture(dailyReport2);
				log.debug("[uploadReportImg] 마감되지않은 이미지 삭제처리");
			}

			DailyReport dailyReport = new DailyReport();
			dailyReport.setCloseDate(params.get("closeDate").toString());
			dailyReport.setImgPath(folderNm);
			dailyReport.setImgName(newFileNm);

			log.debug("[uploadReportImg] imgUrl : " + Globals.endPoint + "/" + Globals.bucketName + "/" + folderNm + newFileNm);
			result.setData(Globals.endPoint + "/" + Globals.bucketName + "/" + folderNm + newFileNm);
			dpMapper.insertReportPicture(dailyReport);
			
		}		
		
		return result;
	}
	
	public DailyReport selectReportPicture(DailyReport dailyReport) {

		return dpMapper.selectReportPicture(dailyReport);
	}
}
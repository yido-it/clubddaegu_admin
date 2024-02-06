package com.clubddaegu_admin.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.util.List;
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

    /**
     * 일매출 데이터 insert
     * 
     * @param dailyReport
     * @return
     */
    public ResultVO insertDailyReport(DailyReport dailyReport) {
       
		ResultVO result = new ResultVO();
		
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
        if (delCnt <= 0) {
        	result.setCode("9999");
        	result.setMessage("마감취소 중 오류가 발생하였습니다.");
        }
        
 		return result;
    }
}
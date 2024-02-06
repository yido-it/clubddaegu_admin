package com.clubddaegu_admin.component;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class FileUtil {

	@Value("${file.root}")
    static String rootDir = "";

    @Value("${file.root}")
    private void setValue(String fileRoot){
    	rootDir = fileRoot + "/";
    }

    /**
	 * 파일 업로드
	 */
    public static void uploadObject(String projectNm, String folderName, String objectName, String filePath) throws IOException {
    	//projectNm = "safed";
    	//folderName = "AA00" + "/" + 1 + "/" + 202004 + "/" + "eval";
    	//objectName = System.currentTimeMillis() + extName;
    	//filePath = convFile.getAbsolutePath();

    	String fullPath = null;
//    	folderName = folderName.replaceAll("/", "\\\\");
		fullPath = folderName + "/" + objectName;
//		fullPath = fullPath.replaceAll("/", "\\\\");

		makeDir(folderName);
		log.debug(folderName);
		log.debug(filePath);
		log.debug(fullPath);

		writeFile(filePath, fullPath);

		String[] tempName = objectName.split("\\.");
		String ext = "."+tempName[1];
		log.debug(ext);

		if (ext.equals(".png") || ext.equals(".jpg") || ext.equals(".jpeg")) {
			ImageUtil.reduceImg(rootDir + folderName + "/", rootDir + "/thumb/" + folderName + "/", ext, objectName);
		}

    }

    /**
	 * 파일 생성
	 */
    private static boolean writeFile(String filePath, String saveFileName) throws IOException{
		boolean result = false;
		//byte[] data = multipartFile.getBytes();
		byte[] data = Files.readAllBytes(new File(filePath).toPath());

		FileOutputStream fos = new FileOutputStream(rootDir + saveFileName);

		fos.write(data);
		fos.close();

		return result;
	}

    /**
     * 파일 삭제
     */
    public static void deleteObject(String folderName, String objectName) {
    	File file = new File("/usr/local" + folderName + "/" + objectName);
    	if(file.exists()) file.delete();
    }

    /**
     * 폴더 생성
     */
	public static void makeDir(String... paths) {

		if(new File(rootDir + paths[paths.length - 1]).exists()){
			return;
		}

		for(String path : paths){
			File dirPath = new File(rootDir + path);

			if(!dirPath.exists()){
				dirPath.mkdirs();
			}
		}
	}

}

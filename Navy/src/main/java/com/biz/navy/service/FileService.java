package com.biz.navy.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FileService {

	// servlet-context에 bean으로 설정된 filePath에 있는 경로를 가져온다.
	private final String filePath;
	
	@Autowired
	public FileService(String filePath) {
		super();
		this.filePath = filePath;
	}

	public String file_up(MultipartFile mFile) {
		
		log.debug("파일서비스 파일 경로 : "+filePath);
		
		
		if(mFile == null) {
			return null;
		}
		
		// 폴더 객체 생성
		File dir = new File(filePath);
		
		// 폴더가 없다면
		if(!dir.exists()) {
			// c:/bizwork/files
			// bizwork 폴더가 있고, files 폴더만 없을 때
			dir.mkdir();
			
			// bizwork 폴더도 없고, files 폴더를 찾을 수 없을 때
			// 모든 경로를 생성
			dir.mkdirs();
		}
		
		String strUUID = UUID.randomUUID().toString();
		
		String originalName = mFile.getOriginalFilename();
		
		String upLoadFileName = strUUID + originalName;
		
		// 업로드할 파일 객체 생성
		// 파일 경로와 UUID가 추가된 파일 이름을 같이 사용하기
		File upLoadFile = new File(filePath,upLoadFileName);
			
		try {
			// 실제로 서버에 저장하는 코드
			
			mFile.transferTo(upLoadFile);
			return upLoadFileName;
			
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public void file_delete(String img_file) {

		// filePath : /bizwork/files/
		// img_file : aaa.jpg 라고 한다면
		// 결과값 : /bizwork/files/aaa.jpg 라는 형식으로 생성한다.
		File file = new File(filePath, img_file);
		if(file.exists()) {
			file.delete();
		}
		
	}
	
}
package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {
	
	//Delete File
	public static boolean deleteFile(String path) {
		boolean status = false;
		try {
			
			File file = new File(path);
			status = file.delete();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return status;
	}
	
	//Save File
	public static boolean saveFile(InputStream io, String path) {
		boolean status = false;
		try(FileOutputStream fos = new FileOutputStream(path)){
			
			byte b[] = new byte[io.available()];
			io.read(b);
			fos.write(b);
			
			status = true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return status;
	}
}

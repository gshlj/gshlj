package testFuture;

import java.nio.file.Files;
import java.nio.file.Paths;

public class Complior {

	static String filepath = "D:\\gs\\Desktop\\TMP.txt";

	public static void main(String[] args) {

		try {
			String content = new String(Files.readAllBytes(Paths.get(filepath)));
			if (filepath.endsWith(".txt")) {
				content = content.replace("\r", "");//
				content = content.replace("\n", "");
				for (int i = 0; i < 10; i++)
					content = content.replace(" ", "");
				
				content = content.replace( "#AA","-");
				content = content.replace( "#44","m");
				content = content.replace( "#DD","=");
				content = content.replace( "#AV","d");
				content = content.replace( "#4D","<");
				content = content.replace( "#D4","!");
				content = content.replace( "#4V","+");
				
				content = content.replace( "#Y","1");
				content = content.replace( "#y","1");
				content = content.replace( "#J","rn");
				content = content.replace( "#G","|");
				content = content.replace( "#E","O");
				
				content = content.replace( "#C","o");
				content = content.replace( "#c","o");
				content = content.replace("#X","I");
				content = content.replace( "#F","[");
				content = content.replace("#K","]");
				content = content.replace("#H",".");
				content = content.replace("#U","i");
				content = content.replace("#u","i");//
				content = content.replace("#P","l");
				content = content.replace("#p","l");
				content = content.replace("#Z","0");
				content = content.replace("#B","\n");
				content = content.replace( "#T","	");
				content = content.replace("#N","int");
				content = content.replace("#D","\"");
				content = content.replace("#S","'");
				content = content.replace( "#V","}");
				content = content.replace( "#A","{");
				content = content.replace( "#R",")");
				content = content.replace("#L","(");
				content = content.replace("	"," ");
			} else {
				content = content.replace(" ", "	");
				for (int i = 0; i < 20; i++)
					content = content.replace("		", "	");
				content = content.replace("(", "#L");
				content = content.replace(")", "#R");
				content = content.replace("{", "#A");
				content = content.replace("}", "#V");
				content = content.replace("'", "#S");
				content = content.replace("\"", "#D");
				content = content.replace("int", "#N");
				content = content.replace("	", "#T");
				content = content.replace("\n", "#B");
				content = content.replace("0", "#Z");
				content = content.replace("l", "#P");
				content = content.replace("i", "#U");
				content = content.replace(".", "#H");
				content = content.replace("]", "#K");
				content = content.replace("[", "#F");
			}
			System.out.println(content);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}

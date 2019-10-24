package Future;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.LinkedList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.mathworks.toolbox.javabuilder.MWException;

import mySum.Class1;

public class test {
	
	
	public static void main(String[] args) {
		
		 /*try {
	            Class1 myClass1 = new Class1();
	            Object[] result = myClass1.mySum(1,1,3);
	            System.out.println(result[0]);
	        } catch (MWException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }*/
		 
		try {
			List<double[]> list = new LinkedList<double[]>();
			BufferedReader reader = new BufferedReader(new FileReader("D:\\gs\\Desktop\\test.txt"));
			String line = null;
			while ((line = reader.readLine()) != null) {
				String [] items = line.split(",");
				int len = items.length;
				double [] itemd = new double[len];
				for(int i = 0 ; i < len ; i++){
					itemd[i] = Double.parseDouble(items[i]);
				}
				list.add(itemd);
			}
			double [][] data = new double[list.size()][];
			list.toArray(data);
			System.out.println(1);
			
		    	 /*BufferedWriter writer = new BufferedWriter(new FileWriter("D:\\gs\\Desktop\\aib\\ex\\future\\"));
		    	 for(int i =1 ; ; i++){
		    		// Thread.sleep(1000);
		    		 URL urI = new URL(url+d+"/yysj/sc/"+i+".html");
						// HttpURLConnection oConn = (HttpURLConnection)
						// urI.openConnection(proxy);
						HttpURLConnection oConn = (HttpURLConnection) urI.openConnection();
						oConn.setConnectTimeout(5000);
						oConn.connect();
						InputStream is = oConn.getInputStream();
						BufferedReader br = new BufferedReader(new InputStreamReader(is));
						String line = null;
						StringBuffer content = new StringBuffer("");
						while ((line = br.readLine()) != null) {
							content.append(line);
						}
						Document doc = Jsoup.parse(content.toString());
						//String title = doc.title();
						//System.out.println(title);
						Element tbody = doc.getElementById("dt_1").getElementsByTag("tbody").get(0);
						Elements trs = tbody.getElementsByTag("tr");
						if(trs.size() == 0)
							break;
						for(Element tr : trs){
							Elements td = tr.getElementsByTag("td");
							writer.write(td.get(0).text()+","+td.get(2).text().replace("-", "")+","+td.get(6).text().replace("-", "")+"\n");
						}
			    writer.close();
		    }*/
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

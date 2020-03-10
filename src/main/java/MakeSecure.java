import java.io.PrintWriter;
import java.util.Map;
import java.util.Scanner;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

public class MakeSecure {
	
	
	//　環境変数セッティング後必ずrestart
	
	private final static String saltPass = "";
	
	
	
	public static void main(String[] args) {
		
		Scanner scan = new Scanner(System.in);
		
		StandardPBEStringEncryptor sPBEEnc = new StandardPBEStringEncryptor();
		
		Map<String,String> envList = System.getenv();
		
		System.out.println("UserID >> " );
		String userId = scan.nextLine();
		
		System.out.println("Password >> ");
		String password = scan.nextLine();
		
		
		
		String envString = envList.get("ORACLE_PASS");
		if(envString == null) envString = saltPass;
		
		
		sPBEEnc.setAlgorithm("PBEWithMD5AndDES");
		sPBEEnc.setPassword(envString);
		
		String encUserId = sPBEEnc.encrypt(userId);
		String encPassword = sPBEEnc.encrypt(password);
		
		System.out.printf("userId : %s, %s\n", userId, encUserId);
		System.out.printf("password : %s, %s\n", password, encPassword);
		
		
		String strUserId = String.format("oracle.username=ENC(%s)", encUserId);
		String strPassword = String.format("oracle.password=ENC(%s)", encPassword);
		
		String proFileName = "./src/main/webapp/WEB-INF/spring/appServlet/db.user.properties";
		
		
		try {
			
			PrintWriter pw = new PrintWriter(proFileName);
			pw.println(strUserId);
			pw.println(strPassword);
			pw.flush();
			pw.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		scan.close();
	}

}

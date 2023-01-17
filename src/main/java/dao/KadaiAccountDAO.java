package dao;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.KadaiAccount;
import dto.KadaiAccountList;
import util.GenerateHashedPw;
import util.GenerateSalt;

public class KadaiAccountDAO {
	private static Connection getConnection() throws URISyntaxException, SQLException {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	    URI dbUri = new URI(System.getenv("DATABASE_URL"));

	    String username = dbUri.getUserInfo().split(":")[0];
	    String password = dbUri.getUserInfo().split(":")[1];
	    String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();

	    return DriverManager.getConnection(dbUrl, username, password);
	}
	
	public static int registerKadaiAccount(KadaiAccount account) {
		String sql = "INSERT INTO kadaiaccount VALUES(default, ?, ?, ?, ?, ?, ?, ?, current_timestamp)";
		int result = 0;
		
		// ランダムなソルトの取得(今回は32桁で実装)
		String salt = GenerateSalt.getSalt(32);
		
		// 取得したソルトを使って平文PWをハッシュ
		String hashedPw = GenerateHashedPw.getSafetyPassword(account.getPw(), salt);
		
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setString(1, account.getName());
			pstmt.setString(2, account.getAge());
			pstmt.setString(3, account.getGender());
			pstmt.setString(4, account.getPhone());
			pstmt.setString(5, account.getEmail());
			pstmt.setString(6, salt);
			pstmt.setString(7, hashedPw);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		} finally {
			System.out.println(result + "件更新しました。");
		}
		return result;
		}
	
	public static List<KadaiAccountList> SelectAllAccount(){
		String sql = "SELECT * FROM kadaiaccount";
		
		List<KadaiAccountList> result = new ArrayList<>();
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			
			try (ResultSet rs = pstmt.executeQuery()){
				
				while(rs.next()) {
					int id = rs.getInt("id");
					String name = rs.getString("name");
					String age = rs.getString("age");
					String gender = rs.getString("gender");
					String phone = rs.getString("phone");
					String email = rs.getString("email");
					
					KadaiAccountList account = new KadaiAccountList(id,name,age,gender,phone,email);
					
					result.add(account);
				}
			}
			} catch (SQLException e) {
				e.printStackTrace();
			}catch (URISyntaxException e) {
				e.printStackTrace();
			}

		// Listを返却する。0件の場合は空のListが返却される。
		return result;
		}
	
	public static String getSalt(String email) {
		String sql = "SELECT salt FROM kadaiaccount WHERE email = ?";
		

		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setString(1,email);
			
			
			try (ResultSet rs = pstmt.executeQuery()){
				
				if(rs.next()) {
					String salt = rs.getString("salt");
					return salt;
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static KadaiAccount login(String email,String hashedPw) {
		String sql = "SELECT * FROM kadaiaccount WHERE email = ? AND password = ?";
		
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setString(1, email);
			pstmt.setString(2, hashedPw);
			

			try (ResultSet rs = pstmt.executeQuery()){
				
				if(rs.next()) {
					int id = rs.getInt("id");
					String name = rs.getString("name");
					String salt = rs.getString("salt");
					String createdAt = rs.getString("created_at");
					
					return new KadaiAccount(id, name, null, null, null, null, salt, null,createdAt );
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return null;
		
	}
}

package PtUser;
import common.DBConnPool;

import java.sql.SQLException;

public class UserDAO extends DBConnPool {

    public UserDAO() {
        super();
    }

    public UserDTO getUserDTO(String userId, String password) {
        /*로그인*/

        UserDTO dto = new UserDTO();

        try {
            String query = " SELECT * FROM c##pro.users WHERE user_id = ? AND password = ?";
            psmt = con.prepareStatement(query);
            psmt.setString(1, userId);
            psmt.setString(2, password);
            rs = psmt.executeQuery();

            while (rs.next()) {
                dto.setUser_id(rs.getString("user_id"));
                dto.setPassword(rs.getString("password"));
                dto.setName(rs.getString("name"));
                dto.setCountry(rs.getString("country"));
                dto.setEmail(rs.getString("email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(); // 자원 해제
        }
        return dto;
    }

    public int addminMember(UserDTO dto) {
        //회원가입
        int result = 0;

        try {
            String query = " INSERT INTO c##pro.users(user_id, name, password, country, email) VALUES (?, ?, ?, ?, ?)";
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getUser_id());
            psmt.setString(2, dto.getName());
            psmt.setString(3, dto.getPassword());
            psmt.setString(4, dto.getCountry());
            psmt.setString(5, dto.getEmail());
            result = psmt.executeUpdate();
            System.out.println(result);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("addminMember 오류발생");
        }

        return result;
    }

    public String findld(String name, String email) {
        /*아이디 찾기*/
        UserDTO dto = new UserDTO();
        String id = "";

        try {
            String query = " SELECT user_id FROM c##pro.users WHERE name=? AND email=?";
            psmt = con.prepareStatement(query);
            psmt.setString(1, name);
            psmt.setString(2, email);

            rs = psmt.executeQuery();

            if (rs.next())
                id = rs.getString("user_id");

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("아이디 찾기 오류 발생");
        }
        return id;
    }

    public boolean check(UserDTO dto) {
        boolean result = false;

        String sql = "SELECT user_id FROM c##pro.users WHERE user_id=?";
        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, dto.getUser_id());

            rs = psmt.executeQuery();

            result = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("아이디중복확인실패");

        }
        return result;
    }
}









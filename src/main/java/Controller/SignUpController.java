package Controller;


import PtUser.UserDAO;
import PtUser.UserDTO;
import util.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/01/SignUp.do")
public class SignUpController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        UserDTO dto = new UserDTO();
        String command = req.getParameter("command");

        if(command != null && command.equals("addMember")){
            String name =req.getParameter("name");
            String id =req.getParameter("id");
            String password =req.getParameter("password");
            String country =req.getParameter("country");
            String email =req.getParameter("email");


            dto.setName(name);
            dto.setUser_id(id);
            dto.setPassword(password);
            dto.setCountry(country);
            dto.setEmail(email);
        }

        UserDAO dao = new UserDAO();
        int result = dao.addminMember(dto);
        dao.close();


        if(result == 1) {
            req.getRequestDispatcher("/TfBottle/MainPage.jsp").forward(req,resp);
        }else  {
            JSFunction.alertBack(resp,"이미 사용중인 아이디입니다.");
        }
    }
}

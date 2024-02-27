package Controller;


import PtUser.UserDAO;
import PtUser.UserDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.JSFunction;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/member/idCheck.do")
public class IdCheckController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

            UserDTO dto = new UserDTO();
        String id = req.getParameter("id");
        dto.setUser_id(id);

        UserDAO dao = new UserDAO();
        boolean result = dao.check(dto);


        PrintWriter out = resp.getWriter();
        out.print(result);

    }
}


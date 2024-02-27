package Controller;

import PtBoard.BoardDAO;
import PtBoard.BoardDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.JSFunction;

import java.io.IOException;
import java.util.Date;

@WebServlet("/mvcboard/viewController.do")
public class ViewController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 편지 불러오기
        BoardDAO dao = new BoardDAO();
        BoardDTO dto = dao.selectRandomPage();

        if(dto.getContents() !=null){
            dto.setContents(dto.getContents().replaceAll("\r\n", "<br/>"));
            req.setAttribute("dto", dto); // JSP 페이지로 dto 객체를 전달합니다.
            req.getRequestDispatcher("/TfBottle/LetterView.jsp").forward(req, resp);
        }else{
            JSFunction.alertLocation(resp, "작성된 글이 없습니다..",
                    "/TfBottle/MainPage.jsp");
        }
        dao.close();
    }
}

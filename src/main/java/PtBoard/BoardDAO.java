package PtBoard;

import common.DBConnPool;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class BoardDAO extends DBConnPool {

    public BoardDAO() {
        super();
    }


    public int insertWrite(BoardDTO dto) {
        int result = 0;
        //DB에 BOARD테이블에 맞춰서 작성
        try {
            String query = " INSERT INTO c##pro.board ( "
                    + " board_id, title, contents, user_id, post_date)"
                    + " VALUES ("
                    + " c##pro.seq_bottle_num.nextval, ?,?,?,sysdate)";

            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getContents());
            psmt.setString(3, dto.getUser_id());

            //반환 값으로  , executeUpdate() 반환값은 숫자
            result = psmt.executeUpdate();
            System.out.println("반환값 확인" + result);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("insertWrite 오류발생");
        }
        return result;
    }


    // 랜덤 페이지
    public BoardDTO selectRandomPage() {
        BoardDTO dto = new BoardDTO();
        String query = "SELECT * FROM (SELECT * FROM c##pro.BOARD order by DBMS_RANDOM.RANDOM) WHERE rownum < 2";

        try {
            psmt = con.prepareStatement(query);
            rs = psmt.executeQuery();

            if (rs.next()) {
                //데이터 추출 및 저장
                dto.setBoard_id(rs.getString("board_id"));
                dto.setTitle(rs.getString("title"));
                dto.setContents(rs.getString("contents"));
                dto.setUser_id(rs.getString("user_id"));
                dto.setPost_date(rs.getDate("post_date"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("selectRandomPage 에러발생");
        }
        return dto;
    }

    // 검색 조건에 맞는 게시물의 개수를 반환한다.
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0;

        String query = "SELECT COUNT(*) FROM c##pro.board";
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                    + " LIKE '%" + map.get("searchWord") + "%'";
        }

        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);
            rs.next();
            totalCount = rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
            ;
            System.out.println("mvcboard selectCount 오류발생");
        }

        return totalCount;
    }

    // 게시물 목록 가져오기
    public List<BoardDTO> selectListPage(Map<String, Object> map) {
        List<BoardDTO> bbs = new ArrayList<BoardDTO>(); // 결과(게시물 목록)를 담을 변수

        // 쿼리문 템플릿 (1)
        String query = " SELECT * FROM ( "
                + " SELECT Tb.*, ROWNUM rNum FROM ("
                + " SELECT * FROM c##pro.BOARD ";

        // 검색 조건 추가 (2)
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                    + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        query += " ORDER BY board_id desc"
                + "     ) Tb "
                + " ) "
                + " WHERE rNUM BETWEEN ? AND ?";

        try {
            // 쿼리문 완성 (4)
            psmt = con.prepareStatement(query);
            psmt.setString(1, map.get("start").toString());
            psmt.setString(2, map.get("end").toString());

            // 쿼리문 실행 (5)
            rs = psmt.executeQuery();

            while (rs.next()) {
                // 한 행(게시물 하나)의 데이터를 DTO에 저장
                BoardDTO dto = new BoardDTO();
                dto.setBoard_id(rs.getString("board_id"));
                dto.setTitle(rs.getString("title"));
                dto.setContents(rs.getString("contents"));
                dto.setPost_date(rs.getDate("post_date"));
                dto.setUser_id(rs.getString("user_id"));

                // 반환할 결과 목록에 게시물 추가
                bbs.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("MVCBoard selectList 오류발생");
        }
        // 목록 반환
        return bbs;
    }

    public BoardDTO selectView(String board_id) {
        BoardDTO dto = new BoardDTO();

        try {
            String query = "SELECT B.* , U.name"
                    + " FROM c##pro.board B"
                    + " INNER JOIN c##pro.users U"
                    + " ON B.user_id = U.user_id"
                    + " WHERE board_id = ?";

            psmt = con.prepareStatement(query);
            psmt.setString(1, board_id);
            rs = psmt.executeQuery();

            if (rs.next()) {
                dto.setBoard_id(rs.getString("board_id"));
                dto.setTitle(rs.getString("title"));
                dto.setContents(rs.getString("contents"));
                dto.setUser_id(rs.getString("user_id"));
                dto.setUser_Name(rs.getString("name"));
                dto.setPost_date(rs.getDate("post_date"));
            }
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("selectView 오류발생");
        }
        return dto;
    }

    // 게시글 데이터를 받아 DB에 저장되어 있던 내용을 갱신한다
    public int updateEdit(BoardDTO dto) {
        int result = 0;

        String query = " UPDATE c##pro.board"
                + " SET title = ? , contents = ?"
                + " WHERE board_id = ?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getContents());
            psmt.setString(3, dto.getBoard_id());

            result = psmt.executeUpdate();

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println("updateEdit 오류 발생");
        }
        return result;
    }

    // 주어진 일련번호의 게시글 삭제
    public int deletePost(String board_id) {
        int result = 0;

        String query = " DELETE FROM c##pro.board WHERE board_id = ?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, board_id);
            result = psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("deletePost 오류발생");
        }

        return result;
    }
}



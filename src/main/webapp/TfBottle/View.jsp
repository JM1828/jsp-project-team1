<%@ page import="PtBoard.BoardDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>

    <link rel="stylesheet" href="/TfCSS/View.css">
    <link rel="preconnect" href="https://fonts.googleapis.com%22%3E/
    <link rel=" preconnect
    " href="https://fonts.gstatic.com/" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;600&display=swap" rel="stylesheet">

    <meta charset="UTF-8">
    <title> 게시판</title>
    <%--버튼 클릭시 정말 삭제할꺼냐고 물어보는 스크립트--%>
    <script>
        function confirmDelete(board_id) {
            if (confirm('정말 삭제하시겠습니까?')) {
                // 삭제되면 get 방식으로 delete.do 매핑
                location.href = '../mvcboard/delete.do?board_id=' + board_id;
            }
        }
    </script>
</head>
<body>

<%--로고--%>
<nav class="linavbar">
    <div class="linavbar_logo">
        <%--<img src="경로" alt="예시 이미지">--%>
        <i class="lifab fa-accusoft"></i>
        <a href="../TfBottle/MainPage.jsp">1일 1편지</a>
    </div>
    <%--메뉴--%>
    <ul class="linavbar_menu">
        <li><a href="../TfBottle/MainPage.jsp">Home</a></li>
        <%--로그인 상태에 따라--%>
        <% if (session.getAttribute("user_id") == null) { %>
        <li><a href="../TfBottle/Login.jsp">로그인</a></li>
        <li><a href="../TfBottle/SignUp.jsp">회원가입</a></li>
        <% } else { %>
        <li><a href="../TfBottle/Logout.jsp">로그아웃</a></li>
        <% } %>
    </ul>
</nav>

<div class="letter">
    <!-- 게시글 정보 -->
    <div class="lettertitle">
        <table>
            <tr>
                <th>${dto.title}</th>
            </tr>
        </table>
    </div>

    <div class="letterwirter">
        <table>
            <tr>
                <td>아이디. ${dto.user_id}</td>
            </tr>
        </table>
    </div>

    <div class="lettercontents">
        <table class="contentstb">
            <tr>
                <td class="aa">${dto.contents}</td>
            </tr>
        </table>
    </div>

    <div class="letterdate">
        <table>
            <tr class="letterdate">
                <td>${dto.post_date}</td>
            </tr>
        </table>
    </div>
</div>
<div class="button-group">
    <table border="1" width="100%">
        <!-- 하단 메뉴(버튼) -->
        <tr>
            <td colspan="4" align="center">
                <%-- 로그인 했을때 session 영역에 저장된 아이디와 게시판 장석자 아이디와 동일하면 보이기 --%>
                <%
                    BoardDTO dto = (BoardDTO) request.getAttribute("dto");
                    if (session.getAttribute("user_id") != null &&
                            session.getAttribute("user_id").toString().equals(dto.getUser_id())) {
                %>
                <%-- 게시글 수정 클릭시 edit.do에 get방식으로 보내기 --%>
                <button type="button" onclick="location.href = '/mvcboard/edit.do?board_id=${dto.board_id}';">
                    게시글 수정
                </button>
                <%-- 게시글 삭제 클릭시 스크립트 confirmDelete 함수 수행 --%>
                <button type="button" onclick="confirmDelete('${ dto.board_id }');">
                    게시글 삭제
                </button>
                <%
                    }
                %>
                <%-- 목록 바로가기 버튼 클릭시 list.do 로 매핑 --%>
                <button type="button" onclick="location.href='../mvcboard/list.do';">
                    목록 바로가기
                </button>
            </td>
        </tr>
    </table>
</div>
<footer>
    <div class="footer-wrapper">
        <div class="footer-section">
            상호명 : 1조<br/>
            대표자 : 송재현<br/>
            사업자등록번호 : 344-73-00485<br/>
            통신판매업번호 : 제1234-부산-5678호<br/>
        </div>
        <div class="footer-section">
            메일 : dnduddl1381@gmail.com<br/>
            사업장 : 부산 부산진구 중앙대로 708 부산파이낸스센터 503호<br/>
            전화 : 070-1234-5678<br/>
        </div>
        <div class="footer-section">
            <a href="#">이용약관</a><br/>
            <a href="#">개인정보취급방침</a><br/>
            <a href="#">운영정책</a><br/>
            <a href="#">PartnerCenter</a><br/>
        </div>
        <div class="footer-section">
            호스팅제공 부산IT교육센터<br/>
        </div>
    </div>
    <p class="footerp">Copyright © 2024 1일 1편지. All right reserved.</p><br/>
</footer>
</body>
</html>
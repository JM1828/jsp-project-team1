<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/TfCSS/List.css">
    <style>
        a {
            text-decoration: none;
        }
    </style>
</head>
<body>
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
<div class="write" style="position: relative; z-index: 10;">
    <div class="list">
        <h2 class="listtitle">편지 목록</h2>
        <%--검색 폼--%>
        <form method="get">
            <table border="1" width="90%">
                <tr>
                    <td align="center">
                        <select name="searchField">
                            <option value="title">제목</option>
                        </select>
                        <input type="text" name="searchWord">
                        <input type="submit" value="검색">
                    </td>
                    <td>
                        <%--
                                            <form action="/mvcboard/write.do" method="get">
                        --%>
                        <button class="writerbutton"><a class="abutton" href="/mvcboard/write.do" methods="get">편지
                            쓰기</a></button>
                        <%--</form>--%>
                    </td>
                </tr>
            </table>
        </form>

        <%--게시물 목록 테이블--%>
        <table border="1" width="90%">
            <tr>
                <th width="10%">번호</th>
                <th width="*">제목</th>
                <th width="15%">아이디</th>
                <th width="15%">작성일</th>
            </tr>
            <c:choose>
                <c:when test="${empty boardList}"><%--게시글이 없을때--%>
                    <tr>
                        <td colspan="4" align="center">
                            등록된 게시물이 없습니다.
                        </td>
                    </tr>
                </c:when>
                <c:otherwise> <%--게시글이 있을때--%>
                    <c:forEach items="${boardList}" var="dto" varStatus="loop">
                        <%-- 현재 페이지의 목록에서 각 항목의 역순 번호를 계산하는 데 사용 --%>
                        <tr align="center">
                            <td>${map.totalCount - (((map.pageNum-1)*map.pageSize) + loop.index)}</td>
                            <td align="left">
                                    <%-- 게시글 제목 클릭스 viewServlet.do로 매핑 --%>
                                <a href="../mvcboard/viewServlet.do?board_id=${dto.board_id}">${dto.title}</a>
                            </td>
                            <td>${dto.user_id}</td>
                            <td>${dto.post_date}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </table>
        <div class="paging">
            <table class="paging" border="1" width="90%">
                <tr>
                    <td>
                        ${map.pagingImg}
                    </td>
                </tr>
            </table>
        </div>
    </div>
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

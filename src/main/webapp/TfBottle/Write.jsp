<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="IsLoggedIn.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>편지 작성</title>
    <link rel="stylesheet" href="/TfCSS/Write.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;600&display=swap" rel="stylesheet">
    <%--유효성 검증 스크립트--%>
    <script type="text/javascript">
        function validateForm(form) {
            if (!form.title.value) {
                alert("제목을 입력 하세요");
                form.title.focus();
                return false;
            }
            if (!form.contents.value) {
                alert("내용을 입력 하세요");
                form.contents.focus();
                return false;
            }
        }

        function countChar(val) {
            var len = val.value.length;
            document.getElementById('charNum').innerHTML = '글자수 : ' + len;
        };
    </script>
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
    <form name="writeFrm" method="post" action="/mvcboard/write.do" onsubmit="return validateForm(this)">
        <div class="title-wrapper">
            <h2>편지 작성</h2>
        </div>
        <div class="writeboxwrap">
            <table class="writebox">
                <tr>
                    <td>제목</td>
                    <td>
                        <input type="text" name="title"/>
                    </td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td>
                        <textarea name="contents" class="content" onkeyup="countChar(this)"></textarea>
                        <div id="charNum"></div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="button-group">
            <button type="submit">작성 완료</button>
            <button type="reset">다시 입력</button>
            <button type="button" onclick="location.href='/mvcboard/list.do';">목록 보기</button>
        </div>
    </form>
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
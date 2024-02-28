<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
    <link rel="stylesheet" href="/TfCSS/Login.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;600&display=swap" rel="stylesheet">
</head>
<body class="lobody">
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
<%
    String LoginErrMsg = (String) session.getAttribute("LoginErrMsg");
    if (LoginErrMsg != null) {
        session.removeAttribute("LoginErrMsg");
%>
<script>
    alert('<%= LoginErrMsg %>');
</script>
<%
    }
%>
<script>
    function validateForm(form) {
        if (!form.user_id.value) {
            alert("아이디를 입력하세요.");
            return false;
        }
        if (!form.user_pw.value) {
            alert("비밀번호를 입력하세요.");
            return false;
        }
    }

    // 페이지가 로드될떄 모든 쿠키를 확인하고 user_id 라는 이름에 쿠키가 있을경우
    // 체크박스를 체크하고 아이디 입력 필드에 쿠키의 값을 채움
    window.onload = function () {
        var cookies = document.cookie.split("; ");
        for (var i = 0; i < cookies.length; i++) {
            var cookie = cookies[i].split("=");
            if (cookie[0] === "user_id") {
                document.getElementById("remember-check").checked = true;
                document.getElementsByName("user_id")[0].value = cookie[1];  // 아이디 입력 필드를 채움

            }
        }
        // 체크박스 해제되었을 경우 user_id 입력 필드의 값이 비워진다.
        document.getElementById("remember-check").addEventListener("change", function () {
            if (!this.checked) {
                // 쿠키는 만료 날짜가 지나면 자동 삭제
                // 따라서 쿠키를 삭제하며면 만료 날짜를 과거로 설정하면됨
                // user_id라는 이름의 쿠키의 만료 날짜를 1970년 1월 1일 00:00:00 UTC로 설정하여 쿠키를 즉시 삭제
                document.cookie = "user_id=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
                document.getElementsByName("user_id")[0].value = "";
            }
        });
    }
</script>

<div class="lobody">
    <div class="container">
        <div class="login-wrapper">
            <h2>로그인</h2>
            <form action="/pro/login.do" method="post" name="loginFrm"
                  onsubmit="return validateForm(this);">
                <input type="text" name="user_id" placeholder="ID"/><br/>
                <input type="password" name="user_pw" placeholder="Password"/><br/>
                <label for="remember-check">
                    <input type="checkbox" name="remember-check" id="remember-check">아이디 저장하기
                </label>
                <input type="submit" value="로그인"/>
            </form>
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
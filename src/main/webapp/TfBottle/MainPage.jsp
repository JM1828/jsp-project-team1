<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<html>

<head>
  <meta charset='utf-8'>
  <meta name="viewport"
        content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
  <title>메인페이지</title>
  <link rel="stylesheet" href="/TfCSS/MainPage.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;600&display=swap" rel="stylesheet">
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
    <% }else { %>
    <li><a href="../TfBottle/Logout.jsp">로그아웃</a></li>
    <% } %>
    <li><a href="../TfBottle/SignUp.jsp">회원가입</a></li>
  </ul>
</nav>
<div class="mainpic">


<%
  boolean canReceiveLetter = true; //편지를 읽을 변수선언 값은 true
  Cookie[] cookies = request.getCookies(); // 쿠키 배열을 생성함 이름은 cookies
  if (cookies != null) {  //if 쿠키가 있으면
    for (Cookie cookie : cookies) { //for문으로 cookies에 cookie를 하나씩 모두 담는다
      if (cookie.getName().equals("receiveCooldown")) { //담는와중에 쿠키의 이름이 "reciveCooldown" 인 쿠키가 발견되면
        canReceiveLetter = false; // 편지를 읽을 변수의값이 false가된다
        break; // 즉 reciveCooldown 이라는 쿠키를 찾을때까지 계속 무한반복(for문)이 돈다
      }
    }
  }
%>
  <div class="buttonwrap">
    <ul>
      <li>
        <form action="/mvcboard/write.do" method="get">
          <button class="birdbutton" type="submit" name="action" value="login">
            <img src="/img/realwrite.png">
          </button>
        </form>
      </li>
      <%--쿠키를 이용한 편지 받기 버튼--%>
      <% if (canReceiveLetter) { %>
      <li>
        <form action="/mvcboard/viewController.do" method="post">
          <button class="picbutton" type="submit" name="action" value="receive">
            <img src="/img/realget.png">
          </button>
        </form>
      </li>
      <% } else { %>
      <li>
        <button class="picbutton" type="submit" onclick="alert('편지는 24시간마다 한 번씩 받을 수 있습니다')"><img src="/img/realget.png"></button>
      </li>
      <% } %>
      <li>
        <form action="/mvcboard/list.do" method="get">
          <button type="submit" name="action" value="login"><img src="/img/reallist.png"></button>
        </form>
      </li>
    </ul>
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

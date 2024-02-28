<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>회원가입</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/TfCSS/SignUp.css">

</head>
<body>

<nav class="linavbar">
    <div class="linavbar_logo">
        <i class="lifab fa-accusoft"></i>
        <a href="../TfBottle/MainPage.jsp">1일 1편지</a>
    </div>

    <ul class="linavbar_menu">
        <li><a href="../TfBottle/MainPage.jsp">Home</a></li>
        <% if (session.getAttribute("user_id") == null) { %>
        <li><a href="../TfBottle/Login.jsp">로그인</a></li>
        <li><a href="../TfBottle/SignUp.jsp">회원가입</a></li>
        <% } else { %>
        <li><a href="../TfBottle/Logout.jsp">로그아웃</a></li>
        <% } %>
    </ul>
</nav>
<section>
    <form name="frmMember">
        <h1>회원가입</h1>
        <label for="name">이름:</label>
        <input type="text" id="name" name="name"><br>

        <label for="id" id="label_id">아이디:</label>
        <input type="text" id="id" name="id"><br>

        <button type="button" onclick="idcheck()">중복확인</button>
        <input type="hidden" id="check" value="unchecked"/>

        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password"><br>

        <label for="confirmPassword">비밀번호 확인:</label>
        <input type="password" id="confirmPassword" name="confirmPassword"><br>

        <label for="country">나라</label>
        <select name="country" id="country">
            <option value="대한민국">대한민국</option>
            <option value="日本">日本</option>
            <option value="中国">中国</option>
            <option value="Российская">Российская</option>
            <option value="USA">USA</option>
            <option value="UK">UK</option>
        </select>

        <label for="email">이메일:</label>
        <input type="email" id="email" name="email"><br>

        <input type="button" value="회원가입하기" onclick="sendMember()">
        <input type="hidden" name="command" value="addMember">
    </form>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</section>

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
<script>
    //비동기식 아이디 중복확인
    function idcheck() {
        let id = $("#id").val();

        $.ajax({
            type: 'POST',
            dataType: 'html',  //전송받은 데이터를 변환시킬 컨텐츠 타입
            data: {id: id},
            url: '/member/idCheck.do',
            //통신 성공시
            success: function (data) {
                if (!id) return alert("아이디를 입력해주세요");

                if (data == 'false') {
                    $("#label_id").html("사용 가능한 아이디입니다.").css("color", "black");
                    $("#check").val("checked");

                } else {
                    $("#label_id").html("중복된 아이디입니다.").css("color", "red");

                }
            },
            //통신 실패시
            error: function () {
                alert("아이디 중복확인 오류");
            }
        });
    }

    //정규식 이용한 이메일형식 확인
    function CheckEmail(str) {
        var reg_email = /^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
        return reg_email.test(str);
    }

    //회원가입 버튼 클릭시
    function sendMember() {
        var checkValue = document.getElementById("check").value;
        var name = document.getElementById("name").value;
        var id = document.getElementById("id").value;
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var country = document.getElementById("country").value;
        var email = document.getElementById("email").value;

        //유효성 검사
        if (!name) return alert("이름을 입력해주세요");
        if (!id) return alert("아이디를 입력해주세요");
        if (!password) return alert("비밀번호를 입력해주세요");
        if (!confirmPassword) return alert("비밀번호를 입력해주세요");
        if (password !== confirmPassword) return alert("비밀번호가 일치하지않습니다.");
        if (!country) return alert("나라를 입력해주세요");
        if (!email) {
            alert("이메일을 입력해주십시오.");
            document.getElementById("email").focus();
            return false;

        } else if (!CheckEmail(email)) {
            alert("이메일 형식이 잘못되었습니다");
            document.getElementById("email").focus();
            return false;

            //아이디 중복에 따른 결과 반환
        } else if (checkValue === "checked") {
            frmMember.method = "post";
            frmMember.action = "/01/SignUp.do"
            frmMember.submit();

        } else {
            alert("아이디 중복확인 해주세요");
        }
    }

</script>
</html>
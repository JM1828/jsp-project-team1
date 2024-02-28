<%@ page import="util.JSFunction" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user_id") == null) {
        JSFunction.alertBack("로그인 후 글작성 가능함", out);
    }
%>
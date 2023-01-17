<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.KadaiAccount" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>下記の内容で登録します。よろしいですか？</p>
	<%
		KadaiAccount account = (KadaiAccount)session.getAttribute("input_Kdata");
	%>
	名前：<%=account.getName() %><br>
	年齢：<%=account.getAge() %><br>
	性別：<%=account.getGender() %><br>
	電話番号：<%=account.getPhone() %><br>
	メール：<%=account.getEmail() %><br>
	パスワード：********<br>
	<a href="KadaiRegisterExeServlet">OK</a><br>

</body>
</html>
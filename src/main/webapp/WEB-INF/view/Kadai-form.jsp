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
	<%
		request.setCharacterEncoding("UTF-8");
	String errorCode = request.getParameter("error");
	if(errorCode != null && errorCode.equals("1")){
		KadaiAccount ka = (KadaiAccount)session.getAttribute("input_Kdata");
	%>
	<p style="color:red">登録失敗</p>
	<h3>新規登録</h3>
	<form action="KadaiRegisterConfirmServlet" method="post">
		名前：<input type="text" name="name" value="<%=ka.getName() %>"><br>
		年齢：<input type="text" name="age" value="<%=ka.getAge() %>"><br>
		性別：男<input type="radio" name="gender" value="男">  女<input type="radio" name="gender" value="女"><br>
		電話番号：<input type="text" name="phone" value="<%=ka.getPhone() %>"><br>
		メールアドレス：<input type="email" name="email" value="<%=ka.getEmail()%>"><br>
		パスワード：<input type="password" name="pw"><br>
		<input type="submit" value="送信">
	</form>
	<%
		} else {
	%>
	<h3>新規登録</h3>
	<form action="KadaiRegisterConfirmServlet" method="post">
		名前：<input type="text" name="name"><br>
		年齢：<input type="text" name="age"><br>
		性別：男<input type="radio" name="gender" value="男">  女<input type="radio" name="gender" value="女"><br>
		電話番号：<input type="text" name="phone"><br>
		メールアドレス：<input type="email" name="email"><br>
		パスワード：<input type="password" name="pw"><br>
		<input type="submit" value="送信">
	</form>
	<%
		}
	%>
</body>
</html>
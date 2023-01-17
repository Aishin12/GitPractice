<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		request.setCharacterEncoding("UTF-8");
		if(request.getParameter("error") != null){	
	%>
<p style="color:red">ログイン失敗</p>
<form action="KadaiLoginServlet" method="post">
【パスワードを再入力して下さい。】<br>
Mail：<input type="text" name="email"　value="<%=request.getParameter("email")%>"><br>
パスワード：<input type="password" name="pw"><br>
<input type="submit" value="ログイン">
</form>
<%
		}else{
%>
<form action="KadaiLoginServlet" method="post">
【IDとPWを入力してください。】<br>
Mail：<input type="text" name="email"><br>
パスワード：<input type="password" name="pw"><br>
<input type="submit" value="ログイン">
</form>
<%
		}
%>
</body>
</html>
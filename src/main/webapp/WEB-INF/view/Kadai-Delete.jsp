<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>削除するアカウントのメールアドレスを入力してください。</h3>
<form action="KadaiDeleteConfirmServlet" method="post">
	メールアドレス：<input type="email" name="email"><br>
	パスワード：<input type="text" name="pw"><br>
	<input type="submit" value="送信">
</form>
</body>
</html>
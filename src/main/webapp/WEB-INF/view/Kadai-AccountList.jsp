<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.KadaiAccountList" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border="1">	
	<tr>
		<th>ID</th>
		<th>名前</th>
		<th>年齢</th>
		<th>性別</th>
		<th>電話番号</th>
		<th>メールアドレス</th>		
<%
	List<KadaiAccountList> list = (ArrayList<KadaiAccountList>)request.getAttribute("AccountList");
	for(KadaiAccountList a : list) {
%>
		<tr>
			<td><%=a.getId() %></td>
			<td><%=a.getName() %></td>
			<td><%=a.getAge() %></td>
			<td><%=a.getGender() %></td>
			<td><%=a.getPhone() %></td>
			<td><%=a.getEmail() %>
		</tr>

<%
	}
%>
</table>
</body>
</html>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Connection conn = null;

String url = "jdbc:oracle:thin:@localhost:1521:xe";
String id = "system";
String pw = "1234";

try{
	Class.forName("oracle.jdbc.OracleDriver");
	conn = DriverManager.getConnection(url, id, pw);
	System.out.println("DB 접속");
}catch(Exception e){
	e.printStackTrace();
}

String sql = "select teacher_code, teacher_name, class_name, class_price, teacher_regist_date from tbl_teacher_202201";

PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
ArrayList<String[]> viewList = new ArrayList<String[]>();

while(rs.next()){
	String[] view = new String[5];
	view[0] = rs.getString(1);
	view[1] = rs.getString(2);
	view[2] = rs.getString(3);
	String price = rs.getString(4);
	String cp = "￦";
	cp += price.substring(0,3);
	cp += ",";
	cp += price.substring(3, price.length());
	view[3] = cp;
	String date = rs.getString(5);
	String trd = date.substring(0, 4);
	trd += "년";
	trd += date.substring(4, 6);
	trd += "월";
	trd += date.substring(6, date.length());
	trd += "일";
	view[4] = trd;
	viewList.add(view);
}
pstmt.close();
conn.close();
rs.close();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.title{
	text-align : center;
}
.table{
	margin : auto;
}
</style>
</head>
<body>
	<jsp:include page="include/header.jsp"></jsp:include>
	<jsp:include page="include/nav.jsp"></jsp:include>
	<div class="section">
		<h3 class="title">강사조회</h3>
		<table class="table" border="1">
			<tr>
				<th>강사코드</th>
				<th>강사명</th>
				<th>강의명</th>
				<th>수강료</th>
				<th>강사자격취득일</th>
			</tr>
			<%
				for(int i = 0; i < viewList.size(); i++) {
			%>
			<tr>
				<td align="center"><%=viewList.get(i)[0] %></td>
				<td align="center"><%=viewList.get(i)[1] %></td>
				<td align="center"><%=viewList.get(i)[2] %></td>
				<td align="center"><%=viewList.get(i)[3] %></td>
				<td align="center"><%=viewList.get(i)[4] %></td>
			</tr>
			<%} %>
		</table>
	</div>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
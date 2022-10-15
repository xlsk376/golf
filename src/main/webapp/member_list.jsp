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

String sql = "select c.regist_month, m.c_no, m.c_name, t.class_name, c.class_area, c.tuition, m.grade from tbl_teacher_202201 t, tbl_member_202201 m, tbl_class_202201 c ";
	sql += " where m.c_no=c.c_no and c.teacher_code=t.teacher_code group by c.regist_month, m.c_no, m.c_name, t.class_name, c.class_area, c.tuition, m.grade ";
	sql += " order by m.c_no asc";

PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
ArrayList<String[]> viewList = new ArrayList<String[]>();

while(rs.next()){
	String[] view = new String[7];
	String rm = rs.getString(1);
	String date = rm.substring(0, 4);
	date += "년";
	date += rm.substring(4, 6);
	date += "월";
	view[0] = date;
	view[1] = rs.getString(2);
	view[2] = rs.getString(3);
	view[3] = rs.getString(4);
	view[4] = rs.getString(5);
	view[5] = "￦" + rs.getString(6);
	view[6] = rs.getString(7);
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
		<h3 class="title">회원정보조회</h3>
		<table class="table" border="1">
			<tr>
				<th>수강월</th>
				<th>회원번호</th>
				<th>회원명</th>
				<th>강의명</th>
				<th>강의장소</th>
				<th>수강료</th>
				<th>등급</th>
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
				<td align="center"><%=viewList.get(i)[5] %></td>
				<td align="center"><%=viewList.get(i)[6] %></td>
			</tr>
			<%} %>
		</table>
	</div>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
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

request.setCharacterEncoding("UTF-8");
String sql = "insert into tbl_class_202201 values (?,?,?,?,?)";

PreparedStatement pstmt = conn.prepareStatement(sql);

pstmt.setString(1, request.getParameter("regist_month"));
pstmt.setString(2, request.getParameter("c_no"));
pstmt.setString(3, request.getParameter("class_area"));
pstmt.setInt(4, Integer.parseInt(request.getParameter("tuition")));
pstmt.setString(5, request.getParameter("teacher_code"));

pstmt.executeUpdate();

pstmt.close();

response.sendRedirect("index.jsp");

%>

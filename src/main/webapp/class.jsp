<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
<script type="text/javascript">
	function change1(){
		
		document.data.tuition.value = "";
		document.data.c_no.value = document.data.c_name.value;
	}
	function change2(){
		var num = document.data.c_no.value;
		var price = document.data.teacher_code.value * 1000;
		
		if(num >= 20000){
			document.data.tuition.value = price*0.5;			
		}else{
			document.data.tuition.value = price;
		}
		
	}

	function checkVal(){
		if(!document.data.regist_month.value){
			alert("수강월을 입력하세요!");
			document.data.regist_month.focus();
			return false;
		}else if(!document.data.c_name.value){
			alert("회원을 선택하세요!");
			document.data.c_name.focus();
			return false;
		}else if(!document.data.class_area.value){
			alert("강의장소를 선택하세요!");
			document.data.class_area.focus();
			return false;
		}else if(!document.data.teacher_code.value){
			alert("강의명을 선택하세요!");
			document.data.teacher_code.focus();
			return false;
		}else{
			alert("수강신청이 완료되었습니다!");
			document.getElementById("data").submit();
		}
	}
	
	function re(){
		document.data.regist_month.value = "";
		document.data.c_name.value = "";
		document.data.c_no.value = "";
		document.data.class_area.value = "";
		document.data.teacher_code.value = "";
		document.data.tuition.value ="";
		
		alert("수강신청에 입력된 정보를 삭제합니다.");
		document.data.regist_month.focus();
		
	}
</script>
</head>
<body>
	<jsp:include page="include/header.jsp"></jsp:include>
	<jsp:include page="include/nav.jsp"></jsp:include>
	<div class="section">
		<h3 class="title">수강신청</h3>
		<form id="data" name="data" method="post" action="class_p.jsp" onsubmit="return false">
			<table class="table" border="1">
				<tr>
					<th>수강월</th>
					<td>
						<input type="text" name="regist_month"><br>
						2022년03월 예)202203
					</td>
				</tr>
				<tr>
					<th>회원명</th>
					<td>
						<select name="c_name" onchange="change1()">
							<option value="">회원명</option>
							<option value="10001">홍길동</option>
							<option value="10002">장발장</option>
							<option value="10003">임꺽정</option>
							<option value="20001">성춘향</option>
							<option value="20002">이몽룡</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>회원번호</th>
					<td>
						<input type="text" name="c_no" readonly>
					</td>
				</tr>
				<tr>
					<th>강의장소</th>
					<td>
						<select name="class_area">
							<option value="">강의장소</option>
							<option value="서울본원">서울본원</option>
							<option value="성남분원">성남분원</option>
							<option value="대전분원">대전분원</option>
							<option value="부산분원">부산분원</option>
							<option value="대구분원">대구분원</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>강의명</th>
					<td>
						<select name="teacher_code" onchange="change2()">
							<option value="">강의명</option>
							<option value="100">초급반</option>
							<option value="200">중급반</option>
							<option value="300">고급반</option>
							<option value="400">심화반</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>수강료</th>
					<td>
						<input type="text" name="tuition" readonly>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button onclick="checkVal()">수강신청</button>
						<button onclick="re()">다시쓰기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
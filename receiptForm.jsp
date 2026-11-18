<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="main.css">
</head>
<body>
<header>
세탁 서비스 접수관리 프로그램
</header>
<nav>
<a href="serviceList.jsp">세탁서비스 조회</a>
<a href="receiptForm.jsp">세탁접수등록</a>
<a href="receiptList.jsp">세탁접수 내역조회</a>
<a href="typeStats.jsp">종류별 매출통계</a>
<a href="index.jsp">홈으로</a>
</nav>

<section class="container">
<form action="seccess.jsp" id="checkRe" method="post" onsubmit=" return checkForm()">
<h1>세탁접수 등록</h1>

<table class= "tbl">
<tbody>
<tr>
<th>접수번호</th>
<td><input type="text" name ="receiptNo" id="receiptNo" placeholder="R0009"><span></span></td>
</tr>
<tr>
<th>접수일자</th>
<td><input type="text" name ="receiptDate" id="receiptDate" placeholder="20261106"><span>YYYYMMDD</span></td>
</tr>
<tr>
<th>서비스코드</th>
<td><select name ="serviceCode" id="serviceCode">
<option value="">선택하세요</option>
<option value="L1001">L1001-티셔츠 세탁</option>
<option value="L1002">L1002-침구 세탁</option>
<option value="L2001">L2001-정장 상의</option>
<option value="L2002">L2002-코드 드라이</option>
<option value="L3001">L3001-운동화 세탁</option>
</select></td>
</tr>
<tr>
<th>접수수량</th>
<td><input type="text" name ="itemQty" id="itemQty" ></td>
</tr>
<tr>
<th>고객명</th>
<td><input type="text" name ="customerName" id="customerName"></td>
</tr>
</tbody>
</table>
<div class="tbtn">
<button type="submit" class= "sBtn">세탁접수</button>
<button type="button" class= "rBtn" onclick="reClick()">다시쓰기</button>
</div>
</form>
</section>
<footer>
세탁 서비스 접수관리 프로그램 · 실기 연습용 화면 예시 &copy;
</footer>
<script>

	function checkForm(){
		
		let receiptNo = document.querySelector("#receiptNo").value;
		let receiptDate = document.querySelector("#receiptDate").value;
		let serviceCode = document.querySelector("#serviceCode").value;
		let itemQty = document.querySelector("#itemQty").value;
		let customerName = document.querySelector("#customerName").value;
		
		
		if (receiptNo==""){
			alert("접수번호가 입력되지 않았습니다!");
			document.querySelector("#receiptNo").focus();
			return false;
		}
		if (receiptDate==""){
			alert("접수일자가 입력되지 않았습니다!");
			document.querySelector("#receiptDate").focus();
			return false;
		}
		if (serviceCode==""){
			alert("서비스 코드를 선택해주세요!");
			document.querySelector("#serviceCode").focus();
			return false;
		}
		if (itemQty==""){
			alert("접수수량이 입력되지 않았습니다!");
			document.querySelector("#itemQty").focus();
			return false;
		}
		if (customerName==""){
			alert("고객명이 입력되지 않았습니다!");
			document.querySelector("#customerName").focus();
			return false;
		}
		return true;
	}
	function reClick(){
		alert("입력내용을 초기화합니다.");
		document.getElementById("checkRe").reset();
		document.querySelector("#receiptNo").focus();
		return false;
	}
	
	</script>
</body>
</html>
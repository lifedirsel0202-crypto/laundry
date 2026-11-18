<%@page import="java.text.SimpleDateFormat"%>
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

<h1>종류별 매출통계</h1>

<table class= "tbl">
<thead>
<tr>
<th>종류코드</th>
<th>세탁종류</th>
<th>접수건수</th>
<th>총접수수량</th>
<th>총매출금액</th>

</tr>
</thead>
<tbody>
	<%
			request.setCharacterEncoding("utf-8");
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			
			try{
				conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HRD_20261118","root","admin");
				String sql = "select tlt.type_code 종류코드, tlt.type_name 세탁종류, COUNT(item_qty) 접수건수," 
						+" SUM(item_qty) 접수수량, sum(UNIT_PRICE*item_qty) 총매출"
						+" FROM tbl_laundry_type tlt LEFT OUTER JOIN TBL_laundry_SERVICE tls"
						+" ON tls.type_code = tlt.type_code LEFT OUTER JOIN TBL_laundry_RECEIPT tlr"
						+" ON tlr.service_code = tls.service_code"
						+" GROUP BY tlt.type_code, tlt.type_name";
				stmt = conn.createStatement();
				
				rs = stmt.executeQuery(sql);
				DecimalFormat df = new DecimalFormat("￦#,###");
				
				while (rs.next()){
					int t = rs.getInt("총매출");
					String totalPrice = df.format(t);
					
				
				%>				
<tr>
<td class= "c"><%=rs.getString(1) %></td>
<td class= "l"><%=rs.getString(2) %></td>
<td class= "c"><%=rs.getInt(3)%></td>
<td class= "c"><%=rs.getInt(4)%></td>
<td class= "r"><%=totalPrice%></td>
</tr>
<%
		}
				}catch(Exception e){
					e.printStackTrace();
					}finally{
				
				if(rs!=null){rs.close();}
				if(stmt!=null){stmt.close();}
				if(conn!=null){conn.close();}
					}
				%>


</tbody>
</table>
</section>
<footer>
세탁 서비스 접수관리 프로그램 · 실기 연습용 화면 예시 &copy;
</footer>
</body>
</html>
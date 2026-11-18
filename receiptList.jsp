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

<h1>세탁접수 내역조회</h1>

<table class= "tbl">
<thead>
<tr>
<th>접수일자</th>
<th>접수번호</th>
<th>서비스명</th>
<th>세탁종류</th>
<th>접수수량</th>
<th>기본요금</th>
<th>접수금액</th>
<th>고객명</th>
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
				String sql = "select RECEIPT_date 접수일자,RECEIPT_NO 접수번호, SERVICE_NAME 서비스명, type_name 세탁종류,item_qty, UNIT_PRICE 기본요금,"
						+" sum(UNIT_PRICE*item_qty) 접수금액, customer_name 고객명"
						+" from TBL_laundry_RECEIPT tlr left outer join TBL_laundry_SERVICE tls"
						+" on tlr.service_code = tls.service_code left outer join tbl_laundry_type tlt"
						+" on tls.type_code = tlt.type_code"
						+" group by RECEIPT_date,RECEIPT_NO"
						+" order by RECEIPT_date,RECEIPT_NO asc";
				stmt = conn.createStatement();
				
				rs = stmt.executeQuery(sql);
				DecimalFormat df = new DecimalFormat("￦#,###");
				
				SimpleDateFormat osd = new SimpleDateFormat("yyyyMMdd");
				SimpleDateFormat nsd = new SimpleDateFormat("yyyy년MM월dd일");
				
				while (rs.next()){
					int t = rs.getInt("접수금액");
					int p = rs.getInt("기본요금");
					String price = df.format(p);
					String totalPrice = df.format(t);
					
					String d = rs.getString("접수일자");
					String date = nsd.format(osd.parse(d));
				%>				
<tr>
<td class= "c"><%=date %></td>
<td class= "l"><%=rs.getString(2) %></td>
<td class= "c"><%=rs.getString(3) %></td>
<td class= "c"><%=rs.getString(4) %></td>
<td class= "c"><%=rs.getInt(5) %></td>
<td class= "r"><%=price %></td>
<td class= "r"><%=totalPrice %></td>
<td class= "c"><%=rs.getString(8) %></td>
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
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
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
		request.setCharacterEncoding("utf-8");
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try{
			conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HRD_20261118","root","admin");
			String sql = "insert into TBL_laundry_RECEIPT values (?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, request.getParameter("receiptNo"));
			pstmt.setString(2, request.getParameter("receiptDate"));
			pstmt.setString(3, request.getParameter("serviceCode"));
			pstmt.setInt(4,Integer.parseInt(request.getParameter("itemQty")));
			pstmt.setString(5, request.getParameter("customerName"));
			
			int result =pstmt.executeUpdate();
			
			if (result>0){
				out.println("<script>alert('세탁접수가 정상적으로 등록되었습니다!');location.href='index.jsp';</script>");
			}
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			if(pstmt != null){pstmt.close();}
			if(conn != null){conn.close();}
		}
			
	
	
	%>

</body>
</html>
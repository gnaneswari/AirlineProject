<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.GenericServlet" %>
<%@ page import="javax.servlet.ServletConfig" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.ServletRequest" %>
<%@ page import="javax.servlet.ServletResponse" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="com.dept.*" %>
<%@ page import="com.dept.dao.*" %>


<%! 
	public void jspInit()
	{
		try
		{
			System.out.println("init");
			System.out.println("loading driver");
			DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
			Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","system","gnan123");
			System.out.println("connected to database");
		}
		catch(Exception e)
		{
			System.out.println("Some sql problem");
		}
	}
%>
<%! 
	public void jspDestroy()
	{
		System.out.println("Destroyed");
	}
%>
<%! DepartmentDAOImpl daoObj=new DepartmentDAOImpl();%>

	
	<%String buttonValue = request.getParameter("submit");

		
	
	if(buttonValue.equals("Add Dept"))
	{
		int dno = Integer.parseInt(request.getParameter("v_deptno")); 
		String dnm = request.getParameter("v_dname");
		String dloc = request.getParameter("v_loc");
		
		Department deptObj = new Department(); 
		deptObj.setDepartmentNumber(dno);
		deptObj.setDepartmentName(dnm); 
		deptObj.setDepartmentLocation(dloc); 
			
		try
		{
			daoObj.addDepartment(deptObj);
			out.println("<h4>Department is added to the database</h4>");
		}
		catch(DepartmentAlreadyExistException e) 
		{
			out.println("<h4>Department add issue: "+e.getMessage()+"</h4>");
		}
	}
		
		
	else if (buttonValue.equals("Find Dept"))
	{int dno = Integer.parseInt(request.getParameter("v_deptno")); 
		try 
		{
			
			
			  Department dptobj = new Department();
			    dptobj=daoObj.findDepartment(dno);
			    int depno=dptobj.getDepartmentNumber();
			    String name=dptobj.getDepartmentName();
			    String loc=dptobj.getDepartmentLocation();
			out.println("<table border=5 cellpadding=10 cellspacing=10>");
			out.println("<tr>");
			out.println("<th>"+"DEPNO"+"</th><th>"+"DEPTNAME"+"</th><th>"+"LOCATION"+"</th>");
			out.println("<tr><td>"+depno+"</td><td>"+name+"</td><td>"+loc+"</td></tr>");
		//	out.println("<td>"+deptObj.getDepartmentNumber()+"</td>");
		//	out.println("<td>"+deptObj.getDepartmentName()+"</td>");
			//out.println("<td>"+deptObj.getDepartmentLocation()+"</td>");
			out.println("</tr>");
			out.println("</table>");	
		}
		catch(NullPointerException e)
		{
			out.println("<h4>Department Not Found Exception  </h4>");
		}
	}
	
	
else if(buttonValue.equals("Find All Depts")) 
	{
	List<Department> deptList = null;
	deptList=daoObj.findDepartments();
	Iterator<Department> iter = deptList.iterator();
	out.println("<table border=3 cellspacing=5 cellpadding=5>");
	out.println("<th>"+"DEPNO"+"</th><th>"+"DEPTNAME"+"</th><th>"+"LOCATION"+"</th>");
	while(iter.hasNext()) {
		Department deptObj = iter.next();
		out.println("<tr><td>"+deptObj.getDepartmentNumber()+"</td><td>"+deptObj.getDepartmentName()+"</td><td>"+deptObj.getDepartmentLocation()+"</td></tr>");
	}
	out.println("</table>");
	out.println("<h4>Departments are found...</h4>");
	}	
		
 	else if (buttonValue.equals("Modify Dept"))
	{ 
			int dno = Integer.parseInt(request.getParameter("v_deptno")); 
			String dnm = request.getParameter("v_dname");
			String dloc = request.getParameter("v_loc");
			
			Department deptObj = new Department(); 
			deptObj.setDepartmentNumber(dno);
			deptObj.setDepartmentName(dnm);
			deptObj.setDepartmentLocation(dloc);
			
			try
			{
				daoObj.modifyDepartment(deptObj);
				out.println("<h4> Department is modified</h4>"+dno);
			}
			catch(DepartmentNotFoundException e) 
			{
				out.println("<h4>"+ e.getMessage()+"</h4>");
			}
			catch(Exception ex)
			 {
				out.println("<h4>Department Cannot Be Modified</h4>");
			}
		}

	 	else if (buttonValue.equals("Delete Dept"))
		{
			int dno = Integer.parseInt(request.getParameter("v_deptno")); 
			Department deptObj = new Department(); 
			deptObj.setDepartmentNumber(dno);
			try
			{
				daoObj.removeDepartment(deptObj);
				out.println("<h4> Department is deleted</h4>");
			}
			catch(DepartmentNotFoundException e)
			{
				out.println("<h4>Department Not Found Exception</h4>");
			}
		}
	out.println("<a href='http://localhost:8080/ServletWithParameters/'> Back to Welcome </a>");
	%>
</body>
</html>
<%@page import="com.onwardpath.wem.repository.TestCaseRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map, com.onwardpath.wem.repository.SegmentRepository" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<%
String resultName = request.getParameter("casetype");
String expType = request.getParameter("datatype");
TestCaseRepository tcr = new TestCaseRepository();
int orgId=0,expId =0;
if(request.getParameter("orgid") !=null)
	orgId = Integer.parseInt(request.getParameter("orgid"));

if(request.getParameter("expid") !=null)
	expId = Integer.parseInt(request.getParameter("expid"));

int org_id = (Integer)session.getAttribute("org_id");
int user_id = (Integer)session.getAttribute("user_id");

%>

<c:if test='<%=orgId!=0 %>'>
	<c:if test='<%=request.getParameter("casetype").equals("listexp") %>'>
		<%=tcr.listTestCaseValues(expType,resultName, 1,0)%> 
	</c:if>
	<c:if test='<%=request.getParameter("casetype").equals("listseg") %>'>
		<%=tcr.listTestCaseValues(expType,resultName, 1,expId)%>
	</c:if>
</c:if>
<c:if test='<%=request.getParameter("casetype").equals("addtestcase") %>'> 
		<% int segId = Integer.parseInt(request.getParameter("segid"));
			String ipaddr = request.getParameter("ip");%>
		<%
		tcr.addTestCase(org_id,user_id,expId,segId,ipaddr);%>
</c:if>

<c:if test='<%=request.getParameter("casetype").equals("viewtestcases") %>'>
 		<%String dynamicIp = request.getParameter("ipaddr"); %>
		<%=tcr.viewTestCases(user_id, org_id,dynamicIp)%>
</c:if>

<c:if test='<%=request.getParameter("casetype").equals("delete") %>'> 
		<%
		int segId = Integer.parseInt(request.getParameter("segid"));
		tcr.deleteTestCase(user_id, org_id,expId,segId);%>
</c:if> 

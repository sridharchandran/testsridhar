<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import=" java.io.ByteArrayOutputStream"%>
<%@ page import=" java.io.ObjectOutputStream"%>
<%@ page import=" java.io.Serializable"%>

<%
String username = "";
int id =0;
ByteArrayOutputStream bos = new ByteArrayOutputStream();
ObjectOutputStream oos = new ObjectOutputStream(bos);
oos.writeObject(session.getAttribute("profile_pic"));
oos.flush();
byte [] profilepic = bos.toByteArray();
System.out.println("profile bytes=="+profilepic);
 
	


    
   
  

if (!(session.getAttribute("authenticated").equals(""))) {
	username = session.getAttribute("firstname").toString();
	System.out.println("username="+username);
	 
	 id  =  ( Integer ) session.getAttribute("userid");
	 System.out.println("id="+id);
	
	
	
 	
}
%>


<!--begin: User Bar -->


<div id="user" class="kt-header__topbar-item kt-header__topbar-item--user">
    <div id="expand" class="kt-header__topbar-wrapper" data-toggle="dropdown" data-offset="0px, 0px">
        <div class="kt-header__topbar-user" onclick="loading()"> 
            <span class="kt-header__topbar-welcome kt-hidden-mobile">Hi,</span> 
            <span class="kt-header__topbar-username kt-hidden-mobile">              
                <%=username%>	                                        	                   
            </span>   
            <%  
            if (!username.equals("") && profilepic.equals(""))  {
            	%>
            	<!--use below badge element instead the user avatar to display username's first letter(remove kt-hidden class to display it) -->
            	<span class="kt-badge kt-badge--username kt-badge--lg kt-badge--brand kt-badge--bold">
            	<%=username.charAt(0)%>
            	</span>
            	<%	
            } else if(!profilepic.equals("")) {
            	%>
            	<img alt="Pic" src='/wem/DisplayImageController/<%=id%>'/>
            	<% 
            }            
            %>                                    
        </div> 
    </div>
    <div id="show" class="dropdown-menu dropdown-menu-fit dropdown-menu-right dropdown-menu-anim dropdown-menu-top-unround dropdown-menu-sm">
        <jsp:include page="_dropdown-user-solid.jsp" />
    </div>
</div>

<!--end: User Bar -->
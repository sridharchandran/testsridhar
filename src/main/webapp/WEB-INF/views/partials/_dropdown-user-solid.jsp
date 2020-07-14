<%@page import="java.util.Base64"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.awt.print.Book"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%-- <%@page import="com.onwardpath.wem.util.Database"%> --%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Blob"%>
<%@ page import="com.onwardpath.wem.entity.User" %>

<%
String fname = "";
String lname = "";
byte[] pic  = null;
  

int ids =  ((User) session.getAttribute("user")).getId();

if (session.getAttribute("user") != null) {
	fname = ((User) session.getAttribute("user")).getFirstname();
	lname = ((User) session.getAttribute("user")).getLastname();
	pic = ((User) session.getAttribute("user")).getProfile_pic();

	
}
%>
<script type="text/javascript">
function logout() {	
	document.getElementById("logout").submit();
}
</script>            
<div class="kt-user-card kt-margin-b-40 kt-margin-b-30-tablet-and-mobile" style="background-image: url(./assets/misc/head_bg_sm.jpg)">
    <div class="kt-user-card__wrapper">
        <div class="kt-user-card__pic">
        	<%
        	if (pic.length != 0) {%>
        		<img alt="Pic" src='DisplayImageController'/> 
        	<%}%>            
        </div>
        <div class="kt-user-card__details">
            <div class="kt-user-card__name">
            <%
        	if (!fname.equals("") && !lname.equals("")) {%>
        		<%=fname%> <%=lname%>
        	<%}%>                                   
            </div>
            <div class="kt-user-card__position"></div>
        </div>
    </div>
</div>
<ul class="kt-nav kt-margin-b-10">
    <li class="kt-nav__item">
        <a href="userprofilesetting" class="kt-nav__link">
            <span class="kt-nav__link-icon"><i class="flaticon2-calendar-3"></i></span>
            <span class="kt-nav__link-text">My Profile</span> 
        </a>
    </li>
    <li class="kt-nav__item">
        <a href="?page=custom/user/profile-v1" class="kt-nav__link">
            <span class="kt-nav__link-icon"><i class="flaticon2-browser-2"></i></span>
            <span class="kt-nav__link-text">My Tasks</span> 
        </a>
    </li>
    <li class="kt-nav__item">
        <a href="?page=custom/user/profile-v1" class="kt-nav__link">
            <span class="kt-nav__link-icon"><i class="flaticon2-mail"></i></span>
            <span class="kt-nav__link-text">Messages</span> 
        </a>
    </li>
    <li class="kt-nav__item">
        <a href="profilesetting" class="kt-nav__link">
            <span class="kt-nav__link-icon"><i class="flaticon2-gear"></i></span>
            <span class="kt-nav__link-text">Settings</span> 
        </a>
    </li>
    <li class="kt-nav__item kt-nav__item--custom kt-margin-t-15">    	    

    	<form id="logout" action="logout" method="post" enctype="multipart/form-data">

			<input type="hidden" name="pageName" value="logout">  
		</form>   
    	<a href="javascript:logout();" class="btn btn-label-brand btn-upper btn-sm btn-bold">Sign Out</a>     	
    </li>
</ul>
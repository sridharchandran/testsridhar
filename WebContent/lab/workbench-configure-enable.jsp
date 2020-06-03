
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map, com.onwardpath.wem.repository.*,com.onwardpath.wem.model.*" %>
<!-- begin:: Content -->
<script src="./assets/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {		
		$('h1').mouseover(function () {			 
			$(this).css('color','red');					
		}).mouseout(function() {
			$(this).css('color','grey');
		});
		
		$('p').mouseover(function () {			 
			$(this).css('color','red');					
		}).mouseout(function() {
			$(this).css('color','grey');
		});
	});
</script>

<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
	<div class="kt-portlet__body"><!-- begin::portlet-body -->
	
	<h1>Welcome to the workbench</h1>
	<p>You can create page experiences visually here. Try the different options to play around.
	
	</div>
	<!-- end::portlet-body -->
 		
</div>
<!-- end:: Content -->	
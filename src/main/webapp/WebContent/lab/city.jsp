<%@ page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<DOCTYPEhtmlPUBLIC"-//W3C//DTDHTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="../assets/css/demo1/pages/custom/apps/jquery-ui.css">
<link rel="stylesheet" href="../assets/css/demo1/pages/custom/apps/style.css">
<script src="../assets/js/demo1/pages/custom/apps/jquery-1.12.4.js"></script>
<script src="../assets/js/demo1/pages/custom/apps/jquery-ui.js"></script>
<script type="text/javascript">
					$(document).ready(function() {
						$(function() {
							$("#geoloc").autocomplete({
								source : function(request, response) {
									var geolength = request.term.length + 1;
									if (geolength >= 4) {
										//alert("initialising ajax...");
										$.ajax({
											url : "../AjaxController",
											data : {
												geoloc : request.term,
											},
											success : function(data) {
												console.log(data);
												response(JSON.parse(data));
											}
										});
									}
								}

							});

						});
					})
</script>
<title>Locations</title>
</head>
<body>	
<div class="ui-widget">
	<label for="us_city">Area:</label> <input type="text" id="geoloc" placeholder="Enter Your Location">
</div>		
</body>
</html>
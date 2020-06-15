<%-- <%@page import="com.onwardpath.wem.model.User"%> --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<!-- begin::Head -->
<head>

<!--begin::Base Path (base relative path for assets of this page) -->
<base href="../../../">

<!--end::Base Path -->
<meta charset="utf-8" />
<title>Geo | Login</title>
<meta name="description" content="User login">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<!--begin::Fonts -->
<script
	src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.16/webfont.js"></script>
<script>
WebFont.load({
	google : {
		"families" : [ "Poppins:300,400,500,600,700" ]
	},
	active : function() {
		sessionStorage.fonts = true;
	}
});

function ValidateSize(file) {
    var FileSize = file.files[0].size/1024/1024; // in MB
    if (FileSize > 2) {
        alert('File size exceeds 2 MB');
        $(file).val(''); //for clearing with Jquery
    } else {

    }
}

function checkURL(abc) {
	  var string = abc.value;
	  console.log(abc);
	  if (!~string.indexOf("http")) {
	    console.log("abcd");
	    string = "https://" + string;
	  }
	  abc.value = string;
	  return abc
	}


function validatePassword(password) {

	// Do not show anything when the length of password is zero.

	if (password.length === 0) {
		document.getElementById("msg").innerHTML = "";
		return;
	}
	// Create an array and push all possible values that you want in password
	var matchedCase = new Array();
	matchedCase.push("[$@$!%*#?&]"); // Special Charector
	matchedCase.push("[A-Z]"); // Uppercase Alpabates
	matchedCase.push("[0-9]"); // Numbers
	matchedCase.push("[a-z]"); // Lowercase Alphabates

	// Check the conditions
	var ctr = 0;
	for (var i = 0; i < matchedCase.length; i++) {
		if (new RegExp(matchedCase[i]).test(password)) {
			ctr++;
		}
	}
	// Display it
	var color = "";
	var strength = "";
	switch (ctr) {
	case 0:
	case 1:
	case 2:
		strength = "Weak";
		color = "red";
		break;
	case 3:
		strength = "Medium";
		color = "orange";
		break;
	case 4:
		strength = "Strong";
		color = "green";
		break;
	}
	document.getElementById("msg").innerHTML = strength;
	document.getElementById("msg").style.color = color;
	
	var pass1 = document.getElementById("n_password")
	var pass2 = document.getElementById("c_password");
	if (pass1.value != pass2.value) {
		pass2.setCustomValidity("Password Don't Match");
	} else {
		pass2.setCustomValidity('');
	}
}

function validateEmail() {
	alert("comindfdfg")
}
</script>

<script type="text/javascript">
/*  $(document).ready(function(){
 $('#email, #confirmemail').on('keyup', function () {
  if ($('#eamil').val() == $('#confirmemail').val()) {
    $('#message').html('Matching').css('color', 'green');
  } else 
    $('#message').html('Not Matching').css('color', 'red'); 
});
 });
 */

function validateEmail() {

 
	 var email1 = document.getElementById("email")
	var email2 = document.getElementById("confirmemail");
	if (email1.value != email2.value) {
		email2.setCustomValidity("Email Don't Match");
	} else {
		email2.setCustomValidity('');

	}
	
	var pass1 = document.getElementById("n_password")
	var pass2 = document.getElementById("c_password");
	
	if (pass1.value != pass2.value) {
		pass2.setCustomValidity("Password Don't Match");
	} else {
		pass2.setCustomValidity('');
	}
	 
	var fileUpload = document.getElementById("fileUpload");
    if (typeof (fileUpload.files) != "undefined") {
        var size = parseFloat(fileUpload.files[0].size / 1024).toFixed(2);
        if(size >= 2)
        	{
        	size.setCustomValidity("Image size more than 2mb'.");
    } else {
    	size.setCustomValidity("");
    }
}
    }


var loadFile = function(event) {
	var image = document.getElementById('output');
	image.src = URL.createObjectURL(event.target.files[0]);
};
</script>
<!--end::Fonts -->

<!--begin::Page Custom Styles(used by this page) -->
<link
	href="wem/assets/css/demo1/pages/custom/general/user/login-v1.css"
	rel="stylesheet" type="text/css" />

<!--end::Page Custom Styles -->

<!--begin::Global Theme Styles(used by all pages) -->
<link href="wem/assets/vendors/global/vendors.bundle.css"
	rel="stylesheet" type="text/css" />
<link href="wem/assets/css/demo1/style.bundle.css"
	rel="stylesheet" type="text/css" />

<!--end::Global Theme Styles -->

<!--begin::Layout Skins(used by all pages) -->
<link href="wem/assets/css/demo1/skins/header/base/light.css"
	rel="stylesheet" type="text/css" />
<link href="wem/assets/css/demo1/skins/header/menu/light.css"
	rel="stylesheet" type="text/css" />
<link href="wem/assets/css/demo1/skins/brand/navy.css"
	rel="stylesheet" type="text/css" />
<link href="wem/assets/css/demo1/skins/aside/navy.css"
	rel="stylesheet" type="text/css" />

<!--end::Layout Skins -->
<!-- link rel="shortcut icon" href="wem/assets/media/logos/favicon.ico" / -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script> -->
</head>

<!-- end::Head -->

<!-- begin::Body -->
<body
	style="background-image: url(wem/assets/misc/bg_1.jpg)"
class="kt-login-v1--enabled kt-quick-panel--right kt-demo-panel--right kt-offcanvas-panel--right kt-header--fixed kt-header-mobile--fixed kt-subheader--enabled kt-subheader--transparent kt-aside--enabled kt-aside--fixed kt-page--loading">

<!-- begin:: Page -->
<div class="kt-grid kt-grid--ver kt-grid--root">
	<div
		class="kt-grid__item  kt-grid__item--fluid kt-grid kt-grid--hor kt-login-v1"
		id="kt_login_v1">

		<!--begin::Item-->
<div class="kt-grid__item">

	<!--begin::Head-->
<div class="kt-login-v1__head">
	<div class="kt-login-v1__logo">
		<!-- a href="#">
<img src="wem/assets/media/logos/logo-4.png" alt="" / -->
<!-- /a-->
	</div>
	<div class="kt-login-v1__signup">
		<h4 class="kt-login-v1__heading">Have an account?</h4>
		<a href="/wem/login">Sign In</a>
	</div>
</div>

<!--begin::Head-->
</div>

<!-- begin::body -->
<!-- begin:: Content -->
<div class="kt-content  kt-grid__item kt-grid__item--fluid"
	id="kt_content">
	
<%
		String message = (String) session.getAttribute("message");
		if (message != null && !message.equals("")) {
			String icon = "la la-thumbs-up";
			if (message.startsWith("Error"))
				icon = "flaticon-warning";
	%>
	<div class="row">
		<div class="col">
			<div class="alert alert-light alert-elevate fade show" role="alert">
				<div class="alert-icon">
					<i class="<%=icon%> kt-font-brand"></i>
				</div>
				<div class="alert-text">
					<%=message%>
				</div>
			</div>
		</div>
	</div>
	<%
		session.setAttribute("message", "");
		}
	%>
	<div class="row">
		<div class="col-lg-12">
			<!--begin::Portlet-->
<form class="kt-form" id="kt_form"
	action="wem/registration" method="post"
	class="needs-validation" enctype="multipart/form-data">
	<input type="hidden" name="pageName" value="signup"> <input
		type="hidden" name="role" value="1">
	<div class="kt-portlet" id="kt_page_portlet">
		<div class="kt-portlet__head kt-portlet__head--lg">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Register</h3>
			</div>
			<div class="kt-portlet__head-toolbar">
				<button type="reset" class="btn btn-primary">Clear</button>
				&nbsp;
				<button type="submit" class="btn btn-primary"
					onclick="validateEmail()">Submit</button>
		
	</div>
</div>
<div class="kt-portlet__body">
	<div class="row">
		<div class="col-xl-2"></div>
		<div class="col-xl-8">
			<div class="kt-section kt-section--first">
				<div class="kt-section__body">
					<h3 class="kt-section__title kt-section__title-lg">Account
						Info:</h3>

					<!-- ORGANIZATION DETAILS -->
					<div class="form-group row">
						<label class="col-3 col-form-label">Company Name</label>
						<div class="col-9">
							<input class="form-control"  name="orgName" pattern="^[a-zA-Z0-9]+$"
								title="alphanumeric characters only allowed" placeholder="Enter Company Name" required>
						</div>
					</div>


					<div class="form-group row">
						<label class="col-3 col-form-label">Company
							Website</label>
						<div class="col-9">
							<div class="input-group">
								<input type="text" class="form-control" name="domain" title="url  should in this pattern https://(www|abc).example.com" 
								pattern="^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$" 
									placeholder="Enter Domain" onblur="checkURL(this)"  required>
								<!-- <div class="input-group-append"><span class="input-group-text">.com</span></div> -->
							</div>
						</div>
					</div>

					<!-- <div class="form-group form-group-last row">
								<label class="col-3 col-form-label">Company Logo</label>
								<div class="col-9">
									<input class="form-control" type="text" name="logoUrl" placeholder="Logo URL">																	
								</div>
							</div> -->

					<div
						class="kt-separator kt-separator--border-dashed kt-separator--space-lg"></div>

					
					<div class="form-group row">
						<label class="col-3 col-form-label">First Name</label>
						<div class="col-9">
							<input class="form-control" type="text" name="firstName"
								pattern="[A-Za-z]+" title="letters only"
								placeholder="First Name" required>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-3 col-form-label">Last Name</label>
						<div class="col-9">
							<input class="form-control" type="text" name="lastName"
								pattern="[A-Za-z]+" title="letters only"
								placeholder="Last Name" required>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-3 col-form-label">Contact Phone</label>
						<div class="col-9">
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text"><i
										class="la la-phone"></i></span>
								</div>
								<input type="text" class="form-control" name="phone"
									pattern="^(?=.*[0-9])[- +()0-9]+$" title="Country code with numbers only"
									placeholder="Phone" aria-describedby="basic-addon1"
									required>
							</div>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-3 col-form-label">Email</label>
						<div class="col-9">
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text"><i
										class="la la-at"></i></span>
								</div>
								<input type="text" class="form-control" id="email"
									pattern="[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,4}$"
									title="xyz@something.com" name="email"
									placeholder="Email" aria-describedby="basic-addon1"
									required>
							</div>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-3 col-form-label">Confirm Email
						</label>
						<div class="col-9">
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text"><i
										class="la la-at"></i></span>
								</div>
								<input type="text" class="form-control"
									id="confirmemail" name="confirmemail"
									pattern="[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,4}$"
									title="xyz@something.com" placeholder="Email"
									aria-describedby="basic-addon1" required>
								<span id='message'></span> 
							</div>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-3 col-form-label">Profile Photo</label>
						<div class="col-9">
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text"><i
										class="la la-at"></i></span>
								</div>
								<input id="fileUpload" type="file" class="form-control" name="photo"
									aria-describedby="basic-addon1" accept="image/*" onchange="ValidateSize(this)"
									required>
							</div>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-3 col-form-label">Password</label>
						<div class="col-9">
							<input id="n_password" class="form-control"
								type="password" name="password"
								title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
								pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
								onkeyup="validatePassword(this.value);" required>
											<span id="msg"></span>
										</div>
									</div>

									<div class="form-group form-group-last row">
										<label class="col-3 col-form-label">Repeat
											Password</label>
										<div class="col-9">
											<input id="c_password" class="form-control"
												title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
												pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
												type="password" name="password-repeat" required>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-2"></div>
					</div>
		</form>
	</div>
</div>
<!--end::Portlet-->
		</div>
	</div>
</div>
<!-- end:: Content -->
<!-- end::body -->

<!--begin::Item-->
<div class="kt-grid__item">
	<div class="kt-login-v1__footer">
		<div class="kt-login-v1__menu">
			<a href="http://www.onwarpath.com">Privacy</a> <a
				href="http://www.onwarpath.com">Legal</a> <a
				href="http://www.onwarpath.com/contact">Contact</a>
		</div>
		<div class="kt-login-v1__copyright">
			<a href="http://www.onwarpath.com">&copy; 2019 OnwardPath</a>
		</div>
	</div>
</div>

<!--end::Item-->
</div>
</div>

<!-- end:: Page -->

<!-- begin::Global Config(global config for global JS sciprts) -->
<script>
var KTAppOptions = {
	"colors" : {
		"state" : {
			"brand" : "#5d78ff",
			"metal" : "#c4c5d6",
			"light" : "#ffffff",
			"accent" : "#00c5dc",
			"primary" : "#5867dd",
			"success" : "#34bfa3",
			"info" : "#36a3f7",
			"warning" : "#ffb822",
			"danger" : "#fd3995",
			"focus" : "#9816f4"
		},
		"base" : {
			"label" : [ "#c5cbe3", "#a1a8c3", "#3d4465", "#3e4466" ],
			"shape" : [ "#f0f3ff", "#d9dffa", "#afb4d4", "#646c9a" ]
		}
	}
};
</script>

<!-- end::Global Config -->

<!--begin::Global Theme Bundle(used by all pages) -->
<script src="wem/assets/vendors/global/vendors.bundle.js"
	type="text/javascript"></script>
<script src="wem/assets/js/demo1/scripts.bundle.js"
	type="text/javascript"></script>

<!--end::Global Theme Bundle -->

<!--begin::Page Scripts(used by this page) -->
<script src="wem/assets/js/demo1/pages/custom/general/login.js"
	type="text/javascript"></script>

<!--end::Page Scripts -->
</body>

<!-- end::Body -->
</html>
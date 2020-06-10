<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
	<!-- begin::Head -->
	<head>

		<!--begin::Base Path (base relative path for assets of this page) -->
		<base href="/">

		<!--end::Base Path -->
		<meta charset="utf-8" />
		<title>Geo | Login</title>
		<meta name="description" content="User login">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />

		<!--begin::Fonts -->
		<script src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.16/webfont.js"></script>
		<script>
			WebFont.load({
				google: {
					"families": ["Poppins:300,400,500,600,700"]
				},
				active: function() {
					sessionStorage.fonts = true;
				}
			});
		</script>

		<!--end::Fonts -->

		<!--begin::Page Custom Styles(used by this page) -->
		<link href="/wem/assets/css/demo1/pages/custom/general/user/login-v1.css" rel="stylesheet" type="text/css" />

		<!--end::Page Custom Styles -->

		<!--begin::Global Theme Styles(used by all pages) -->
		<link href="/wem/assets/vendors/global/vendors.bundle.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/css/demo1/style.bundle.css" rel="stylesheet" type="text/css" />

		<!--end::Global Theme Styles -->

		<!--begin::Layout Skins(used by all pages) -->
		<link href="/wem/assets/css/demo1/skins/header/base/light.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/css/demo1/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/css/demo1/skins/brand/navy.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/css/demo1/skins/aside/navy.css" rel="stylesheet" type="text/css" />

		<!--end::Layout Skins -->
		<!-- link rel="shortcut icon" href="/wem/assets/media/logos/favicon.ico" / -->
	</head>

	<!-- end::Head -->

	<!-- begin::Body -->
	<body style="background-image: url(/wem/assets/media/misc/bg_1.jpg)" class="kt-login-v1--enabled kt-quick-panel--right kt-demo-panel--right kt-offcanvas-panel--right kt-header--fixed kt-header-mobile--fixed kt-subheader--enabled kt-subheader--transparent kt-aside--enabled kt-aside--fixed kt-page--loading">

		<!-- begin:: Page -->
		<div class="kt-grid kt-grid--ver kt-grid--root">
			<div class="kt-grid__item  kt-grid__item--fluid kt-grid kt-grid--hor kt-login-v1" id="kt_login_v1">

				<!--begin::Item-->
				<div class="kt-grid__item">

					<!--begin::Heade-->
					<div class="kt-login-v1__head">
						<div class="kt-login-v1__logo">
							<a href="/wem/login.jsp">
								<!-- img src="/wem/assets/media/logos/logo-4.png" alt="" / -->								
							</a>
						</div>
						<div class="kt-login-v1__signup">
							<h4 class="kt-login-v1__heading">Don't have an account?</h4>
							<a href="/wem/registration">Sign Up</a>
						</div>
					</div>

					<!--begin::Head-->
				</div>

				<!--end::Item-->

				<!--begin::Item-->
				<div class="kt-grid__item  kt-grid kt-grid--ver  kt-grid__item--fluid">

					<!--begin::Body-->
					<div class="kt-login-v1__body">

						<!--begin::Section-->
						<div class="kt-login-v1__section">
							<div class="kt-login-v1__info">
								<h3 class="kt-login-v1__intro">Create Unique Experiences</h3>
								<p>Relevant to your audience</p>
							</div>
						</div>

						<!--begin::Section-->

						<!--begin::Separator-->
						<div class="kt-login-v1__seaprator"></div>

						<!--end::Separator-->

						<!--begin::Wrapper-->
						<div class="kt-login-v1__wrapper">
							<div class="kt-login-v1__container">
								<h3 class="kt-login-v1__title">
									Welcome
								</h3>
								<%
								String message = (String) session.getAttribute("message");
								if (message != null && !message.equals("")) {
									String icon = "flaticon-placeholder-3"; 
									if (message.startsWith("Error"))
										icon = "flaticon-warning";
									%>																	    		            		          
						            <div class="alert-text">
						                <font color="#ffffff"><%=message%></font>
						            </div>								    						
									<%
									session.setAttribute("message", "");
								}								
								%>
								<!--begin::Form-->
								<form class="kt-login-v1__form kt-form" action="wem/login" modelAttribute="user" method="post" autocomplete="off" enctype="multipart/form-data">								
									<input type="hidden" name="pageName" value="login">
									<div class="form-group">
										<input class="form-control" type="text" placeholder="Username" name="userName" autocomplete="off">
									</div>
									<div class="form-group">
										<input class="form-control" type="password" placeholder="Password" name="password" autocomplete="off">
									</div>
									<div class="kt-login-v1__actions">
										<a href="#" class="kt-login-v1__forgot">
											Forgot Password ?
										</a>
										<button type="submit" class="btn btn-pill btn-elevate">Sign In</button>
									</div>
								</form>

								<!--end::Form-->

								<!--begin::Divider-->
								<div class="kt-login-v1__divider">
									<div class="kt-divider">
										<span></span>
										<!-- span>OR</span -->
										<span></span>
									</div>
								</div>

								<!--end::Divider-->

								<!--begin::Options-->
								<!-- div class="kt-login-v1__options">
									<a href="#" class="btn">
										<i class="fab fa-facebook-f"></i>
										Fcebook
									</a>
									<a href="#" class="btn">
										<i class="fab fa-twitter"></i>
										Twitter
									</a>
									<a href="#" class="btn">
										<i class="fab fa-google"></i>
										Google
									</a>
								</div -->

								<!--end::Options-->
							</div>
						</div>

						<!--end::Wrapper-->
					</div>

					<!--begin::Body-->
				</div>

				<!--end::Item-->

				<!--begin::Item-->
				<div class="kt-grid__item">
					<div class="kt-login-v1__footer">
						<div class="kt-login-v1__menu">
							<a href="#">Privacy</a>
							<a href="#">Legal</a>
							<a href="#">Contact</a>
						</div>
						<div class="kt-login-v1__copyright">
							<a href="https://www.onwardpath.com/">&copy; 2020 OnwardPath</a>
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
				"colors": {
					"state": {
						"brand": "#5d78ff",
						"metal": "#c4c5d6",
						"light": "#ffffff",
						"accent": "#00c5dc",
						"primary": "#5867dd",
						"success": "#34bfa3",
						"info": "#36a3f7",
						"warning": "#ffb822",
						"danger": "#fd3995",
						"focus": "#9816f4"
					},
					"base": {
						"label": [
							"#c5cbe3",
							"#a1a8c3",
							"#3d4465",
							"#3e4466"
						],
						"shape": [
							"#f0f3ff",
							"#d9dffa",
							"#afb4d4",
							"#646c9a"
						]
					}
				}
			};
		</script>

		<!-- end::Global Config -->

		<!--begin::Global Theme Bundle(used by all pages) -->
		<script src="/wem/assets/vendors/global/vendors.bundle.js" type="text/javascript"></script>
		<script src="/wem/assets/js/demo1/scripts.bundle.js" type="text/javascript"></script>

		<!--end::Global Theme Bundle -->

		<!--begin::Page Scripts(used by this page) -->
		<script src="/wem/assets/js/demo1/pages/custom/general/login.js" type="text/javascript"></script>

		<!--end::Page Scripts -->
	</body>

	<!-- end::Body -->
</html>
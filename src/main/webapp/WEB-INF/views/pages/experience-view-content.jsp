<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.onwardpath.wem.util.Database"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map,com.onwardpath.wem.repository.*,com.onwardpath.wem.model.*" %>
<!DOCTYPE html>


<html lang="en">

	<!-- begin::Head -->
	<head>

		
		<meta charset="utf-8" />
		<title>Keen | Local Data</title>
		<meta name="description" content="Initialized with local json data">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<style>
ul.pagination {
    display: inline-block;
    padding: 0;
    margin: 0;
}

ul.pagination li {display: inline;}

ul.pagination li a {
    color: black;
    float: left;
    padding: 8px 16px;
    text-decoration: none;
    transition: background-color .3s;
    border: 1px solid #ddd;
}

ul.pagination li a.active {
    background-color: #4CAF50;
    color: white;
    border: 1px solid #4CAF50;
    
}

ul.pagination li a:hover:not(.active) {background-color: #ddd;}


.popover
{
    min-width: 200px ! important;
}
		
		</style>

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
		<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">

		<!--end::Fonts -->

		<!--begin:: Global Mandatory Vendors -->
		<link href="/wem/assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />

		<!--end:: Global Mandatory Vendors -->

		<!--begin:: Global Optional Vendors -->
		<link href="/wem/assets/vendors/general/tether/dist/css/tether.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/bootstrap-datetime-picker/css/bootstrap-datetimepicker.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/bootstrap-timepicker/css/bootstrap-timepicker.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/nouislider/distribute/nouislider.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/owl.carousel/dist/assets/owl.carousel.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/owl.carousel/dist/assets/owl.theme.default.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/dropzone/dist/dropzone.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/summernote/dist/summernote.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/bootstrap-markdown/css/bootstrap-markdown.min.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/animate.css/animate.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/toastr/build/toastr.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/morris.js/morris.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/socicon/css/socicon.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
		<link href="/wem/assets/vendors/general/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css" />

		<!--end:: Global Optional Vendors -->

		<!--begin::Global Theme Styles(used by all pages) -->
		

		<!--end::Global Theme Styles -->

		

		<!--end::Layout Skins -->
		<link rel="shortcut icon" href="/wem/assets/media/logos/favicon.ico" />
	</head>

<!-- begin:: Content -->

		
		
			
			
			<!-- end::portlet-body -->
			
			

	

		<!-- begin:: Root -->
		<div class="kt-grid kt-grid--hor kt-grid--root">

			<!-- begin:: Page -->
			

				<!-- begin:: Aside -->
				<button class="kt-aside-close " id="kt_aside_close_btn"><i class="la la-close"></i></button>
				

				<!-- end:: Aside -->

				<!-- begin:: Wrapper -->
				

					<!-- begin:: Header -->
				

					<!-- end:: Header -->
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
					<div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor">

						<!-- begin:: Subheader -->
						

						<!-- end:: Subheader -->

						<!-- begin:: Content -->
						<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
							
							<div class="kt-portlet kt-portlet--mobile">
								
								<div class="kt-portlet__body">

									<!--begin: Search Form -->
									<div class="kt-form kt-fork--label-right kt-margin-t-20 kt-margin-b-10">
										<div class="row align-items-center">
											<div class="col-xl-8 order-2 order-xl-1">
												<div class="row align-items-center">
													<div class="col-md-4 kt-margin-b-20-tablet-and-mobile">
														<div id="search" class="kt-input-icon kt-input-icon--left" style="display:none;">
															<input type="text" onkeyup="javascript:search(this)" class="form-control" placeholder="Search..." id="generalSearch">
															<span class="kt-input-icon__icon kt-input-icon__icon--left">
																<span><i class="la la-search"></i></span>
															</span>
														</div>
													</div>
													
																
						 							<div class="col-md-4 kt-margin-b-20-tablet-and-mobile">
														<div id = "delete" class="kt-form__group kt-form__group--inline">
															<!-- <button class="btn btn-secondary" onclick="javascript:clear	(this)" type="button" id="kt_datatable_reload">Clear Search</button> -->
														</div>
													</div>
										
													
												</div>
											</div>
										 
										</div>
									</div>

									<!--end: Search Form -->
								</div>
						<!-- 		<a id="popoverData" class="btn" href="#" data-content="Popover with data-trigger"  data-placement="bottom" data-original-title="Title" data-trigger="hover">Popover with data-trigger</a> -->
							
						<!-- modal popup  -->
						
						  <div class="modal" id="myModal" role="document">
						    <div class="modal-dialog ">
						      <div class="modal-content">
						      
						        <!-- Modal Header -->
						        <div  class="modal-header">
						          <h4 id="segment-element" class="modal-title">Modal Heading</h4>
						          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">�</span>
								  </button>
						        </div>
						        
						        <!-- Modal body -->
						        <div id="popover-element" data-trigger="hover" class="modal-body">
						          Modal body..
						        </div>
						        
						        <!-- Modal footer -->
						        <div class="modal-footer">
						          <button type="button" class="btn btn-outline-brand" data-dismiss="modal">Close</button>
						        </div>
						        
						      </div>
						    </div>
						  </div>
						  
						  
						  
						  <div class="modal" id="myModals" role="document">
						    <div class="modal-dialog ">
						      <div class="modal-content">
						      
						        <!-- Modal Header -->
						        <div  class="modal-header">
						          <h4 id="experience-element" class="modal-title">Modal Heading</h4>
						          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">�</span>
								  </button>
						        </div>
						        
						        <!-- Modal body -->
						        <div id="popover-elements" class="modal-body">
						          Modal body..
						        </div>
						        
						        <!-- Modal footer -->
						        <div class="modal-footer">
						          <button type="button" class="btn btn-outline-brand" data-dismiss="modal">Close</button>
						        </div>
						        
						      </div>
						    </div>
						  </div>
									   
						  <div class="modal" id="modalurls" role="document">
						    <div class="modal-dialog ">
						      <div class="modal-content">
						      
						        <!-- Modal Header -->
						        <div  class="modal-header">
						          <h4 id="experience-elements" class="modal-title">Modal Heading</h4>
						          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">�</span>
								  </button>
						        </div>
						        
						        <!-- Modal body -->
						        <div id="popurl-elements" class="modal-body">
						          Modal body..
						        </div> 
						        
						        <!-- Modal footer -->
						        <div class="modal-footer">
						          <button type="button" class="btn btn-outline-brand" data-dismiss="modal">Close</button>
						        </div>
						        
						      </div>
						    </div>
						  </div>
								
								
								
								<div class="kt-portlet__body kt-portlet__body--fit">
								
								<!-- <div id="spin" class="spinner-border" style="display:none;"></div> -->
								
								<!-- <div id="spin" class="col-sm" style="margin-left: 100px;">
                                 <div class="kt-spinner kt-spinner--md kt-spinner--info"></div>
                            	</div> -->
                            	
                            	<div id="spin" style="display:none; class="d-flex justify-content-center">
                            	<button id="spinner"  class="btn btn-brand "  disabled>
								  <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
								  Loading...
								</button>
								</div>

									<!--begin: Datatable -->
									
									
									<div class="kt_datatable" id="local_data"></div>
									
			

									<!--end: Datatable -->
									
								
								
								<div id ="custom" class="kt-datatable__pager-info" >
									 <select class="select" id="mySelect" style="margin-left : 10px;margin-bottom: 10px;visibility:hidden">
    <option value="10">10</option>
    <option value="20">20</option>
    <option value="50">50</option>
    <option value="100">100</option>   
  </select>
								<span id="count" class="kt-datatable__pager-detail" style="
								    
								    bottom: 25px;
								    margin: 10px
								"></span></div>
								
								</div>
								
							</div>
							
							   
							 
				
						</div>

						<!-- end:: Content -->
					</div>

					<!-- begin:: Footer -->
				

					<!-- end:: Footer -->
				

				<!-- end:: Wrapper -->
			

			<!-- end:: Page -->
		</div>

		<!-- end:: Root -->


		<!-- begin::Demo Panel -->
		

		<!-- end::Demo Panel -->

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

		<!--begin:: Global Mandatory Vendors -->
		<script src="/wem/assets/vendors/general/jquery/dist/jquery.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/jquery/dist/jquery.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/popper.js/dist/umd/popper.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/moment/min/moment.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/wnumb/wNumb.js" type="text/javascript"></script>

		<!--end:: Global Mandatory Vendors -->

		<!--begin:: Global Optional Vendors -->
		<script src="/wem/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/block-ui/jquery.blockUI.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/custom/js/vendors/bootstrap-datepicker.init.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/bootstrap-datetime-picker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/bootstrap-timepicker/js/bootstrap-timepicker.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/custom/js/vendors/bootstrap-timepicker.init.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/bootstrap-maxlength/src/bootstrap-maxlength.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/custom/vendors/bootstrap-multiselectsplitter/bootstrap-multiselectsplitter.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/bootstrap-select/dist/js/bootstrap-select.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/typeahead.js/dist/typeahead.bundle.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/handlebars/dist/handlebars.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/inputmask/dist/jquery.inputmask.bundle.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/inputmask/dist/inputmask/inputmask.date.extensions.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/inputmask/dist/inputmask/inputmask.numeric.extensions.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/nouislider/distribute/nouislider.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/owl.carousel/dist/owl.carousel.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/autosize/dist/autosize.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/clipboard/dist/clipboard.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/dropzone/dist/dropzone.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/summernote/dist/summernote.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/markdown/lib/markdown.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/bootstrap-markdown/js/bootstrap-markdown.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/custom/js/vendors/bootstrap-markdown.init.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/jquery-validation/dist/jquery.validate.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/jquery-validation/dist/additional-methods.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/custom/js/vendors/jquery-validation.init.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/toastr/build/toastr.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/raphael/raphael.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/morris.js/morris.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/chart.js/dist/Chart.bundle.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/custom/vendors/bootstrap-session-timeout/dist/bootstrap-session-timeout.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/custom/vendors/jquery-idletimer/idle-timer.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/waypoints/lib/jquery.waypoints.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/counterup/jquery.counterup.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/es6-promise-polyfill/promise.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/sweetalert2/dist/sweetalert2.min.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/custom/js/vendors/sweetalert2.init.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/jquery.repeater/src/lib.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/jquery.repeater/src/jquery.input.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/jquery.repeater/src/repeater.js" type="text/javascript"></script>
		<script src="/wem/assets/vendors/general/dompurify/dist/purify.js" type="text/javascript"></script>

		<!--end:: Global Optional Vendors -->

		<!--begin::Global Theme Bundle(used by all pages) -->
		<script src="/wem/assets/js/demo1/scripts.bundle.js" type="text/javascript"></script>
		<!-- <script src="/wem/assets/plugins/global/plugins.bundle.js" type="text/javascript"></script> -->

		<!--end::Global Theme Bundle -->

		<!--begin::Page Scripts(used by this page) -->
				<script src="/wem/assets/js/demo1/pages/components/base/popovers.js" type="text/javascript"></script>
		<!-- <script src="/wem/assets/js/demo1/pages/crud/keen-datatable/base/data-local.js" type="text/javascript"></script>
		 -->
		<script src="/wem/assets/js/demo1/pages/crud/keen-datatable/base/data-local.js" type="text/javascript"></script>
       
  
		<!--end::Page Scripts -->
		
		<ul class="pagination" id ="page" style=" display: flex; padding-left: 0px; list-style: none; border-radius: 0.25rem; justify-content: center; cursor: pointer;margin: 10px;">
		
		</ul>
		
	
	</body>
			
			
		
						

<!-- end:: Content -->	
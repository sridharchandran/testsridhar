<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" >
    <!-- begin::Head test commitd basdysd sremugaan-->
    <head>
        <meta charset="utf-8"/>
        <title>wem</title>
        <meta name="description" content="Latest updates and statistic charts">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!--begin::Fonts -->
        <script src="/wem/assets/js/jscolor.js"></script> 
         <script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script>
             
        <script src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.16/webfont.js"></script>        
        <script>
        WebFont.load({
                google: {
					"families":["Poppins:300,400,500,600,700"]
        		},
                active: function() {
                    sessionStorage.fonts = true;                
                }            
		});
        </script>
        <!--end::Fonts -->
        <!--begin::Page Vendors Styles(used by this page) -->
        <link href="/wem/assets/vendors/custom/fullcalendar/fullcalendar.bundle.css" rel="stylesheet" type="text/css" />
       <!-- 
        <link href="/wem/assets/vendors/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" /> -->
        <!--end::Page Vendors Styles -->
        <!--begin::Global Theme Styles(used by all pages) -->
        <link href="/wem/assets/vendors/global/vendors.bundle.css" rel="stylesheet" type="text/css" />
        <link href="/wem/assets/css/demo1/style.bundle.css" rel="stylesheet" type="text/css" />
        <!--end::Global Theme Styles -->
        <!--begin::Layout Skins(used by all pages) -->
        <link href="/wem/assets/css/demo1/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="/wem/assets/css/demo1/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="/wem/assets/css/demo1/skins/brand/brand.css" rel="stylesheet" type="text/css" />
        <link href="/wem/assets/css/demo1/skins/aside/navy.css" rel="stylesheet" type="text/css" />
     
       
        <link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
        <!--end::Layout Skins -->
        <!-- link rel="shortcut icon" href="/wem/assets/media/logos/favicon.ico" / -->
        <style>
        .dataTables_wrapper .dataTables_paginate .paginate_button:hover{
			background: #5d78ff !important;
    		color: #ffffff;
    		border: 1px solid #5d78ff;
		}
        </style>
           <link href="/wem/assets/css/selectstyle.css" rel="stylesheet" type="text/css" />
    </head>
    <!-- end::Head -->
    <!-- begin::Body -->
    <body class="kt-quick-panel--right kt-demo-panel--right kt-offcanvas-panel--right kt-header--fixed kt-header-mobile--fixed kt-subheader--enabled kt-subheader--transparent kt-aside--enabled kt-aside--fixed kt-page--loading" >    	     
  <%
		if (null == session.getAttribute("authenticated") || session.getAttribute("authenticated").equals("") || !session.getAttribute("authenticated").equals("true")) { 			
			response.sendRedirect("/wem/login");
		    return;
		} else {%>
		<h1>User profile Page</h1>
  <table>
    <tr>
      <td>First Name</td>
      <td>${user.email}</td>
    </tr>
  </table>			
			<jsp:include page="_layout.jsp" />			
		<%}%>
                                
        <!-- begin::GlobalConfig(global config for global JS sciprts) -->
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
        
        <script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script>
        <script src="/wem/assets/vendors/global/vendors.bundle.js" type="text/javascript"></script>
        <script src="/wem/assets/js/demo1/scripts.bundle.js" type="text/javascript"></script>
        <!-- <script src="/wem/assets/vendors/custom/datatables/datatables.bundle.js"></script>
        <script src="/wem/assets/js/demo1/pages/components/datatables/basic/basic.js"></script> -->
        <!--end::Global Theme Bundle -->
        <!--begin::Page Vendors(used by this page) -->
        <script src="/wem/assets/vendors/custom/fullcalendar/fullcalendar.bundle.js" type="text/javascript"></script>
        <!-- using below causes issues with bootstrap-select components -->
        <!-- script src="/wem/assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script -->        
        <!--end::Page Vendors -->
        <!--begin::Page Scripts(used by this page) -->
        <script src="/wem/assets/js/demo1/pages/dashboard.js" type="text/javascript"></script>
        <script src="/wem/assets/js/demo1/pages/crud/forms/layouts/repeater.js" type="text/javascript"></script>
        <script src="/wem/assets/js/demo1/pages/crud/forms/widgets/bootstrap-select.js" type="text/javascript"></script>
        <script src="/wem/assets/js/demo1/pages/components/extended/session-timeout.js" type="text/javascript"></script>
        
        
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" type="text/javascript"></script>
        
        <!-- using below causes issues with bootstrap-select components -->        
        <!-- script src="/wem/assets/js/demo1/pages/crud/datatables/data-sources/html.js" type="text/javascript"></script>        
        <script src="/wem/assets/js/demo1/pages/crud/datatables/advanced/multiple-controls.js" type="text/javascript"></script -->
        <!--end::Page Scripts -->
       <script src=" /wem/assets/js/bootstrap-datepicker.js"></script>
        
     <!--   <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> -->
        
       <script src="/wem/assets/js/selectstyle.js" type="text/javascript"></script>
       <!-- <script src="https://keenthemes.com/keen/themes/keen/theme/demo1/dist/assets/js/pages/components/forms/widgets/bootstrap-daterangepicker.js"></script> -->
       
        <script>
        
         $(document).ready(function() {
            $('.kt_table_1').DataTable({
                "order": [[ 0, "asc"]],
                "columnDefs": [
            	    { "orderable": false, "targets": 4}
            	  ]
            });
            $('#showdependantexperience').modal('show');
            //Below code is for left navigation to stay open as per the corresponding page.
           if(location.search !=""){
            	var getPageName =  location.search.substring(location.search.indexOf("/")+1,location.search.indexOf("."));
        		$("li#"+getPageName).addClass("kt-menu__item--active");
        		$( "li#"+getPageName).parents("li").addClass( "kt-menu__item--open kt-menu__item--here");
           }
           $("select#exampleSelect1").select2({})
        });
        </script>
    </body>
    <!-- end::Body -->
</html>
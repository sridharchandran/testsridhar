<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
String currentView = (String) session.getAttribute("view");	 
boolean showBreadCrumbs = false;
String[] breadCrumbs = {"","",""};

if (currentView != null) {		
	String breadCrumb = currentView.substring(currentView.indexOf("/")+1, currentView.indexOf("."));
	breadCrumbs = breadCrumb.split("-");
	showBreadCrumbs = true;
	System.out.println("getvalue=" + breadCrumbs[1].substring(0, 1).toUpperCase() + breadCrumbs[1].substring(1));
	
}
%>
<!-- begin:: Subheader -->
<div class="kt-subheader kt-grid__item" id="kt_subheader">
    <div class="kt-subheader__main">
        <!-- h3 class="kt-subheader__title">
            Dashboard
        </h3 -->
        <span class="kt-subheader__separator kt-hidden"></span> 
        <%if (showBreadCrumbs) {%> 
        <div class="kt-subheader__breadcrumbs">
            <a href="#" class="kt-subheader__breadcrumbs-home"><i class="flaticon2-shelter"></i></a>
            <span class="kt-subheader__breadcrumbs-separator"></span> 
            	<a href="" class="kt-subheader__breadcrumbs-link"> 	       
	            		<%=breadCrumbs[0].substring(0, 1).toUpperCase() + breadCrumbs[0].substring(1)%>
	            		 
            	</a> 
            	<span class="kt-subheader__breadcrumbs-separator"></span> 
            	<a href="" class="kt-subheader__breadcrumbs-link">            	 	
	            		<%=breadCrumbs[1].substring(0, 1).toUpperCase() + breadCrumbs[1].substring(1)%>
	            		
            	</a>
            	<%if (breadCrumbs.length > 2 && (breadCrumbs[1].substring(0, 1).toUpperCase() + breadCrumbs[1].substring(1)).equals("Create") && (breadCrumbs[0].substring(0, 1).toUpperCase() + breadCrumbs[0].substring(1)).equals("Segment")){%> 
            		 <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">            		
	            		<%-- >>  <%=breadCrumbs[2].substring(0, 1).toUpperCase() + breadCrumbs[2].substring(1)%>     --%>        	
            		</span> 
            	<%}%>
            	<%if (breadCrumbs.length > 2 && (breadCrumbs[1].substring(0, 1).toUpperCase() + breadCrumbs[1].substring(1)).equals("Create") && (breadCrumbs[0].substring(0, 1).toUpperCase() + breadCrumbs[0].substring(1)).equals("Experience")){%> 
            		 <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">            		
	            		>>  <%=breadCrumbs[2].substring(0, 1).toUpperCase() + breadCrumbs[2].substring(1)%>            	
            		</span> 
            	<%}%>
            	
            		<%if  (breadCrumbs.length > 2 && (breadCrumbs[1].substring(0, 1).toUpperCase() + breadCrumbs[1].substring(1)).equals("View")){%> 
            		 <span class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--active">            		
	            		<%-- >> print <%=breadCrumbs[2].substring(0, 1).toUpperCase() + breadCrumbs[2].substring(1)%> --%>            	
            		</span> 
            	<%}%>
            	
            	
        </div> 
        <%}%>
    </div>
    <div class="kt-subheader__toolbar">
        <div class="kt-subheader__wrapper">
            <a href="#" class="btn btn-icon btn btn-label btn-label-brand btn-bold" data-toggle="kt-tooltip" title="Reports" data-placement="top"><i class="flaticon2-writing"></i></a>
            <a href="#" class="btn btn-icon btn btn-label btn-label-brand btn-bold" data-toggle="kt-tooltip" title="Calendar" data-placement="top"><i class="flaticon2-hourglass-1"></i></a>
            <div class="dropdown dropdown-inline" data-toggle="kt-tooltip" title="Quick actions" data-placement="top">
                <a href="#" class="btn btn-icon btn btn-label btn-label-brand btn-bold" data-toggle="dropdown" data-offset="0px,0px" aria-haspopup="true" aria-expanded="false"> <i class="flaticon2-add-1"></i> </a>
                <div class="dropdown-menu dropdown-menu-sm dropdown-menu-right">
                    <ul class="kt-nav kt-nav--active-bg" role="tablist">
                        <li class="kt-nav__item">
                            <a href="" class="kt-nav__link"> <i class="kt-nav__link-icon flaticon2-psd"></i> <span class="kt-nav__link-text">Document</span> </a>
                        </li>
                        <li class="kt-nav__item">
                            <a class="kt-nav__link" role="tab" > <i class="kt-nav__link-icon flaticon2-supermarket"></i> <span class="kt-nav__link-text">Message</span> </a>
                        </li>
                        <li class="kt-nav__item">
                            <a href="" class="kt-nav__link"> <i class="kt-nav__link-icon flaticon2-shopping-cart"></i> <span class="kt-nav__link-text">Product</span> </a>
                        </li>
                        <li class="kt-nav__item">
                            <a class="kt-nav__link" role="tab" >
                                <i class="kt-nav__link-icon flaticon2-chart2"></i> <span class="kt-nav__link-text">Report</span> 
                                <span class="kt-nav__link-badge"> <span class="kt-badge kt-badge--danger kt-badge--inline kt-badge--rounded">pdf</span> </span>
                            </a>
                        </li>
                        <li class="kt-nav__item">
                            <a href="" class="kt-nav__link"> <i class="kt-nav__link-icon flaticon2-sms"></i> <span class="kt-nav__link-text">Post</span> </a>
                        </li>
                        <li class="kt-nav__item">
                            <a href="" class="kt-nav__link"> <i class="kt-nav__link-icon flaticon2-avatar"></i> <span class="kt-nav__link-text">Customer</span> </a>
                        </li>
                    </ul>
                </div>
            </div>
            <a href="#" class="btn btn-sm btn-elevate btn-brand btn-elevate" id="kt_dashboard_daterangepicker" data-toggle="kt-tooltip" title="" data-placement="left" data-original-title="Select dashboard daterange"> <span class="kt-opacity-7" id="kt_dashboard_daterangepicker_title">Today:</span>&nbsp; <span class="kt-font-bold" id="kt_dashboard_daterangepicker_date">Jan 11</span> <i class="flaticon-calendar-with-a-clock-time-tools kt-padding-l-5 kt-padding-r-0"></i> </a>
        </div>
    </div>
</div>
<!-- end:: Subheader -->
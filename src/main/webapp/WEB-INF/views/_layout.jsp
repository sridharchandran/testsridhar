<script type="text/javascript">
function logout() {	
	document.getElementById("logout").submit();
}
</script> 
<%
String view = request.getParameter("view");
session.setAttribute("view", view); 
%>
<jsp:include page="partials/_header-base-mobile.jsp" />
<!-- begin:: Root -->
<div class="kt-grid kt-grid--hor kt-grid--root">
    <!-- begin:: Page -->
    <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--ver kt-page">
        <jsp:include page="partials/_aside-base.jsp" />
        <!-- begin:: Wrapper -->
        <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor kt-wrapper" id="kt_wrapper">
           <jsp:include page="partials/_header-base.jsp" />
            <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor">
            	<jsp:include page="partials/_subheader-subheader-v1.jsp" />                  	                                                          
                <%if(view != null && !view.equals("index")) {%>        	                	     
                	<jsp:include page="<%=view%>" />   
                <%} else {%>                	
                	<jsp:include page="partials/_content-base.jsp" />
                <%}%> 
                
                <!-- Begin::Session Timeout -->
                <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display: none;">
					<div class="modal-dialog modal-dialog-centered" role="document">
		                <div class="modal-content">                   
							<div class="modal-header">                     
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>                     
								<h4 class="modal-title">Session Timeout Notification</h4>                   
							</div>                   
							<div class="modal-body">                     
								<p>Your session is about to expire.</p>                     
								<p>Redirecting in <span class="countdown-holder">23s</span> seconds.</p>                     
								<div class="progress">                   
									<div class="progress-bar progress-bar-striped countdown-bar active" role="progressbar" style="min-width: 15px; width: 71%;">                     
										<span class="countdown-holder">23s</span>                   
									</div>                 
								</div>                   
							</div>                   
							<div class="modal-footer">                     
								<form id="logout" action="UserController" method="post">
									<input type="hidden" name="pageName" value="logout">
								</form>
						    	<a href="javascript:logout();" class="btn btn-label-brand btn-upper btn-sm btn-bold">Sign Out</a>                     
								<button id="session-timeout-dialog-keepalive" type="button" class="btn btn-primary" data-dismiss="modal">Stay Connected</button>                   
							</div>                 
						</div>
					</div>
				</div>
                <!-- End: Session Timeout -->               	
            </div>
            <jsp:include page="partials/_footer-base.jsp" />
        </div>
        <!-- end:: Wrapper -->
    </div>
    <!-- end:: Page -->
</div>
<!-- end:: Root -->
<!-- begin:: Topbar Offcanvas Panels -->
<jsp:include page="partials/_offcanvas-quick-actions.jsp" />
<!-- end:: Topbar Offcanvas Panels -->
<jsp:include page="partials/_layout-quick-panel.jsp" />
<jsp:include page="partials/_layout-scrolltop.jsp" />
<!-- jsp:include page="partials/_layout-toolbar.jsp" / -->
<!-- jsp:include page="partials/_layout-demo-panel.jsp" / -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.onwardpath.wem.entity.User" %>
<%@ page import="com.onwardpath.wem.entity.Organization" %>
<!-- begin:: Content -->

<script>
	function myCopy() {
		const copyText = document.getElementById("myInput").textContent;
		const textArea = document.createElement('textarea');
		textArea.textContent = copyText;
		document.body.append(textArea);
		textArea.select();
		document.execCommand("copy");
	}
</script>
<div class="kt-content  kt-grid__item kt-grid__item--fluid"
	id="kt_content">
	<%
		int org_id = ((User) session.getAttribute("user")).getOrgid();
		int site_id = ((User) session.getAttribute("user")).getAnalytics_id();
		String org_domain = ((Organization) session.getAttribute("org")).getDomain();
		
		String Org_name	  =	((Organization) session.getAttribute("org")).getName();
	%>
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
	<div class="kt-portlet kt-portlet--mobile">
		<!-- begin::portlet -->
		<div class="kt-portlet__head">
			<!-- begin::portlet-head -->
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Settings</h3>
			</div>
		</div>
		<!-- end::portlet-head -->
		<div class="kt-portlet__body">
			<!-- begin::portlet-body -->

			
				<input type="hidden" name="pageName" value="profilesetting">
				<input type="hidden" name="role" value="1"> <input
					type="hidden" name="orgId" value='<%=org_id%>'>
				<!-- Organization Settings -->
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Organization</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<input type="text" class="form-control" name="org"
							aria-describedby="emailHelp"
							value="<%=Org_name%>" disabled>
					</div>
				</div>

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Domain</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<input type="text" class="form-control" name="domain"
							aria-describedby="emailHelp"
							value="<%=org_domain%>" disabled>
					</div>
				</div>

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Header
						Embed Code</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<code id="myInput">
							&lt;script&gt; var _gr = window._gr || {}; _gr.orgID = "<%=org_id%>";
							_gr.siteID = "<%=site_id%>";
							_gr.url = "http://demo.onwardpath.com/wws/";
							(function() { var u= _gr.url; var d=document,
							g=d.createElement('script'),
							s=d.getElementsByTagName('script')[0]; g.type='text/javascript';
							g.async=true; g.defer=true; g.src=u+'georeach.js';
							s.parentNode.insertBefore(g,s); })(); &lt;/script&gt;
						</code>
						<br> <br>
						<button type="button" class="btn btn-outline-brand"
							onclick="myCopy()">Copy</button>
					</div>

				</div>

			<!-- 	<div class="form-group row">
					<label class="col-for m-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<button type="submit" class="btn btn-primary">Update</button>
						&nbsp;

					</div>
				</div> -->
			

		</div>
		<!-- end::portlet-body -->
	</div>
</div>
<!-- end:: Content -->

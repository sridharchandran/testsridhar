<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

	var expDetailsObj = {};
	var segment = null;
	var segment_id = null;
	var segment_name = null;
	var url = null;

	function selectIndex() {
		segment = document.getElementById("segment");
		segment_id = segment.value;
		segment_name = segment.options[segment.selectedIndex].innerHTML;
		url = document.getElementById("url").value;

	}

	function add() {
		var segment = document.getElementById("segment");
		var segment_id = segment.value;
		var segment_name = segment.options[segment.selectedIndex].innerHTML;
		selectIndex();
		if (segment_id in expDetailsObj) {
			swal.fire("Segment " + segment_name
					+ " already added. Select a different segment.");
		} else {

			var url = document.getElementById("url").value;
			expDetailsObj[segment_id] = url;
			if (url.length > 0) {
				var stage = document.getElementById("stage");
				stage.innerHTML += '<div id="'+segment_name+'" class="card-body"><img src="'+url+'" class="rounded">&nbsp;<button type="button" class="btn btn-outline-info btn-pill" onclick="remove(\''
						+ segment_name
						+ '\','
						+ segment_id
						+ ')">'
						+ segment_name
						+ '<i class="la la-close"></i></button></div>';
				stage.style.display = "block";
				var library = document.getElementById("library");
				library.style.display = "none";
			} else {
				swal.fire("Enter Image URL");
			}
		}
	}
	function remove(element, segment_id) {
		var displayElement = document.getElementById(element);
		delete expDetailsObj[segment_id];
		displayElement.style.display = "none";
	}
	function showLibrary() {
		var library = document.getElementById("library");
		library.style.display = "block";
	}
	function getImageURL(x) {
		var imageID = x;
		var imageUrl = document.getElementById(imageID).src;
		document.getElementById("url").value = imageUrl;
	}
	function saveExperience() {

		var name = document.getElementById('name').value;
		if(name){
			var type = "image";
			if (JSON.stringify(expDetailsObj) !== '{}') {
				document.getElementById("experience-form").type.value = type;
				document.getElementById("experience-form").experienceDetails.value = JSON.stringify(expDetailsObj);
				document.getElementById("experience-form").method = "post";
				document.getElementById("experience-form").action = "image";
				document.getElementById("experience-form").submit();
			}
			else{
				swal.fire("Please Enter Atleast one Image");
			}
		} else {
			swal.fire("Please Enter Experience Name");
		}
	}

	window.addEventListener("load", function() {
		selectIndex();
		localStorage.setItem("exp_type", "image");
	});
	/* function cancelOperation() {
	location.replace("?view=pages/experience-create-image.jsp")
} */
</script>

<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid"
	id="kt_content">
	 <% 
		String message = (String) session.getAttribute("message");

		//SegmentRepository segmentRepository = new SegmentRepository();
		int org_id = (Integer) session.getAttribute("org_id");
		
				if (message != null && !message.equals("")) {
			String icon = "flaticon-paper-plane";
			if (message.startsWith("Error"))
				icon = "flaticon-warning";

			String name = "";
			String experience = "";
			String organization = "";
			if (message.contains("#")) {
				String codeConstructor = message.substring(message.indexOf("#") + 1);
				message = message.substring(0, message.indexOf("#"));
				String[] decoder = codeConstructor.split("#");
				name = decoder[0].substring(decoder[0].indexOf("=") + 1);
				experience = decoder[1].substring(decoder[0].indexOf("=") + 1);
				organization = decoder[2].substring(decoder[0].indexOf("=") + 1);
			}
	%>
 --	<%-- <div class="row">
		<div class="col">
			<div class="alert alert-light alert-elevate fade show" role="alert">
				<div class="alert-icon">
					<i class="<%=icon%> kt-font-brand"></i>
				</div>
				<div class="alert-text">
					<%=message%>
					<!-- Button trigger modal -->
					&nbsp;&nbsp;
					<button type="button" class="btn btn-outline-brand"
						data-toggle="modal" data-target="#exampleModalCenter">
						View Code</button>
				</div>
			</div>
		</div>
	</div> --%>

	<!-- begin::modal -->
	<%-- <div class="kt-section__content kt-section__content--border">
		<!-- Modal -->
		<div class="modal fade" id="exampleModalCenter" tabindex="-1"
			role="dialog" aria-labelledby="exampleModalCenterTitle"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalCenterTitle">
							Embed Code for:
							<%=name%></h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">
						<h3>Header</h3>
						<code>
							&lt;!-- Begin::GeoSmart-Header --&gt; &lt;script&gt; function
							geo() { var serviceURL=
							"http://lab01.onwardpath.com/GeoTargetService/app/georeach/get?id=<%=experience%>&org_id=<%=org_id%>&s=";
							var geoElement = document.getElementById("Geo-<%=name%>-<%=experience%>");
							var url = new URL(window.location.href); var c =
							url.searchParams.get("s"); serviceURL += c;
							console.log(serviceURL); var xhttp = new XMLHttpRequest();
							xhttp.responseType = 'json'; xhttp.onreadystatechange =
							function() { if (this.readyState == 4 && this.status == 200) {
							let data = this.response; geoElement.innerHTML =
							data[1].embedCode; } }; xhttp.open("GET", serviceURL);
							xhttp.send(); } window.onload = geo; &lt;/script&gt; &lt;!--
							End::GeoSmart-Header --&gt;
						</code>
						<h3>Body</h3>
						<code>
							&lt;!-- Begin::GeoSmart-Body --&gt; &lt;div id="Geo-<%=name%>-<%=experience%>"&gt;&lt;/div&gt;
							&lt;!-- End::GeoSmart-Body --&gt;
						</code>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-brand">Copy</button>
						<button type="button" class="btn btn-outline-brand"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end::modal -->
	--%>
	<% 
		session.setAttribute("message", "");
		}
	%>
 	<!--begin::Portlet-->
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Create Image Experience</h3>
			</div>
		</div>

		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form">
			<div class="kt-portlet__body">

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Segment</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<select id="segment" class="custom-select form-control"
							data-width="300" onchange="javascript:selectIndex()">
							
														<c:forEach items="${seglist}" var="segment">
							 
							<option value="${segment.id}">${segment.name}</option>
														</c:forEach>												
							
													</select>
					</div>
				</div>

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Image</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<input id="url" type="text"
							class="form-control col-lg-9 col-sm-12"
							aria-describedby="emailHelp" placeholder="URL" data-width="100">
						Enter Image URL or <a href="#" onclick="javascipt:showLibrary();">Pick
							from library</a>
					</div>
				</div>

				<div class="kt-section__content kt-section__content--border">
					<div id="library" style="display: none;">
						<img id="image1" onclick="getImageURL('image1')"
							src="https://www.associatedbank.com/content/image/mobile_upgrade_img_banking"
							class="rounded" style="width: 250px;" /> <img id="image2"
							onclick="getImageURL('image2')"
							src="https://www.associatedbank.com/content/image/mobile_upgrade_img_mobile"
							class="rounded" style="width: 250px;" /> <img id="image3"
							onclick="getImageURL('image3')"
							src="https://cdn.oectours.com/media/cds/banks/5231/59750.png"
							class="rounded" style="width: 250px;" /> <img id="image4"
							onclick="getImageURL('image4')"
							src="https://cdn.oectours.com/media/cds/banks/5231/81461.png"
							class="rounded" style="width: 250px;" /> <img id="image5"
							onclick="getImageURL('image5')"
							src="https://www.associatedbank.com/content/image/OLB_LP_Image"
							class="rounded" style="width: 250px;" /> <img id="image6"
							onclick="getImageURL('image6')"
							src="https://x7i5t7v9.ssl.hwcdn.net/cds/banks/5231/81626.png"
							class="rounded" style="width: 250px;" />
					</div>
				</div>

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<button type="reset" class="btn btn-accent"
							onclick="javascript:add()">Add</button>
					</div>
				</div>

				<div class="kt-separator kt-separator--border-dashed"></div>
				<div class="kt-separator kt-separator--height-sm"></div>

				<div class="kt-section__content kt-section__content--border">
					<div id="stage" style="display: none;"></div>
				</div>

			</div>
		</form>
		<!--end::Form-->

		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="experience-form">
			<div class="kt-portlet__body">

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Experience
						Name</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<input name="name" id="name" type="text" class="form-control"
							aria-describedby="emailHelp" placeholder="Name"> <span
							class="form-text text-muted">Give a name for this
							experience</span>
					</div>
				</div>

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<div id="hidden-form" style="display: none;">
							<input type="hidden" name="pageName" value="create-experience">
							<input type="hidden" name="type"> <input type="hidden"
								name="experienceDetails"> <input type="hidden"
								name="segment_id"> <input type="hidden" name="url">
						</div>
						<button type="reset" class="btn btn-primary"
							onclick="saveExperience();">Save</button>
						<button type="reset" class="btn btn-secondary">Cancel</button>
					</div>
				</div>
			</div>
		</form>
		<!--end::Form-->
	</div>
	<!--end::Portlet-->
</div>
<!--end::Content-->
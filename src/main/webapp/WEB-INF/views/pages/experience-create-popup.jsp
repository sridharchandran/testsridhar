<!-- Owner:Gurujegan --Implementing this page for Popup functionality-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%> 

<script type="text/javascript">
	var expDetailsObj = {};
	var cnt_details= {};
	var segment = null;
	var segment_id = null;
	var segment_name = null;
	var content = null;
	var popup = null;
	var bgcolor = null;
	var bgcolor_txt = null;
	var bgimgurl = null;
	var width = null;
	var height = null;
	var ptype = null;
	var modalcontent = null; 
	var modalurl = null; 
	function selectIndex() {
		segment = document.getElementById("segment");
		segment_id = segment.value;
		segment_name = segment.options[segment.selectedIndex].innerHTML;
		popup = document.getElementById("popup");

		//set modal content from the UI
		setModalContent();
		content = exampleModalLongInner.outerHTML;
		modalcontent = document.getElementById("content");
		modalurl = document.getElementById("iframe-url"); 
	}
	function add(event) {
		selectIndex();
		if (segment_id in cnt_details) {
			swal.fire("Segment " + segment_name
					+ " already added please select a different segment.");
		} else {
			if (modalurl.value.length > 0 || (modalcontent.value.length > 0 || bgimgurl.length > 0)) {
				
				var seg_data = {};
				
				seg_data.popup_type= popup.options[popup.selectedIndex].value;
				seg_data.popup_body = content;
				seg_data.popup_html =  modalcontent.value == "" ? "null" : modalcontent.value;
				seg_data.popup_url = modalurl.value == "" ? "null" : modalurl.value;
				seg_data.width = document.getElementById("width").value;
				seg_data.height = document.getElementById("height").value;
				seg_data.bg_color_txt = document.getElementById("bgcolor_txt").value;
				seg_data.bg_color = document.getElementById("bgcolor").value;
				seg_data.bg_img_url = document.getElementById("bgimgurl").value;
				
				cnt_details[segment_id] = seg_data;
				
			
				
				var stage = document.getElementById("stage");
				stage.innerHTML += '<div id="'+segment_name+'" class="card-body">'
						//+ content
						+ '&nbsp;<button type="button" class="btn btn-outline-info btn-pill" onclick="remove(\''
						+ segment_name
						+ '\','
						+ segment_id
						+ ',event)">'
						+ segment_name
						+ '<i class="la la-close"></i></button></div>';
				stage.style.display = "block";
			} else
				swal.fire("Please enter any content");
		}

	}
	function remove(element, segment_id,event) {
		delete cnt_details[segment_id];
		var stage =  document.getElementById("stage");
		stage.removeChild(event.currentTarget);
	}
	function saveExperience() {
		var page_events = getCheckedEvents();
		var popup_cookie = document.getElementById('popup_cookie').value;
		var popup_delay = document.getElementById('popup_delay').value;
		var name = document.getElementById('name').value;
		var type = "popup";
		document.getElementById("experience-form").type.value = type;
		document.getElementById("experience-form").page_events.value = page_events;
		document.getElementById("experience-form").popup_cookie.value = popup_cookie;
		document.getElementById("experience-form").popup_delay.value = popup_delay;
		document.getElementById("experience-form").experienceDetails.value = JSON
				.stringify(cnt_details);
		document.getElementById("experience-form").method = "post";
        
		
		if (Object.entries(cnt_details).length <= 0) {
			swal.fire("Please add atleast one content by Clicking ADD Button");
		} else {
			document.getElementById("experience-form").action = "create-popup";
			document.getElementById("experience-form").submit();
		}

	}
	function getCheckedEvents() {
		var checkedValue = "";
		var inputElements = document.getElementById('page_events')
				.getElementsByTagName("input");

		for (var i = 0; inputElements[i]; ++i) {
			if (inputElements[i].checked) {
				checkedValue += inputElements[i].value + "|";
			}
		}

		checkedValue = checkedValue.slice(0, checkedValue.length - 1);
		return checkedValue;
	}

	function showChild(event) {
		var el = document.getElementById(event.target.id);
		var opt_val = el.options[el.selectedIndex].value;
		var opt_text = el.options[el.selectedIndex].text;

		var el_htm = document.getElementById("for-html");
		var el_ifr = document.getElementById("for-iframe");
		
		if (opt_val === "html") {
			el_htm.style.display = "flex";
			el_ifr.style.display = "none";
			document.getElementById("bgimgurl").value = "";
		} else {
			/* document.getElementById("bgimgurl").disabled = true;
			document.getElementById("bgcolor").style.pointerEvents = "none"; */
			el_htm.style.display = "none";
			el_ifr.style.display = "flex";
			document.getElementById("content").value = "";
		}
	}
	//Validate Advanced Settings Checkbox & return its content
	function isChecked(event) {
		let el_id = event.target.attributes.for.value;
		if (event.currentTarget.checked == true)
			document.getElementById(el_id).style.display = "block";
		else
			document.getElementById(el_id).style.display = "none";

	}

	function changeIcon(event) {
		var icon_el = event.target.children[0];
		icon_el.setAttribute("class", "flaticon-folder-1");

	}

	function preview(event) {
		setModalContent();
	}

	//JS code for set content in the modal
	function setModalContent() {
		var prvw_el = document.getElementById("preview");
		var prvw_style_el = document.getElementById("preview-style");

		var ifr_el = document.getElementById("iframe-element");
		var ifr_url_val = document.getElementById("iframe-url").value;

		bgcolor = "background-color:#"
				+ document.getElementById("bgcolor").value;
		bgcolor_txt =  "#"+document.getElementById("bgcolor_txt").value;
		bgimgurl = "url('" + document.getElementById("bgimgurl").value
				+ "')";
		width = document.getElementById("width").value + "px";
		height = document.getElementById("height").value + "px";

		prvw_style_el.setAttribute("style", bgcolor);
		prvw_style_el.setAttribute("margin-left", "auto");
		prvw_style_el.setAttribute("margin-right", "auto");
		prvw_style_el.style.backgroundImage = bgimgurl;
		prvw_style_el.style.backgroundSize = "contain";
		prvw_style_el.style.width = width;
		prvw_style_el.style.height = height;
		
		
		
		var ptype = popup.options[popup.selectedIndex].value;
		prvw_el.style.padding = "0.25em";
		prvw_el.style.color = bgcolor_txt;
		if (ptype == "html") {
			prvw_el.innerHTML = document.getElementById("content").value;
		} else if (ptype == "iframe") {
			ifr_el.firstElementChild.setAttribute("src", ifr_url_val);
			var cln = ifr_el.cloneNode(true);
			cln.style.display = "block";
			prvw_el.innerHTML = cln.outerHTML;
		}
	}

	window.addEventListener("load", function() {
		selectIndex();
		document.getElementById("adv-settings").style.display = "none";
		
			localStorage.setItem("exp_type", "popup");
		
	});
</script>

<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid"
	id="kt_content">
	<%
		String message = (String) session.getAttribute("message");
	
	//SegmentRepository segmentRepository = new SegmentRepository();
	int org_id = (Integer) session.getAttribute("org_id");
	/* 		Map<Integer, String> segments = segmentRepository.getOrgSegments(org_id);
			if (segments.size() == 0) {
		message = "Error: No Segments are configured. Create a Segment <a class='kt-link kt-font-bold' href='?view=pages/segment-create-geo.jsp'>here</a>";
			} */

	if (message != null && !message.equals("")) {
		String icon = "fa fa-cocktail";
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
	<div class="row">
		<div class="col">
			<div class="alert alert-light alert-elevate fade show" role="alert">
				<div class="alert-icon">
					<i class="<%=icon%> kt-font-brand"></i>
				</div>
				<div class="alert-text">
					<%=message%>
					<!-- Button trigger modal -->
					<!-- button type="button" class="btn btn-outline-brand" data-toggle="modal" data-target="#exampleModalCenter">
							View Code
						</button -->
				</div>
			</div>
		</div>
	</div>

	<%
		session.setAttribute("message", "");
	}
	%>

	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Create Popup Experience</h3>
			</div>
		</div>
		<!--begin::Content-->
		<div id="basic" class="card-body-wrapper"
			aria-labelledby="headingOne3" style="">
			<div class="card-body">
				<!--begin::Form-->
				<form class="kt-form kt-form--label-right">
					<div class="kt-portlet__body">

						<div class="form-group row">
							<label class="col-form-label col-lg-3 col-sm-12">Segment</label>
							<div class="col-lg-4 col-md-9 col-sm-12">
								<select id="segment" class="custom-select form-control"
									data-width="300" onchange="javascript:selectIndex()">
									<%-- 		<%
											for (Map.Entry<Integer, String> entry : segments.entrySet()) {
												Integer key = entry.getKey();
												String val = entry.getValue();
												out.println("<option value='" + key + "'>" + val + "</option>");
											}
										%> --%>
									<c:forEach items="${seglist}" var="segment">
										<option value="${segment.id}">${segment.name}</option>
									</c:forEach>
										
								</select>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-form-label col-lg-3 col-sm-12">Popup
								Content</label>
							<div class="col-lg-4 col-md-9 col-sm-12">
								<select id="popup" class="custom-select form-control"
									data-width="300" onchange="showChild(event)">
									<option value="html">HTML Code</option>
									<option value="iframe">URL</option>
								</select>
							</div>
						</div>
						<div class="form-group row">


							<label class="col-lg-3 col-sm-12 col-form-label">Background
								Color:</label>
							<div class="col-lg-2 col-md-9 col-sm-12">
								<input id="bgcolor" type="text" class="form-control jscolor">
							</div>
							<label class="col-lg-1 col-form-label">Width (px):</label>
							<div class="col-lg-1 col-md-9 col-sm-12">
								<input id="width" type="text" value="400" class="form-control">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-lg-3 col-sm-12 col-form-label">Text
								Color:</label>
							<div class="col-lg-2 col-md-9 col-sm-12">
								<div class="kt-input-icon">
									<input id="bgcolor_txt" type="text"
										class="form-control jscolor">
								</div>
							</div>
							<label class="col-lg-1 col-form-label">Height (px):</label>
							<div class="col-lg-1 col-md-9 col-sm-12">
								<div class="kt-input-icon">
									<input id="height" type="text" value="250" class="form-control">
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-lg-3 col-sm-12 col-form-label">Background
								ImageURL:</label>
							<div class="col-lg-4 col-md-9 col-sm-12">
								<div class="kt-input-icon">
									<input id="bgimgurl" type="text" class="form-control">
								</div>
							</div>
						</div>

						<!--  Preview Button -->
						<div class="form-group row" id="for-html">
							<label class="col-form-label col-lg-3 col-sm-12">Content
								(Text/HTML)</label>
							<div class="col-lg-4 col-md-9 col-sm-12">
								<textarea id="content" type="text"
									class="form-control col-lg-9 col-sm-12"
									aria-describedby="emailHelp" placeholder="Enter Text" rows="10"
									cols="10"></textarea>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-form-label col-lg-3 col-sm-12"></label>
							<div class="col-lg-4 col-md-9 col-sm-12">
								<button type="button" class="btn btn-accent" data-toggle="modal"
									data-target="#exampleModalLongInner"
									onclick="javascript:preview(event)">Preview</button>
							</div>
							<!--  Iframe for External URL View -->
							<div class="embed-responsive embed-responsive-16by9"
								id="iframe-element" style="display: none; height: 100%">
								<iframe class="embed-responsive-item" src=""></iframe>
							</div>


							<div class="modal fade" id="exampleModalLongInner" tabindex="-1"
								role="dialog" aria-labelledby="exampleModalLongTitle"
								aria-hidden="true" style="display: none;">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content" id="preview-style">
										<div class="modal-body" id="preview">
											<div id="preview" class="kt-scroll ps" data-scroll="true"
												style="overflow: hidden;"></div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-form-label col-lg-3 col-sm-12"></label>
							<div class="col-lg-4 col-md-9 col-sm-12">
								<div class="kt-checkbox-inline">
									<label class="kt-checkbox"> <input id="is-adv-settings"
										for="adv-settings" type="checkbox" value=""
										onclick="isChecked(event);">Advanced Settings<span></span>
									</label>
								</div>
							</div>
						</div>

						<div class="form-group row" id="for-iframe" style="display: none;">
							<label class="col-form-label col-lg-3 col-sm-12"> URL</label>
							<div class="col-lg-4 col-md-9 col-sm-12">
								<input id="iframe-url" type="text"
									class="form-control col-lg-9 col-sm-12"
									aria-describedby="emailHelp" data-toggle="tooltip"
									data-original-title="Tooltip on bottom"
									placeholder="Enter or Paste URL" />
							</div>
						</div>


						<div class="form-group row" id="adv-settings"
							style="display: none;">
							<div class="kt-section__content kt-section__content--border">
								<div class="form-group">
									<div class="card-header kt-font-bolder">Choose the Page
										Events here</div>
									<div class="kt-separator--space-md"></div>
									</br>
									<div class="kt-checkbox-inline" id="page_events">
										<label class="kt-checkbox"> <input type="checkbox"
											checked="" value="load" for="for-onload"
											onclick="isChecked(event);">On Page Load<span></span></label>
										<label class="kt-checkbox"> <input type="checkbox"
											value="pageexit">On Page Exit<span></span></label> <label
											class="kt-checkbox"> <input type="checkbox"
											value="scroll">On Page Scroll<span></span></label> <label
											class="kt-checkbox"> <input type="checkbox"
											value="idle">On Page Idle<span></span></label>
									</div>
									<span class="form-text text-muted"></span>
								</div>




								<div class="card-header kt-font-bolder">Popup Cookie</div>
								<div class="form-group row">
									<label class="col-3 col-form-label">Cookie Time (hours)</label>
									<div class="col-lg-4 col-md-9 col-sm-12">
										<input id="popup_cookie" class="form-control" type="text"
											value="0"> <span class="form-text text-muted">Shows
											popup to visitor only once in the time period . Set to 0 to
											shown on every page visit.</span>
									</div>
								</div>
								<div id="for-onload">
									<div class="card-header kt-font-bolder">Popup Delay</div>
									<div class="form-group row">
										<label class="col-3 col-form-label">Delay Time
											(seconds)</label>
										<div class="col-lg-4 col-md-9 col-sm-12">
											<input id="popup_delay" class="form-control" type="text"
												value="0"> <span class="form-text text-muted">Delay
												pop up from being displayed. Set 0 to show popup instantly.</span>
										</div>
									</div>

								</div>

							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-lg-3 col-sm-12"></label>
							<div class="col-lg-4 col-md-9 col-sm-12">
								<button type="button" class="btn btn-accent"
									onclick="javascript:add(event)">Add</button>
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
			</div>
		</div>

		<!--end::Accordion-->



		<!--begin::Form-->
		<form id="experience-form">
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

				<div class="form-group row" class="kt-form">
					<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<div id="hidden-form" style="display: none;">
							<input type="hidden" name="pageName" value="create-experience">
							<input type="hidden" name="type"> <input type="hidden"
								name="experienceDetails"> <input type="hidden"
								name="segment_id"> <input type="hidden" name="url">
							<input type="hidden" name="page_events"> <input
								type="hidden" name="popup_cookie"> <input type="hidden"
								name="popup_delay">
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
	<!--begin::Portlet-->
</div>
<!--end::Content-->
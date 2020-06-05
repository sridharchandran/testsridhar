<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<script type="text/javascript">
	function suggestArea(obj) {
		var geoloc = document.getElementById("geoloc").value;
		var suggest_list = document.getElementById("suggest_list");
		var frag = document.createDocumentFragment();
		var serviceName = document.getElementById("geotype").options[document.getElementById("geotype").selectedIndex].value
		if (geoloc.length >= 3) {
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200
						&& this.response != "null") {
					
					var response = JSON.parse(this.response);
					suggest_list.innerHTML = "";
					response.forEach(function(item) {
						var option = document.createElement('option');
						//option.value = item.substring(0,item.indexOf(","));
						//option.textContent = item.substring(item.indexOf(",")+1,item.length).trim();
						option.value = item;
						frag.appendChild(option);
					});
					suggest_list.appendChild(frag);
				}
			};
			xhttp.open("GET", "AjaxController?service="+serviceName+"_suggestions&geoloc="
					+ geoloc);
			xhttp.send();
		}
	}
	function add() {
		var geotype = document.getElementById("geotype").value;
		var georule = document.getElementById("georule").value;
		var geoloc = document.getElementById("geoloc").value;
		if(geotype == "country")
		{
		var location = geoloc.substring(0,geoloc.indexOf(","));
		geoloc = location;
		console.log("loc"+geoloc);
		
		}
		//alert(geoloc);
		if(geoloc.length > 0){
		var geocondition = georule + ":" + geotype + ":" + geoloc;
		var select = document.getElementById("dynamic-select");
		var index = select.options.length;
		select.options[index] = new Option(geocondition, geocondition);
		document.getElementById("geoloc").value = ""; //Clear the Text Field
		document.getElementById("suggest_list").innerHTML = ""; //Clear Suggestion list
		var x = document.getElementById("geobucket");
		geoloc = geoloc.replace(/\s+/g, ''); //Remove white space before displaying. Note: We are using the name as-is while saving the locations to segment table.	
		geoloc = geoloc.replaceAll(',', ''); //Remove comma before displaying.
		//alert(geoloc);
		if (georule == "include") {
			x.innerHTML += '<button id="'
					+ geoloc
					+ '" type="button" class="btn btn-outline-info btn-pill" onclick="remove('
					+ geoloc + ',' + index + ')">' + geoloc
					+ '<i class="la la-close"></i></button>&nbsp;';
			//alert(x.innerHTML);
		} else {
			x.innerHTML += '<button id="'
					+ geoloc
					+ '" type="button" class="btn btn-outline-danger btn-pill" onclick="remove('
					+ geoloc + ',' + index + ')">' + geoloc
					+ '<i class="la la-close"></i></button>&nbsp;';
			//alert(x.innerHTML);
		}
		x.style.display = "block";
		
		}else{
			swal.fire("Area value should not be empty.")
		}
		document.getElementById("geoloc").focus();
	}
	function remove(element, index) {
		//alert(element);
		//alert(index);
		var select = document.getElementById("dynamic-select");
		select.remove(index);
		element.style.display = "none";
	}
	function removeAll() {
		var select = document.getElementById("dynamic-select");
		select.options.length = 0;
		var x = document.getElementById("geobucket");
		x.style.display = "none";
	}
	function saveSegment() {
		//TODO: Validate Rules and display error for conflicting/invalid rules
		var x = document.getElementById("dynamic-select");
		if(x.length > 0){
		var segmentName = document.getElementById("segmentName").value
		var txt = "";
		var i;
		for (i = 0; i < x.length; i++) {
			if (i == 0) {
				txt = x.options[i].text;
			} else {
				txt = txt + "|" + x.options[i].text;
			}
		}
		txt = "loc{" + txt + "}";
		document.getElementById("segmentRules").value = txt;
		if(segmentName.replace(" ","").length > 0){
		document.getElementById("segment-form").method = "post";
		document.getElementById("segment-form").action = "SegmentController";
		document.getElementById("segment-form").submit();
		}else{
			swal.fire("Segment Name value should not be empty.")
			document.getElementById("segmentName").focus()
		}
		}else{
			swal.fire("Area value should not be empty. Please Select any")
			document.getElementById("geoloc").focus()
		}
	}

	String.prototype.replaceAll = function(search, replacement) {
		var target = this;
		return target.replace(new RegExp(search, 'g'), replacement);
	};
	
	//Created new function for dropdown(City/State/Country) - Sre.
	function selectedValue(selectedValue){
		var selectedTagId = selectedValue.getAttribute("id")
		var setSelectedValue = document.getElementById(selectedTagId)
		var optionSelectedVal = setSelectedValue.options[setSelectedValue.selectedIndex].getAttribute("value") 
		
		$("#"+selectedTagId+" option").each(function(){
			if(optionSelectedVal == $(this).val()){
				$(this).attr("selected","selected")
			}else{
				$(this).removeAttr("selected")
			}
	    });
	}
</script>

<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid"
	id="kt_content">
	<%
		String message = (String) session.getAttribute("message");
		if (message != null && !message.equals("")) {
			String icon = "fa fa-chart-pie";
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
	<!--begin::Portlet-->
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">

				<h3 class=\"kt-portlet__head-title\">Create Geo Segment</h3>
			</div>
		</div>
		<div class="kt-portlet__body">
			<div class="kt-portlet__content">
				Create segments based on location of the visitor. For example, you
				can create a segment called <span class="badge badge-warning">West
					Coast</span> with criteria <span class="badge badge-secondary">Include
					- State - California</span>, <span class="badge badge-secondary">Include
					- State - Oregon</span> & <span class="badge badge-secondary">Include
					- State - Washington</span>
			</div>
		</div>
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form">
			<div class="kt-portlet__body">

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Criteria</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<select id="georule"
							class="form-control form-control--fixed kt_selectpicker"
							data-width="100">
							<option value="include">Include</option>
							<option value="exclude">Exclude</option>
						</select> <select id="geotype"
							class="form-control form-control--fixed kt_selectpicker"
							data-width="120" onchange="selectedValue(this)">
							<option value="city">City</option>
							<option value="state">State</option>
							<option value="country">Country</option>
						</select>
					</div>
				</div>

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Area</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<input id="geoloc" type="text"
							class="form-control col-lg-9 col-sm-12"
							aria-describedby="emailHelp" placeholder="Name"
							list="suggest_list" onkeyup="javascript:suggestArea(this)">
						<datalist id="suggest_list"></datalist>
						<!-- div class="ui-widget">
							<label for="us_city">Area:</label> <input id="geoloc" type="text" class="form-control col-lg-9 col-sm-12" placeholder="Enter Your Location">
						</div -->
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

				<div id="geobucket" style="display: none;">
					<div class="kt-section__content kt-section__content--border">
					</div>
				</div>

			</div>
		</form>
		<!--end::Form-->

		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="segment-form">
			<div class="kt-portlet__body">

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Segment
						Name</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<input name="segmentName" id="segmentName" type="text"
							class="form-control col-lg-9 col-sm-12"
							aria-describedby="emailHelp" placeholder="Name"> <span
							class="form-text text-muted">Give a name for this segment</span>
					</div>
				</div>

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<div id="hidden-form" style="display: none;">
							<input type="hidden" name="pageName"
								value="segment-create-geo.jsp">
							<!-- input type="hidden" id = "segmentName" name="segmentName"  -->
							<input type="hidden" id="segmentRules" name="segmentRules">
							<select id="dynamic-select" size="2"></select>
						</div>
						<button type="reset" class="btn btn-primary"
							onclick="saveSegment();">Save</button>
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
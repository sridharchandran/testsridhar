<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<style>
.ttc{
	text-transform:capitalize
}
</style>
<script type="text/javascript">


var obj = [];
obj.devices=["Desktop","Mobile","Tablet"];
obj.os = ["MacOS", "Windows", "Linux","Mobile"];
obj.browser = ["chrome","firefox","safari","edge","IE","Opera"];
console.log(obj["devices"])
var buttonlabelArr = new Array();
var techTypeArr = new Array();

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
		var techRule = document.getElementById("technologyrule").value;
		var techList = document.getElementById("technologylist").value;
		var techDynamicSelection = document.getElementById("dynamicselection").value;
		console.log("tech value is :"+techRule+" and :: "+techList+" and ksjdn:"+techDynamicSelection)

		//This variable is to checking the restriction to allow user to choose only one device,os and browser
		/* if($.inArray(techList,techTypeArr) == 0){
			
		} */
		
		console.log("techTypeArr value is ::"+techTypeArr+" and its techlist is ::"+techList);
		if($.inArray(techRule+"-"+techList,techTypeArr) != -1){
			swal.fire("Only one time the "+techRule+"-"+techList+" value added in technology");
		}else{
			
			
			var techCondition = techRule + "-" + techList + "-" + techDynamicSelection;
			var buttonlabel = techCondition.replace(/:/g, "");
			buttonlabel = techCondition.replace(".", "");	
			var select = document.getElementById("dynamic-select");
			var index = select.options.length;
			select.options[index] = new Option(techCondition, techCondition);
			//Reset value into it.	
			document.getElementById("technologyrule").reset;
			document.getElementById("technologylist").reset;
			document.getElementById("dynamicselection").reset;
			var x = document.getElementById("technologybucket");
			
			if(($.inArray(buttonlabel, buttonlabelArr) == -1)){
			if(techRule == "include") {		
				x.innerHTML += '<button id="'+buttonlabel+'" data-typeval="'+techList+'" type="button" class="btn btn-outline-info btn-pill" onclick="remove(this)">'+techCondition+'<i class="la la-close"></i></button>&nbsp;';		
			} else {		
				x.innerHTML += '<button id="'+buttonlabel+'" data-typeval="'+techList+'" type="button" class="btn btn-outline-danger btn-pill" onclick="remove(this)">'+techCondition+'<i class="la la-close"></i></button>&nbsp;';		
			}
				x.style.display = "block";
				document.getElementById("technologyrule").focus();
				buttonlabelArr.push(buttonlabel);
				techTypeArr.push(techRule+"-"+techList);
			}else{
			 swal.fire("The Same Criteria already exist for technology segment.")
			}
		}
	}
	function remove(buttonId) {
		var tecRule = buttonId.id.split("-")[0];
		var tecType = buttonId.id.split("-")[1];
		var buttonIdName = buttonId.id
		$('#'+buttonId.id).remove();
		techTypeArr = $.grep(techTypeArr, function(value) {
  			return value != tecRule+"-"+tecType;
		});
		buttonlabelArr = $.grep(buttonlabelArr, function(value) {
  			return value != buttonIdName;
		});
	}
	function removeAll() {
		var select = document.getElementById("dynamic-select");
		select.options.length = 0;
		var x = document.getElementById("technologybucket");
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
		txt = "tech{" + txt + "}";
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
			swal.fire(" Provide value for technology rule. Please Select any")
			document.getElementById("technologyrule").focus()
		}
	}

	String.prototype.replaceAll = function(search, replacement) {
		var target = this;
		return target.replace(new RegExp(search, 'g'), replacement);
	};
	
	//Created new function for dropdown(City/State/Country) - Sre.
	
function selectedCriteria(selectedValue){
		var selectedTagId = selectedValue.getAttribute("id")
		//console.log("selectedTagId ::"+selectedTagId)
		var setSelectedValue = document.getElementById(selectedTagId)
		var optionSelectedVal = setSelectedValue.options[setSelectedValue.selectedIndex].getAttribute("value") 
		//console.log("optionSelectedVal::"+optionSelectedVal)
		
		$("#"+selectedTagId+" option").each(function(){
			if(optionSelectedVal == $(this).val()){
				$(this).attr("selected","selected")
			}else{
				$(this).removeAttr("selected")
			}
	    });
	}
	
	function selectedValue(selectedValue){
		var selectedTagId = selectedValue.getAttribute("id")
		console.log("selectedTagId ::"+selectedTagId)
		var setSelectedValue = document.getElementById(selectedTagId)
		var optionSelectedVal = setSelectedValue.options[setSelectedValue.selectedIndex].getAttribute("value") 
		console.log("optionSelectedVal::"+optionSelectedVal)
		$("div#formtechoptiondynamic").empty();
		$("div#formtechoptiondynamic").append(" <label class=\"col-form-label col-lg-3 col-sm-12 ttc\">"+optionSelectedVal+"</label>");
		var optionAppendVal ="";
		$.each(obj[optionSelectedVal], function( index, value ) {
			optionAppendVal += "<option class=\"ttc\" value=\""+value+"\">"+value+"</option>"
			});
		
		$("div#formtechoptiondynamic").append("<div class=\"col-lg-4 col-md-9 col-sm-12\"><select id=\"dynamicselection\" class=\" ttc form-control form-control--fixed kt_selectpicker\" "+
				"data-width=\"100\">"+optionAppendVal+
			"</select></div>")
		
		
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

				<h3 class=\"kt-portlet__head-title\">Create Technology Segment</h3>
			</div>
		</div>
		<div class="kt-portlet__body">
			<div class="kt-portlet__content">
				Create segments based on technology of the visitor. For example, you
				can create a segment called <span class="badge badge-warning">Mobile
					Technology</span> with criteria <span class="badge badge-secondary">Include
					- Device - Mobile</span>
			</div>
		</div>
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form">
			<div class="kt-portlet__body">

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Criteria</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<select id="technologyrule"
							class="form-control form-control--fixed kt_selectpicker"
							data-width="100" onchange="selectedCriteria(this)">
							<option value="include" selected>Include</option>
							<option value="exclude">Exclude</option>
						</select>
						 <select id="technologylist"
							class="form-control form-control--fixed kt_selectpicker"
							data-width="120" onchange="selectedValue(this)">
							<option value="devices">Devices</option>
							<option value="os">OS</option>
							<option value="browser">Browser</option>
						</select>
					</div>
				</div>

				<div class="form-group row" id="formtechoptiondynamic">
					<label class=" ttc col-form-label col-lg-3 col-sm-12">Devices</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<select 
							id="dynamicselection"
							class=" ttc form-control form-control--fixed kt_selectpicker"
							data-width="100">
							<option class="ttc" value="Desktop">Desktop</option>
							<option class="ttc" value="Mobile">Mobile</option>
							<option class="ttc "value="Tablet">Tablet</option>
						</select>
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

				<div id="technologybucket" style="display: none;">
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
								value="segment-create-technology.jsp">
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
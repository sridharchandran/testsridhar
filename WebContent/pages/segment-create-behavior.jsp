<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<script type="text/javascript">
function add(){	
	var errorMSg =""
	var rule = document.getElementById("rule").value;
	var type = document.getElementById("type").value;
	var criteria = document.getElementById("criteria").value;
	var rulevalue = document.getElementById("rulevalue").value;
	errorMSg = rulevalue.replace(" ","").length  <=0 ? "Number/Duration in Seconds should not be empty" : ""; 
	if(errorMSg !="" || isNaN(rulevalue) ){
		errorMSg = errorMSg !="" ? errorMSg : "Please Provide only numeric value in the Number/Duration in Seconds" 
			swal.fire(errorMSg)
		document.getElementById("rulevalue").focus();
	}else{
	var behavior = rule+":"+type+":"+criteria+":"+rulevalue;	
	var select = document.getElementById("dynamic-select");
	
	var index = select.options.length;
	select.options[index] = new Option(behavior, behavior);		
	document.getElementById("rule").reset;
	document.getElementById("type").reset;
	document.getElementById("criteria").reset;
	document.getElementById("rulevalue").value = ""; //Cleammr the Text Field	
	var x = document.getElementById("behaviourbucket");	
	if(!hasConditionExistsAlready(type,criteria)){
		if(rule == "include") {	
			x.innerHTML += '<button id="'+type+criteria+rulevalue+'" data-condition="'+type+criteria+'" type="button" class="btn btn-outline-info btn-pill" onclick="remove('+type+criteria+rulevalue+','+index+')">'+type+':'+criteria+':'+rulevalue+'<i class="la la-close"></i></button>&nbsp;';
		} else {		
			x.innerHTML += '<button id="'+type+criteria+rulevalue+'" data-condition="'+type+criteria+'" type="button" class="btn btn-outline-danger btn-pill" onclick="remove('+type+criteria+rulevalue+','+index+')">'+type+':'+criteria+':'+rulevalue+'<i class="la la-close"></i></button>&nbsp;';
		}
	}else{
		swal.fire("The Same condition has exist already.Please remove the conditon and add it again")
	}
	x.style.display = "block";			
	document.getElementById("rule").focus();
	}
	
}
function hasConditionExistsAlready(type,criteria){
	var exist = false
	$("#behaviourbucket button").each(function(){
		var conditionMatch = $(this).attr("data-condition")
		if(conditionMatch == (type+criteria)){
			exist = true
		}
	});
	return exist
}
function remove(element, index){
	var select = document.getElementById("dynamic-select");
	select.remove(index);
	
	//Bug Fix for not removing the selected beahviour criteria completely in behaviour segment creation.
	var removeButtonTag = document.getElementById("behaviourbucket")
	removeButtonTag.removeChild(element)
	//element.style.display = "none";		
}
function removeAll(){
	var select = document.getElementById("dynamic-select");
	select.options.length = 0;
	var x = document.getElementById("behaviourbucket");
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
    txt = "beh{"+txt+"}";    
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
		swal.fire("Rule should not be empty Please provide rule for the criteria.")
		document.getElementById("criteria").focus()
	}
}

//Created new function for dropdown issue - Sre.
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
//To hide include & Exclude dropdoen

</script>

<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
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
		            <div class="alert-icon"><i class="<%=icon%> kt-font-brand"></i></div>		            		           
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
				<h3 class="kt-portlet__head-title">Create Behavior Segment</h3>				   															
			</div>												
		</div>
		<div class="kt-portlet__body">
			<div class="kt-portlet__content">
				Create segments based on visitor behavior. For example, you can create a 
				<span class="badge badge-warning">Returning Visitor</span> segment with Criteria 
				<span class="badge badge-secondary">Visits</span>
				<span class="badge badge-secondary">More than</span>
				<span class="badge badge-secondary">0</span> 				
				and a 
				<span class="badge badge-warning">Engaged Visitor</span> segment with Criteria 
				<span class="badge badge-secondary">Session Duration</span>
				<span class="badge badge-secondary">More than</span>
				<span class="badge badge-secondary">120 seconds</span>				
			</div>
		</div>					
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form"> 
			<div class="kt-portlet__body">
																			 				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Criteria</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
				<%--Removed Include & Exclude Criteria By  Poovarasan --%> 
					<div id="tohide" style="display:none;">
						<select id="rule" class="form-control form-control--fixed kt_selectpicker" data-width="150">
							<option value="include" selected>Include</option>  
							<option value="exclude">Exclude</option>												
						</select>
						</div>
						<%-- include onchange event for type and criteria -Sre--%>																		
						<select id="type" class="form-control form-control--fixed kt_selectpicker" data-width="150" onchange="selectedValue(this)">
							<option value="visit">Visits</option>
							<option value="session">Session Duration</option>														
						</select>															
						<select id="criteria" class="form-control kt_selectpicker" data-width="120" onchange="selectedValue(this)">
							<option value="equals" id="criteria_equals" >Equals</option>
							<option value="more" id="criteria_more" >More than</option>
							<option value="less" id="criteria_less">Less than</option>							
						</select>																															
					</div>
				</div>
											
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Number/Duration in Seconds</label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
						<input id="rulevalue" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="0 to 10">						
					</div>
				</div>
				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
						<button type="reset" class="btn btn-accent" onclick="javascript:add()">Add</button>
					</div>
				</div>
				
				<div class="kt-separator kt-separator--border-dashed"></div>
				<div class="kt-separator kt-separator--height-sm"></div>
								
				<div id="behaviourbucket" style="display: none;">																					
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
					<label class="col-form-label col-lg-3 col-sm-12">Segment Name</label>
						<div class="col-lg-4 col-md-9 col-sm-12">															
							<input name="segmentName" id="segmentName" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="Name">	
							<span class="form-text text-muted">Give a name for this segment</span>					
						</div>
				</div>
						
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>					
						<div class="col-lg-4 col-md-9 col-sm-12">
							<div id="hidden-form" style="display: none;">							
								<input type="hidden" name="pageName" value="segment-create-behavior.jsp">
								<!-- input type="hidden" id = "segmentName" name="segmentName"  -->
								<input type="hidden" id = "segmentRules" name="segmentRules" >
								<select id="dynamic-select" size="2"></select>																																																					
							</div>											
							<button type="reset" class="btn btn-primary" onclick="saveSegment();">Save</button>
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
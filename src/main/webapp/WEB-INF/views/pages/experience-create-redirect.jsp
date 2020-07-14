<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Map, com.onwardpath.wem.repository.SegmentRepository" %>    
<script type="text/javascript">


var expDetailsObj = {};
var segment = null;	
var segment_id = null;	
var segment_name = null;
var content = null;
var allsupage ="No";
var alerttext = "No";       
      
       
function remove(element, segment_id){		
	var displayElement = document.getElementById(element);	
	delete expDetailsObj[segment_id];	
	displayElement.style.display = "none";		
} 
function selectIndex()
{
	segment = document.getElementById("segment");
	segment_id = segment.value;	
	segment_name = segment.options[segment.selectedIndex].innerHTML;
	content = document.getElementById("content").value;	
	
}

function isChecked(event) {
	let el_id = event.target.attributes.for.value;		
	if (event.currentTarget.checked == true)
		document.getElementById(el_id).style.display = "block";
	else
		document.getElementById(el_id).style.display = "none";

}


function ispopChecked(event) {
	let el_id = event.target.attributes.for.value;		
	if (event.currentTarget.checked == true)
		document.getElementById(el_id).style.display = "block";
	else
		document.getElementById(el_id).style.display = "none";

}
 
function add(event){
       selectIndex();	
	   if (segment_id in expDetailsObj) {
		   swal.fire("Segment "+segment_name+" already added. Select a different segment.");	
		} else {
			if(content.length > 0)
			{
				var allsubpagetext = document.querySelector('#subpages').checked;
				 if(allsubpagetext === true){
					 allsubpagetext = "Yes" 
				 }else{
					 allsubpagetext = "No";
				 }
			  
				var popuptext = document.getElementById('popuptext').value;
				if(popuptext){
					popuptext = popuptext; 
				 }else{
					 popuptext = "N/A";
				 }
				
				 
				var popuptime = document.getElementById('popuptime').value;
				
				if(popuptime){
					popuptime = popuptime; 
				 }else{
					 popuptime = "N/A";
				 }
				     
				//allsupage = getCheckedEvents();
				//alerttext = document.getElementById('subpopup').value 
				expDetailsObj[segment_id] = content+"#"+allsubpagetext+"#"+popuptext+"#"+popuptime;
			//expDetailsObj[segment_id] = content+"#allsubpage:"+allsupage+"#popup:"+alerttext;	
			var stage = document.getElementById("stage");
			stage.innerHTML += '&nbsp;<button type="button" id="'+segment_name+'" class="btn btn-outline-info btn-pill" onclick="remove(\''+segment_name+'\','+segment_id+')"><b>'+segment_name+'</b>:<b style="color:#3d4e5e"> '+content+'<b><i class="la la-close"></i></button>';
			stage.style.display = "block";
			}
			else
				swal.fire("Please enter any URL");
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
 
 
function saveExperience(){	
	var name = document.getElementById('name').value;
	//var page_events = getCheckedEvents();
	var allsubpagetext = document.querySelector('#subpages').checked;
	var popuptext = document.getElementById('popuptext').value;
	var popuptime = document.getElementById('popuptime').value;
	//var allsubpagetext = document.getElementById('subpages').value; 
	   
    
 
	 if(name){  	    
	var type = "redirect"; 
	if (JSON.stringify(expDetailsObj)!=='{}'){
	document.getElementById("experience-form").type.value=type;
	document.getElementById("experience-form").subpage.value = allsubpagetext;
	document.getElementById("experience-form").subpagepopup.value = popuptext;
	document.getElementById("experience-form").popuptime.value = popuptime;
	//document.getElementById("experience-form").redirecturl.value=redirectURL; 
	document.getElementById("experience-form").experienceDetails.value=JSON.stringify(expDetailsObj);	
	document.getElementById("experience-form").method = "post";
	document.getElementById("experience-form").action = "redirect";
	document.getElementById("experience-form").submit();
	}else{
		swal.fire("Please enter Redirect URL for this Experience")
	}
	}else{ 
		swal.fire("Please enter a value for  Experience Name")
	}  
	 
}
 
 
</script>
 
<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
	<%	
	String message = (String) session.getAttribute("message");
	
				
	if (message != null && !message.equals("")) {
		String icon = "fa fa-cocktail"; 
		if (message.startsWith("Error"))
			icon = "flaticon-warning";		
		
		String name = "";
		String experience = "";
		String organization = "";		
		if (message.contains("#")) {			
			String codeConstructor = message.substring(message.indexOf("#")+1);			
			message = message.substring(0,message.indexOf("#"));
			String[] decoder = codeConstructor.split("#");
			name = decoder[0].substring(decoder[0].indexOf("=")+1);
			experience = decoder[1].substring(decoder[0].indexOf("=")+1);
			organization = decoder[2].substring(decoder[0].indexOf("=")+1);
		}			 							 							 					
		%>
		<div class="row">
		    <div class="col">
		        <div class="alert alert-light alert-elevate fade show" role="alert">
		            <div class="alert-icon"><i class="<%=icon%> kt-font-brand"></i></div>		            		           
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
	<!--begin::Portlet-->
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Create Redirect Experience</h3>
			</div>
		</div>
				
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form"> 
			<div class="kt-portlet__body">
																			 				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Segment</label>
					<div class="col-lg-4 col-md-9 col-sm-12">											
						<select id="segment" class="custom-select form-control" data-width="300" onchange="javascript:selectIndex()">
						   		<c:forEach items="${seglist}" var="segment">
										<option value="${segment.id}">${segment.name}</option>
									</c:forEach>
																					
						</select>																																							
					</div>
				</div>
											
				
				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Redirect URL</label>
					<div class="col-lg-4 col-md-9 col-sm-12">																								
						<input name="redirectURL" id="content" type="text" class="form-control" aria-describedby="emailHelp" placeholder="Target URL">	
							
					</div>
				</div>
				
				<div class="form-group row">
									<label class="col-form-label col-lg-3 col-sm-12"></label>
									<div class="col-lg-4 col-md-9 col-sm-12">
										<div class="kt-checkbox-inline">
											<label class="kt-checkbox"> <input
												id="is-adv-settings" for="adv-settings" type="checkbox"
												value="" onclick="isChecked(event);">Advanced
												Settings<span></span>
											</label>
										</div>
									</div>
								</div>

								<div  id="adv-settings" style="display:none;">
								       <div class="form-group row">
						               <label class="col-3 col-form-label"></label>
						               <div class="col-9">
											<div class="kt-checkbox-inline" id="page_events">
												<label class="kt-checkbox"> 
												<input type="checkbox" value="Yes" id="subpages" >Redirect Sub Pages<span></span></label>
					
											
											
			                                
												<label class="kt-checkbox"> 
												<input type="checkbox" value="Yes" id="popup" for="adv-setting" onclick="ispopChecked(event);">Display Alert<span></span></label>	 
										<div  id="adv-setting" style="display:none;">
																																		
						           <input name="redirectURL" id="popuptext" type="text" class="form-control" style="width:20%;display:unset" aria-describedby="emailHelp" placeholder="Alert Text" >
						           <input name="redirectURL" id="popuptime" type="text" class="form-control" style="width:20%;display:unset"  aria-describedby="emailHelp" placeholder="Alert Close second" >		
						              </div> 
					    
											
						                   </div>
										</div>   
										
										</div>
								</div>			
				 </div>
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
						<button type="reset" class="btn btn-accent" onclick="javascript:add(event)">Add</button>
					</div>
				</div>
				
				<div class="kt-separator kt-separator--border-dashed"></div>
				<div class="kt-separator kt-separator--height-sm"></div>
				
				<div class="kt-section__content kt-section__content--border">				
					<div id="stage" style="display: none;">																																																																																																										
					</div>
				</div>	
						
						
				
													
																	
			
		</form>
		<!--end::Form-->
		
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="experience-form">
			<div class="kt-portlet__body">	
						
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Experience Name</label>
						<div class="col-lg-4 col-md-9 col-sm-12">															
							<input name="name" id="name" type="text" class="form-control" aria-describedby="emailHelp" placeholder="Name">	
							<span class="form-text text-muted">Give a name for this experience</span>					
						</div>
				</div>
						
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>					
						<div class="col-lg-4 col-md-9 col-sm-12">
							<div id="hidden-form" style="display: none;">																	
								<input type="hidden" name="pageName" value="create-experience">								
								<input type="hidden" name="type">
								<input type="hidden" name="segment_id">
								<input type="hidden" name="experienceDetails">
								<input type="hidden" name="redirecturl">
								<input type="hidden" name="subpage">
								<input type="hidden" name="subpagepopup">
								<input type="hidden" name="popuptime">																																																																																				
							</div>											
							<button type="reset" class="btn btn-primary" onclick="saveExperience();">Save</button>
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
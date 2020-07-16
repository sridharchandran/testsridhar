<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
.mr10{
	margin-right :10px;
}
.mt10{
	margin-top : 10px;
}

</style>  
<script type="text/javascript">
var expDetailsObj = {};
var segment = null;	
var segment_id = null;	
var segment_name = null;
var block_url = null;
var block_message = null;
var block_exp = null;
var typeVal = "Block";



function checkURL(abc) {
	  var string = abc.value;
	  console.log(abc);
	  if (!~string.indexOf("http")) {
	    console.log("abcd");
	    string = "http://" + string;
	  }
	  abc.value = string;
	  return abc
	}

function selectIndex() {
	segment = document.getElementById("segment");
	segment_id = segment.value;	
	segment_name = segment.options[segment.selectedIndex].innerHTML;
	block_url = document.getElementById("block_value").value ;	
	block_message = document.getElementById("block_message").value;
//	block_exp	=	block_url+"|"+block_message;
	console.log("blox"+block_message)
}

//Function to add segment with the entered content
function add(event) {
	
	
	selectIndex();
	  if (segment_id in expDetailsObj) {
		swal.fire("Segment " + segment_name
				+ " already added please select a different segment.");
	} else {
			if((block_url.length > 0) && (block_message)){
				
			expDetailsObj[segment_id] = block_url+"-"+block_message;
			
			var stage = document.getElementById("stage");
			stage.innerHTML += '<button type="button" id="'+segment_name+'" class="btn btn-outline-info btn-pill mr10 mt10" onclick="remove(\''
					//+ content
					
					+ segment_name
					+ '\','
					+ segment_id
					+ ',event)">'
					+'<b >'+typeVal+'</b>'
					+':'
					+'<b style="color:#3d4e5e">'+segment_name+'</b>'
					+ '<i class="la la-close"></i></button>';
			stage.style.display = "block";
			var dropDown = document.getElementById("segment");
			dropDown.selectedIndex = 0;
			document.getElementById("block_value").value="";
			document.getElementById("block_message").value="";
		} 
			
		
			else
			
			{
				swal.fire("Please enter any content");
			}
		}
}
	
//Function to save Experiences with entered segment
function saveExperience() {
	
	var name = document.getElementById('name').value;
	var allsubpage = localStorage.getItem("blockpage");
	console.log("allsubpage"+allsubpage);
	if(name){	
	var type = "block"; 
	
	var allsubpage = localStorage.getItem("blockpage");
	if (JSON.stringify(expDetailsObj)!=='{}'){
		console.log("bar="+JSON.stringify(expDetailsObj))
	document.getElementById("experience-form").subpage.value = allsubpage;
	document.getElementById("experience-form").type.value=type;	
	document.getElementById("experience-form").experienceDetails.value=JSON.stringify(expDetailsObj);	
	document.getElementById("experience-form").method = "post";
	document.getElementById("experience-form").action = "create-block";
	document.getElementById("experience-form").submit();
	}else{
		swal.fire("Please enter atleast one content for this Experience")
	}
	}else{ 
		swal.fire("Please enter a value for  Experience Name")
	} 
	 
	}
//Function to delete selected segment	
function remove(element, segment_id, event) {

	delete expDetailsObj[segment_id];
	var stage =  document.getElementById("stage");
	stage.removeChild(event.currentTarget);
	console.log("bar segments deleted");
}

	/* function getallsubpages(page)
	{
		var page_all = page.value;
		console.log("blockpage="+page_all)
		localStorage.setItem("blockpage", page_all);
	}
	 */
	function getallsubpages(event) {
	//	let el_id = event.target.attributes.for.value;	
		
		if (event.currentTarget.checked == true)
			localStorage.setItem("blockpage", "yes");
		else
			localStorage.setItem("blockpage", "no");
	}

//Generic onload function
	window.addEventListener("load", function() {
		localStorage.setItem("blockpage", "no");
		
		localStorage.setItem("exp_type", "block");


	


	});
	
</script>
<body>
<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
	<%	
	String message = (String) session.getAttribute("message");
	
//	SegmentRepository segmentRepository = new SegmentRepository();
	int org_id = (Integer)session.getAttribute("org_id");
	/* Map<Integer,String> segments = segmentRepository.getOrgSegments(org_id);
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
						<h3 class="kt-portlet__head-title">Create Block Experience</h3>
					</div>
				</div>


			<!--begin::Content-->
			<div id="basic" class="card-body-wrapper"
				aria-labelledby="headingOne3" style="">
				<div class="card-body">
					<!--begin::Form-->
					<form class="kt-form kt-form--label-right" id="block-form">
						<div class="kt-portlet__body">

							<div class="form-group row">
								<label class="col-form-label col-lg-3 col-sm-12">Segment</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<select id="segment" class="custom-select form-control"
										data-width="300" onchange="javascript:selectIndex()">
									<%-- 	<%
											for (Map.Entry<Integer, String> entry : segments.entrySet()) {
												Integer key = entry.getKey();
												String val = entry.getValue();
												out.println("<option value='" + key + "'>" + val + "</option>");
												session.setAttribute("segment_id", key);
											}
										%> --%>
										
										<c:forEach items="${seglist}" var="segment">
										<option value="${segment.id}">${segment.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="form-group row" id="block_url">
								<label class="col-form-label col-lg-3 col-sm-12">Block URL</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<input type="text" id="block_value"
										class="form-control col-lg-9 col-sm-12"
										placeholder="provide URL" onblur="checkURL(this)"  required /> 
								</div>
							</div>			 
							
							<div class="form-group row" id="block_url">
								<label class="col-form-label col-lg-3 col-sm-12">Messages to be shown after block</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<input type="text" id="block_message"
										class="form-control col-lg-9 col-sm-12"
										placeholder="provide message" required /> 
								</div>
							</div>
							
							
							<div id="screen" class="form-group row" >
								<label class="col-3 col-form-label">Block all SubPages/URL</label>
								<div class="col-9">
									<div class="kt-checkbox-inline">
										<label class="kt-checkbox"> 
										<input type="checkbox" id="yes" name="BlockURL" onclick="getallsubpages(event)" value="yes"> Yes <span></span>
										</label> 
										

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
									<input type="hidden" name="subpage">
							</div>
							<button type="reset" class="btn btn-primary"
								onclick="saveExperience();">Save</button>
							<button type="reset" class="btn btn-secondary">Cancel</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	<!--end::Portlet-->
		</div>
		<!--end::Content-->
</body>  
</html>
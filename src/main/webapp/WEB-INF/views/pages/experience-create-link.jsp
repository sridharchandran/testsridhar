<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<style>
.mr10{
	margin-right :10px;
}
.mt10{
	margin-top : 10px;
}
.mr20{
	margin-right :20px;
}
</style>    
<script type="text/javascript">
var cnt_details= {};
var segment = null;	
var segment_id = null;	
var segment_name = null;
var content = null;
var targetUrl = null;
var anchorClassName = null;
var anchorTarget = "_self";
var imageUrl = null;
var linkText= null;
var linkHTMLElement =null;
var errorMsg = "";
var typeVal="Link"
var imgWidth =null;
var imgHeight =null;
var imagelinktext =null;
   
   
function selectIndex()
{
	errorMsg =""
	segment = document.getElementById("segment");
	segment_id = segment.value;	
	segment_name = segment.options[segment.selectedIndex].innerHTML;
	//content = document.getElementById("content").value;	
	linkText = document.getElementById("linkTxt").value;	
	targetUrl = document.getElementById("targeturl").value;
	 
	console.log("linkText value is ::"+(linkText.trim().length))
	 
	//Validating url field(Targeturl,Imageurl).
	var expression =  /^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$/gm; 
   	//var regex = new RegExp(expression);
        
        
	//errorMessage()
	if(!document.getElementById("imageChkBox").checked && linkText.trim().length==0){
		errorMsg = "Please provide value in linktext";
	}else if(targetUrl.trim().length==0 && (!expression.test(targetUrl))){
		errorMsg = "Please provide valid url in TargetUrl field";
	}else if(document.getElementById("imageChkBox").checked){
		//linkText = document.getElementById("imgaltlinkTxt").value;
		imageUrl =  document.getElementById("image-url").value;
		imgWidth =	document.getElementById("width").value;
		imgHeight = document.getElementById("height").value;
		imagelinktext = document.getElementById("imgaltlinkTxt").value;
		console.log("IMAGE URL VALUE IS :::"+imageUrl)
		if(imageUrl.trim().length==0){
			errorMsg = "Please provide image url in ImageUrl field";
		}

		/* if(!expression.test(imageUrl)){
			errorMsg = "Please provide valid image url in ImageUrl field";
		} */ 
	}
	//alert("ksjdkdf"+targetUrl.match(regex))
	
	
	//anchorClassName
	anchorClassName = document.getElementById("anchorcustomclass").value;
	//console.log("imaheurl value is ::"+imageUrl+"Checked value is ::"+document.getElementById("imageChkBox").checked)
}
function toggleCheckbox(element)
{
	if(element.id == "imageChkBox" && element.checked){
			document.getElementById("imageurl").style.display =""
	
			document.getElementById("linktext").style.display="none";
			document.getElementById("imgalttext").style.display="block";
			//document.getElementById("adv-settings").style.display = "none";
			//document.getElementsByClassName("imagelinktext").innerText ="Alt Text";
			//alert("sdfd"+document.getElementsByClassName("imagelinktext").innerText)
			typeVal = "Image";
			//console.log("inside chekjbhkhcked symbol")
	}else{
		document.getElementById("linktext").style.display="block";
		document.getElementById("imageurl").style.display ="none"
		document.getElementById("imgalttext").style.display ="none"
		
		
	}
}
function getContentFromLinkExp(){
	 var linkHTMLElemFormation = ""
	 var createAnchor = document.createElement("a");
	  createAnchor.href=targetUrl;
	  //added for classname and target for the anchor
	  createAnchor.className =anchorClassName
	  createAnchor.target =anchorTarget
	  createAnchor.id=segment_id+"_"+linkText
	 
	  if(typeVal == "Image"){
		linkHTMLElemFormation = document.getElementById("linkContent").appendChild(createAnchor)
		var anchorIDVal = "#"+segment_id+"_"+linkText;
		  var createImg = $('<img/>').attr({
	            'src': imageUrl,
	            'alt': linkText,
	            'width': imgWidth+"px",
	            'height':imgHeight+"px" 
	        }).appendTo(anchorIDVal);
		
	/* 	var createImg = new Image();
		createImg.src = imageUrl;
		createImg.alt = linkText;
		createImg.style.width = imgWidth+"px" ;
		createImg.style.height = imgHeight+"px" ; */
		
		//document.getElementById(segment_id+"_"+linkText).appendChild(createImg);
	  }else{
		  createAnchor.innerHTML = linkText;
		  linkHTMLElemFormation = document.getElementById("linkContent").appendChild(createAnchor)
	  }
	  return document.getElementById("linkContent").innerHTML;
}
function add(event){
	//console.log("Before add function() ::")
       selectIndex();
	

	   if (segment_id in cnt_details) {
		   swal.fire("Segment "+segment_name+" already added. Select a different segment.");	
		} else {
			if(errorMsg=="")
			{
			content = getContentFromLinkExp()
			var seg_data = {};
			
			
			//setting form values to object
			seg_data.link_html_body = content;
			seg_data.typeVal = typeVal;
			seg_data.linkText = linkText == null ? "null" : linkText;
			seg_data.targetUrl = targetUrl  == null ? "null" : targetUrl;
			seg_data.imageUrl = imageUrl  == null ? "null" : imageUrl;
			seg_data.anchorClassName = anchorClassName == "" ? "null" : anchorClassName;
			seg_data.anchorTarget = anchorTarget  == null ? "null" : anchorTarget;
			seg_data.imgWidth = imgWidth  == null ? "null" : imgWidth;
			seg_data.imgHeight = imgHeight  == null ? "null" : imgHeight;
			seg_data.imagelinktext = imagelinktext   == null ? "null" : imagelinktext;
			
			cnt_details[segment_id] = seg_data;
			
			var stage = document.getElementById("stage");
			stage.innerHTML += '<button type="button" id="'+segment_name+'" class="btn btn-outline-info btn-pill mr10 mt10" onclick="remove(\''+segment_name+'\','+segment_id+',event)"><b>'+typeVal+'</b>:<b style="color:#3d4e5e">'+ segment_name+ '</b>:'+linkText +'<i class="la la-close"></i></button>';
			stage.style.display = "block";
			document.getElementById("dummy-form").reset();
			document.getElementById("imageurl").style.display ="none"
			document.getElementById("linkContent").innerHTML = ""
			document.getElementById("linktext").style.display="block";
			//document.getElementById("anchorcustomclass").style.display="none";
			document.getElementById("imgalttext").style.display="none";
			document.getElementById("adv-settings").style.display = "none";
			typeVal = "Link";
			}  
			else{
				swal.fire(errorMsg);
				//document.getElementById("targeturl").focus();
			}
		}		 
}   
function remove(element,segment_id,event){
	delete cnt_details[segment_id];
	var stage =  document.getElementById("stage");
	stage.removeChild(event.currentTarget);
}
function saveExperience(){	

	var name = document.getElementById('name').value;
	if(name){	
	var type = "link";
	if (JSON.stringify(cnt_details)!=='{}'){
	document.getElementById("experience-form").type.value=type;	
	document.getElementById("experience-form").experienceDetails.value=JSON.stringify(cnt_details);	
	document.getElementById("experience-form").method = "post";
	document.getElementById("experience-form").action = "create-link";
	document.getElementById("experience-form").submit();
	}else{
		swal.fire("Please enter atleast one link for this Experience")
	}
	}else{ 
		swal.fire("Please enter a value for  Experience Name")
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
function getTargetOption(target){
	anchorTarget = target.value;
}

window.addEventListener("load", function() {
	
	localStorage.setItem("exp_type", "link");
});

</script>
<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
	<%	
	String message = (String) session.getAttribute("message");
	
	//SegmentRepository segmentRepository = new SegmentRepository();
	int org_id = (Integer)session.getAttribute("org_id");
/* 	Map<Integer,String> segments = segmentRepository.getOrgSegments(org_id);
	if (segments.size() == 0) {
		message = "Error: No Segments are configured. Create a Segment <a class='kt-link kt-font-bold' href='?view=pages/segment-create-geo.jsp'>here</a>";	
	}*/
				
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
		
		<!-- begin::modal -->		
		<div class="kt-section__content kt-section__content--border">			
			<!-- Modal -->
			<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display: none;">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">						
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalCenterTitle">Embed Code for: <%=name%></h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">�</span>
							</button>
						</div>
						<div class="modal-body">														 
							 <h3>Header</h3>
							 <code>
								&lt;!-- Begin::GeoSmart-Header --&gt; 
								&lt;script&gt;
								function geo()
								{
								      var serviceURL= "http://lab01.onwardpath.com/GeoTargetService/app/georeach/get?id=<%=experience%>&org_id=<%=org_id%>&s=";
								      var geoElement = document.getElementById("Geo-<%=name%>-<%=experience%>");
								      var url = new URL(window.location.href);
								      var c = url.searchParams.get("s");
								      serviceURL += c;
								      console.log(serviceURL);
								
								      var xhttp = new XMLHttpRequest();
								      xhttp.responseType = 'json';
								      xhttp.onreadystatechange = function() 
								      {
										if (this.readyState == 4 && this.status == 200)
										{
											let data = this.response;
											geoElement.innerHTML = data[1].embedCode;
										}
								      };
								      xhttp.open("GET", serviceURL);
								      xhttp.send();
								 }								
								window.onload = geo;
								&lt;/script&gt;  
								&lt;!-- End::GeoSmart-Header --&gt;
							</code>
							<h3>Body</h3>
							<code>
								&lt;!-- Begin::GeoSmart-Body --&gt;
								&lt;div id="G-<%=name%>-<%=experience%>"&gt;&lt;/div&gt;
								&lt;!-- End::GeoSmart-Body --&gt;
							</code>
						</div>
						<div class="modal-footer">							
							<button type="button" class="btn btn-outline-brand">Copy</button>
							<button type="button" class="btn btn-outline-brand" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>	
		<!-- end::modal -->						
		<%
		session.setAttribute("message", "");
	}																
	%>			
	<!--begin::Portlet-->
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Create Link Experience</h3>
			</div>
		</div>
		<div id="linkContent" style="display:none"></div>
				
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form"> 
			<div class="kt-portlet__body">
																			 				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Segment</label>
					<div class="col-lg-4 col-md-9 col-sm-12">											
						<select id="segment" class="custom-select form-control" data-width="300" onchange="javascript:selectIndex()">
<%-- 						    <%
							for ( Map.Entry<Integer, String> entry : segments.entrySet()) {
								Integer key = entry.getKey();
							    String val = entry.getValue();	     	   
							    out.println("<option value='"+key+"'>"+val+"</option>");
							}
							%>	 --%>	
									<c:forEach items="${seglist}" var="segment">
										<option value="${segment.id}">${segment.name}</option>
									</c:forEach>
																					
						</select>																																							
					</div>
				</div>
				<div class="form-group row">
				<label class="col-form-labe col-lg-3 col-sm-12">Type</label>
					<div class="col-lg-6 col-md-9 col-sm-12">	
						<label class="kt-checkbox mr20">
                           	<input type="radio" id="imageChkBox" name="imageCheckbox" value="Image" onchange="toggleCheckbox(this)">Image<span></span>
		                 </label>
		                 <label class="kt-checkbox mr20">
                           	<input type="radio" id="linkChkBox" name="imageCheckbox" value="Link" checked onchange="toggleCheckbox(this)">Text<span></span>
		                 </label>																						
					</div>
				</div>
				<div id="imageurl" style="display:none">
					<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Image Url</label>
						<div class="col-lg-6 col-md-9 col-sm-12">	
							<input type="text" id="image-url" class="form-control col-lg-9 col-sm-12" placeholder="Enter the url"/>																						
						</div>
					</div>
					<div class="form-group row">
						<label class="col-lg-3 col-sm-12 col-form-label">Width (px):</label>
							<div class="col-lg-3">
								<input id="width" type="text" value="400" class="form-control">
							</div>
						<label class="col-lg-2 col-form-label">Height (px):</label>
							<div class="col-lg-3">
								<input id="height" type="text" value="250" class="form-control">
							</div>
					</div>
				</div>						
				
				<div id="linktext">
				<div class="form-group row" >
				<label class="col-form-label col-lg-3 col-sm-12 imagelinktext">Text</label>
					<div class="col-lg-6 col-md-9 col-sm-12">	
						<input type="text" id="linkTxt" class="form-control col-lg-9 col-sm-12" placeholder="Enter Display text" required/>																						
					</div>
				</div>
				</div>
				<div id="imgalttext" style="display:none">
				<div class="form-group row" id="">
				<label class="col-form-label col-lg-3 col-sm-12 imagealttext">AltText</label>
					<div class="col-lg-6 col-md-9 col-sm-12">	
						<input type="text" id="imgaltlinkTxt" class="form-control col-lg-9 col-sm-12" placeholder="Enter Alt text" required/>																						
					</div>
				</div>
				</div>
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Target URL</label>
					<div class="col-lg-6 col-md-9 col-sm-12">
						<input type="text" id="targeturl" class="form-control col-lg-9 col-sm-12" placeholder="Provide Target Url" required/>																						
					</div>
				</div>
				<%-- Advanced Setting --%>
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
				<div id="adv-settings" style="display:none;">
						<div class="form-group row">
						<label class="col-form-label col-lg-3 col-sm-12">Classname</label>
							<div class="col-lg-6 col-md-9 col-sm-12">
								<input type="text" id="anchorcustomclass" class="form-control col-lg-9 col-sm-12" placeholder="Custom classname for anchor link" required/>																						
							</div>
						</div>
						
						
						<div class="form-group row">
						<label class="col-3 col-form-label">Target Page Open In</label>
						<div class="col-9">
							<div class="kt-radio-inline">
								<label class="kt-radio">
									<input type="radio" name="targetradio" checked value="_self" onclick="getTargetOption(this)"> Same Frame
									<span></span>
								</label>
								<label class="kt-radio">
									<input type="radio" name="targetradio"  value="_top" onclick="getTargetOption(this)"> Same Page
									<span></span>
								</label>
								<label class="kt-radio">
									<input type="radio" name="targetradio" value="_blank"onclick="getTargetOption(this)"> New Page
									<span></span>
								</label>
								<!-- <label class="kt-radio">
									<input type="radio" name="targetradio" value="_parent"onclick="getTargetOption(this)"> Parent Frame
									<span></span>
								</label> -->
							</div>
						</div>
					</div>
				</div>
				<%--Advanced Setting End --%>
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
						<button type="button" class="btn btn-accent" onclick="javascript:add(event)">Add</button>
					</div>
				</div>
				
				<div class="kt-separator kt-separator--border-dashed"></div>
				<div class="kt-separator kt-separator--height-sm"></div>
				
				<div class="kt-section__content kt-section__content--border">				
					<div id="stage" style="display: none;">																																																																																																										
					</div>
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
								<input type="hidden" name="experienceDetails">
								<input type="hidden" name="segment_id">
								<input type="hidden" name="url">																																																																																				
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
<!-- <script>
window.addEventListener("load", function(){
	document.getElementsByClassName("linktext").innerText ="Text";
	//selectIndex();
});
</script> -->
<!--end::Content-->
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


var bar_details= {};
var segment = null;	
var segment_id = null;	
var segment_name = null;
var content = null;
var typeVal = "Bar";
var bar_content = null;
var anchorTarget = "_self";

function selectIndex() {
	var bar_top_disp = document.getElementById('barbg_color');
	if(document.getElementById('showchkbox').checked == true)
	{
	var show_b = document.getElementById('showchkbox').value;
	
	localStorage.setItem("Not_button", show_b);
	} 
else
	{
	
	localStorage.setItem("Not_button", "hide");
	}
	var screen = localStorage.getItem("screen");
	segment = document.getElementById("segment");
	localStorage.setItem("segment", "segment");
	segment_id = segment.value;
	
	/* localStorage.setItem("segment_id", segment_id); */
	segment_name = segment.options[segment.selectedIndex].innerHTML;
	content = document.getElementById("content").value;	
	buttoncontent = document.getElementById("buttoncontent").value;
	link_value = document.getElementById("link_value").value;
//	 var dyn_id = document.getElementById("container");
	 var position = "fixed";
	 var d = new Date();
	var n = d.getTime();
	var r = document.getElementsByClassName("container")
	var id = r[0].id;
	id= "Bar-"+segment_id+"-"+n;
	
	$(".container").attr('id',id); 
	$(".container").css("display", "block");
	$(".container").css("position", "fixed");
	$(".container").css("z-index", "1000000");
	$(".container").css("left", "0px");
	$(".container").css("top", "0px");
	$(".container").css("width", "100%");
	$(".container").css("height", "50px");
/* 	notify_bar(position, screen);
	
	bar_content = $('.container')[0].outerHTML; */
	console.log("bar---"+bar_content)
	
	/* popup = document.getElementById("popup");

	//set modal content from the UI
	setModalContent();
	content = exampleModalLongInner.outerHTML;
	modalcontent = document.getElementById("content");
	modalurl = document.getElementById("iframe-url");  */
	
	
}

//Function to add segment with the entered content
function add(event) {
	
	
	selectIndex();
	var count = 0;
	var screen = localStorage.getItem("screen");
	var expression =  new RegExp('^(?:[a-z]+:)?//', 'i');
	var position = "fixed";
	localStorage.setItem("segment", "segment");
	var typeVal = "Bar"
	var button_display = localStorage.getItem("Not_button");
	if(buttoncontent.length == 0 && button_display == "show")
	{
	swal.fire("Please enter Button Text");
	}
	else if(link_value.length == 0 && button_display == "show" && (!expression.test(link_value)))
	{
	swal.fire("Please enter Link URL");
	}
	else  if (segment_id in bar_details) {
		swal.fire("Segment " + segment_name
				+ " already added please select a different segment.");
	} else {
			if((!expression.test(link_value)) && button_display == "show")
		{
				swal.fire("Please enter Valid URL");
				document.getElementById("link_value").value="";
				return false;
		}
			if((content.length > 0)){
				
				notify_bar(position, screen);
					
					bar_content = $('.container')[0].outerHTML;
					var bar_bgcolor = localStorage.getItem("bar_bgcolor");
					var bar_text_col = localStorage.getItem("bar_text_col");
					var bar_txt = localStorage.getItem("bar_txt");
					var screen = localStorage.getItem("screen");
					var Not_button = localStorage.getItem("Not_button");
					if(Not_button == "hide")
						{
						var button_txt = "null";
						var button_text_col = "null";
						var button_back_col = "null";
						var link_val = "null";
						var anchorTarget = "null";
						}
					else
						{
					var button_txt = localStorage.getItem("button_txt");
					var button_text_col = localStorage.getItem("button_text_col");
					var button_back_col = localStorage.getItem("button_back_col");
					var link_val = localStorage.getItem("link_val");
					var anchorTarget = localStorage.getItem("anchorTarget");
						}
										
			
			
			var seg_data = {};

			seg_data.screen				=	screen;
			seg_data.bar_body			=	bar_content;
			seg_data.bar_bgcolor		=	bar_bgcolor;
			seg_data.bar_text_col		=	bar_text_col;
			seg_data.bar_txt			=	bar_txt;
			seg_data.Not_button			=	Not_button
			seg_data.button_back_col	=	button_back_col == "" ? "null" : button_back_col;
			seg_data.button_text_col	=	button_text_col == "" ? "null" : button_text_col;
			seg_data.button_txt			=	button_txt == "" ? "null" : button_txt;
			seg_data.link_val			=	link_val == "" ? "null" : link_val;
			seg_data.anchorTarget		=	anchorTarget == "" ? "null" : anchorTarget;


			bar_details[segment_id] = seg_data;
			
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

			document.getElementById("content").value="";
			document.getElementById("buttoncontent").value="";
			document.getElementById("link_value").value="";
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
	if(name){	
	var type = "bar"; 

	if (JSON.stringify(bar_details)!=='{}'){
		
	document.getElementById("experience-form").type.value=type;	
	document.getElementById("experience-form").experienceDetails.value=JSON.stringify(bar_details);	
	document.getElementById("experience-form").method = "post";
	document.getElementById("experience-form").action = "create-bar";
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
	
		delete bar_details[segment_id];
		var stage =  document.getElementById("stage");
		stage.removeChild(event.currentTarget);
		
	}
//Function to Shoe/Hide Button 
/* 	function ShowCheckbox(element) {
		if (element.id != "showchkbox" && element.checked) {
			document.getElementById("button_col").style.display = "none";
			document.getElementById("button_cont").style.display = "none"
			document.getElementById("link_custom").style.display = "none"
			document.getElementById("custom_page").style.display = "none"

		} else {

			document.getElementById("button_col").style.display = "flex";
			document.getElementById("button_cont").style.display = "flex";
			document.getElementById("link_custom").style.display = "flex";
			document.getElementById("custom_page").style.display = "flex";
		}

	} */
//Function to get selected button value	
	/* function getButton(button)
	{
		var button_sel = button.value;
		console.log("bi="+button_sel)
		localStorage.setItem("Not_button", button_sel);
	} */
	
	function getButton(event) {
		let el_id = event.target.attributes.for.value;	
		
		if (event.currentTarget.checked == true)
			document.getElementById(el_id).style.display = "block";
		else
			document.getElementById(el_id).style.display = "none";
	}
	
//Function to get selected screen value	
	function getScreen(screen)
	{
		var screen_sel = screen.value;
		console.log("screen="+screen_sel)
		localStorage.setItem("screen", screen_sel);
	}
//Function to show fixed/float button value	
	function fixed(element) {
		if (element.id != "fixchkbox" && element.checked) {
			document.getElementById("screen").style.display = "none";

		} else {

			document.getElementById("screen").style.display = "flex";

		}
	}
	
	function getTargetOption(target){
		anchorTarget = target.value;
		localStorage.setItem("anchorTarget", anchorTarget);
		
	} 
	
//Genereic method to show notification bar experiences 
	function notify_bar(position, screen) {
		var position = position;
		var screen = screen;
		var segment_d = localStorage.getItem("segment");
		var button_display = localStorage.getItem("Not_button");
		/* Style for inner_div id */
		$("#inner_div").css("display", "block");
		$("#inner_div").css("position", "fixed");
		$("#inner_div").css("top", "0%");
		$("#inner_div").css("width", "100%");
		$("#inner_div").css("height", "50px");
		$("#button_bg").css("display", "block");
		
		var bar_bgcolor = "#"
				+ document.getElementById("bar_color").value;
		localStorage.setItem("bar_bgcolor", document.getElementById("bar_color").value);
		console.log("bar_bgcolor=" + bar_bgcolor)
		var bar_text_col = "color:#"
				+ document.getElementById('txt_color').value;
		localStorage.setItem("bar_text_col", document.getElementById('txt_color').value);
		console.log("bar_text_col=" + bar_text_col)
		var bar_txt = document.getElementById('content').value;
		localStorage.setItem("bar_txt", bar_txt);
		console.log("bar_txt=" + bar_txt)
		
		var bar_top_disp = document.getElementById('barbg_color');
		
		var button_txt = document.getElementById('buttoncontent').value;
		console.log("button_txt=" + button_txt)
		localStorage.setItem("button_txt", button_txt);
		
		var bar_cont = document.getElementById('text');
		
		var button = document.getElementById('but_text');
		
		var button_bg = document.getElementById('button_bg');
		
		var button_text_col = "color:#"
				+ document.getElementById('button_txt_color').value;
		console.log("button_text_col=" + button_text_col)
		localStorage.setItem("button_text_col", document.getElementById('button_txt_color').value);
		var button_back_col = "#"
				+ document.getElementById("button_color").value;
		console.log("button_back_col=" + document.getElementById("button_color").value) 
		localStorage.setItem("button_back_col", document.getElementById("button_color").value);

	//	bar_top_disp.setAttribute("style", bar_bgcolor);
		
		bar_top_disp.setAttribute("style", bar_text_col);
		var bar = bar_bgcolor;
		bar_top_disp.style.backgroundColor  =  bar;
		bar_top_disp.style.position = "fixed";
	 	if (screen == "top") {
			bar_top_disp.style.top = "0"
		} else if (screen == "bottom") {
			bar_top_disp.style.bottom = "0"
			/* bar_top_disp.style.margin = "auto" */
		} 
		/* bar_top_disp.style.left = "0"
		bar_top_disp.style.width = "100vw"
		bar_top_disp.style.height = "auto"
		bar_top_disp.style.zIndex = "60009022"

		bar_cont.setAttribute("style", bar_text_col);
		bar_cont.innerHTML = bar_txt;

		bar_cont.style.top = "0"
		bar_cont.style.width = "100vw" */
		
		bar_top_disp.style.width ="100%"
		bar_top_disp.style.fontSize  ="13px"
		bar_top_disp.style.padding = "10px 50px 10px 10px";
		bar_top_disp.style.left = "0"
		bar_top_disp.style.textAlign = "center";
		bar_top_disp.style.lineHeight = "30px";
		bar_top_disp.innerHTML = bar_txt;
		
		/* button.innerHTML = button_txt;
		button.setAttribute("style", button_text_col)
		button_bg.style.marginRight = "10px" */
		/* 
		button_bg.setAttribute("style", button_back_col)
		button_bg.setAttribute("style", button_text_col);
		button_bg.style.padding = "5px 10px";
		button_bg.style.borderRadius = "5px";
		button_bg.style.margin = "0px";
		button_bg.style.whiteSpace = "nowrap"; */
		
		
		if (button_display == "show") {
			/* button_bg.style.display = "block";

			button_bg.setAttribute("style", button_back_col)
			button_bg.setAttribute("style", button_text_col);
			button_bg.style.padding = "5px 10px";
			button_bg.style.borderRadius = "5px";
			button_bg.style.margin = "0px";
			button_bg.style.whiteSpace = "nowrap"; */
			 var link_val = document.getElementById("link_value").value;
			 console.log("link_val = "+ link_val);
			 localStorage.setItem("link_val", link_val);
			 var x = document.createElement("A");
		//	  var t = document.createTextNode("Tutorials");
		//	  x.setAttribute("href", link_val);
			  x.setAttribute("id","c_anchor")
			  x.innerHTML=button_txt ;
			  x.href = link_val;
			  x.target = anchorTarget;
		//	  	x.setAttribute("style", button_back_col)
				x.setAttribute("style", button_text_col);
				var button_color = button_back_col;
			  	x.style.backgroundColor  =  button_color;
				x.style.padding = "5px 10px";
				x.style.borderRadius = "5px";
				x.style.margin = "10px";
				x.style.whiteSpace = "nowrap";
		//	  x.appendChild(t);
			  document.body.appendChild(x);
			  var c_span = document.createElement("SPAN");
			  c_span.setAttribute("onclick","$('.alerts').hide();");
			  c_span.style.right			=	"10px";
			  c_span.style.position			=	"absolute";
			  c_span.style.top				=	"10px"		
			  c_span.style.height			=	"28px"
			  c_span.style.borderRadius 	=	"1000px"
			  c_span.style.width			=	"28px"
			  c_span.style.cursor			=	"pointer"
			  c_span.style.background		=	"url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAAf0lEQVR42p1RUQqAMAjdSYKg+38F3WPQAYKdQfez1V40MBVGCTLx+dxTQ/hjpZS1eWTmWWPIAWu+SUI8m9VaD0lCjBww1AQFpE4iognei4GZ32U3vDL2pBrSsBgmZUh5w+5DSWroe0Av5601OWtNZq3P4fac86KlIgfsdbgvdgGq1xH0UYC51wAAAABJRU5ErkJggg==) 8px 8px no-repeat scroll rgba(0, 0, 0, 0.44)"
			  
			  bar_top_disp.appendChild(x);
			  bar_top_disp.appendChild(c_span);
		} else if (button_display == "hide") {
		//	button_bg.style.display = "none";
			
			var c_span = document.createElement("SPAN");
			  c_span.setAttribute("onclick","$('.alerts').hide();");
			  c_span.style.right			=	"10px";
			  c_span.style.position			=	"absolute";
			  c_span.style.top				=	"10px"		
			  c_span.style.height			=	"28px"
			  c_span.style.borderRadius 	=	"1000px"
			  c_span.style.width			=	"28px"
			  c_span.style.cursor			=	"pointer"
			  c_span.style.background		=	"url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAAf0lEQVR42p1RUQqAMAjdSYKg+38F3WPQAYKdQfez1V40MBVGCTLx+dxTQ/hjpZS1eWTmWWPIAWu+SUI8m9VaD0lCjBww1AQFpE4iognei4GZ32U3vDL2pBrSsBgmZUh5w+5DSWroe0Av5601OWtNZq3P4fac86KlIgfsdbgvdgGq1xH0UYC51wAAAABJRU5ErkJggg==) 8px 8px no-repeat scroll rgba(0, 0, 0, 0.44)"
			  bar_top_disp.appendChild(c_span);
		}
		
		
		
		if ((segment_d == "preview") ) {
			//		document.getElementById("container").style.display = "flex";
			bar_top_disp.style.position = "fixed";
			$(".container").hide().show('medium');
				}

			else
				{
			//	alert("wrong")
		//		document.getElementById("container").style.display = "none";
		
		
				}
	}
	
	

//Function for preview button to show notification bar
	function text(event) {
		localStorage.setItem("segment", "preview");
	/* 	if (document.getElementById('fixchkbox').checked) {
			var fixed = document.getElementById('fixchkbox').value;

		}
		if (document.getElementById('floatchkbox').checked) {
			var floating = document.getElementById('floatchkbox').value;

		} */
		if (document.getElementById('top').checked) {
			var top = document.getElementById('top').value;

		}
		if (document.getElementById('bottom').checked) {
			var bottom = document.getElementById('bottom').value;

		}
		if(document.getElementById('showchkbox').checked == true)
			{
			var show_b = document.getElementById('showchkbox').value;
			
			localStorage.setItem("Not_button", show_b);
			} 
		else
			{
			
			localStorage.setItem("Not_button", "hide");
			}
		/* if (document.getElementById('showchkbox').checked) {
			var show_b = document.getElementById('showchkbox').value;
			localStorage.setItem("Not_button", show_b);
			console.log("show_b=" + show_b)

		}
		if (document.getElementById('hidechkbox').checked) {
			var hide_b = document.getElementById('hidechkbox').value;
			localStorage.setItem("Not_button", hide_b);
			console.log("hide_b=" + hide_b)

		} */
		if ( (top == "top" && top != "undefined")	|| (bottom == "bottom" && bottom != "undefined")) {

			if (top == "top") {
				var screen = "top";
				var position = "fixed";
				notify_bar(position, screen);

			} else if ( bottom == "bottom") {
				var screen = "bottom";
				var position = "fixed";
				notify_bar(position, screen);

			}

		}
		/*  else if((floating == "floating" && floating != null) ||(top == "top" && top != null)||(bottom == "bottom" && bottom != null))
			 {
			 console.log("floating="+floating)
			 console.log("top="+top)
			 console.log("bottpm="+bottom)
			 } */
		else {
			// $(".container").hide().show('medium');
			alert("float")
		}
	}
//Generic onload function
	window.addEventListener("load", function() {
		localStorage.setItem("Not_button", "hide");
	 	localStorage.setItem("screen", "top"); 
	 	localStorage.setItem("exp_type", "bar");
	 	localStorage.setItem("anchorTarget", "_self");


	 	

	

	});
</script>
<body>
<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
	<%	
	String message = (String) session.getAttribute("message");
	
	/* SegmentRepository segmentRepository = new SegmentRepository(); */
	int org_id = (Integer)session.getAttribute("org_id");
	/* Map<Integer,String> segments = segmentRepository.getOrgSegments(org_id);
	if (segments.size() == 0) {
		message = "Error: No Segments are configured. Create a Segment <a class='kt-link kt-font-bold' href='?view=pages/segment-create-geo.jsp'>here</a>";	
	}
	*/		
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
						<h3 class="kt-portlet__head-title">Create Bar Experience</h3>
					</div>
				</div>


			<!--begin::Content-->
			<div id="basic" class="card-body-wrapper"
				aria-labelledby="headingOne3" style="">
				<div class="card-body">
					<!--begin::Form-->
					<form class="kt-form kt-form--label-right" id="bar-form">
						<div class="kt-portlet__body">

							<div class="form-group row">
								<label class="col-form-label col-lg-3 col-sm-12">Segment</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<select id="segment" class="custom-select form-control"
										data-width="300" onchange="javascript:selectIndex()">
										<%-- <%
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

						<!-- 	<div class="form-group row">
								<label class="col-form-label col-lg-3 col-sm-12">Content
									(Text/HTML)</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<textarea id="content" type="text"
										class="form-control col-lg-9 col-sm-12"
										aria-describedby="emailHelp" placeholder="Enter Text" rows=""
										cols=""></textarea>
								</div>
							</div> -->
						<!-- 	<div class="form-group row">
								<label class="col-3 col-form-label">Bar</label>
								<div class="col-9">
									<div class="kt-checkbox-inline">
										<label class="kt-checkbox"> <input id="fixchkbox" type="radio" name="Barcheckbox" 
										value="fixed" checked	onchange="fixed(this)"> Fixed <span></span>
										</label> 
										<label class="kt-checkbox"> <input id="floatchkbox" type="radio" name="Barcheckbox" 
										value="floating" onchange="fixed(this)">	Floating <span></span>
										</label>

									</div>
								</div>
							</div> -->

							<div id="screen" class="form-group row" >
								<label class="col-3 col-form-label">Align</label>
								<div class="col-9">
									<div class="kt-checkbox-inline">
										<label class="kt-checkbox"> 
										<input type="radio" id="top" name="screencheckbox" onclick="getScreen(this)" checked value="top"> Top <span></span>
										</label> 
										<label class="kt-checkbox"> 
										<input type="radio" id="bottom" name="screencheckbox" onclick="getScreen(this)" value="bottom"> Bottom <span></span>
										</label>

									</div>
								</div>
							</div>
							<div class="form-group row">


								<label class="col-lg-3 col-sm-12 col-form-label">Background Color</label>
								<div class="col-lg-1 col-md-9 col-sm-12">
									<input id="bar_color" type="text" class="form-control jscolor">
								</div>
								<label class="col-lg-1 col-form-label">Text Color</label>
								<div class="col-lg-1 col-md-9 col-sm-12">
									<input id="txt_color" type="text"
											class="form-control jscolor">
								</div>
							</div>
						<!-- 	<div class="form-group row">
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
										<input id="height" type="text" value="250"
											class="form-control">
									</div>
								</div>
							</div> -->
						<!-- 	<div class="form-group row">
								<label class="col-lg-3 col-sm-12 col-form-label">Background
									ImageURL:</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<div class="kt-input-icon">
										<input id="bgimgurl" type="text" class="form-control">
									</div>
								</div>
							</div> -->

							<!--  Preview Button -->
							<div class="form-group row" id="for-html">
								<label class="col-form-label col-lg-3 col-sm-12">Content
									(Text/HTML)</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<textarea id="content" type="text"
										class="form-control col-lg-9 col-sm-12"
										aria-describedby="emailHelp" placeholder="Enter Text"></textarea>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-3 col-form-label">Button</label>
								<div class="col-9">
									<div class="kt-checkbox-inline">
										<label class="kt-checkbox"> <input id="showchkbox"
											type="checkbox" name="Buttoncheckbox" for="show_link"  value="show" onclick="getButton(event)" > Show
											<span></span>
										</label> 

									</div>
								</div>
							</div>
						
						<div id="show_link" style="display:none;">
							<div id="button_col" class="form-group row">


								<label class="col-lg-3 col-sm-12 col-form-label">Button Color</label>
								<div class="col-lg-1 col-md-9 col-sm-12">
									<input id="button_color" type="text" class="form-control jscolor">
								</div>
								<label class="col-lg-1 col-form-label">Text Color</label> 
								<div class="col-lg-1 col-md-9 col-sm-12">
									<input id="button_txt_color" type="text" class="form-control jscolor">
								</div>
							</div>
							<div id="button_cont" class="form-group row" id="for-html">
								<label class="col-form-label col-lg-3 col-sm-12">Button Text</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<input id="buttoncontent" type="text" 
										class="form-control col-lg-9 col-sm-12"
										aria-describedby="emailHelp" placeholder="Enter Text"/>
								</div>
							</div>

							<div class="form-group row" id="link_custom">
								<label class="col-form-label col-lg-3 col-sm-12">Link</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<input type="text" id="link_value"
										class="form-control col-lg-9 col-sm-12"
										placeholder="Provide link URL" required />
								</div>
							</div>


							<div class="form-group row" id="custom_page">
								<label class="col-3 col-form-label">Target Link </label>
								<div class="col-9">
									<div class="kt-radio-inline">
										<label class="kt-radio"> <input type="radio"
											name="targetradio" checked value="_self"
											onclick="getTargetOption(this)"> Same Page <span></span>
										</label> <label class="kt-radio"> <input type="radio"
											name="targetradio" value="_blank"
											onclick="getTargetOption(this)"> New Page <span></span>
										</label>
										<!-- <label class="kt-radio">
									<input type="radio" name="targetradio" value="_parent"onclick="getTargetOption(this)"> Parent Frame
									<span></span>
								</label> -->
									</div>
								</div>
							</div>
						</div>
							<div class="form-group row">
								<label class="col-form-label col-lg-3 col-sm-12"></label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<button type="button" class="btn btn-accent"
										data-toggle="modal" data-target="#exampleModalLongInner"
										onclick="javascript:text(event)">Preview</button>
								</div>
							<!--  Iframe for External URL View -->
								<div class="embed-responsive embed-responsive-16by9"
									id="iframe-element" style="display: none; height: 100%">
									<iframe class="embed-responsive-item" src=""></iframe>
								</div>


						<!-- 		<div class="modal fade" id="exampleModalLongInner" tabindex="-1"
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
								</div> -->
							</div>

					<!-- 		<div class="container" >
								<h2>Alerts</h2>
								<div id="notify" class="alert alert-info"
									style="position: fixed; left: 0; top: 0; width: 100vw; height: auto; background-color: antiquewhite;">
									<button type="button" class="close" data-dismiss="alert"
										aria-label="Close">
										<span aria-hidden="true">×</span>
									</button>
									<span style="background: white;"> <strong>Info!</strong>
										This alert box could indicate a neutral informative change or
										action.
									</span>
									<button class="btn btn-outline-brand btn-pill" id="myBtn"></button>
								</div>
							</div>
 -->
		
	
						<!-- 	<div id="container" class="container" style="display:none">
								
								<div id ="barbg_color" class="alert alert-info"
									style="position: fixed; left: 0; top: 0; width: 100vw; height: auto;z-index:60009022; background-color: antiquewhite;">
									
									<span id ="text" >
										
									</span>
									<button class="btn btn-outline-brand btn-pill"
										id="button_bg">
										<span id ="but_text" >
										
										</span></button>
									
									<button type="button" class="close" onclick="$('.alert').hide()"
										aria-label="Close">
										
										<span aria-hidden="true">×</span>
									</button>
									
								</div>
							</div> -->


							<div id="container" class="container"
								style="display: none; position: fixed; z-index: 1000000; left: 0px; top: 0px; width: 100%; height: 50px;">
								<div id="inner_div"
									style="display: none; position: fixed; top: 0%; width: 100%; height: 50px;">
									<div id="barbg_color" class="alerts"
										style="position: fixed; top: 0%; width: 100%;  font-size: 13px; padding: 10px 50px 10px 10px; left:0; text-align: center; line-height: 30px;">
										<!-- <span id="text" ></span> -->
										<a id="button_bg" href="" target="_blank"
											style="display:none; padding: 5px 10px; border-radius: 5px; margin: 0px 10px; white-space: nowrap;">prmom</a>
										<!-- <span id="but_text" ></span> -->
										<span id="custom_close" aria-label="Close"
											style="position: absolute; display:none;top: 10px; right: 10px; height: 28px; border-radius: 1000px; width: 28px; cursor: pointer;"
											onclick="$('.alerts').hide()" aria-hidden="true">×</span>
									</div>
								</div>
							</div>


							<!-- <div class="form-group row">
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

							<div class="form-group row" id="for-iframe"
								style="display: none;">
								<label class="col-form-label col-lg-3 col-sm-12"> URL</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<input id="iframe-url" type="text"
										class="form-control col-lg-9 col-sm-12"
										aria-describedby="emailHelp" data-toggle="tooltip"
										data-original-title="Tooltip on bottom"
										placeholder="Enter or Paste URL" />
								</div>
							</div>
 -->

							<!-- <div class="form-group row" id="adv-settings"
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
										<label class="col-3 col-form-label">Cookie Time
											(hours)</label>
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
							</div> -->
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
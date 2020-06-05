<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.onwardpath.wem.util.Database"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="com.onwardpath.wem.repository.SegmentRepository"
%><%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"
%><%@ page import="java.util.Map, com.onwardpath.wem.helper.ExperienceHelper" 
%><%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%>
 
<%

pageContext.setAttribute("newLineChar", "\n");
String id= request.getParameter("id");
ExperienceHelper expHelper = new ExperienceHelper();
SegmentRepository segmentRepository = new SegmentRepository();
int org_id = (Integer)session.getAttribute("org_id");
%>
  
  <%!

LinkedList<String> timezoneLst = new LinkedList<String>();
private Connection dbConnection;
String[] timeZoneIds = TimeZone.getAvailableIDs();
private LinkedList<String> getTimeZone() throws SQLException {
	dbConnection = Database.getConnection();
	String displayName ="";
	PreparedStatement prepStatement = dbConnection.prepareStatement("select * from timezone");
	ResultSet result = prepStatement.executeQuery();  
	while(result.next()){
		displayName = result.getString("zone_id")+"@("+result.getString("utcoffset")+") "+result.getString("displayname")+" ("+result.getString("zone_id")+" )" ;
		timezoneLst.add(displayName);
	} 
	result.close();
    prepStatement.close();
    dbConnection.close();

	return timezoneLst;

} 
%>
<script>
var index 			= 	1;
var liStart			=	"<li class=\"list-group-item\" id="; 
var nameStart		=   "<div class=\"col-sm-9\"> <span class=\"text-break\" id= ";
var nameEnd			=   "</span> </div>";
var divRow			=   "<div class=\"row d-flex align-items-center\" >";
var ButtonStart 	= 	"<div class=\"col-sm-1.5\"> <button type=\"button\" class=\"btn btn-outline-info btn-pill\"";
var EditSpan 		= 	"<i class=\"fa fa-edit\"><span></span></i>";
var DeleteSpan 		= 	"<i class=\"flaticon2-trash\"><span></span></i>";
var ButtonEnd 		= 	"</button>&nbsp;</div>";
var NameSpan   		=   "";

var spanEnd			=   "</span>";

var url_id,actionis;
var expDetailsObj 	= 	{};
var cfgDetailsObj 	= 	{};
var schDetailsObj 	= 	{};
var advDetailsObj 	= 	{};

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

function setupSchedule(action, action_id) {
	var segment = document.getElementById("Timezonelist");
	if (action === "edit") {
		segment.value = schDetailsObj[action_id].split("#")[0];
		//actionis = action_id;      
		//document.getElementById("Timezonelist").value = schDetailsObj[action_id].split("#")[0];
		document.getElementById("kt_datepicker_1").value = schDetailsObj[action_id].split("#")[1];
		document.getElementById("kt_datepicker_2").value = schDetailsObj[action_id].split("#")[2];
	} else {  
		actionis = "";
		$("#Timezonelist").val($("#Timezonelist option:first").val());
		document.getElementById("kt_datepicker_1").value = "";
		document.getElementById("kt_datepicker_2").value = "";
		//document.getElementById("content").value = "";
	}
} 


function delete_exp_content(type, id) {
	var title = "Are you sure you want to delete the segment Content";
	//alert(type);
	//alert(id);
	var text = document.getElementById(type+'-'+id + "-namespan").innerHTML
	//alert(text);   
	var listId = "#" + type + "list-" + id;
	var deleteConfirmation = "Deleted";
	if ("url" === type) {
		title = "Are you sure you want to delete the Page URL";
		text = cfgDetailsObj[id];
		deleteConfirmation = "Deleted"
	}
	swal.fire({
		title : title,
		text : text,
		type : "warning",
		showCancelButton : !0,
		confirmButtonText : "Yes",
		cancelButtonText : "No",
		reverseButtons : !0
	}).then(function(e) {
		if (e.value) {
			swal.fire(deleteConfirmation, text, "success")
			$(listId).remove();
			if ("url" === type) {
				delete cfgDetailsObj[id];
			} else if ("segment" === type) {
				delete expDetailsObj[id];
			}else{
				delete schDetailsObj[id];
				//document.getElementById("blockstyle").style.display = "block";
				//document.getElementById("ablockstylesss").style.display = "block";
				     
				let elem = document.querySelector('#ablockstylesss');
				elem.style.setProperty('display', 'block', 'important');
			 	          
			}
		} else {
			"cancel" === e.dismiss;
			swal.fire("Cancelled", "Delete " + type, "error");
		}

	}); 
} 

function addsch(){
	
	var scheduletimezoneValue = document.getElementById("Timezonelist").value
	
	var startdatevalue = document.getElementById("kt_datepicker_1").value
	var enddatevalue = document.getElementById("kt_datepicker_2").value
	var passStatus = true
	
	if(startdatevalue =="" && enddatevalue==""){
		passStatus = false
		swal.fire("Please provide either startdate or enddate for scheduling")
		$("#schdeulding").modal("show");
	}else{
		if(startdatevalue !=""){
			document.getElementById("experience-form").startdate.value = startdatevalue;
		}
		if(enddatevalue !=""){
			document.getElementById("experience-form").enddate.value = enddatevalue;
		}
		if(scheduletimezoneValue !=""){
			document.getElementById("experience-form").timezoneval.value = scheduletimezoneValue;
			//document.getElementById("config-form").fulltimezoneval.value = result;
			
		}
		         
	}
	 if (JSON.stringify(schDetailsObj) == '{}') {
		addtoSchdeule('0',scheduletimezoneValue,startdatevalue,enddatevalue)
		document.getElementById("ablockstylesss").style.display = "none";
		//document.getElementById("blockstylesss").style.display = "none";
	}    
	schDetailsObj['0'] = scheduletimezoneValue+"#"+startdatevalue+"#"+enddatevalue
	$("#schdeulding").modal("hide"); 	  
}  
                        
function addtoSchdeule(segment_id,timezone,startdate,endate) {
	var addsegment = document.getElementById("addonschedule");
	//alert(addsegment);
	addsegment.innerHTML += liStart+"\"schedulelist-"+segment_id+"\">"
		+divRow
		+nameStart  +  "\"schedule-"+ segment_id+"-namespan\" data-toggle=\"tooltip\" title=\"Scheduling Enabled\">" +"Scheduling enabled for timezone "+timezone+" from "+startdate+" to "+endate+ nameEnd
		+ ButtonStart + " data-toggle=\"modal\" data-target=\"#schdeulding\" onclick=\"setupSchedule('edit','"+ segment_id+"')\" >" + EditSpan +ButtonEnd  
		+ ButtonStart+ " onclick=\"delete_exp_content('schedule','"+ segment_id +"')\">" + DeleteSpan + ButtonEnd.replace("&nbsp;",'')
		+"</li>";   	          	
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

function displaymodal(action_id) {
	
	
	
	var checkboxvalue = advDetailsObj[action_id].split("#")[0];           
	 
	 var arrayValues = checkboxvalue.split('|');
	  
	$.each(arrayValues, function(i, val){

		   $("input[value='" + val + "']").prop('checked', true);
  
		});
			         
	document.getElementById("popup_cookie").value =advDetailsObj[action_id].split("#")[1];
		document.getElementById("popup_delay").value =advDetailsObj[action_id].split("#")[2];	
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
     
function setupModal(action, action_id) {
	var segment = document.getElementById("segment");
	if (action === "edit") {
		//document.getElementById("adv-settings").style.display = "block";
		//document.getElementById("adv-setting").style.display = "block";    
		segment.value = action_id; 
		actionis = action_id;
		//typeVal = expDetailsObj[action_id].split("#")[0];
		//if(typeVal ==="top"){
			//$("#top").prop('checked', true);
		//}else{
			
			//$("#bottom").prop('checked', true);
			
		//} 
		
		document.getElementById("popup").value = expDetailsObj[action_id].split("#")[1];
		var el_htm = document.getElementById("for-html");
		var el_ifr = document.getElementById("for-iframe");
		if (expDetailsObj[action_id].split("#")[1] === "html") {
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
		if(expDetailsObj[action_id].split("#")[2] != 'null'){
			document.getElementById("content").value = expDetailsObj[action_id].split("#")[2];	
		}else{
			document.getElementById("content").value = "";
		}
		
		if(expDetailsObj[action_id].split("#")[3] != 'null'){
			document.getElementById("iframe-url").value = expDetailsObj[action_id].split("#")[3];	
		}else{
			document.getElementById("iframe-url").value = "";
		}
		
		if(expDetailsObj[action_id].split("#")[4] != 'null'){
			document.getElementById("width").value = expDetailsObj[action_id].split("#")[4];	
		}else{
			document.getElementById("width").value = "";
		}
		
		
		
		if(expDetailsObj[action_id].split("#")[5] != 'null'){
			document.getElementById("height").value = expDetailsObj[action_id].split("#")[5];	
		}else{
			document.getElementById("height").value = "";
		}
		
		if(expDetailsObj[action_id].split("#")[6] != 'null'){
			document.getElementById("bgcolor_txt").value = expDetailsObj[action_id].split("#")[6];	
		}else{
			document.getElementById("bgcolor_txt").value = "";
		}
		
		if(expDetailsObj[action_id].split("#")[7] != 'null'){
			document.getElementById("bgcolor").value = expDetailsObj[action_id].split("#")[7];	
		}else{
			document.getElementById("bgcolor").value = "";
		}
		
		if(expDetailsObj[action_id].split("#")[8] != 'null'){
			document.getElementById("bgimgurl").value = expDetailsObj[action_id].split("#")[8];	
		}else{
			document.getElementById("bgimgurl").value = "";
		}
		
		   
		  	   
	   	   
	} else { 
		actionis = "";
		$("#segment").val($("#segment option:first").val());
		document.getElementById("content").value = "";
		document.getElementById("popup").value ="html";
		document.getElementById("iframe-url").value = "";
		document.getElementById("width").value = "";
		document.getElementById("height").value = "";
		document.getElementById("bgcolor_txt").value = "";
		document.getElementById("bgcolor").value = "";
		document.getElementById("bgimgurl").value = "";
		
		 
		  
              
	}
	  	     
	}
	

function addadvnsetting() {
	
	  
	var page_events = getCheckedEvents();
	var pageeventsvalue="";
	var popupcookievalue="";
	var popupdelayvalue="";
	var popup_cookie = document.getElementById("popup_cookie").value;
	var  popup_delay=  document.getElementById("popup_delay").value;
	
	if(page_events ===""){
		pageeventsvalue="load";
	}else{
		pageeventsvalue=page_events
	}	
	
	if(popup_cookie ===""){
		popupcookievalue="0";
	}else{
		popupcookievalue=popup_cookie
	}
	
	if(popup_delay ===""){
		popupdelayvalue="0";
	}else{
		popupdelayvalue=popup_delay
	}
	  
	advDetailsObj['0'] = pageeventsvalue+"#"+popupcookievalue+"#"+popupdelayvalue;
	$("#advancesetting_Modal").modal("hide"); 
	  
	 
} 
	
function addContent() {
	var segment = document.getElementById("segment");
	
	var _segid = segment.value;
	
		//alert("hey:"+ typeVal);
	var contentvalue = document.getElementById("content").value
	if(contentvalue != "null"){
		modalcontent = contentvalue;
	}
	var popupvalue = document.getElementById("popup").value
	if(popupvalue !="null"){
		popup = popupvalue;
	} 
	var iframeurlvalue = document.getElementById("iframe-url").value
	if(iframeurlvalue != "null"){
		modalurl = iframeurlvalue;
	}
	var widthvalue = document.getElementById("width").value
	if(widthvalue != "null"){
		width = widthvalue;
	}
	var heightvalue = document.getElementById("height").value
	if(heightvalue != "null"){
		height = heightvalue;
	}
	var bgcolortxtvalue = document.getElementById("bgcolor_txt").value
	if(bgcolortxtvalue != "null"){
		bgcolor_txt = bgcolortxtvalue;
	}
	var bgcolorvalue = document.getElementById("bgcolor").value
	
	if(bgcolorvalue != "null"){
		bgcolor = bgcolorvalue;
	}
	
var bgimgurlvalue = document.getElementById("bgimgurl").value
	
	if(bgimgurlvalue != "null"){
		bgimgurl = bgimgurlvalue;
	}
	
	
	if (popup.length > 0) {
		if (actionis && actionis!=_segid){
			var listId = "#segmentlist-" + actionis;
			$(listId).remove();
			delete expDetailsObj[actionis];
			
		}
		setModalContent();
		content = exampleModalLongInner.outerHTML;   
		if (!(_segid in expDetailsObj)) {
			
			segment_name = segment.options[segment.selectedIndex].innerHTML;
			
			addtoSegment(_segid, segment_name, content+"#"+popup+"#"+modalcontent+"#"+modalurl+"#"+width+"#"+height+"#"+bgcolor_txt+"#"+bgcolor+"#"+bgimgurl);
			//console.log("hey:"+addtoSegment()):
		} 
		expDetailsObj[_segid] = content+"#"+popup+"#"+modalcontent+"#"+modalurl+"#"+width+"#"+height+"#"+bgcolor_txt+"#"+bgcolor+"#"+bgimgurl;  
		console.log ("wow:"+expDetailsObj[_segid]);   
		$("#segment_modal").modal("hide");
} else {
	swal.fire("Content required for the Segment");
}
 
}   


function addtoSegment(segment_id, segment_name,segementContent ) {
	var addsegment = document.getElementById("addonContent");
	addsegment.innerHTML += liStart+"\"segmentlist-"+segment_id+"\">"
		+divRow
		+nameStart  +  "\"segment-"+ segment_id+"-namespan\" data-toggle=\"tooltip\" title='"+segementContent+"'>" + segment_name + nameEnd
		+ ButtonStart + " data-toggle=\"modal\" data-target=\"#segment_modal\" onclick=\"setupModal('edit','"+ segment_id+"')\" >" + EditSpan +ButtonEnd  
		+ ButtonStart+ " onclick=\"delete_exp_content('segment','"+ segment_id +"')\">" + DeleteSpan + ButtonEnd.replace("&nbsp;",'')
		+"</li>";
	  	
}   
 
function contenturl(urlID) {
	if (urlID in cfgDetailsObj) {
		document.getElementById("pageurl").value = cfgDetailsObj[urlID];
		url_id = urlID;
	} else {
		document.getElementById("pageurl").value = '';
		url_id = index;
		index++;
	}
}
function addUrl() {
	var pageUrl = document.getElementById("pageurl").value;
	if (pageUrl.length > 0) {
		if (!(url_id in cfgDetailsObj)) {
			var addurl = document.getElementById("addonurl");
			addurl.innerHTML += liStart+"\"urllist-"+url_id+"\">"
				+divRow
				+ nameStart +"\"url-"+ url_id+"-namespan\">" + pageUrl + nameEnd
				+  ButtonStart + " data-toggle=\"modal\" data-target=\"#PageURL_Modal\" onclick=\"contenturl('"+ url_id+"')\">"	+ EditSpan +ButtonEnd 			
				
				+ ButtonStart + " onclick=\"delete_exp_content('url','"+ url_id +"')\">" + DeleteSpan + ButtonEnd.replace("&nbsp;",'')
				+ "</li>";
		} else {
			document.getElementById('url-'+url_id + '-namespan').innerHTML = pageUrl;
		}
		cfgDetailsObj[url_id] = pageUrl;
		url_id = "";
		$("#PageURL_Modal").modal("hide");
	} else {
		Swal.fire('URL cannot be empty. Please enter an url')
	}
} 


function saveExperience() {
	var finalexp_name = document.getElementById("form-expname").value;
	if (finalexp_name) {
		if (JSON.stringify(expDetailsObj) !== '{}') {
			var experienceid =document.getElementsByName("expid");
			document.getElementById("form-contentdetails").value = JSON.stringify(expDetailsObj);
			document.getElementById("form-urldetails").value = JSON.stringify(cfgDetailsObj);
			document.getElementById("form-schdetails").value = JSON.stringify(schDetailsObj);
			document.getElementById("form-advdetails").value = JSON.stringify(advDetailsObj);
			document.getElementById("experience-form").method = "post";
			document.getElementById("experience-form").action = "ExperienceController";
			document.getElementById("experience-form").submit();
		} else {
			Swal.fire("Please enter atleast one content for this Experience")
		}
	} else {
		Swal.fire("Please enter a value for  Experience Name")
	}

}

function cancelOperation() {	
	location.replace("/wem?view=pages/experience-view-content.jsp")
   
} 


function setModalContent() {
	var prvw_el = document.getElementById("preview");
	var prvw_style_el = document.getElementById("preview-style");

	var ifr_el = document.getElementById("iframe-element");
	var ifr_url_val = document.getElementById("iframe-url").value;

	var bgcolors = "background-color:#"
			+ document.getElementById("bgcolor").value;
	bgcolor_txt =  document.getElementById("bgcolor_txt").value;
	var bgimgurls = "url('" + document.getElementById("bgimgurl").value
			+ "')";
	var widths = document.getElementById("width").value + "px";
	var heights = document.getElementById("height").value + "px";

	prvw_style_el.setAttribute("style", bgcolors);
	prvw_style_el.setAttribute("margin-left", "auto");
	prvw_style_el.setAttribute("margin-right", "auto");
	prvw_style_el.style.backgroundImage = bgimgurls;
	prvw_style_el.style.backgroundSize = "contain";
	prvw_style_el.style.width = widths;
	prvw_style_el.style.height = heights;
	
	    
	   
	var ptype = document.getElementById("popup").value;
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
</script>
         
<!-- <script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script> -->
 
<c:set var="all_segements" value="<%=segmentRepository.getOrgSegments(org_id) %>" />
<c:set var="experience_contents" value="<%=expHelper.experiencepopup(id) %>" />
<c:set var="scheduleValue" value="<%=expHelper.scheduleDate(id) %>" />
<c:set var="experience_name" value="<%=expHelper.getexperienceName(id) %>" />
<c:set var="advncsettingValue" value="<%=expHelper.popupadvnsetting(id) %>" />
  
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Edit Popup Experience </h3>
			</div>
		</div>
		<div class="kt-portlet__body">
		<form class="kt-form kt-form--label-right" id="experience-form" >
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Experience Name</label>
				<div class="col-lg-4 col-md-9 col-sm-12">															
					<input type="text"		id="form-expname"			name="expName"   class="form-control" aria-describedby="Experience Name"  placeholder="Expereince Name"  value='${experience_name}'>
					<input type="hidden" 	id="form-contentdetails"	name="experienceDetails"  />
					<input type="hidden"	id="form-urldetails"		name="urlList"   />
					<input type="hidden"	id="form-schdetails"		name="schList"   />
					<input type="hidden"	id="form-advdetails"		name="advList"   />
					
					            <input type="hidden" id="form-startdate" name="startdate">
								<input type="hidden" id="form-enddate" name="enddate">
								
								<input type="hidden" id="form-timezoneval" name="timezoneval">
					<input type="hidden"	name="pageName"  value="edit-popupexperience"  />
					<input type="hidden"	name="expid"  value="<%=id%>"  />
				</div> 
			</div>
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Segment</label>
				<div class="col-sm-6 padding-top-12">
					<div class="kt-section">
						<div class="kt-section__content kt-section__content--border">
							<ul class="list-group" id="addonContent">
							<c:forEach items="${experience_contents}" var="content"  varStatus="counter">
							<c:if test ="${not empty content.segmentName }">
							<li class="list-group-item" id="segmentlist-${content.id}">
								<div class="row d-flex align-items-center">
								<div class="col-sm-9"><span id="segment-${content.id}-namespan" data-toggle="tooltip"  title='${content.content}'> ${content.segmentName} </span></div>
								<div class="col-sm-1.5">
								    <button type="button" class="btn btn-outline-info btn-pill" data-toggle="modal" data-target="#segment_modal" onclick="setupModal('edit','${content.id}')">
								        <i class="fa fa-edit"><span></span></i>
								    </button>&nbsp;
								</div>
								<div class="col-sm-1.5">
								    <button type="button" class="btn btn-outline-info btn-pill" onclick="delete_exp_content('segment','${content.id}')">
								            <i class="flaticon2-trash"><span></span></i>
								        </button>
								    </div>
								</div>
							</li>
							  								
                         <script> expDetailsObj[escape('${content.id}')]= '${fn:replace(content.barfulldata, newLineChar, " ")}#${content.content}#${content.htmlcontent}#${content.urls}#${content.width}#${content.height}#${content.textcolor}#${content.bgcolor}#${content.bgimageurl}' ; </script>
                        </c:if> 
                        </c:forEach> 
                     </ul>  
                     <br/>
                     <a href="" class="btn btn-success btn-pill" data-toggle="modal"  data-target="#segment_modal" onclick="setupModal('add','')">Add</a>
                     
                     <div class="modal fade show" id="segment_modal" role="dialog" aria-labelledby="" style="display:none;padding-right: 16px;" aria-modal="true">
                        <div class="modal-dialog modal-lg" role="document">
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title" id="">New Segment</h5>
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true" class="la la-remove"></span>
                                 </button>
                              </div>
                              
                              <div class="modal-body">
                                 <div class="form-group row kt-margin-t-20">
                                    <label class="col-form-label col-lg-3 col-sm-12">Segment</label>
                                    <div class="col-lg-9 col-md-9 col-sm-12">
                                       <select id="segment" class="form-control kt-select2 select2-hidden-accessible" name="segment-dropdown" style="width: 75%">
                                          <c:forEach items="${all_segements}" var="segment" >
							                      <option value="${segment.key}">${segment.value} </option>
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
								<label class="col-lg-3 col-sm-12 col-form-label">Text Color:</label>
								<div class="col-lg-2 col-md-9 col-sm-12">
									<div class="kt-input-icon">
										<input id="bgcolor_txt" type="text" class="form-control jscolor">
									</div>
								</div>
								<label class="col-lg-1 col-form-label">Height (px):</label>
								<div class="col-lg-1 col-md-9 col-sm-12">
									<div class="kt-input-icon">
										<input id="height" type="text" value="250"
											class="form-control">
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
										aria-describedby="emailHelp" placeholder="Enter Text"
										rows="10" cols="10"></textarea>
								</div>
							</div>
                              
                              <div class="form-group row">
								
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
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-brand" data-dismiss="modal">Close</button>
                                 <button type="button" class="btn btn-secondary" onclick="addContent()">Submit</button>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         
         
         
         <div class="form-group row">
            <label class="col-form-label col-lg-3 col-sm-12">Advance Setting</label>
            <div class="col-sm-6 padding-top-12">
               <div class="kt-section">
                  <div class="kt-section__content kt-section__content--border" >
                     <ul class="list-group" id="addonavansetting">
                      <c:forEach items="${advncsettingValue}" var="advncsettingValue" varStatus="counter">
			              <li class="list-group-item" id="advurllist">
			               <div class="row d-flex align-items-center" >
	                        <div class="col-sm-9" ><span class="text-break" id="advurl-namespan"> Advance Setting </span></div>	
							<div class="col-sm-1.5" >
								
									<button type="button" class="btn btn-outline-info btn-pill" data-toggle="modal" data-target="#advancesetting_Modal"  onclick="displaymodal('${advncsettingValue.id}')">
										<i class="fa fa-edit"><span></span></i>
									</button>&nbsp;
							</div>
							
						</div>		
			              
                        </li>      
                         <script> advDetailsObj[escape('${advncsettingValue.id}')]= '${advncsettingValue.events}#${advncsettingValue.cookie}#${advncsettingValue.delay}' ; </script> 
                        </c:forEach>
                     </ul>
                     <br/>
                        
                     
                     <div class="modal fade show" id="advancesetting_Modal" role="dialog" aria-labelledby="" style="display: none; padding-right: 16px;" aria-modal="true">
                        <div class="modal-dialog modal-lg" role="document" >
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title" id="">Advance Setting</h5>
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true" class="la la-remove"></span>
                                 </button>
                              </div>
                              <div class="modal-body">
                                 <div class="form-group row" id="adv-settings">
								<div class="kt-section__content kt-section__content--border">
									<div class="form-group">
										<div class="card-header kt-font-bolder">Choose the Page
											Events here</div>
										<div class="kt-separator--space-md"></div>
										</br>
										<div class="kt-checkbox-inline" id="page_events">
											<label class="kt-checkbox"> <input type="checkbox"
												 value="load" checked="" for="for-onload"
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
							</div>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-brand" data-dismiss="modal">Close</button>
                                 <button type="button" class="btn btn-secondary" onclick="addadvnsetting()">Submit</button>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
          
         <div class="form-group row">
            <label class="col-form-label col-lg-3 col-sm-12">Pages</label>
            <div class="col-sm-6 padding-top-12">
               <div class="kt-section">
                  <div class="kt-section__content kt-section__content--border" >
                     <ul class="list-group" id="addonurl">
                     <c:forEach items="${experience_contents}" var="content" varStatus="counter">
			              <c:if test ="${empty content.segmentName }">
			              <li class="list-group-item" id="urllist-${counter.count}">
			               <div class="row d-flex align-items-center" >
	                        <div class="col-sm-9" ><span class="text-break" id="url-${counter.count}-namespan"> ${content.content} </span></div>	
							<div class="col-sm-1.5" >
								
									<button type="button" class="btn btn-outline-info btn-pill" data-toggle="modal" data-target="#PageURL_Modal"  onclick="contenturl('${counter.count}')">
										<i class="fa fa-edit"><span></span></i>
									</button>&nbsp;
							</div>
							<div class="col-sm-1.5" >		
									<button type="button" class="btn btn-outline-info btn-pill" onclick="delete_exp_content('url','${counter.count}')" >
										<i class="flaticon2-trash"><span></span></i>
									</button>
							</div>
						</div>		
			              
                        </li> 
                         <script> cfgDetailsObj[index++]= '${fn:replace(content.content, newLineChar, " ")}' ; </script>
                        </c:if>
                        </c:forEach>
                     </ul>
                     <br/>
                     <a href="" class="btn btn-success btn-pill" data-toggle="modal" data-target="#PageURL_Modal" onclick="contenturl('')">Add</a>
                     
                     <div class="modal fade show" id="PageURL_Modal" role="dialog" aria-labelledby="" style="display: none; padding-right: 16px; top:25%" aria-modal="true">
                        <div class="modal-dialog modal-lg" role="document" >
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title" id="">Page</h5>
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true" class="la la-remove"></span>
                                 </button>
                              </div>
                              <div class="modal-body">
                                 <div class="form-group row kt-margin-t-20" >
                                    <label class="col-form-label col-lg-3 col-sm-12">URL</label>
                                    <div class="col-lg-9 col-md-9 col-sm-12" >
                                       <input name="url" id="pageurl" type="text" class="form-control" aria-describedby="url"  style="width: 75%" >
                                    </div>
                                 </div> 
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-brand" data-dismiss="modal">Close</button>
                                 <button type="button" class="btn btn-secondary" onclick="addUrl()">Submit</button>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         
          
         
         
         <div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Schedule</label>
				<div class="col-sm-6 padding-top-12">
					<div class="kt-section">
						<div class="kt-section__content kt-section__content--border">
							<ul class="list-group" id="addonschedule">
							<c:forEach items="${scheduleValue}" var="schedule" varStatus="counter">
						  <%--  st:${schedule.startDate}
							En:${schedule.endDate}     
							status:${schedule.status}   
							timezonefullvalue:${schedule.timeZonevalue} --%> 
							<c:if test="${schedule.status eq 'scheduled'}">   
							<li class="list-group-item" id="schedulelist-${schedule.id}">
								<div class="row d-flex align-items-center">
								<div class="col-sm-9"><span id="schedule-${schedule.id}-namespan" data-toggle="tooltip"  title='Scheduling Enabled'> Scheduling Enabled for ${schedule.timeZonevalue} timezone from ${schedule.startDate} to  ${schedule.endDate}  </span></div>
								<div class="col-sm-1.5">
								    <button type="button" class="btn btn-outline-info btn-pill" data-toggle="modal" data-target="#schdeulding" onclick="setupSchedule('edit','${schedule.id}')">
								        <i class="fa fa-edit"><span></span></i>
								    </button>&nbsp;
								</div>   
								<div class="col-sm-1.5">
								    <button type="button" class="btn btn-outline-info btn-pill" onclick="delete_exp_content('schedule','${schedule.id}')">
								            <i class="flaticon2-trash"><span></span></i>
								        </button>
								    </div>
								</div> 
							</li>
								 							
                           
                         <script> schDetailsObj[escape('${schedule.id}')]= '${schedule.timeZonevalue}#${schedule.startDate}#${schedule.endDate}' ; </script>
                         <a href="" class="btn btn-success btn-pill" id="ablockstylesss"  data-toggle="modal" data-target="#schdeulding" onclick="setupSchedule('add','')" style="display:none; width: min-content">Add</a>
                         </c:if>       
                         <c:if test="${schedule.status ne 'scheduled'}"> 
                           
                     <a href="" class="btn btn-success btn-pill" id="ablockstylesss" data-toggle="modal" data-target="#schdeulding" onclick="setupSchedule('add','')" style="width: min-content">Add</a>
                     </c:if>
                        </c:forEach> 
                     </ul> 
                             
                           
                     <div class="modal fade show" id="schdeulding" role="dialog" aria-labelledby="" style="display:none;padding-right: 16px;top:20%" aria-modal="true">
                        <div class="modal-dialog modal-lg" role="document">
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title" id="">Scheduling</h5>
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true" class="la la-remove"></span>
                                 </button>
                              </div>  
                              
                              <div class="modal-body">
                                 <div class="form-group row">
                                    <label class="col-form-label col-lg-3 col-sm-12">TimeZone</label>
                                    <div class="col-lg-9 col-md-9 col-sm-12">
                                      <select class="form-control" placeholder="Select Your favourite" data-search="true" id="Timezonelist">
							<!-- <option value="">--Select--</option> --> 
							<c:forEach items="<%=getTimeZone()%>" var="timezoneVal">
								<option value='${fn:split(timezoneVal,"@")[0]}'>${fn:split(timezoneVal,"@")[1]}</option>
							</c:forEach>
						</select>
                                    </div>
                                 </div>
                                 <div class="form-group row" >
                                    <label class="col-form-label col-lg-3 col-sm-12">Start Date</label>
                                     <div class="col-lg-3 col-md-9 col-sm-12">
                                    <div class="input-group date">
						<input type="text" class="form-control "value="" placeholder="Select date" id="kt_datepicker_1">
						<div class="input-group-append">
							<span class="input-group-text">
								<i class="la la-calendar-check-o"></i>
							</span>
						</div>
					</div> 
					</div>
                                 </div>  
                                 
                                 <div class="form-group row">
                                    <label class="col-form-label col-lg-3 col-sm-12">End Date</label>
                                    <div class="col-lg-3 col-md-9 col-sm-12">
                                    <div class="input-group date">
						<input type="text" class="form-control "value="" placeholder="Select date" id="kt_datepicker_2">
						<div class="input-group-append">
							<span class="input-group-text">
								<i class="la la-calendar-check-o"></i>
							</span>
						</div>
					</div>
                           </div>      
                           </div>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-brand" data-dismiss="modal">Close</button>
                                 <button type="button" class="btn btn-secondary" onclick="addsch()">Submit</button>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
          
         <%-- <div id="dateformation">
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Start Date</label>
				<div class="col-lg-3 col-md-9 col-sm-12">
					<div class="input-group date">
						<input type="text" class="form-control "value="" placeholder="Select date" id="kt_datepicker_1">
						<div class="input-group-append">
							<span class="input-group-text">
								<i class="la la-calendar-check-o"></i>
							</span>
						</div>
					</div>
				</div>
			</div>
			
			
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">End Date</label>
				<div class="col-lg-3 col-md-9 col-sm-12">
					<div class="input-group date">
						<input type="text" class="form-control "  value="" placeholder="Select date" id="kt_datepicker_2">
						<div class="input-group-append">
							<span class="input-group-text">
								<i class="la la-calendar-check-o"></i>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">TimeZone</label>
					<div class="col-lg-3 col-md-9 col-sm-12" id="exampleSelect2">
						<select class="form-control" placeholder="Select Your favourite" data-search="true" id="Timezonelist">
							<option value="">--Select--</option>
							<c:forEach items="<%=getTimeZone()%>" var="timezoneVal">
								<option value='${fn:split(timezoneVal,"@")[0]}'>${fn:split(timezoneVal,"@")[1]}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>   --%>
         <!--end::PortletPages-->
         	
         <div class="kt-portlet__body">
            <div class="form-group row">
               <label class="col-form-label col-lg-3 col-sm-12"></label>					
               <div class="col-lg-4 col-md-9 col-sm-12">
                  <button type="button" class="btn btn-primary" onclick="saveExperience()">Save</button>&nbsp;
                  <button type="button" class="btn btn-secondary" onclick="cancelOperation()">Cancel</button>
               </div>
            </div>
         </div>
        
      </form>
   </div>
</div>
</div>
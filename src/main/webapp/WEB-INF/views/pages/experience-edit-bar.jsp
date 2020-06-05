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
var anchorTarget = "_self";
var classname ="null";
var typeVal = "";
var barbgcolor = null;
var bartextcolor =null;
var bartext =null;
var button =null;
var buttonbgcolor =null;
var buttontextcolor =null;
var buttontext= null ;
var linkurl= null;
var segment_id = null;
var bar_content = null;
var buttonshowvalue = "hide";
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


//Validate Advanced Settings Checkbox & return its content

 

function delete_exp_content(type, id) {
	var title = "Are you sure you want to delete the segment Content";
	var text = document.getElementById(type+'-'+id + "-namespan").innerHTML
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

function getButton(event) {
	let el_id = event.target.attributes.for.value;	
	
	if (event.currentTarget.checked == true)
		document.getElementById(el_id).style.display = "block";
	else
		document.getElementById(el_id).style.display = "none";
}

 
function setupModal(action, action_id) {
	var segment = document.getElementById("segment");
	if (action === "edit") {
		//document.getElementById("adv-settings").style.display = "block";
		//document.getElementById("adv-setting").style.display = "block";    
		segment.value = action_id; 
		actionis = action_id;
		typeVal = expDetailsObj[action_id].split("#")[0];
		if(typeVal ==="top"){
			$("#top").prop('checked', true);
		}else{
			
			$("#bottom").prop('checked', true);
			
		} 
		
		if(expDetailsObj[action_id].split("#")[1] != 'null'){
			document.getElementById("bar_color").value = expDetailsObj[action_id].split("#")[1];	
		}else{
			document.getElementById("bar_color").value = "";
		}
		
		if(expDetailsObj[action_id].split("#")[2] != 'null'){
			document.getElementById("txt_color").value = expDetailsObj[action_id].split("#")[2];	
		}else{
			document.getElementById("txt_color").value = "";
		}
		
		if(expDetailsObj[action_id].split("#")[3] != 'null'){
			document.getElementById("content").value = expDetailsObj[action_id].split("#")[3];	
		}else{
			document.getElementById("content").value = "";
		}
		
		
		
		if(expDetailsObj[action_id].split("#")[5] != 'null'){
			document.getElementById("button_color").value = expDetailsObj[action_id].split("#")[5];	
		}else{
			document.getElementById("button_color").value = "";
		}
		
		if(expDetailsObj[action_id].split("#")[6] != 'null'){
			document.getElementById("button_txt_color").value = expDetailsObj[action_id].split("#")[6];	
		}else{
			document.getElementById("button_txt_color").value = "";
		}
		
		if(expDetailsObj[action_id].split("#")[7] != 'null'){
			document.getElementById("buttoncontent").value = expDetailsObj[action_id].split("#")[7];	
		}else{
			document.getElementById("buttoncontent").value = "";
		}
		
		if(expDetailsObj[action_id].split("#")[8] != 'null'){
			document.getElementById("link_value").value = expDetailsObj[action_id].split("#")[8];	
		}else{
			document.getElementById("link_value").value = "";
		}
		
		if(expDetailsObj[action_id].split("#")[9] == "_self"){
			 document.getElementById("self").checked = true;				
		}
		 
		 
		 
		 if(expDetailsObj[action_id].split("#")[9] == "_blank"){
			 document.getElementById("blank").checked = true;				
		}
		  	   
	   	   
	} else { 
		actionis = "";
		$("#segment").val($("#segment option:first").val());
		document.getElementById("bar_color").value = "";
		document.getElementById("txt_color").value = "";
		document.getElementById("content").value = "";
		document.getElementById("button_color").value = "";
		document.getElementById("button_txt_color").value = "";
		document.getElementById("buttoncontent").value = "";
		document.getElementById("link_value").value = "";
		document.getElementById("self").checked = true;
		
		  
              
	}
	  	     
	}
	
	
	
   
function getScreen(screen)
{
	var screen_sel = screen.value;
	typeVal = screen_sel;
}
function addContent() {
	var segment = document.getElementById("segment");
	
	var _segid = segment.value;
	
		//alert("hey:"+ typeVal);
	var barcolorvalue = document.getElementById("bar_color").value
	if(barcolorvalue != ""){
		barbgcolor = barcolorvalue;
	}
	var txtcolorvalue = document.getElementById("txt_color").value
	if(txtcolorvalue !=""){
		bartextcolor = txtcolorvalue;
	} 
	var contentvalue = document.getElementById("content").value
	if(contentvalue != ""){
		bartext = contentvalue;
	}
	var buttoncolorvalue = document.getElementById("button_color").value
	if(buttoncolorvalue != ""){
		buttonbgcolor = buttoncolorvalue;
	}
	var buttontxtcolorvalue = document.getElementById("button_txt_color").value
	if(buttontxtcolorvalue != ""){
		buttontextcolor = buttontxtcolorvalue;
	}
	var buttoncontentvalue = document.getElementById("buttoncontent").value
	if(buttoncontentvalue != ""){
		buttontext = buttoncontentvalue;
	}
	var link_value = document.getElementById("link_value").value
	
	if(link_value != ""){
		linkurl = link_value;
	}
	
	if(document.getElementById('showchkbox').checked == true)
	{
	buttonshowvalue = document.getElementById('showchkbox').value;
	
	} 
	
	
	var position = "fixed";
	 var d = new Date();
	var n = d.getTime();
	var r = document.getElementsByClassName("container")
	var id = r[0].id;
	id= "Bar-"+_segid+"-"+n;
	 
	$(".container").attr('id',id); 
	$(".container").css("display", "block");
	$(".container").css("position", "fixed");
	$(".container").css("z-index", "1000000");
	$(".container").css("left", "0px");
	$(".container").css("top", "0px");
	$(".container").css("width", "100%");
	$(".container").css("height", "50px");
	
	var count = 0;
	var screen = typeVal;
	var expression =  new RegExp('^(?:[a-z]+:)?//', 'i');
	var position = "fixed";
	////localStorage.setItem("segment", "segment");
	//var typeVal = "Bar"
	//var button_display = localStorage.getItem("Not_button");
	    
	
	/*  var checkedValue = "";
   	var inputElements = document.getElementById('page_events')
   			.getElementsByTagName("input");
   //alert("Hey:"+ inputElements)
   	for (var i = 0; inputElements[i]; ++i) {
   		if (inputElements[i].checked != "") {
   			checkedValue += inputElements[i].value;
   		}else{
   			checkedValue ="No"
   		}
   	} */
   
   	//content = getContentFromLinkExp() 
     
	
		  
	if (typeVal.length > 0) {
		if (actionis && actionis!=_segid){
			var listId = "#segmentlist-" + actionis;
			$(listId).remove();
			delete expDetailsObj[actionis];
			
		}
		notify_bar(position, screen);
		bar_content = $('.container')[0].outerHTML;
		
		if (!(_segid in expDetailsObj)) {
			
			segment_name = segment.options[segment.selectedIndex].innerHTML;
			addtoSegment(_segid, segment_name, typeVal+"#"+barbgcolor+"#"+bartextcolor+"#"+bartext+"#"+buttonshowvalue+"#"+buttonbgcolor+"#"+buttontextcolor+"#"+buttontext+"#"+linkurl+"#"+anchorTarget+"#"+bar_content);
			//console.log("hey:"+addtoSegment()):
		} 
		expDetailsObj[_segid] = typeVal+"#"+barbgcolor+"#"+bartextcolor+"#"+bartext+"#"+buttonshowvalue+"#"+buttonbgcolor+"#"+buttontextcolor+"#"+buttontext+"#"+linkurl+"#"+anchorTarget+"#"+bar_content;  
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
		+nameStart  +  "\"segment-"+ segment_id+"-namespan\" data-toggle=\"tooltip\">" + segment_name + nameEnd
		+ ButtonStart + " data-toggle=\"modal\" data-target=\"#segment_modal\" onclick=\"setupModal('edit','"+ segment_id+"')\" >" + EditSpan +ButtonEnd  
		+ ButtonStart+ " onclick=\"delete_exp_content('segment','"+ segment_id +"')\">" + DeleteSpan + ButtonEnd.replace("&nbsp;",'')
		+"</li>";
	  	
}



function notify_bar(position, screen) {
	var position = position;
	var screen = screen;
	var segment_d = document.getElementById("segment");
	var button_display = buttonshowvalue;
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

function getTargetOption(target){
	anchorTarget = target.value;
}
</script>
         
<!-- <script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script> -->
 
<c:set var="all_segements" value="<%=segmentRepository.getOrgSegments(org_id) %>" />
<c:set var="experience_contents" value="<%=expHelper.experiencebar(id)%>" />
<c:set var="scheduleValue" value="<%=expHelper.scheduleDate(id) %>" />
<c:set var="experience_name" value="<%=expHelper.getexperienceName(id) %>" />
  
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Edit Bar Experience </h3>
			</div>
		</div>
		<div id="linkContent" style="display:none"></div>
		<div class="kt-portlet__body">
		<form class="kt-form kt-form--label-right" id="experience-form" >
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Experience Name</label>
				<div class="col-lg-4 col-md-9 col-sm-12">															
					<input type="text"		id="form-expname"			name="expName"   class="form-control" aria-describedby="Experience Name"  placeholder="Expereince Name"  value='${experience_name}'>
					<input type="hidden" 	id="form-contentdetails"	name="experienceDetails"  />
					<input type="hidden"	id="form-urldetails"		name="urlList"   />
					<input type="hidden"	id="form-schdetails"		name="schList"   />
					            <input type="hidden" id="form-startdate" name="startdate">
								<input type="hidden" id="form-enddate" name="enddate">
								
								<input type="hidden" id="form-timezoneval" name="timezoneval">
					<input type="hidden"	name="pageName"  value="edit-bar-experience"  />
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
							   								
                         <script> expDetailsObj[escape('${content.id}')]= '${content.content}#${content.barbgcolor}#${content.bartextcolor}#${content.bartext}#${content.button}#${content.buttonbgcolor}#${content.buttontextcolor}#${content.buttontext}#${content.linkurl}#${content.targetlink}#${fn:replace(content.barfulldata, newLineChar, " ")}' </script>
                        </c:if>    
                        </c:forEach>  
                     </ul> 
                     <br/>  
                     <a href="" class="btn btn-success btn-pill" data-toggle="modal"  data-target="#segment_modal" onclick="setupModal('add','')">Add</a>
                     
                     <div class="modal fade show" id="segment_modal" role="dialog" aria-labelledby="" style="display:none;padding-right: 16px; aria-modal="true">
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
									<input id="bar_color" type="text" class="form-control jscolor" >
								</div>
								<label class="col-lg-1 col-form-label">Text Color</label>
								<div class="col-lg-1 col-md-9 col-sm-12">
									<input id="txt_color" type="text"
											class="form-control jscolor" > 
								</div>
							</div> 


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
											 onclick="getTargetOption(this)" id="self"> Same Page <span></span>
										</label> <label class="kt-radio"> <input type="radio"
											name="targetradio" value="_blank"
											onclick="getTargetOption(this)" id="blank"> New Page <span></span>
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
								 
							<!--  Iframe for External URL View -->
								<div class="embed-responsive embed-responsive-16by9"
									id="iframe-element" style="display: none; height: 100%">
									<iframe class="embed-responsive-item" src=""></iframe>
								</div>




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



							 

							<div class="kt-separator kt-separator--border-dashed"></div>
							<div class="kt-separator kt-separator--height-sm"></div>

							<div class="kt-section__content kt-section__content--border">
								<div id="stage" style="display: none;"></div>
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


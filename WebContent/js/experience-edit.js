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

     
function delete_exp_content(type, id) {
	var title = "Are you sure you want to delete the segment Content";
	alert(type);
	alert(id);
	var text = document.getElementById(type+'-'+id + "-namespan").innerHTML
	alert(text);   
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
function setupModal(action, action_id) {
	var segment = document.getElementById("segment");
	if (action === "edit") {
		segment.value = action_id;
		actionis = action_id;
		document.getElementById("content").value = expDetailsObj[action_id];
	} else {
		actionis = "";
		$("#segment").val($("#segment option:first").val());
		document.getElementById("content").value = "";
		
	}
} 
function addContent() {
	var segment = document.getElementById("segment");
	var segementContent = document.getElementById("content").value
	if (segementContent.length > 0) {
		var _segid = segment.value;
	
		if (actionis && actionis!=_segid){
			var listId = "#segmentlist-" + actionis;
			$(listId).remove();
			delete expDetailsObj[actionis];
			
		}
		
		if (!(_segid in expDetailsObj)) {
			segment_name = segment.options[segment.selectedIndex].innerHTML;
			addtoSegment(_segid, segment_name, segementContent);
		}
		expDetailsObj[_segid] = segementContent;
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
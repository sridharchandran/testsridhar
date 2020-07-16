<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>

<%@page import="java.sql.Connection"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
   

<%-- <%!

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
<%
String block_url=(String)session.getAttribute("block_url");  
String exp_type=(String)session.getAttribute("exp_type"); 
System.out.println("block_url="+block_url);
System.out.println("exp_type="+exp_type);
		 
		 %> --%>
<style>
.mr20{
	margin-right :20px;
}
.ml50{
	margin-left :50px
}
.tac{
	text-align :center;
}
#dateformation{
display:none;
}
</style>
 <script type="text/javascript">

var cfgDetailsObj = {};
var index = 0;

function add(){	
	var pageurl = document.getElementById("url").value;	
	if(pageurl !=""){
		var buttonid = pageurl.replace(/:/g, "");
		buttonid = buttonid.replace(".", "");		
		if (pageurl in cfgDetailsObj) {
			swal.fire("Page "+url+" already added. Add a different page.");	
		} else {					
			cfgDetailsObj[index] = pageurl;
			index++;
			var stage = document.getElementById("stage");	
			stage.innerHTML += '<button id = '+buttonid+' type="button" class="btn btn-outline-info btn-pill" onclick="remove(\''+buttonid+'\','+index+')">'+pageurl+'<i class="la la-close"></i></button>&nbsp;';
			stage.style.display = "block";		
		}
	}else{
		swal.fire("Page URL should not be empty.Please add valid page url");	
	}
}
function remove(element, index){		
	var displayElement = document.getElementById(element);	
	delete cfgDetailsObj[index];	
	displayElement.style.display = "none";		
}
function saveConfig(){
	console.log(cfgDetailsObj)
	var exp_type = localStorage.getItem("exp_type");
	//alert("exp_type"+exp_type)
	var passStatus = true
	var startDate = document.getElementById("kt_datepicker_1").value
	var endDate = document.getElementById("kt_datepicker_2").value
	var timeZoneList = document.getElementById("Timezonelist").value
	console.log("Startdate ::"+startDate+"and endddate::"+endDate);
	if($("#scheduleChkBox").prop("checked") == true){
		document.getElementById("config-form").status.value="scheduled";	
		if(startDate =="" && endDate==""){
			passStatus = false
			swal.fire("Please provide either startdate or enddate for scheduling")
		}else{
			if(startDate !=""){
				document.getElementById("config-form").startdate.value = startDate+":00";
			}
			if(endDate !=""){
				document.getElementById("config-form").enddate.value = endDate+":00";
			}
			if(timeZoneList !=""){
				document.getElementById("config-form").timezoneval.value = timeZoneList;
			}
			
		}
	} 
	if(passStatus){
		//console.log("TimeZone value is ::"+document.getElementById("Timezonelist").value)
		//console.log("inside passtatus check ::"+jQuery.isEmptyObject(cfgDetailsObj))
		
		if(exp_type == "block")
		{
			console.log("startdate value is ::"+document.getElementById("kt_datepicker_1").value)
			console.log("startdate value is ::"+document.getElementById("kt_datepicker_2").value)
			console.log("cfgDetailsObj Value is ::"+JSON.stringify(cfgDetailsObj));
			document.getElementById("config-form").urlList.value=JSON.stringify(cfgDetailsObj);	
			document.getElementById("config-form").method = "post";
			document.getElementById("config-form").action = "configsave";
			document.getElementById("config-form").submit();
		}
		else{
			
		if(jQuery.isEmptyObject(cfgDetailsObj)){
			passStatus = false
			swal.fire("Page Url should not be empty");
		}else{
			
			console.log("startdate value is ::"+document.getElementById("kt_datepicker_1").value)
			console.log("startdate value is ::"+document.getElementById("kt_datepicker_2").value)
			console.log("cfgDetailsObj Value is ::"+JSON.stringify(cfgDetailsObj));
			document.getElementById("config-form").urlList.value=JSON.stringify(cfgDetailsObj);	
			document.getElementById("config-form").method = "post";
			document.getElementById("config-form").action = "configsave";
			document.getElementById("config-form").submit();
		}
		}
	}
		
	}
function preview() {
	swal.fire("Under Development");
}
function toggleCheckbox(){
	if($("#scheduleChkBox").prop("checked") == true){
      	$("#dateformation").show();
    }else{
    	$("#dateformation").hide();
    }
} 
 
 document.addEventListener("DOMContentLoaded", () => {
	var exp_type = localStorage.getItem("exp_type");
	if(exp_type == "block")
	{
		
	}
	else
	{
	document.getElementById("show_block").style.display = "block";
	}
  }); 
  

</script>

<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
- <%
	String message = (String) session.getAttribute("message");		
	int org_id = (Integer)session.getAttribute("org_id");
	String name = "";
	String experience = "";
	String organization = "";
	String types ="";
	 
	
	if (message != null && !message.equals("")) {
		String icon = "fa fa-cocktail"; 
		boolean displayCode = false;
		
		if (message.startsWith("Error"))
			icon = "flaticon-warning";		
						
		if (message.contains("#")) {			
			String codeConstructor = message.substring(message.indexOf("#")+1);			
			message = message.substring(0,message.indexOf("#"));			
			String[] decoder = codeConstructor.split("#");
			name = decoder[0].substring(decoder[0].indexOf("=")+1);			
			experience = decoder[1].substring(decoder[0].indexOf("=")+1);			
			organization = decoder[2].substring(decoder[0].indexOf("=")+1);
		 	types = decoder[3].substring(decoder[0].indexOf("=")+1);
			System.out.println("types="+types); 
			
		}
		
		/*  String block_url=(String)session.getAttribute("block_url");  
		 System.out.println("block_url="+block_url); */
		 
		if (message.startsWith("Page"))
			displayCode = true;
		%>
	
		
		  
		
		<div class="row">
		    <div class="col">
		        <div class="alert alert-light alert-elevate fade show" role="alert">
		            <div class="alert-icon"><i class="fa fa-cocktail kt-font-brand"></i></div>		            		           
		            <div class="alert-text">
		               <%=message%>
		               <%
		                if (displayCode) {
		                	%>
		                	<!-- Button trigger modal -->		                	
		                	You can now embed the following code in the pages:
		                	<br><br>
							<button type="button" class="btn btn-outline-brand" data-toggle="modal" data-target="#exampleModalCenter">
								View Code
							</button>
		                	<%		                		
		                }
		                %>	 	            			            
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
							<h5 class="modal-title" id="exampleModalCenterTitle">
							Embed below code in the body section of your page where <span class="badge badge-secondary"><%=name%></span> experience should appear
							</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">														 							 							
							<code>&lt;div id="webpersonify-<%=experience%>"&gt;&lt;/div&gt;</code>
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
				<h3 class="kt-portlet__head-title">Enable Experience</h3>
			</div>
		</div>
				
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form"> 
			<div class="kt-portlet__body">
				<div id="show_block" style="display:none;">											 																
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Page Address</label>
						<div class="col-lg-4 col-md-9 col-sm-12">															
							<input name="url" id="url" type="text" class="form-control" aria-describedby="url" placeholder="URL">	
							<span class="form-text text-muted">Enter the URL of the page that will display this experience</span>					
						</div>
				</div>
		
				  
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
						<button type="reset" class="btn btn-accent" onclick="javascript:preview()">Preview</button>																									
						<button type="button" class="btn btn-accent" onclick="javascript:add()">Add</button>
					</div>
				</div>
				</div>
					<%-- Scheduling Experience --%>	
				<div class="form-group row">
						<div class="col-lg-6 col-md-9 col-sm-12 tac ml50">	
							<label class="kt-checkbox mr20">
								<input type="checkbox" id="scheduleChkBox" name="scheduleCheckbox" value="showenable" onchange="toggleCheckbox()">Schedule<span></span>
							 </label>																					
						</div>
				</div>
			<div id="dateformation">
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
							<%-- <c:forEach items="<%=getTimeZone()%>" var="timezoneVal">
								<option value='${fn:split(timezoneVal,"@")[0]}'>${fn:split(timezoneVal,"@")[1]}</option>
							</c:forEach> --%>
							
							<c:forEach items="${zonelist}" var="zonevalue">
							<option value='${zonevalue.zone_id}'>(${zonevalue.utcoffset}) ${zonevalue.displayname} (${zonevalue.zone_id})</option>
							</c:forEach>
						</select>     
					</div>
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
		<form class="kt-form kt-form--label-right" id="config-form">
			<div class="kt-portlet__body">															
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>					
						<div class="col-lg-4 col-md-9 col-sm-12">
							<div id="hidden-form" style="display: none;">																	
								<input type="hidden" name="pageName" value="experience-create-enable.jsp">								
								 <input type="hidden" name="experience_id" value="<%=experience%>">
								<input type="hidden" name="experience_name" value="<%=name%>">	
								<input type="hidden" name="experience_type" value="<%=types%>">
								<input type="hidden" name="exp_id" value="${exp_id}"> 
								
						<%-- 		<input type="hidden" name="experience_url" value="<%=url%>"> --%>								
								<input type="hidden" name="urlList">
								<input type="hidden" name="startdate">
								<input type="hidden" name="enddate">
								<input type="hidden" name="status">	
								<input type="hidden" name="timezoneval">																																																																																																	
							</div>											
							<button type="reset" class="btn btn-primary" onclick="saveConfig();">Save</button>
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
<%@page import="java.sql.Connection"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.onwardpath.wem.util.Database"%>
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
var expDetailsObj 	= 	{};
var cfgDetailsObj 	= 	{};
var schDetailsObj 	= 	{};

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
</script>
 
<!-- <script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script> -->
<script src="js/experience-edit.js" type="text/javascript"></script> 
<c:set var="all_segements" value="<%=segmentRepository.getOrgSegments(org_id) %>" />
<c:set var="experience_contents" value="<%=expHelper.experienceImage(id) %>" />
<c:set var="scheduleValue" value="<%=expHelper.scheduleDate(id) %>" />
<c:set var="experience_name" value="<%=expHelper.getexperienceName(id) %>" />
 
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Edit Image Experience </h3>
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
					            <input type="hidden" id="form-startdate" name="startdate">
								<input type="hidden" id="form-enddate" name="enddate">
								
								<input type="hidden" id="form-timezoneval" name="timezoneval">
					
					<input type="hidden"	name="pageName"  value="edit-image-experience"  />
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
							  								
                         <script> expDetailsObj[escape('${content.id}')]= '${fn:replace(content.content, newLineChar, " ")}' ; </script>
                        </c:if>
                        </c:forEach> 
                     </ul>
                     <br/>
                     <a href="" class="btn btn-success btn-pill" data-toggle="modal" data-target="#segment_modal" onclick="setupModal('add','')">Add</a>
                     
                     <div class="modal fade show" id="segment_modal" role="dialog" aria-labelledby="" style="display:none;padding-right: 16px;top:20%" aria-modal="true">
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
                                 <div class="form-group row kt-margin-t-20" >
                                    <label class="col-form-label col-lg-3 col-sm-12">Enter Image URL</label>
                                    <div class="col-lg-9 col-md-9 col-sm-12" >
                                       <input id="content" type="text"
							class="form-control col-lg-9 col-sm-12"
							aria-describedby="emailHelp" placeholder="URL" data-width="100">
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
         
         
         <%-- <div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Scheduling</label>
				<div class="col-sm-6 padding-top-12">
					<div class="kt-section">
						<div class="kt-section__content kt-section__content--border">
							<ul class="list-group" id="addonContent">
							
							<li class="list-group-item" id="segmentlist-${content.id}">
								<div class="row d-flex align-items-center">
								<div class="col-sm-9"><span id="segment-${content.id}-namespan" data-toggle="tooltip"  title='${content.content}'> ${content.segmentName} </span></div>
								<div class="col-sm-1.5">
								    <button type="button" class="btn btn-outline-info btn-pill" data-toggle="modal" data-target="#schdeulding" onclick="setupModal('edit','${content.id}')">
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
							  								
                         <script> expDetailsObj[escape('${content.id}')]= '${fn:replace(content.content, newLineChar, " ")}' ; </script>

                     </ul>
                     <br/>
                     <a href="" class="btn btn-success btn-pill" data-toggle="modal" data-target="#schdeulding" onclick="setupModal('add','')">Add</a>
                     
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
                                       <select id="segment" class="form-control kt-select2 select2-hidden-accessible" name="segment-dropdown" style="width: 75%">
                                          <c:forEach items="${all_segements}" var="segment" >
							                      <option value="${segment.key}">${segment.value} </option>
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
						<input type="text" class="form-control "value="" placeholder="Select date" id="kt_datepicker_1">
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
                                 <button type="button" class="btn btn-secondary" onclick="addContent()">Submit</button>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div> --%>
          
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
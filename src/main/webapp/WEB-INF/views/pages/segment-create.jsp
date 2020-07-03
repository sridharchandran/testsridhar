<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="/wem/assets/js/custom/unified_segment.js" type="text/javascript"></script> 
</head>
<body>

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
	
           
           <div class="row">			
	<div class="col-xl-8">
	<div class="kt-portlet">
	 <div class="kt-portlet__head">
                <div class="kt-portlet__head-label">
                    <h3 class="\&quot;kt-portlet__head-title\&quot;">Create Segment</h3>
                </div>
            </div>
		<!--begin::Portlet-->
		<div class="kt-portlet__body">
                <ul class="nav nav-pills nav-tabs-btn nav-pills-btn-info" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#kt_tabs_10_1" role="tab">
                            <span class="nav-link-icon"><i class="fa fa-map-marker-alt"></i></span>
                            <span class="nav-link-title">Geo</span>
                        </a>
                    </li> 
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#kt_tabs_10_2" role="tab">
                            <span class="nav-link-icon"><i class="fa fa-user-clock"></i></span>
                            <span class="nav-link-title">Behavior</span>
                        </a>
                    </li>                   
                    <li class="nav-item">
                       <a class="nav-link" data-toggle="tab" href="#kt_tabs_10_3" role="tab">
                            <span class="nav-link-icon"><i class="fas fa-chalkboard-teacher"></i></span>
                            <span class="nav-link-title">Technology</span>
                        </a>
                    </li>
                     <li class="nav-item">
                       <a class="nav-link" data-toggle="tab" href="#kt_tabs_10_4" role="tab">
                            <span class="nav-link-icon"><i class="fa fa-star"></i></span>
                            <span class="nav-link-title">Interest</span>
                        </a>
                    </li>
                     <li class="nav-item">
                       <a class="nav-link" data-toggle="tab" href="#kt_tabs_10_5" role="tab">
                            <span class="nav-link-icon"><i class="flaticon2-line-chart"></i></span>
                            <span class="nav-link-title">Source</span>
                        </a>
                    </li>
                </ul>                                

                <div class="tab-content">
                    <div class="tab-pane fade active show" id="kt_tabs_10_1" role="tabpanel">
                      <div class="kt-portlet__body">
			<div class="kt-portlet__content">
				Create segments based on location of the visitor. For example, you
				can create a segment called <span class="badge badge-warning">West
					Coast</span> with criteria <span class="badge badge-secondary">Include
					- State - California</span>, <span class="badge badge-secondary">Include
					- State - Oregon</span> & <span class="badge badge-secondary">Include
					- State - Washington</span>
			</div>
		</div>
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form">
			<div class="kt-portlet__body">

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Criteria</label>
					<div class="btn-group" style="padding-right: 10px;padding-left: 10px;">
						<select id="georule"
							class="form-control form-control--fixed kt_selectpicker"
							data-width="100">
							<option value="include">Include</option>
							<option value="exclude">Exclude</option>
						</select> <select id="geotype"
							class="form-control form-control--fixed kt_selectpicker"
							data-width="120" onchange="selectedValue(this)">
							<option value="city">City</option>
							<option value="state">State</option>
							<option value="country">Country</option>
						</select>
					</div>
				</div>

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Area</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<input id="geoloc" type="text" 
							class="form-control btn-group"
							aria-describedby="emailHelp" placeholder="Name"
							list="suggest_list" onkeyup="javascript:suggestArea(this)">
						<datalist id="suggest_list"></datalist>
						<!-- div class="ui-widget">
							<label for="us_city">Area:</label> <input id="geoloc" type="text" class="form-control col-lg-9 col-sm-12" placeholder="Enter Your Location">
						</div -->
					</div>
				</div>

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<button id="geobutton" type="reset" class="btn btn-accent"
							onclick="javascript:geoadd()">Add</button>
					</div>
				</div>


			</div>
		</form>                        
                    </div>
                    <div class="tab-pane fade" id="kt_tabs_10_2" role="tabpanel">
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
					<div class="btn-group" style="padding-right: 10px;padding-left: 10px;">
			
					<div id="tohide" style="display:none;">
						<select id="behrule" class="form-control form-control--fixed kt_selectpicker" data-width="150">
							<option value="include" selected>Include</option>  
							<option value="exclude">Exclude</option>												
						</select>
						</div>
						<%-- include onchange event for type and criteria -Sre--%>																		
						<select id="behtype" class="form-control form-control--fixed kt_selectpicker" data-width="150" onchange="selectedValue(this)">
							<option value="visit">Visits</option>
							<option value="session">Session Duration</option>														
						</select>															
						<select id="behcriteria" class="form-control kt_selectpicker" data-width="120" onchange="selectedValue(this)">
							<option value="equals" id="criteria_equals" >Equals</option>
							<option value="more" id="criteria_more" >More than</option>
							<option value="less" id="criteria_less">Less than</option>							
						</select>																															
					</div>
				</div>
											
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Number/Duration in Seconds</label>
					<div class="btn-group" style="padding-right: 10px;padding-left: 10px;">														
						<input id="behrulevalue" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="0 to 10">						
					</div>
				</div>
				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
						<button type="reset" class="btn btn-accent" onclick="javascript:behadd()">Add</button>
					</div>
				</div>
		
																	
			</div>
		</form>
		<!--end::Form-->
                    </div>
                    <div class="tab-pane fade" id="kt_tabs_10_3" role="tabpanel">
                        <div class="kt-portlet__body">
			<div class="kt-portlet__content">
				Create segments based on technology of the visitor. For example, you
				can create a segment called <span class="badge badge-warning">Mobile
					Technology</span> with criteria <span class="badge badge-secondary">Include
					- Device - Mobile</span>
			</div>
		</div>
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form">
			<div class="kt-portlet__body">

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Criteria</label>
					<div class="btn-group"style="padding-right: 10px;padding-left: 10px;">
						<select id="technologyrule"
							class="form-control form-control--fixed kt_selectpicker"
							data-width="100" onchange="selectedCriteria(this)">
							<option value="include" selected>Include</option>
							<option value="exclude">Exclude</option>
						</select>
						 <select id="technologylist"
							class="form-control form-control--fixed kt_selectpicker"
							data-width="120" onchange="selectedValue(this)">
							<option value="devices">Devices</option>
							<option value="os">OS</option>
							<option value="browser">Browser</option>
						</select>
					</div>
				</div>

				<div class="form-group row" id="formtechoptiondynamic">
					<label class=" ttc col-form-label col-lg-3 col-sm-12">Devices</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<select 
							id="dynamicselection"
							class=" form-control btn-group"
							data-width="100">
							<option class="ttc" value="Desktop">Desktop</option>
							<option class="ttc" value="Mobile">Mobile</option>
							<option class="ttc "value="Tablet">Tablet</option>
						</select>
					</div>	
				</div>

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<button type="reset" class="btn btn-accent"
							onclick="javascript:techadd()">Add</button>
					</div>
				</div>

				
			</div>
		</form>
		<!--end::Form-->
                    </div>
                    <div class="tab-pane fade" id="kt_tabs_10_4" role="tabpanel">
                        <div class="kt-portlet__body">
			<div class="kt-portlet__content">
				Create segments based on visitors interest. For example, you can create a <span class="badge badge-warning">Packer Fan</span> segment with Criteria
				<span class="badge badge-secondary">Visits</span>
				<span class="badge badge-secondary">More than</span>
				<span class="badge badge-secondary">0</span> 
				on Page
				<span class="badge badge-secondary">mywebsite.com/packers-story</span>				
			</div>
		</div>					
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form"> 
			<div class="kt-portlet__body">
																			 				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Criteria</label>
					<div class="btn-group"style="padding-right: 10px;padding-left: 10px;">		
						<select id="intrule" class="form-control form-control--fixed kt_selectpicker" data-width="150">
							<option value="include">Include</option>
							<option value="exclude">Exclude</option>														
						</select>																		
						<select id="inttype" class="form-control form-control--fixed kt_selectpicker" data-width="150">
							<option value="visit">Visits</option>
							<option value="session">Session Duration</option>														
						</select>																	
																																				
					</div>
				</div>
						
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
							<select id="intcriteria" class="form-control form-control--fixed kt_selectpicker" data-width="150">
							<option value="equals">Equals</option>
							<option value="more">More than</option>
							<option value="less">Less than</option>							
						</select>						
					</div>
				</div>
															
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Number/Duration in Seconds</label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
						<input id="intrulevalue" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="0 to 10">						
					</div>
				</div>
				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">On Page</label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
						<input id="intpageurl" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="Page URL">						
					</div>
				</div>
				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
						<button type="reset" class="btn btn-accent" onclick="javascript:intadd()">Add</button>
					</div>
				</div>
				
	
																	
			</div>
		</form>
		<!--end::Form-->
                    </div>
                    <div class="tab-pane fade" id="kt_tabs_10_5" role="tabpanel">
                        <div class="kt-portlet__body">
			<div class="kt-portlet__content">
				Create segments based on visitors source (referrer). For example, you can create a <span class="badge badge-warning">Google Ads</span> segment for visitors coming from your Google Ads with Criteria
				<span class="badge badge-secondary">Source URL</span>
				<span class="badge badge-secondary">Contains</span>
				<span class="badge badge-secondary">utm_source=google</span>				
			</div>
		</div>					
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form"> 
			<div class="kt-portlet__body">
																			 				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Criteria</label>
					<div class="btn-group"style="padding-right: 10px;padding-left: 10px;">
					
						<select id="sourcerule" class="form-control form-control--fixed kt_selectpicker" data-width="150">
							<option value="source">Source URL</option>																				
						</select>
						
						<select id="sourcecriteria" class="form-control form-control--fixed kt_selectpicker" data-width="120">
		 					<option value="match">Matches</option>
							<option value="contain">Contains</option>
							<option value="notmatch">Is Not</option>							
							<option value="notcontain">Does not Contain</option>							
						</select>								
													
						<!-- select id="rule" class="form-control form-control--fixed kt_selectpicker" data-width="150">
							<option value="include">Include</option>
							<option value="exclude">Exclude</option>														
						</select>																																	
						<select id="type" class="form-control form-control--fixed kt_selectpicker" data-width="150">
							<option value="visit">Visits</option>
							<option value="session">Session Duration</option>														
						</select -->																	
																													
					</div>
				</div>
																	
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Pattern</label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
						<input id="sourcepattern" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="String">						
					</div>
				</div>
											
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
						<button type="reset" class="btn btn-accent" onclick="javascript:sourceadd()">Add</button>
					</div>
				</div>

																	
			</div>
		</form>
		<!--end::Form-->
                    </div>
                </div>      
            </div>
		<!--end::Portlet-->
	</div>
	</div>
	<div class="col-xl-4">
		<!--begin::Portlet-->
		<div class="kt-portlet"> 
		<form class="kt-form kt-form--label-right" id="segment-form">
			<div class="kt-portlet__body">

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Segment
						Name</label>
					<div class="col 10">
						<input name="segmentName" id="segmentName" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="Name"> <span class="form-text text-muted">Give a name for this segment</span>
					</div>
				</div>

				<div class="kt-form__actions">
					<label class="col-form-label col-lg-3 col-sm-12"></label>
					
						<div id="hidden-form" style="display: none;">
							<input type="hidden" name="pageName" value="segment-create.jsp">
							<!-- <input type="hidden" id = "segmentName" name="segmentName"> --> 
							<input type="hidden" id="segmentRules" name="segmentRules">
							<select id="dynamic-select" size="2"></select>
						</div>
						<button type="reset" class="btn btn-primary" onclick="saveSegment();">Save</button>
						<button type="reset" class="btn btn-secondary">Cancel</button>
					

				</div>
			</div>    
			</form> 
			
			 <div class="modal" id="modalurls" role="document">
						    <div class="modal-dialog ">
						      <div class="modal-content">
						      
						        <!-- Modal Header -->
						        <div  class="modal-header">
						          <h4 id="experience-elements" class="modal-title">Modal Heading</h4>
						          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">�</span>
								  </button>
						        </div>
						        
						        <!-- Modal body -->
						        <div id="popurl-elements" class="modal-body">
						          Modal body..
						        </div> 
						        
						        <!-- Modal footer -->
						        <div class="modal-footer">
						          <button type="button" class="btn btn-outline-brand" data-dismiss="modal">Close</button>
						        </div>
						        
						      </div>
						    </div>
						  </div>
			
			<div class="kt-portlet__body">
				<div id="geobucket" style="display: none;">
					<div class="kt-section__content kt-section__content--border">
					</div>
				</div>
				<div id="behaviourbucket" style="display: none; margin-top:10px">																					
					<div class="kt-section__content kt-section__content--border">																																						
					</div>																																							
				</div>
				<div id="technologybucket" style="display: none; margin-top:10px">
					<div class="kt-section__content kt-section__content--border">
				</div>
				</div>
				<div id="interestbucket" style="display: none; margin-top:10px">																					
					<div class="kt-section__content kt-section__content--border">																																						
					</div>																																							
				</div>
				<div id="referrerbucket" style="display: none; margin-top:10px">																					
					<div class="kt-section__content kt-section__content--border">																																						
				</div>
				</div>
				
			</div>
			
		<!--end::Portlet-->
	</div>
	</div>
</div>
        </div>
		<!--end::Portlet-->
	
	<!--end::Content-->
                
            
</body>
</html>
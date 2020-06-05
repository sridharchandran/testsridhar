
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map, com.onwardpath.wem.repository.*,com.onwardpath.wem.model.*" %>
<!-- begin:: Content -->

<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
		<%
			//TODO: Resolve DataTable issue -- https://datatables.net/forums/discussion/32575/uncaught-typeerror-cannot-set-property-dt-cellindex-of-undefined
			SegmentRepository segmentRepository = new SegmentRepository();
			UserRepository userRepository = new UserRepository();
			int org_id = (Integer)session.getAttribute("org_id");
			//Map<Integer,Segment> orgSegments = segmentRepository.loadOrgSegments(org_id);
			Map<Integer,Segment> orgSegments = segmentRepository.loadOrgSegmentsByType(org_id,"ref");
			
			if (orgSegments.size() == 0) {
				%>
				<div class="alert alert-light alert-elevate" role="alert">
					<div class="alert-icon"><i class="flaticon-warning kt-font-brand"></i></div>
						<div class="alert-text">
						No Segments Available for your Organization. Create a new segment <a class="kt-link kt-font-bold" href="?view=pages/segment-create-geo.jsp">here</a>.
					</div>
				</div>
				<%
					
			} else {
				%>
				<div class="kt-portlet kt-portlet--mobile">
						<div class="kt-portlet__head">
							<div class="kt-portlet__head-label">
								<h3 class="kt-portlet__head-title">
									Your Source Segments
								</h3>
							</div>
						</div>
						
						<div class="kt-portlet__body">			
							<!--begin: Datatable-->
							<table class="table table-striped- table-bordered table-hover table-checkable" id="kt_table_1">
								<thead>
									<tr>
										<th>Name</th>
										<th>Source</th>
										<th>Created By</th>
										<th>Created On</th>																
										<th>Actions</th>
									</tr>
								</thead>								
								<%
								for ( Map.Entry<Integer, Segment> entry : orgSegments.entrySet()) {
									Integer key = entry.getKey();
									Segment segment = entry.getValue();
									User user = userRepository.getUser(segment.getUser_id());
								    %>
				    			<tbody>
									<tr>
										<td><%=segment.getName()%></td>
										<td>
										<%	
										//TODO: Update to include new format 										
										//loc{include:city:San Jose-CA-USA|include:city:Santa Clara-CA-USA|include:city:Fremont-CA-USA}
										//beh{include:visit:equals:10|include:session:equals:60}
										//int{include:visit:equals:1:onwardpath.com/packers-info}
										//ref{source:match:google.com}
										
										//<option value="match">Matches</option>
										//<option value="contain">Contains</option>
										//<option value="notmatch">Is Not</option>							
										//<option value="notcontain">Does not Contain</option>
										
										String segmentRules = segment.getGeography(); 
										//Remove "ref{" and "}"
										if (segmentRules.indexOf("}") !=0) {
											int beginIndex = segmentRules.indexOf("{")+1;
											int endIndex = segmentRules.indexOf("}");											
											segmentRules = segmentRules.substring(beginIndex, endIndex);
										}
										String [] rule = segmentRules.split("\\|"); 
										for(String a:rule) {
											String[] criteria = a.split(":");
											String display = "";
											if (criteria[1].startsWith("match") || criteria[1].startsWith("contain")) {												
												display = "<button id='"+segment.getId()+"' type='button' class='btn btn-outline-info btn-pill'><i class='fa fa-hand-point-right'></i>"+criteria[2]+"&nbsp;</button>";	
											} else {
												display = "<button id='"+segment.getId()+"' type='button' class='btn btn-outline-danger btn-pill'><i class='fa fa-hand-point-right'></i>"+criteria[2]+"&nbsp;</button>";
											}																				
											%>											
											<%=display%>
										<%}%>
										<!-- 
										include:City:Test2|include:City:Test3										
										 -->										
										</td>
										<td><%=user.getFirstname()%>&nbsp;<%=user.getLastname()%></td>
										<td>1/2/2019</td>										
										<td nowrap>																				
										<form id="form-<%=key%>">
					                    <input type="hidden" name="seg_id" value="<%=segment.getId()%>"/>
					                    <input type="hidden" name="seg_name" value="<%=segment.getName()%>"/>
					                    <input type="hidden" name="result_page" value="pages/segment-view-source.jsp"/>																				
										<button type='button' class="btn btn-outline-secondary btn-icon"><i class="fa fa-tools"></i></button>&nbsp;
										<button type='button' class="btn btn-outline-brand" data-toggle="modal" data-target="#exampleModalCenter" onclick="getsegmentname(<%=segment.getId()%>)"><i class="fa fa-trash-alt"></i></button>
										  
										<!-- Modal -->
						<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display: none;">
							<div class="modal-dialog modal-dialog-centered" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalCenterTitle">Are you sure to delete Segment</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">×</span>
										</button>
									</div>
									<div class="modal-body">
										<p id="segmentTitle"><b><%=segment.getName()%></b></p> 
									</div>
									 
									<div class="modal-footer">
										<button type="button" class="btn btn-outline-brand"  id="segmentId"  value="<%=segment.getId()%>" onclick="deletesegment(<%=segment.getId()%>)">Yes</button>
										<button type="button" class="btn btn-outline-brand" data-dismiss="modal">No</button>     
									</div>     
									     
								</div>
							</div>
						</div>
					 
										</form>																																															
										</td>
									</tr>
								</tbody>
								<%
								}
								%>																				
							</table>
							<!--end: Datatable -->
						</div>
					</div>
				    <%				    				   					
			}			
		%>
	
</div>
<!-- end:: Content -->	
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map, com.onwardpath.wem.model.Experience, com.onwardpath.wem.repository.ExperienceRepository" %>

<script src="https://cdn.ckeditor.com/ckeditor5/12.3.0/classic/ckeditor.js"></script>
<script type="text/javascript">
function preview() {		
	//var pageUrl  = document.getElementById("pageurl").value;
	//var serviceUrl = "AjaxController?service=renderUrl&pageUrl="+pageUrl;
	//var x = new XMLHttpRequest();
	//x.responseType = 'json';
	//x.responseType = "document";
	//x.responseType = "text";
		
	//x.onreadystatechange = function(){
	//	if(this.readyState == 4 && this.status == 200){
	//		showPreview(this.response);			
	//		//showPreview(this.responseXML);			
	//	}
	//};	
	//x.open("GET", serviceUrl); 
	//x.setRequestHeader('Content-type', 'text/html');
	//x.send(); 
									
	document.getElementById("preview-form").method = "post";
	document.getElementById("preview-form").action = "AjaxController";
	document.getElementById("preview-form").submit();	
} 

function showPreview(html) {
	//console.log(html);
	
	//var stage = document.getElementById("previewdiv");	
	//document.getElementById("editor").value = html;	
	ClassicEditor
		.create( document.querySelector( '#editor' ) )
       	.catch( error => {
            console.error( error );
        } );		
	stage.style.display = "block";
	
	//var stage = document.getElementById("previewdiv");
	//stage.innerHTML+=html;
	//stage.appendChild(newNode.documentElement);		
	//console.log(nodeToString(html)); -- this might be usefull
	//console.log(html.documentElement);	
	//var stage = document.getElementById("previewdiv");
	//stage.innerHTML=html.documentElement.innerHTML;
	//stage.style.display = "block";		
	//var htmlAllCollection = html.all
	//console.log(htmlAllCollection);		
	//console.log(html.body.innerHTML);	
	//var stage = document.getElementById("previewdiv");
	//stage.innerHTML=html.body.innerHTML;
	//stage.style.display = "block";			
	//stage.innerHTML='<object type="text/html" data="'+html+'" ></object>';
	//stage.innerHTML=html.title;
	//stage.innerHTML+=html.outerHTML;
	//stage.innerHTML=html[0].prop('outerHTML');
	//stage.innerHTML += html;		
	//var template = '<h1>Hello world!</h1>';
	//render(template, document.querySelector('#main'));		
	//render(html, document.querySelector('#previewdiv'));	
}

function nodeToString(n) {
    var ret = '{\n';
 
    for (var i in n) {
        ret += '\t' + i + ' -> ' + n[i] + '\n';
    }
 
    return ret + '}';
}
</script>

<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
	<%	
	String message = (String) session.getAttribute("message");
	String icon = "fa fa-cocktail";	
	
	if (message != null && !message.equals("")) {
		%>
		<!-- begin::alert -->
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
		<!-- end::alert -->
		<!-- begin::modal -->		
		<div class="kt-section__content kt-section__content--border">			
			<!-- Modal -->
			<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display: none;">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">						
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalCenterTitle"><!-- Heading Goes Here --></h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">														 
							 <!-- modal body text goes here -->
						</div>
						<div class="modal-footer">
							<!-- modal buttons go here -->														
						</div>
					</div>
				</div>
			</div>
		</div>	
		<!-- end::modal -->	
		<%		
	}	
	session.setAttribute("message", "");															
	%>			
	<!--begin::Portlet-->
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Serve Experience on Page</h3>
			</div>
		</div>
				
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="preview-form"> 
			<div class="kt-portlet__body">
																			 																	
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Page Address</label>
					<div class="col-lg-4 col-md-9 col-sm-12">	
						<input id="service" name="service" type="hidden">														
						<input id="pageUrl" name="pageUrl" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="URL">						
					</div>
				</div>
				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
						<button type="reset" class="btn btn-accent" onclick="javascript:preview()">Preview</button>
					</div>
				</div>
											
				<div class="kt-separator kt-separator--border-dashed"></div>
				<div class="kt-separator kt-separator--height-sm"></div>
				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
						<div id="previewdiv" style="width: 100%; display: none;">							 
							<textarea name="content" id="editor"></textarea>																	
						</div>
					</div>
				</div>
				
																																						
			</div>
		</form>
		<!--end::Form-->
							
	</div>
	<!--begin::Portlet-->
</div>
<!--end::Content-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<style>
#cardlistdata {
	width: 100%;
}

.cardbox {
	width: 22%;
	float: left;
	margin-right: 3%;
	height:200px;
}
</style>

<div class="kt-content  kt-grid__item kt-grid__item--fluid"
	id="kt_content">
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">

				<h3 class="kt-portlet__head-title">Create TestCase</h3>
			</div>
		</div>
		<form class="kt-form kt-form--label-right" id="experience-form">
			<div class="kt-portlet__body">
				<!-- <div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Enable Access:</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<span class="kt-switch kt-switch--sm kt-switch--success">
							<label>
								<input type="checkbox" name="quick_panel_notifications_5">
								<span></span>
							</label>
						</span>
					</div>
				</div> -->
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">IP Address
						:</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<div class="kt-widget-18__desc" id="dynamicipaddr"
							style="padding-top: 10px;"></div>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Experience
						Type :</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<select id="expType" class="custom-select form-control"
							data-width="300" onchange="javascript:listAssocexp()">
							<option value="content">Content</option>
							<option value="image">Image</option>
							<option value="bar">Bar</option>
							<option value="redirect">Redirect</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Experience
						Name :</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<select id="experiencelist" class="custom-select form-control"
							data-width="300" onchange="javascript:listAssocSegment()">
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Segment
						Name :</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<select id="segmentlist" class="custom-select form-control"
							data-width="300"><option>--Select--</option></select>
					</div>
				</div>
				<div id="output"></div>
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<button type="reset" class="btn btn-accent"
							onclick="javascript:add(event)">Add</button>
					</div>
				</div>
				<div id="cardlistdata"></div>
			</div>
		</form>
	</div>
</div>
<script>
var expType = $("#expType").val();

function dynamicTestCaseAjaxCall(casetypeVal,dispType,dataType,expId){
	var getresult = $.ajax({url:"pages/testcase-data.jsp",
    	type:"POST",
    	async: false,
    	//cache:false,
    	//timeout: 30000,
    	data: {casetype:casetypeVal,datatype:dataType,orgid:1,expid:expId},
    	dataType:'json',
    	success:function(data){
   			var dataDetails = dispType =="exp" ? data.explist[0] : data.seglist[0]
   			if(dataDetails !=null){
       			var OptionDatalength = data.totallength;
       			var optionValues = dataDetails.name;
       			console.log("optionValues :::::"+optionValues);
       			var selectIdName = dispType =="exp" ? "experiencelist" : "segmentlist";
                $("#"+selectIdName).empty();
                $("#"+selectIdName).append("<option value=default'>--Select--</option>")
                for( var i = 0; i< OptionDatalength; i++){
                    var name = data.totallength == 1 ? optionValues : optionValues[i];   
                    $("#"+selectIdName).append("<option value='"+name.split("=")[1].replace(/ /g, "-")+"' data-optionid="+name.split("=")[0]+">"+name.split("=")[1]+"</option>");
                }
   			}
		},
		error: function() {
			$("#output").html("Fail Something"); 
		}
    	});
}
function addTestCase(casetypeVal,expId,segId,ipaddress){
	var getresult = $.ajax({url:"pages/testcase-data.jsp",
    	type:"POST",
    	async: false,
    	//cache:false,
    	//timeout: 30000,
    	data: {casetype:casetypeVal,segid:segId,expid:expId,ip:ipaddress},
    	//dataType:'json',
    	success:function(data){
   			console.log("data value is :::"+data);	
		},
		error: function() {
			$("#output").html("Fail Something"); 
		}
    	});
}

function viewCreatedTestcases(casetypeVal,ipVal){
	var getresult = $.ajax({url:"pages/testcase-data.jsp",
    	type:"POST",
    	//async: false,
    	//cache:false,
    	//timeout: 30000,
    	data: {casetype:casetypeVal,ipaddr:ipVal},
    	dataType:'json',
    	success:function(data){
    		var totalCnt = data.totallength; 
    		var cardBoxValues = data.viewtestcases[0].values
   			for (var i=0;i<totalCnt && i<10 ;i++){
   				var viewtestcaseValues = totalCnt ==1 ? cardBoxValues : cardBoxValues[i];
   				formDynamicDivBlock(viewtestcaseValues.split("=")[0],viewtestcaseValues.split("=")[1],viewtestcaseValues.split("=")[3],viewtestcaseValues.split("=")[2]);
   			}
		},
		error: function() {
			$("#output").html("View Created Fail Something"); 
		}
    	});
}

function formDynamicDivBlock(expId,segId,selectedSegName,selectedExpName){
	var addDivBlock = "<div class='card alert alert-secondary cardbox' role='alert' id='"+expId+"_"+segId+"' data-expid='"+expId+"' onclick='removeSelected(this,"+expId+","+segId+")'>";
		addDivBlock += "<a href='javascript:void(0)' class='close removebox' aria-label='close' title='close'>×</a>";
		addDivBlock +="<div class='card-body'><h6 class='card-title'>Exp Name:"+selectedExpName+"</h6><h6 class='card-title'>Seg Name: "+selectedSegName+"</h6>";
		//addDivBlock +="<h6 class='card-title'>URL:<a href='#'>Go somewhere</a></h6>";
		addDivBlock +="</div></div>";
		$("#cardlistdata").append(addDivBlock);	
}

function deleteTestCase(casetypeVal,expId,segId){
	var getresult = $.ajax({url:"pages/testcase-data.jsp",
    	type:"POST",
    	//async: false,
    	//cache:false,
    	//timeout: 30000,
    	data: {casetype:casetypeVal,expid:expId,segid:segId},
    	//dataType:'json',
    	success:function(data){
   			console.log(" Deleted testcases data value is :::"+data);
		},
		error: function() {
			$("#output").html("Fail Something"); 
		}
    	});
	
}
function listAssocSegment(){
	console.log("expid selected ::"+$("#experiencelist option:selected").attr("data-optionid"))
	//List Seg Name
	var selectedExpId = $("#experiencelist option:selected").attr("data-optionid");
	var expType = $("#expType").val();
	dynamicTestCaseAjaxCall("listseg","seg",expType,selectedExpId)
}
 
 function listAssocexp(){
	var expTypes = $("#expType").val();
	console.log("onchange exp type")
	dynamicTestCaseAjaxCall("listexp","exp",expTypes,0) 
} 
 
$(document).ready(function(){
	$.getJSON("https://api.ipify.org?format=json", function(data) {
		$("#dynamicipaddr").html(data.ip);
		var dynamicIpAddr = data.ip
		viewCreatedTestcases("viewtestcases",dynamicIpAddr);
	});
	//List Exp name 
	dynamicTestCaseAjaxCall("listexp","exp",expType,0)
	
});
function removeSelected(elem,expid,segid){
	 if (confirm('Are you sure you want to delete ?')) {
	    	deleteTestCase("delete",expid,segid)
	    	$("div").remove("#"+elem.id);
	    }
}
function avoidDuplicateTestCases(expid,segid){
	var wrapperChildren = $("#cardlistdata").children().length;
	//alert("wapperchildren length::"+wrapperChildren);
	for (var i = 0; i < wrapperChildren; i++) {
			var childId = $($("#cardlistdata").children()[i]).attr("id")
			var childExpId = $($("#cardlistdata").children()[i]).attr("data-expid")
			if(childId == expid+"_"+segid){
				swal.fire("Already same exp and seg added");
				return false;
			}
			if(childExpId == expid){
				swal.fire("Multiple segment with the same experience cannot be added");
				return false;
			}
	}
	return true;
}
function add(){
	var maxElementCnt = $("#cardlistdata").children().length;
	if(maxElementCnt < 10){
		var expId = $("#experiencelist option:selected").attr("data-optionid")
		var segId = $("#segmentlist option:selected").attr("data-optionid")
		if(typeof expId == "undefined" && typeof segId == "undefined"){
			swal.fire("Please fill all the values to adds");
		}else{
		var ipaddr =$("#dynamicipaddr").text()
		var allowToAdd = avoidDuplicateTestCases(expId,segId);
		
			if(allowToAdd){
				console.log("Allow Duplicate Value ix ::"+allowToAdd);
				addTestCase("addtestcase",expId,segId,ipaddr)
				
				var selectedExpName = $("#experiencelist option:selected").text()
				var selectedSegName = $("#segmentlist option:selected").text()
				$("#segmentlist").empty();
				$("#segmentlist").append("<option value=default'>--Select--</option>");
				formDynamicDivBlock(expId,segId,selectedSegName,selectedExpName);
			}
		}
		}else{
			swal.fire("Maximum 10 testcases should be added");
	}
}
</script>
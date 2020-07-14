function saveSegment() {
	
	
	//unified segment
	 
	
		//TODO: Validate Rules and display error for conflicting/invalid rules
		var x = document.getElementById("dynamic-select");
		if(x.length > 0){
		var segmentName = document.getElementById("segmentName").value
		var txt = "";
		var i;
		for (i = 0; i < x.length; i++) {
			if (i == 0) {
				txt = x.options[i].text;
			} else {
				txt = txt + "|" + x.options[i].text;
			}
		}
		
		var r = txt.split("|");
		var text = "";
		var texts = "";
		var text_int = "";
		var text_tech = "";
		var text_source ="";
		var j;
		var unified = new Array();
	
		for (j = 0; j < r.length; j++) {
		if((r[j].includes("state") == true) ||(r[j].includes("city")== true)||(r[j].includes("country")== true))
		{
					if (j == 0) {
						texts = r[j]+"|";
					} else {
						texts = r[j]+"|"+texts  ;
					}
					
				}
		
		
		else if (((r[j].includes("visit") == true) || (r[j].includes("session") == true))&& (r[j].split(":").length == 4)) {

					if (j == 0) {
						text = r[j]+"|";
					} else {
						text = r[j] + "|" + text;
					}

				}

		else if (((r[j].includes("visit") == true) || (r[j].includes("session") == true))&& (r[j].split(":").length >= 5)) {
					if (j == 0) {
						text_int = r[j]+"|";
					} else {
						text_int = r[j] + "|" + text_int;
					}

				}
		else if ((r[j].includes("devices") == true) ||(r[j].includes("os")== true)||(r[j].includes("browser")== true)) {
					if (j == 0) {
						text_tech = r[j]+"|";
					} else {
						text_tech = r[j] + "|" + text_tech;
					}

				}
		else if ((r[j].includes("match") == true) ||(r[j].includes("contain")== true)||(r[j].includes("notmatch")== true) ||(r[j].includes("notcontain")== true)) {
			
			
			if (j == 0) {
				text_source = r[j]+"|";
			} else {
				text_source = r[j] + "|" + text_source;
			}

		}
				//	text;
				
			
			}

		if(texts != "")
		{
		var org_texts = texts.slice(0,texts.lastIndexOf("|"))
		unified.push("loc{" + org_texts + "}");
		}
		if(text != "")
		{
		var org_text = text.slice(0,text.lastIndexOf("|"))
		unified.push("beh{" + org_text + "}");
		}
		if(text_int != "")
		{
		var org_text_int = text_int.slice(0,text_int.lastIndexOf("|"))
		unified.push("int{" + org_text_int + "}");
		}
		if(text_tech != "")
		{
		var org_text_tech = text_tech.slice(0,text_tech.lastIndexOf("|"))
		unified.push("tech{" + org_text_tech + "}");
		}
		if(text_source != "")
		{
		var org_text_source = text_source.slice(0,text_source.lastIndexOf("|"))
		unified.push("ref{" + org_text_source + "}");
		}
		var attrstr = unified.join('+');
		
			document.getElementById("segmentRules").value = attrstr;
			if (segmentName.replace(" ", "").length > 0) {
				document.getElementById("segment-form").method = "post";
				document.getElementById("segment-form").action = "Segment_Save";
				document.getElementById("segment-form").submit();
			} else {
				swal.fire("Segment Name value should not be empty.")
				document.getElementById("segmentName").focus()
			}
		} else {
			swal.fire("Area value should not be empty. Please Select any")
			document.getElementById("geoloc").focus()
		}
	}

var buttonlabelgeoArr = new Array();
var geoTypeArr = new Array();
var f_location = null;
var locations = null;
var timer;
//Geo_location save segment javscript code
function suggestArea(obj) {
	
	$('#geobutton').attr("disabled", true);
	var geoloc = document.getElementById("geoloc").value;
	var suggest_list = document.getElementById("suggest_list");
	var frag = document.createDocumentFragment();
	var serviceName = document.getElementById("geotype").options[document.getElementById("geotype").selectedIndex].value
	clearTimeout(timer) // clear the request from the previous event
    timer = setTimeout(function() {
	if (geoloc.length >= 3) {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200
					&& this.response != "null" ) {
				
				var response = JSON.parse(this.response);
				suggest_list.innerHTML = "";
				var dataToStore = JSON.stringify(response);
				localStorage.setItem('someData', response);
				localStorage.setItem('jsonstring', dataToStore);
				response.forEach(function(item) {
					var option = document.createElement('option');
					//option.value = item.substring(0,item.indexOf(","));
					//option.textContent = item.substring(item.indexOf(",")+1,item.length).trim();
					option.value = item;
					frag.appendChild(option);
					$('#geobutton').attr("disabled", true);
					
				});
					
				
				suggest_list.appendChild(frag);
				$('#geobutton').attr("disabled", false);
			}
		};
		xhttp.open("GET", "AjaxController?service="+serviceName+"_suggestions&geoloc="
				+ geoloc);
		xhttp.send();
	}
    }, 500)
}


/*
$(document).ready(function() {

    $("input#geoloc").autocomplete({

        width: 300,
        max: 10,
        delay: 100,
        minLength: 1,
        autoFocus: true,
        cacheLength: 1,
        scroll: true,
        highlight: false,
        source: function(request, response) {
            $.ajax({
                url: "AjaxController",
               contentType: "application/json; charset=utf-8", 
				data: { 
            	service: document.getElementById("geotype").options[document.getElementById("geotype").selectedIndex].value+"_suggestions", 
            	geoloc:document.getElementById("geoloc").value
            	
              },
          
            async: true,
                success: function( data, textStatus, jqXHR) {
                    console.log( data);
                    var items = data;
                    response(items);
                },
                error: function(jqXHR, textStatus, errorThrown){
                     console.log( textStatus);
                }
            });
        }
 
    });
    });*/

function geoadd() {
	var georule = document.getElementById("georule").value;
	var geotype = document.getElementById("geotype").value;
	var geoloc = document.getElementById("geoloc").value;
	console.log("georule is :"+georule+" and geotype: "+geotype+" and geoloc:"+geoloc)
	if($.inArray(georule+":"+geotype,geoTypeArr) != -1){
		swal.fire("Only one time the "+georule+"-"+geotype+" value added in geo segment");
	}
	else
		{
	if(geotype == "country")
	{
	var location = geoloc.substring(0,geoloc.indexOf(","));
	geoloc = location;
	f_location = location;
	console.log("loc"+geoloc);
	
	}
	//alert(geoloc);
	if(geoloc.length > 0){
	let geocondition = georule + ":" + geotype + ":" + geoloc;
	let geobuttonlabel = geocondition.replace(/:/g, "");
	geobuttonlabel = geocondition.replace(".", "");
	var select = document.getElementById("dynamic-select");
	var index = select.options.length;
	select.options[index] = new Option(geocondition, geocondition);
	document.getElementById("geoloc").value = ""; //Clear the Text Field
	document.getElementById("suggest_list").innerHTML = ""; //Clear Suggestion list
	var x = document.getElementById("geobucket");
	if((geotype == "city")||(geotype == "state"))
	{
	var locations = geoloc.substring(0,geoloc.indexOf(","));
	locations = locations.replace(/\s+/g, ''); //Remove white space before displaying. Note: We are using the name as-is while saving the locations to segment table.	
	locations = locations.replaceAll(',', ''); //Remove comma before displaying.
	locations = locations.replaceAll('&', '');
	f_location = locations;
	}
	
	if((geotype == "country"))
	{
	f_location = geoloc;
	console.log("loc"+geoloc);
	}
	
	
	geoloc = geoloc.replace(/\s+/g, ''); //Remove white space before displaying. Note: We are using the name as-is while saving the locations to segment table.	
	geoloc = geoloc.replaceAll(',', ''); //Remove comma before displaying.
	//alert(geoloc);
	if(!hasConditionExistsAlready(f_location)){
	if (georule == "include") {
		x.innerHTML += '<button id=	"'+f_location+'" data-typeloc="'+geobuttonlabel+'" data-typeval="'+geotype+'"  type="button" class="btn btn-outline-info btn-pill" onclick="georemove(this)"><i class="fa fa-map-marker-alt"></i>' + geoloc
				+ '<i class="la la-close"></i></button>&nbsp;';
		//alert(x.innerHTML);
	} else {
		x.innerHTML += '<button id="'+f_location+'" data-typeloc="'+geobuttonlabel+'" data-typeval="'+geotype+'"  type="button" class="btn btn-outline-danger btn-pill" onclick="georemove(this)"><i class="fa fa-map-marker-alt"></i>	' + geoloc
				+ '<i class="la la-close"></i></button>&nbsp;';
		//alert(x.innerHTML);
	}
	}
	else
		{
		swal.fire("The Same condition has exist already.Please remove the conditon and add it again")
		}
	x.style.display = "block";
	buttonlabelgeoArr.push(geobuttonlabel);
	geoTypeArr.push(georule+":"+geotype);
	
	}
	else{
		swal.fire("Area value should not be empty.")
	}
	document.getElementById("geoloc").focus();
}
}

 
 function hasConditionExistsAlready(f_location){
		var exist = false
		$("#geobucket button").each(function(){
			var conditionMatch = $(this)[0].id;
			if(conditionMatch == (f_location)){
				exist = true
			}
		});
		return exist
	}

 
function georemove(buttonId) {
	var geobuttonvalue = buttonId.dataset.typeloc;
	localStorage.setItem("geobuttonvalue", geobuttonvalue);
	var georule = buttonId.dataset.typeloc.split(":")[0];
	var geotype = buttonId.dataset.typeloc.split(":")[1];
	var buttonIdName = buttonId.id
	$('#'+buttonId.id).remove();
	var selectobject = document.getElementById("dynamic-select");
	for (var i=0; i<selectobject.length; i++) {
	    if (selectobject.options[i].value == buttonId.dataset.typeloc)
	        selectobject.remove(i);
	}
	geoTypeArr = $.grep(geoTypeArr, function(value) {
			return value != georule+":"+geotype;
	});
	buttonlabelgeoArr = $.grep(buttonlabelgeoArr, function(value) {
		var geobuttonvalues = localStorage.getItem("geobuttonvalue");
			return value != geobuttonvalues;
	});
}

function removeAll() {
	var select = document.getElementById("dynamic-select");
	select.options.length = 0;
	var x = document.getElementById("geobucket");
	x.style.display = "none";
}
//End of geo location segment js code

//Begin of behavior segment js code

function behadd(){	
	var errorMSg =""
	var behrule = document.getElementById("behrule").value;
	var behtype = document.getElementById("behtype").value;
	var behcriteria = document.getElementById("behcriteria").value;
	var behrulevalue = document.getElementById("behrulevalue").value;
	if(!hasbehConditionExistsAlready(behtype,behcriteria)){
	errorMSg = behrulevalue.replace(" ","").length  <=0 ? "Number/Duration in Seconds should not be empty" : ""; 
	if(errorMSg !="" || isNaN(behrulevalue) ){
		errorMSg = errorMSg !="" ? errorMSg : "Please Provide only numeric value in the Number/Duration in Seconds" 
			swal.fire(errorMSg)
		document.getElementById("behrulevalue").focus();
	}else{
	var behavior = behrule+":"+behtype+":"+behcriteria+":"+behrulevalue;	
	var select = document.getElementById("dynamic-select");
	
	var index = select.options.length;
	select.options[index] = new Option(behavior, behavior);		
	document.getElementById("behrule").reset;
	document.getElementById("behtype").reset;
	document.getElementById("behcriteria").reset;
	document.getElementById("behrulevalue").value = ""; //Cleammr the Text Field	
	var x = document.getElementById("behaviourbucket");	
	
		if(behrule == "include") {	
			x.innerHTML += '<button id="'+behtype+behcriteria+behrulevalue+'" data-condition="'+behtype+behcriteria+'" type="button" class="btn btn-outline-info btn-pill" onclick="behremove('+behtype+behcriteria+behrulevalue+','+index+')"><i class="fa fa-user-clock"></i>'+behtype+':'+behcriteria+':'+behrulevalue+'<i class="la la-close"></i></button>&nbsp;';
		} else {		
			x.innerHTML += '<button id="'+behtype+behcriteria+behrulevalue+'" data-condition="'+behtype+behcriteria+'" type="button" class="btn btn-outline-danger btn-pill" onclick="behremove('+behtype+behcriteria+behrulevalue+','+index+')"><i class="fa fa-user-clock"></i>'+behtype+':'+behcriteria+':'+behrulevalue+'<i class="la la-close"></i></button>&nbsp;';
		}
	
	x.style.display = "block";			
	document.getElementById("behrule").focus();
	}
	}else{
		swal.fire("The Same condition has exist already.Please remove the conditon and add it again")
	}
	
}
function hasbehConditionExistsAlready(behtype,behcriteria){
	var exist = false
	$("#behaviourbucket button").each(function(){
		var conditionMatch = $(this).attr("data-condition")
		if(conditionMatch == (behtype+behcriteria)){
			exist = true
		}
	});
	return exist
}
function behremove(element, index){
	var select = document.getElementById("dynamic-select");
	select.remove(index);
	
	//Bug Fix for not removing the selected beahviour criteria completely in behaviour segment creation.
	var removeButtonTag = document.getElementById("behaviourbucket")
	removeButtonTag.removeChild(element)
	//element.style.display = "none";		
}
function removeAll(){
	var select = document.getElementById("dynamic-select");
	select.options.length = 0;
	var x = document.getElementById("behaviourbucket");
	x.style.display = "none";	
}


//Created new function for dropdown(City/State/Country) - Sre.
function selectedValue(selectedValue){
	var selectedTagId = selectedValue.getAttribute("id")
	var setSelectedValue = document.getElementById(selectedTagId)
	var optionSelectedVal = setSelectedValue.options[setSelectedValue.selectedIndex].getAttribute("value") 
	
	$("#"+selectedTagId+" option").each(function(){
		if(optionSelectedVal == $(this).val()){
			$(this).attr("selected","selected")
		}else{
			$(this).removeAttr("selected")
		}
    });
}
//end of beh segment

//start tech segment

var obj = [];
obj.devices=["Desktop","Mobile","Tablet"];
obj.os = ["MacOS", "Windows", "Linux","Mobile"];
obj.browser = ["chrome","firefox","safari","edge","IE","Opera"];
console.log(obj["devices"])
var buttonlabelArr = new Array();
var techTypeArr = new Array();

	
	function techadd() {
		var techRule = document.getElementById("technologyrule").value;
		var techList = document.getElementById("technologylist").value;
		var techDynamicSelection = document.getElementById("dynamicselection").value;
		console.log("tech value is :"+techRule+" and :: "+techList+" and ksjdn:"+techDynamicSelection)

		//This variable is to checking the restriction to allow user to choose only one device,os and browser
		/* if($.inArray(techList,techTypeArr) == 0){
			
		} */
		
		console.log("techTypeArr value is ::"+techTypeArr+" and its techlist is ::"+techList);
		if($.inArray(techRule+"-"+techList,techTypeArr) != -1){
			swal.fire("Only one time the "+techRule+"-"+techList+" value added in technology");
		}else{
			
			
			var techCondition = techRule + "-" + techList + "-" + techDynamicSelection;
			var techConditions = techRule + ":" + techList + ":" + techDynamicSelection;
			var buttonlabel = techCondition.replace(/:/g, "");
			buttonlabel = techCondition.replace(".", "");	
			var select = document.getElementById("dynamic-select");
			var index = select.options.length;
			select.options[index] = new Option(techConditions, techConditions);
			//Reset value into it.	
			document.getElementById("technologyrule").reset;
			document.getElementById("technologylist").reset;
			document.getElementById("dynamicselection").reset;
			var x = document.getElementById("technologybucket");
			
			if(($.inArray(buttonlabel, buttonlabelArr) == -1)){
			if(techRule == "include") {		
				x.innerHTML += '<button id="'+buttonlabel+'" data-typeval="'+techList+'" type="button" class="btn btn-outline-info btn-pill" onclick="techremove(this)"><i class="fas fa-chalkboard-teacher"></i>'+techConditions+'<i class="la la-close"></i></button>&nbsp;';		
			} else {		
				x.innerHTML += '<button id="'+buttonlabel+'" data-typeval="'+techList+'" type="button" class="btn btn-outline-danger btn-pill" onclick="techremove(this)"><i class="fas fa-chalkboard-teacher"></i>'+techConditions+'<i class="la la-close"></i></button>&nbsp;';		
			}
				x.style.display = "block";
				document.getElementById("technologyrule").focus();
				buttonlabelArr.push(buttonlabel);
				techTypeArr.push(techRule+"-"+techList);
			}else{
			 swal.fire("The Same Criteria already exist for technology segment.")
			}
		}
	}
	function techremove(buttonIds) {
		var buttonre = buttonIds.id.replace(/-/g, ":");
		var tecRule = buttonre.split(":")[0];
		var tecType = buttonre.split(":")[1];
		var buttonIdName = buttonIds.id
		$('#'+buttonIds.id).remove(); 
		
		var selectobject = document.getElementById("dynamic-select");
		for (var i=0; i<selectobject.length; i++) {
		    if (selectobject.options[i].value == buttonre)
		        selectobject.remove(i);
		}
		
		techTypeArr = $.grep(techTypeArr, function(value) {
  			return value != tecRule+"-"+tecType;
		});
		buttonlabelArr = $.grep(buttonlabelArr, function(value) {
  			return value != buttonIdName;
		});
	}
	function removeAll() {
		var select = document.getElementById("dynamic-select");
		select.options.length = 0;
		var x = document.getElementById("technologybucket");
		x.style.display = "none";
	}


String.prototype.replaceAll = function(search, replacement) {
		var target = this;
		return target.replace(new RegExp(search, 'g'), replacement);
	};
	
	//Created new function for dropdown(City/State/Country) - Sre.
	
function selectedCriteria(selectedValue){
		var selectedTagId = selectedValue.getAttribute("id")
		//console.log("selectedTagId ::"+selectedTagId)
		var setSelectedValue = document.getElementById(selectedTagId)
		var optionSelectedVal = setSelectedValue.options[setSelectedValue.selectedIndex].getAttribute("value") 
		//console.log("optionSelectedVal::"+optionSelectedVal)
		
		$("#"+selectedTagId+" option").each(function(){
			if(optionSelectedVal == $(this).val()){
				$(this).attr("selected","selected")
			}else{
				$(this).removeAttr("selected")
			}
	    });
	}
	
	function selectedValue(selectedValue){
		var selectedTagId = selectedValue.getAttribute("id")
		console.log("selectedTagId ::"+selectedTagId)
		var setSelectedValue = document.getElementById(selectedTagId)
		var optionSelectedVal = setSelectedValue.options[setSelectedValue.selectedIndex].getAttribute("value") 
		console.log("optionSelectedVal::"+optionSelectedVal)
		$("div#formtechoptiondynamic").empty();
		$("div#formtechoptiondynamic").append(" <label class=\"col-form-label col-lg-3 col-sm-12 ttc\">"+optionSelectedVal+"</label>");
		var optionAppendVal ="";
		$.each(obj[optionSelectedVal], function( index, value ) {
			optionAppendVal += "<option class=\"ttc\" value=\""+value+"\">"+value+"</option>"
			});
		
		$("div#formtechoptiondynamic").append("<div class=\"col-lg-4 col-md-9 col-sm-12\"><select id=\"dynamicselection\" class=\" ttc form-control form-control--fixed kt_selectpicker\" "+
				"data-width=\"100\">"+optionAppendVal+
			"</select></div>")
		
		
		$("#"+selectedTagId+" option").each(function(){
			if(optionSelectedVal == $(this).val()){
				$(this).attr("selected","selected")
			}else{
				$(this).removeAttr("selected")
			}
	    });
	} // tech end
	
	//interest start
	function intadd(){	
		var errorMSg ="";
		var errorMSgs ="";
		var intrule = document.getElementById("intrule").value;
		var inttype = document.getElementById("inttype").value;
		var intcriteria = document.getElementById("intcriteria").value;
		var intrulevalue = document.getElementById("intrulevalue").value;
		var intpageurl = document.getElementById("intpageurl").value;	
		if(!hasintConditionExistsAlready(inttype,intcriteria)){
//		errorMSgs = pageurl.replace(" ","").length  <=0 ? "Page URL should not be empty" : ""; 
		if(intrulevalue.length < 0 || intrulevalue ==""  ){
			
				swal.fire("Number/Duration in Seconds should not be empty" );
		}
				else if(isNaN(intrulevalue))
					{
					swal.fire("Please Provide only numeric value in the Number/Duration in Seconds" );
					}
		//	document.getElementById("rulevalue").focus();
		
		else if((intpageurl.length > 0)  && (intrulevalue.length > 0) )
		{
		var interest = intrule+":"+inttype+":"+intcriteria+":"+intrulevalue+":"+intpageurl;	
		var buttonlabel = interest.replace(/:/g, "");
		buttonlabel = buttonlabel.replace(".", "");	
		var select = document.getElementById("dynamic-select");
		var index = select.options.length;
		select.options[index] = new Option(interest, interest);			
		document.getElementById("intrule").reset;
		document.getElementById("inttype").reset;
		document.getElementById("intcriteria").reset;
		document.getElementById("intrulevalue").value = ""; //Clear the Text Field
		document.getElementById("intpageurl").value = "";//Clear the Text Field	
		var x = document.getElementById("interestbucket");	
		
		if(intrule == "include") {		
			x.innerHTML += '<button id="'+inttype+intcriteria+intrulevalue+'" data-condition="'+inttype+intcriteria+'" type="button" class="btn btn-outline-info btn-pill" onclick="intremove('+inttype+intcriteria+intrulevalue+','+index+')"><i class="fa fa-star"></i>'+inttype+':'+intcriteria+':'+intrulevalue+':'+intpageurl+'<i class="la la-close"></i></button>&nbsp;';		
		} else {		
			x.innerHTML += '<button id="'+inttype+intcriteria+intrulevalue+'" data-condition="'+inttype+intcriteria+'" type="button" class="btn btn-outline-danger btn-pill" onclick="intremove('+inttype+intcriteria+intrulevalue+','+index+')"><i class="fa fa-star"></i>'+inttype+':'+intcriteria+':'+intrulevalue+':'+intpageurl+'<i class="la la-close"></i></button>&nbsp;';	
		}
		
		x.style.display = "block";			
		document.getElementById("intrule").focus();	
		}
		else
			{
			swal.fire("Page URL should not be empty");
			}
//		document.getElementById("pageurl").focus();
		}else 
		{
		swal.fire("The Same condition has exist already.Please remove the conditon and add it again")
		}
	}

	function hasintConditionExistsAlready(inttype,intcriteria){
		var exist = false
		$("#interestbucket button").each(function(){
			var conditionMatch = $(this).attr("data-condition")
			if(conditionMatch == (inttype+intcriteria)){
				exist = true
			}
		});
		return exist
	}
	function intremove(element, index){
		var select = document.getElementById("dynamic-select");
		select.remove(index);
		
		//Bug Fix for not removing the selected beahviour criteria completely in behaviour segment creation.
		var removeButtonTag = document.getElementById("interestbucket")
		removeButtonTag.removeChild(element)
		//element.style.display = "none";		
	}
	function removeAll(){
		var select = document.getElementById("dynamic-select");
		select.options.length = 0;
		var x = document.getElementById("interestbucket");
		x.style.display = "none";	
	} //interest end
	
	
	// source start
	function sourceadd(){	
		var errorMSg ="";
		var sourcerule = document.getElementById("sourcerule").value;	
		var sourcecriteria = document.getElementById("sourcecriteria").value;	
		var sourcepattern = document.getElementById("sourcepattern").value;	
		if(!hassourceConditionExistsAlready(sourcerule,sourcecriteria)){
		errorMSg = sourcepattern.replace(" ","").length  <=0 ? "URL field should not be empty" : ""; 
		if(errorMSg !=""  ){
			
				swal.fire(errorMSg)
			document.getElementById("sourcepattern").focus();
		}else{
		var referrer = sourcerule+":"+sourcecriteria+":"+sourcepattern;	
		var buttonid = referrer.replace(/:/g, "");
		buttonid = buttonid.replace(".", "");		
		var select = document.getElementById("dynamic-select");
		var index = select.options.length;
		select.options[index] = new Option(referrer, referrer);			
		document.getElementById("sourcerule").reset;	
		document.getElementById("sourcecriteria").reset;
		document.getElementById("sourcepattern").value = ""; //Clear the Text Field		
		var x = document.getElementById("referrerbucket");		
		
		if(sourcecriteria == "match" || sourcecriteria == "contain") {		
			x.innerHTML += '<button id="'+buttonid+'" data-condition="'+sourcerule+sourcecriteria+'" type="button" class="btn btn-outline-info btn-pill" onclick="sourceremove('+buttonid+','+index+')"><i class="flaticon2-line-chart"></i>'+sourcerule+':'+sourcecriteria+':'+sourcepattern+'<i class="la la-close"></i></button>&nbsp;';		
		} else {		
			x.innerHTML += '<button id="'+buttonid+'" data-condition="'+sourcerule+sourcecriteria+'" type="button" class="btn btn-outline-danger btn-pill" onclick="sourceremove('+buttonid+','+index+')"><i class="flaticon2-line-chart"></i>'+sourcerule+':'+sourcecriteria+':'+sourcepattern+'<i class="la la-close"></i></button>&nbsp;';		
		}	
		
		x.style.display = "block";			
		document.getElementById("sourcerule").focus();
		}
		}
		else
			{
			swal.fire("The Same condition has exist already.Please remove the conditon and add it again")
			}
	}
	function hassourceConditionExistsAlready(sourcerule,sourcecriteria){
		var exist = false
		$("#referrerbucket button").each(function(){
			var conditionMatch = $(this).attr("data-condition")
			if(conditionMatch == (sourcerule+sourcecriteria)){
				exist = true
			}
		});
		return exist
	}

	function sourceremove(element, index){
		var select = document.getElementById("dynamic-select");
		select.remove(index);
		
		//Bug Fix for not removing the selected beahviour criteria completely in behaviour segment creation.
		var removeButtonTag = document.getElementById("referrerbucket")
		removeButtonTag.removeChild(element)
		//element.style.display = "none";		
	}
	function removeAll(){
		var select = document.getElementById("dynamic-select");
		select.options.length = 0;
		var x = document.getElementById("referrerbucket");
		x.style.display = "none";	
	} // source end
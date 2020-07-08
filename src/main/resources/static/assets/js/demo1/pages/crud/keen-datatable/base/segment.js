var dataJSONArray = {};

jQuery(document).ready(function() {
	localStorage.clear();

	var offset = 0;
	var limit = 10;  
	var record = 10;

	test(offset,limit,record);
	
	localStorage.setItem("segpageload", "onload");
	
	
	/*console.log(document.getElementById('popoverData').getAttribute('data-content'));
	var myInput = document.getElementById('popoverData');
	var sec = myInput.getAttribute('data-content');
	myInput.setAttribute('data-content', 'custom-value');
	console.log(myInput.setAttribute('data-content', 'custom-value'));*/
	$('#popoverData').popover(); 
	
	  
});

// Custom Dropdown for selection of pageitem
$(document).on("change","#mySelect", function() {
	 let clickedOption = $(this).val();
	 console.log("cliock="+clickedOption);
	 console.log("value="+$(this).val());
	 localStorage.setItem("segpageload", "onclick");
	 var tot_page = localStorage.getItem("pagecount");
	 console.l

	 var offset = 0;
	 var seg_limit = $(this).val();
	 var record = $(this).val();
		
		document.getElementById("spin").style.display= "block";
		document.getElementById("spin").style.position= "relative";
		document.getElementById("spin").style.top= "50%";
		document.getElementById("spin").style.left= "40%"; 
		document.getElementById("local_data").style.display= "none";
		document.getElementById("mySelect").style.display = "none";
		document.getElementById("count").style.display = "none";
		var seg_geo = "loc";
		var seg_beh = "beh";
		var seg_tech = "tech";
		var seg_int = "int";
		var seg_ref = "ref";

		$.ajax({
            type : "GET", 
           
            url : "/wem/segmentlist",
            contentType: "application/json; charset=utf-8", 
            data: { 
            	'segtype':seg_geo, 
            	'segbev':seg_beh,
            	'segtech':seg_tech,
            	'segint':seg_int,
            	'segref':seg_ref,
            	offset: offset, 
            	limit:seg_limit
            	
              },
          
            async: true,
          
	            success : function(data) {    
	            	document.getElementById("local_data").style.display= "block";
	            	document.getElementById("spin").style.display= "none";
	            	document.getElementById("mySelect").style.display = "unset";
	            	document.getElementById("count").style.display = "unset";
	                /*dataJSONArray = JSON.parse(data) ;
	                ktDATA();*/
	                
	                response = this.response; 
					
					dataJSONArray = data;
					var table = $('.kt_datatable');
					c = table.KTDatatable();

					c.originalDataSet = dataJSONArray;

					c.reload();
	                var count = dataJSONArray[0];
					var tot_segment = count.SegCount;
					var recordsPerPage = record;
					var seg_display = Math.ceil(tot_segment/recordsPerPage); 
					console.log("page=="+seg_display);
					localStorage.setItem("total_seg_page", seg_display);
					localStorage.setItem("total_seg_count", tot_segment);
					localStorage.setItem("total_seg_limit", seg_limit);
					$('#page').empty();
					paginate(seg_display,tot_segment,seg_limit);

					
	            }
	        });
	});


function loading(){
	if(document.getElementById('user').className == "kt-header__topbar-item kt-header__topbar-item--user")
	{
	document.getElementById('user').className = "kt-header__topbar-item kt-header__topbar-item--user show ";

	
	var myInput = document.getElementById('expand');
	var sec = myInput.getAttribute('aria-expanded');
	myInput.setAttribute('aria-expanded', 'true');
	document.getElementById('show').className = "dropdown-menu dropdown-menu-fit dropdown-menu-right dropdown-menu-anim dropdown-menu-top-unround dropdown-menu-sm show";
}
else
	{
	document.getElementById('user').className = "kt-header__topbar-item kt-header__topbar-item--user ";
	var myInput = document.getElementById('expand');
	var sec = myInput.getAttribute('aria-expanded');
	myInput.setAttribute('aria-expanded', 'false');
	document.getElementById('show').className = "dropdown-menu dropdown-menu-fit dropdown-menu-right dropdown-menu-anim dropdown-menu-top-unround dropdown-menu-sm ";
	}
}

$(window).ready(function() {
	

    $('ul.pagination').on('click', 'a', function() {
    	console.log("total_page="+ localStorage.getItem("total_seg_page"));
    	var total_page = localStorage.getItem("total_seg_page");
    	   if($(this).hasClass('active')) return false;
    	    
    	    var active_elm = $('ul.pagination a.active');
    	    var page_id = $(this).attr("data-pageid")//on click call ajax controller(check page-id not equals to undefined)
    	    
    	    if(page_id == null)
    	    	{
    	   // 	console.log("page_id="+page_id);
    	    	}else
    	    		{
    	    		
    	    		page(page_id);
    	    		}
					
					  var l_total_page = $(this).attr("data-load");//on click call ajax controller(check page-id not equals to undefined)
					  var l_next = $(this).attr("data-page");
	    	    
	    	  // Fast forward & Fast backward functionality
			  
					  var load = localStorage.getItem("segpageload");
			    	    
			    	    if((load != "onload"))
			    	    	{
			    	  
			    	    if((total_page == l_total_page) && (l_next == "last_next")&& (total_page >= 6) )
			    	    	{
			    	    	console.log("page_id="+l_total_page);
			    	    	
			    	    	 var page_i = total_page - 4;
			    	    	 var page_e = total_page - 1;
			    	    	  for(var i=page_i,j=1,numt=page_i;i<=total_page;i++) 
			    	    						{
			    	    						j++;
			    	    						var num = numt++;
			    	    						 num = parseInt(num) ;	
			    	    						var nums = 'test'+num;
			    	    						if( i == total_page)
			    	    							{
			    	    							active_elm.removeClass('active');
			    	    							var list = document.createElement("li");
			    	    							list.setAttribute('class',"three_links");
			    	    			    	    	list.innerHTML='<a class="active"  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
			    	    			    	    	
			    	    							}
			    	    						else
			    	    							{
			    	    						var list = document.createElement("li");
			    	    						list.setAttribute('class',"three_links");
			    	    						list.innerHTML='<a class=""  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
			    	    							}
			    	    	  var item = document.getElementById("page");
			    	    	  item.replaceChild(list, item.childNodes[j]);
			    	    	  
			    	    	  
			    	    						}
							
		    	    	  if(total_page == l_total_page)
		    	    		  {
		    	    		  document.getElementById("next").style.pointerEvents  = "none";
		  	    	    	  document.getElementById("last").style.pointerEvents  = "none";
		    	    		  }
			    	    	page(total_page);
			    	    	}
			    
			    	    else if((total_page == l_total_page) && (l_next == "last_previous")&& (total_page >= 6))
			    	    {
			    	    	console.log("page_id="+l_total_page);
			    	    	
			    	    	 
			    	    	  for(var i=1,j=1,numt=1;i<=5;i++) 
		    						{
			    	    		  var id = 1;
		    						j++;
		    						var num = numt++;
			   						num = parseInt(num) ;	
			   						var nums = 'test'+num;
		    						if( i == 1)
		    							{
		    							 
		    							var list = document.createElement("li");
		    							list.setAttribute('class',"three_links");
		    			    	    	list.innerHTML='<a class="active"  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
		    			    	    	document.getElementById("last").className="";  
		    							}
		    						else
		    							{
		    						var list = document.createElement("li");
		    						list.setAttribute('class',"three_links");
		    						list.innerHTML='<a class=""  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
		    							}
		    	  var item = document.getElementById("page");
		    	  item.replaceChild(list, item.childNodes[j]);
		    	  
		    						}
		    	  
		    	page(id);
		    	}
			    	    	}
			    	    else
			    	    	{
			    	    	 if((total_page == l_total_page) && (l_next == "last_next") && (total_page >= 6))
				    	    	{
				    	    	console.log("page_id="+l_total_page);
				    	    	
				    	    	 var page_i = total_page - 4;
				    	    	 var page_e = total_page - 1;
				    	    	  for(var i=page_i,j=2,numt=page_i;i<=total_page;i++) 
				    	    						{
				    	    						j++;
				    	    						var num = numt++;
				    	    						 num = parseInt(num) ;	
				    	    						var nums = 'test'+num;
				    	    						if( i == total_page)
				    	    							{
				    	    							active_elm.removeClass('active');
				    	    							var list = document.createElement("li");
				    	    							list.setAttribute('class',"three_links");
				    	    			    	    	list.innerHTML='<a class="active"  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
				    	    			    	    	
				    	    							}
				    	    						else
				    	    							{
				    	    						var list = document.createElement("li");
				    	    						list.setAttribute('class',"three_links");
				    	    						list.innerHTML='<a class=""  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
				    	    							}
				    	    	  var item = document.getElementById("page");
				    	    	  item.replaceChild(list, item.childNodes[j]);
				    	    	  
				    	    	  
				    	    						}
				    	    	  
				    	    	page(total_page);
				    	    	}
				    	    else if((total_page == l_total_page) && (l_next == "last_previous") && (total_page >= 6))
				    	    {
				    	    	console.log("page_id="+l_total_page);
				    	    	
				    	    	 
				    	    	  for(var i=1,j=2,numt=1;i<=5;i++) 
			    						{
				    	    		  var id = 1;
			    						j++;
			    						var num = numt++;
				   						num = parseInt(num) ;	
				   						var nums = 'test'+num;
			    						if( i == 1)
			    							{
			    							 
			    							var list = document.createElement("li");
			    							list.setAttribute('class',"three_links");
			    			    	    	list.innerHTML='<a class="active"  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
			    			    	    	document.getElementById("last").className="";  
			    							}
			    						else
			    							{
			    						var list = document.createElement("li");
			    						list.setAttribute('class',"three_links");
			    						list.innerHTML='<a class=""  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
			    							}
			    	  var item = document.getElementById("page");
			    	  item.replaceChild(list, item.childNodes[j]);
			    	  
			    						}
			    	  
			    	page(id);
			    	}
			    	    	
			    	    	}		
    	    var new_id = "";
    	    var custom_id = "";
    	   
    	    if(this.id == 'next'){
    	      var _next = active_elm.parent().next().children('a');
    	      var page_idn = $(_next).attr('data-pageid');//on move  call ajax controller(check page-id not equals to undefined)
    	      var next = true;
    	      if(page_idn == null)
    	    	{
    	    //	console.log("page_idn="+page_idn);
    	    	}
    	      else
    	    	  {
    	    	  page(page_idn);
    	    	  }
    	      if($(_next).attr('id') == 'next') {
    	    	  var page_idns = $(_next).attr('data-pageid');
    	        // appending next button if reach end
    	  //      var num = parseInt($('a.active').text())+1;
    	        var testing = $('a.active').last();
    	        var count = (testing.prevObject[0].dataset.pageid);
    	        var num = parseInt(count) + 1;
    	        var next_num = num;
    	        
    	        if(num <= total_page){
    	        	var nums = 'test'+num;
    	        active_elm.removeClass('active');
    	        $('.three_links').first().remove();
    	  			$('.three_links').last().after('<li class="three_links"><a id="'+nums+'" data-pageid="'+num+'" class="active" >'+num+'</a></li>');
    	  			var new_element = $('.three_links').last();
    		//		new_id = new_element[0].textContent;//on move of newly created element call ajax controller(check page-id not equals to undefined)
    				/*var n = new_element[0].innerHTML;
    				new_id = n.substring(27,28);*/
    				
    				page(num);
    				
    				if((next_num == total_page))
	    	    	{
	    	    	document.getElementById("next").style.pointerEvents  = "none";
	    	    	document.getElementById("last").style.pointerEvents  = "none";
	    	    	}
    	        }
    	  			return; 
    	      }
    	      _next.addClass('active');   
    	      
    	      
    	      
    	      
    	    }
    	    
    	    else if(this.id == 'prev') {
    	        var _prev = active_elm.parent().prev().children('a');
    	        var page_idp = $(_prev).attr('data-pageid');//on move  call ajax controller(check page-id not equals to undefined)
    	        localStorage.setItem("segpage_idp", page_idp);
    	        var prev = true;
    	        if(page_idp == null)
    	    	{
    	//    	console.log("page_idp="+page_idp);
    	    	}
    	        else
    	        	{
    	        	
    	        	page(page_idp);
    	        	}
    	        if($(_prev).attr('id') == 'prev'){
    	        	var page_idps = $(_prev).attr('data-pageid');
    	     //   	var num = parseInt($('a.active').text())-1;
    	        	 var testing = $('a.active').first();
    	        	 
 	    	        var count = (testing.prevObject[0].dataset.pageid);
 	    	        var num = parseInt(count) - 1;
 	    	       var prev_num = num;
 	    	       
    	          if(num > 0){
    	        	  var nums = 'test'+num;
    	            active_elm.removeClass('active');
    	          	$('.three_links').last().remove();
    	    				$('.three_links').first().before('<li class="three_links"><a id="'+nums+'" data-pageid="'+num+'" class="active" >'+num+'</a></li>');
    	    				var new_element = $('.three_links').first();
    	    		//		new_idp = new_element[0].textContent;//on move of newly created element call ajax controller(check page-id not equals to undefined)
    	    			/*	var r = new_element[0].innerHTML;
    	    				new_idp = r.substring(27,28);*/
    	    				
    	    				page(num);
    	    				
    	    				if((prev_num == 1))
    		    	    	{
	    					document.getElementById("prev").style.pointerEvents  = "none";
			    	    	document.getElementById("first").style.pointerEvents  = "none";	
    		    	    	}
    	          }
    	          return; 
    	        }
    	        _prev.addClass('active');   
    	      }
    	    else {
    	        $(this).addClass('active');
    	        document.getElementById("last").className="flaticon2-fast-next";
	    	    document.getElementById("first").className="flaticon2-fast-back";
	    	    if(((total_page == l_total_page) && (l_next == "last_next")) && (total_page >= 6))
	    		  {
	    	    document.getElementById("next").style.pointerEvents  = "none";
    	    	document.getElementById("last").style.pointerEvents  = "none";
    	    	document.getElementById("prev").style.pointerEvents  = "unset";
    	    	document.getElementById("first").style.pointerEvents  = "unset";	
	    		  }
	    	    else if(((total_page == l_total_page) &&(l_next == "last_previous")) && (total_page >= 6))
	    	    {
    	    	document.getElementById("prev").style.pointerEvents  = "none";
    	    	document.getElementById("first").style.pointerEvents  = "none";	
    	    	document.getElementById("next").style.pointerEvents  = "unset";
	    	    document.getElementById("last").style.pointerEvents  = "unset";
	    	    }
	    	    else if(total_page >= 6)
	    	    	{
	    	    	document.getElementById("next").style.pointerEvents  = "unset";
	    	    	document.getElementById("last").style.pointerEvents  = "unset";
	    	    	document.getElementById("prev").style.pointerEvents  = "unset";
	    	    	document.getElementById("first").style.pointerEvents  = "unset";	
	    	    	console.log("previous page")
	    	    	}
	    	    
    	      }
    	      active_elm.removeClass('active');
    	      localStorage.getItem("page_idp", page_idp);
    	      if((page_idn == total_page) && (total_page >= 6))//onclick disable last_next adn next button
	    	     {
	    	    	document.getElementById("next").style.pointerEvents  = "none";
	    	    	document.getElementById("last").style.pointerEvents  = "none";
	    	     }
    	      else if(((page_idp == 1) ||(page_id == 1)) && (total_page >= 6))
    	    	  {
    	    	  	document.getElementById("prev").style.pointerEvents  = "none";
	    	    	document.getElementById("first").style.pointerEvents  = "none";	
    	    	  }
    	     
    	      else if((page_id == total_page )&& (total_page >= 6))
    	    	  {
    	    	  document.getElementById("next").style.pointerEvents  = "none";
    	    	  document.getElementById("last").style.pointerEvents  = "none";
    	    	  }
    	      else if((prev)&& (total_page >= 6))
	    	  {
	    	  document.getElementById("next").style.pointerEvents  = "unset";
    	      document.getElementById("last").style.pointerEvents  = "unset";
    	     
	    	  }
	      else if((next)&& (total_page >= 6))
    	  {
	    	document.getElementById("prev").style.pointerEvents  = "unset";
    	    document.getElementById("first").style.pointerEvents  = "unset";	
    	   
    	  }
    	       
        
    });
 
});

function page(id)
{
	var page_id = id;
	var page_end = "";
	var page_count = localStorage.getItem("total_seg_count");
	
	var offset  = "";
	var limit =  localStorage.getItem("total_seg_limit");
	var offset_l = "";

	//page_id  = page_id-1 ;

	if(limit == 20){
		page_id  = page_id-1 ;
		if(page_id != '0'){

		offset = (page_id * 20) + 1;
		offset_l = (page_id * 20) ;
		page_end = offset+19;
		limit = limit;
		}
 
		else
			{
		offset = 0; 
		offset_l = 0;
		limit =  limit;
		page_end = limit;
			}
		}


	else if(limit == 50){
	page_id  = page_id-1 ;
	if(page_id != '0'){

	offset = (page_id * 50) + 1;
	offset_l = (page_id * 50) ;

	page_end = offset+49;
	limit = limit;
	}

	else
		{
	offset = 0;  
	offset_l = 0;
	limit =  limit; 
	page_end = limit;
		}
	}

	else if(limit == 100){
	page_id  = page_id-1 ;
	if(page_id != '0'){

	offset = (page_id * 100) + 1;
	offset_l = (page_id * 100) ;

	page_end = offset+99;
	limit = limit;
	}

	else
	{
		offset = 0; 
		offset_l = 0;
		limit =  limit;
		page_end = limit;
	}
	}
	else if(limit == 10)
	{
	page_id  = page_id-1 ;
	if(page_id != '0'){
	
	offset = (page_id * 10) + 1;
	offset_l = (page_id * 10) ;
	
	page_end = offset+9;
	limit = limit;
	}
	
	else
		{
	offset = 0; 
	offset_l = 0;
	limit =  limit;
	page_end = limit;
		}
	}



 		var url	 = "/wem/segmentlist"
 		var params = "offset="+offset_l+"&limit="+limit+"&load=next&segtype=loc&segbev=beh&segtech=tech&segint=int&segref=ref";
 		var response = "";
 		document.getElementById("spin").style.display= "block";
 		document.getElementById("spin").style.position= "relative";
 		document.getElementById("spin").style.top= "50%";
 		document.getElementById("spin").style.left= "40%"; 
 		document.getElementById("local_data").style.display= "none";
 		document.getElementById("count").style.display = "none";
 		document.getElementById("mySelect").style.display = "none";
		
		var xhttp = new XMLHttpRequest(); 
		
		xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200
					&& this.response != "null") {
			document.getElementById("spin").style.display= "none";
			document.getElementById("local_data").style.display= "block";
			document.getElementById("count").style.display = "unset";
			document.getElementById("mySelect").style.display = "unset";
				response = this.response; 
				
				dataJSONArray = JSON.parse(response);
				var table = $('.kt_datatable');
				c = table.KTDatatable();

				c.originalDataSet = dataJSONArray;

				c.reload();
				if(page_id != '0')
					{
					document.getElementById("count").innerHTML= 'Showing '+offset+' - '+page_end+' of '+page_count+'';
					}
				
				else
					{
					document.getElementById("count").innerHTML= 'Showing 1 - '+page_end+' of '+page_count+''
					}
				
				
				
		}};
		xhttp.open("GET", url+"?"+params);
		
		xhttp.send();
		return response;
}


var timer;
function search() {
	
	document.getElementById("spin").style.display= "block";
	document.getElementById("spin").style.position= "relative";
	document.getElementById("spin").style.top= "50%";
	document.getElementById("spin").style.left= "40%"; 
	document.getElementById("local_data").style.display= "none";
	document.getElementById("page").style.display = "none";
	document.getElementById("count").style.display = "none";
	document.getElementById("mySelect").style.display = "none";
    clearTimeout(timer) // clear the request from the previous event
    timer = setTimeout(function() {
     	var values =  document.getElementById("generalSearch").value;
    	 
        if (values.length >= 3 && values != null && values != '' ) {
		  
        document.getElementById("delete").innerHTML='\
			  <label id="find" type="text" class="col-2 col-form-label">'+values+' </label>\
				<span id="clear" class="kt-input-icon__icon kt-input-icon__icon--right">\
			  <span></span>\
			  <a href="#" class="kt-demo-panel__close" id="kt_demo_panel_close">\
			 <i style="margin-left: 100px;" class="flaticon2-delete"></i>\
			  </a>\
			  </span>\
 			  ';
      
		var url	 = "/wem/segmentlist"
 		var params = "search="+values+"&limit=10"+"&segtype=loc&segbev=beh&segtech=tech&segint=int&segref=ref";
  		var response = "";
	   		 
	   				
			var xhttp = new XMLHttpRequest(); 
			
			xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200
						&& this.response != "null") {
					document.getElementById("page").style.display = "none";
					document.getElementById("spin").style.display= "none";
					document.getElementById("count").style.display = "none";
					document.getElementById("mySelect").style.display = "none";
					document.getElementById("local_data").style.display= "block";
					
					response = this.response; 
					
				
					dataJSONArray = JSON.parse((response));
					var table = $('.kt_datatable');
					c = table.KTDatatable();

					c.originalDataSet = dataJSONArray;
                    
					c.reload();
					
					
					
					
			}};
			xhttp.open("POST", url+"?"+params);
			
			xhttp.send();
			return response;
	  }
    }, 5000);
}


document.body.onclick= function(e){
e=window.event? event.srcElement: e.target;
if(e.className && e.className.indexOf('flaticon2-delete')!=-1)
		{
				 
        	
        	console.log("clear console true")
        	document.getElementById("delete").style.display = "none";
        	window.location.reload(true);
				        
				 
				
		}

//Segment_Rule Popup modal

if(e.className && e.className.indexOf('fa fa-inverse fa-stack-1x')!=-1)
{

	   var url		=	e.getAttribute("data-segvalue");
	   var seg_name	=	e.getAttribute("data-segname");
	   
	   var s = "";
	   var seg_one = "";
	 
	   if(url.includes("|") == true)
		   {
		   var rule = url.split("|");
		   for(var i = 0;i<rule.length;i++)
		   {
			  var criteria = rule[i].split(":");
		
				
				if((criteria[1].includes("state") == true)||(criteria[1].includes("city")== true)||(criteria[1].includes("country")== true))
				{
				s+= '<i class="fa fa-map-marker-alt" style="font-size: 1.5rem !important;padding-right: 5px;"></i>'+ criteria[2]+"<br>  ";
				}
				if(((criteria[1].includes("visit") == true)||(criteria[1].includes("session")== true))&&(( rule[i].split(":").length == 4)))
				{
				s+= '<i class="fa fa-user-clock" style="font-size: 1.5rem !important;padding-right: 5px;"></i>'+ criteria[1]+", "+criteria[2]+", "+criteria[3]+"<br>  ";
				}
				if(((criteria[1].includes("visit") == true)||(criteria[1].includes("session")== true))&&(( rule[i].split(":").length >= 5)))
				{
				s+= '<i class="fa fa-star" style="font-size: 1.5rem !important;padding-right: 5px;"></i>'+ criteria[1]+", "+criteria[2]+", "+criteria[3]+", "+criteria[4]+"<br>  ";
				}
				if((criteria[1].includes("devices") == true)||(criteria[1].includes("os")== true)||(criteria[1].includes("browser")== true))
				{
				s+= '<i class="fas fa-chalkboard-teacher" style="font-size: 1.5rem !important;padding-right: 5px;"></i>'+ criteria[1]+", "+criteria[2]+"<br>  ";
				}
				if(criteria[1].includes("match") == true||(criteria[1].includes("contain")== true)||(criteria[1].includes("notmatch")== true)||(criteria[1].includes("notcontain")== true))
				{
				s+= '<i class="flaticon2-line-chart" style="font-size: 1.5rem !important;padding-right: 5px;"></i>'+ criteria[1]+", "+criteria[2]+"<br>  ";
				}
		   
		   } 
		document.getElementById("popurl-elements").innerHTML = '<span style="font-size: 1.5rem !important;" class="fa fa-info-circle"><span style="padding-left: 5px;">Segment Rules</span> <br><br></span><div id = "url" class="kt-demo-icon__class" style=" margin-top: 11px;">'+s+ '</div>'
		document.getElementById("experience-elements").innerHTML = seg_name;
		$('#modalurls').modal('show');
		   }
	   else
		   {
		   var criteria = url.split(":");
		   
		   if((criteria[1].includes("state") == true)||(criteria[1].includes("city")== true)||(criteria[1].includes("country")== true)) 
			{
			seg_one+= '<i class="fa fa-map-marker-alt" style="font-size: 1.5rem !important;padding-right: 5px;"></i>'+ criteria[2]+"<br>  ";
			}
			if(((criteria[1].includes("visit") == true)||(criteria[1].includes("session")== true))&&(( url.split(":").length == 4)))
			{
			seg_one+= '<i class="fa fa-user-clock" style="font-size: 1.5rem !important;padding-right: 5px;"></i>'+ criteria[1]+", "+criteria[2]+", "+criteria[3]+"<br>  ";
			}
			if(((criteria[1].includes("visit") == true)||(criteria[1].includes("session")== true))&&(( url.split(":").length >= 5)))
			{
			seg_one+= '<i class="fa fa-star" style="font-size: 1.5rem !important;padding-right: 5px;"></i>'+ criteria[1]+", "+criteria[2]+", "+criteria[3]+", "+criteria[4]+"<br>  ";
			}
			if((criteria[1].includes("devices") == true)||(criteria[1].includes("os")== true)||(criteria[1].includes("browser")== true))
			{
			seg_one+= '<i class="fas fa-chalkboard-teacher" style="font-size: 1.5rem !important;padding-right: 5px;"></i>'+ criteria[1]+", "+criteria[2]+"<br>  ";
			}
			if(criteria[1].includes("match") == true||(criteria[1].includes("contain")== true)||(criteria[1].includes("notmatch")== true)||(criteria[1].includes("notcontain")== true))
			{
			seg_one+= '<i class="flaticon2-line-chart" style="font-size: 1.5rem !important;padding-right: 5px;"></i>'+ criteria[1]+", "+criteria[2]+"<br>  ";
			}
		   
		   
		document.getElementById("popurl-elements").innerHTML = '<span style="font-size: 1.5rem !important;" class="fa fa-info-circle"><span style="padding-left: 5px;">Segment Rule</span> <br><br></span><div id = "url" class="kt-demo-icon__class" style=" margin-top: 11px;">'+seg_one+"<br>  " + '</div>';
		document.getElementById("experience-elements").innerHTML = seg_name;
		$('#modalurls').modal('show');
		   }

}


}

function paginate(seg_display,tot_segment,seg_limit)
{ 
	var total_seg_page = localStorage.getItem("total_seg_page");
	var mydiv = document.getElementById("page");
	var load = localStorage.getItem("segpageload");
	/*var ul = document.createElement('ul');
	ul.setAttribute('class',"pagination");
	ul.setAttribute('id',"lists");
	ul.setAttribute("onclick","paginate();")*/
	var lists=document.createElement('li');
	lists.innerHTML='<a class="flaticon2-fast-back" id="first"  data-load = "'+seg_display+'"  data-page = "last_previous" >' + ""  + '</a>';
	mydiv.appendChild(lists);
	
	
	var list=document.createElement('li');
	list.innerHTML='<a class="flaticon2-back"  id="prev"  data-page = "previous" >' + ""  + '</a>';
	mydiv.appendChild(list);

	var x = document.getElementsByClassName("page-link");
	for(var i = 1; i <= seg_display; i++) 
	{

		if(i > 5)
		{
		for (var p = 5; p < x.length; p++) {
		document.getElementsByClassName("three_links")[p].style.display = 'none';
		}
		}
		else
			{
		var mydiv = document.getElementById("page");
		
		
		var li=document.createElement('li');
		li.setAttribute('class',"three_links");
		
		if(i == 1)
		{
		li.innerHTML='<a  class="active" id="test'+i+'"  data-pageid='+i+' data-page = "'+seg_display+'" >' + i  + '</a>';
		
		console.log("true="+i);
		}
		else
			{
			li.innerHTML='<a id="test'+i+'" data-pageid='+i+'  data-page = "'+seg_display+'" >' + i  + '</a>';	
			}
		mydiv.appendChild(li);
			
			}
		
	}
	var lists=document.createElement('li');
	lists.innerHTML='<a class="flaticon2-next" id="next"  data-page = "next" >' + ""  + '</a>';
	mydiv.appendChild(lists);
	
	var list_next=document.createElement('li');
	list_next.innerHTML='<a class="flaticon2-fast-next" id="last"  data-load = "'+seg_display+'"  data-page = "last_next" >' + ""  + '</a>';
	mydiv.appendChild(list_next);
	
	  if(total_seg_page < 5)
		{
		document.getElementById("first").style.pointerEvents  = "none";
		document.getElementById("last").style.pointerEvents  = "none";
		}
	  if(((load == "onload")|| (load == "onclick"))&&(total_seg_page >=6))
		 {
		 document.getElementById("prev").style.pointerEvents  = "none";
	     document.getElementById("first").style.pointerEvents  = "none";	
		 }
	document.getElementById("count").innerHTML= 'Showing 1 - '+seg_limit+' of '+tot_segment+''
}


function test(offset,limit,record)
{
var offset = offset;
var seg_limit = limit;
document.getElementById("spin").style.display= "block";
document.getElementById("spin").style.position= "relative";
document.getElementById("spin").style.top= "50%";
document.getElementById("spin").style.left= "40%"; 
document.getElementById("local_data").style.display= "none";
var seg_geo = "loc";
var seg_beh = "beh";
var seg_tech = "tech";
var seg_int = "int";
var seg_ref = "ref";

		$.ajax({
            type : "GET", 
           
            url : "/wem/segmentlist",
            contentType: "application/json; charset=utf-8", 
            data: { 
            	'segtype':seg_geo, 
            	'segbev':seg_beh,
            	'segtech':seg_tech,
            	'segint':seg_int,
            	'segref':seg_ref,
            	offset: offset, 
            	limit:seg_limit
            	
              },
          
            async: true,
          
            success : function(data) {    
            	document.getElementById("local_data").style.display= "block";
            	document.getElementById("spin").style.display= "none";
            	document.getElementById("mySelect").style.visibility = "visible";
            	document.getElementById("mySelect").style.display = "unset";
            	document.getElementById("search").style.display = "block";
            	
                dataJSONArray = data ;
                ktDATA();
                var count = dataJSONArray[0];
            	var tot_segment = count.SegCount;
				var recordsPerPage = 10;
				var seg_display = Math.ceil(tot_segment/recordsPerPage); 
				console.log("seg=="+seg_display);
				localStorage.setItem("total_seg_page", seg_display);
				localStorage.setItem("total_seg_count", tot_segment);
				localStorage.setItem("total_seg_limit", seg_limit);
				var tot_page = localStorage.getItem("total_seg_count");
				if(tot_page <= 10)
				 {
				 $('option[value=20]').prop('disabled', true);
				 $('option[value=50]').prop('disabled', true);
				 $('option[value=100]').prop('disabled', true);
				 }
			 else if(tot_page <= 20)
				 {
				 $('option[value=50]').prop('disabled', true);
				 $('option[value=100]').prop('disabled', true);
				 }
			 else if(tot_page <= 50)
				 {
				 $('option[value=100]').prop('disabled', true);
				 }
				
               
				paginate(seg_display,tot_segment,seg_limit);
            }
        });
                
	}
	
	
function ktDATA()
	{
	 
                var datatable = $('.kt_datatable').KTDatatable({
        			// datasource definition
                	
        			data: {
        				type: 'local',
        				source: dataJSONArray,
        				
        			},
        			
        			// layout definition
        			layout: {
        				scroll: false, // enable/disable datatable scroll both horizontal and vertical when needed.
        				// height: 450, // datatable's body's fixed height
        				footer: false, // display/hide footer
        			},

        			// column sorting
        			sortable: true,

        			pagination: false,
        			
        			searching: false,

        		/*	search: {
        				input: $('#generalSearch'),
        			},
*/
        			// columns definition
        			columns: [
        				{
        					
        					field: 'Seg_id',
        					title: '#',
        					sortable: false,
        					width: 20,
        					type: 'number',
        					selector: {class: 'kt-checkbox--solid'},
        					textAlign: 'center',
        				}, {
        					field: 'segment',
        					title: 'Segment',
        				}, {
        					field: '',
        					title: 'Rule',
        					template: function(row) {
        						
        						
        						var geo = row.geography.split("+");
        						var segment_name = row.segment;
        						var txt = "";
        						var r="";
        						for (i = 0; i < geo.length; i++) {
        								if (i == 0) {
        									txt = geo[i];
        								} else {
        									txt = txt + "|" + geo[i];
        								}
        							}
        					var geo_re = txt.replace(/\+/g,'|')

        					var re = geo_re.replace(/[\])}[{(]/g, '')

        						
        						var rule = re.split("|");
        						var segs="";
        						var last_test="";
        						for(var j = 0;j<rule.length ;j++)
        							
        							{
        						
        							if (j == 0) {
        								segs = rule[j];
    								} else {
    									segs = segs + "|" + rule[j];
    								}
        						    
        							}

        							last_test = segs;
        						
        							r+= '<a  href="javascript:void(0); class="page" ><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i  href="javascript:void(0); data-toggle="modal" data-segname="'+segment_name+'"   data-segvalue="'+last_test+'" class="fa fa-inverse fa-stack-1x" style="cursor: pointer;">'+rule.length+'</i></span></a>'
        							return r;
        			
        					}
        				},/*{
        					field: 'segment',
        					title: 'Geography',
        					template: function(row) {
        						var exp_id = row.id;
        					
        						var exp_name = row.experience;
        						var segArray = row.segments.split(",");
        						segArray = segArray.slice(0,segArray.lastIndexOf(","));
        					
        						
        						var s = "";
        						var seg	=	"";
        						for(var i=0;i<segArray.length;++i)
        							{  
        							
        							var segname = segArray[i].slice(segArray[i].indexOf(":")+1,segArray[i].length); 
        							s += '<a href="" class="hover" data-expname="'+exp_name+'" data-toggle="modal"  title="Experience contents" data-segname="'+segArray[i].slice(segArray[i].indexOf(":")+1,segArray[i].length)+'"  data-expid="'+exp_id+'" id="' + segArray[i].slice(0,segArray[i].lastIndexOf(":")) + '" >' + segname +",  " + '</a>';
        							
        							}
        						
        						return s.slice(0,s.lastIndexOf(",")) ;
        					
        					},
        				}, */ /*{
        					field: 'statuss',
        					title: 'Embed Code', 
        					template:function(row)
        					{
        					
        		 				var exp_id = row.id;
        		 				var exp_name = row.experience;
        						var r = "";
        						 
        						r+= '<button  id="myBtn"  dat-seg=""  onclick="javascript:embed(this)" data-ids="'+exp_id+'" data-expname="'+exp_name+'" class="btn btn-outline-brand btn-pill" >View</button>'
        							return r;
        					}
        				}, */ {
        					field: 'name',
        					title: 'Created By',
        				},{
        					field: 'Actions',
        					title: 'Actions',
        					sortable: false,
        					width: 110,
        					overflow: 'visible',
        					autoHide: false,
        					template: function() {
        						return '\
        						<a <a href="/wem?view=pages/segment-edit-geo.jsp" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Edit details">\
        							<i class="la la-edit"></i>\
        						</a>\
        						<a href="javascript:;" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Delete">\
        							<i class="la la-trash"></i>\
        						</a>\
        					';
        					},
        				}],
        		});
	}
	
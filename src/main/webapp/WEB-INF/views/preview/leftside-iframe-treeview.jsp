<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--  Tree JS reference : http://mbraak.github.io/jqTree/#demo -->

<%
	String html = (String) session.getAttribute("content");
	String tree_data = (String) session.getAttribute("tree_data");
%>
<!DOCTYPE html>
<html>

<head>
<style>
.exp-tree, button {
	font-family: Poppins;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.16/webfont.js"></script>
<script>
	WebFont.load({
		google : {
			"families" : [ "Poppins:300,400,500,600,700" ]
		},
		active : function() {
			sessionStorage.fonts = true;
		}
	});
</script>
<link rel="stylesheet" href="preview/jqtree.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="preview/tree.jquery.js"></script>

<script type="text/template" id="tree_data">	
   <%=tree_data%>
	</script>
</head>
<script>
	var data = tree_data.innerText.replace(/\\/g, '');
	
	$(function() {
		localStorage.removeItem("tree");
		$('.exp-tree').tree({
			data : JSON.parse(data),
			saveState : true,
			selectable : true,
			autoOpen : false,
			animationSpeed: 1000,
			onDragMove : handleMove,
			onCreateLi : function(node, $li, is_selected) {
		
				// Add 'icon' span before title
				//  debugger;
				//  $li.find('.jqtree-title').before('<span class="icon"></span>');
				if (!(node.parent.name == "")) {
					c = $li.find('.jqtree-title');
					$li[0].draggable = "true";
					//$li[0].setAttribute("ondragstart", "onDragStart(event);");
					$li[0].id = node.id;
				}
			}

		});

		function handleMove(node, e) {
			console.log("DFG");
		}

		$('.exp-tree').on('tree.open', function(e) {
			var child = e.node.children;
			var tot_childs = e.node.children.length;
		       
			for (i = 0; i < tot_childs; i++) {
				let cnt_id = child[i].id.split("c-")[1];
				let is_loaded = child[i].content;
				let data;
				if (is_loaded == undefined) {
					getContentByID(cnt_id,child[i],function(response,obj){
						obj.content = response;
						obj.element.setAttribute("data-insert-html",response);
					});;
				}
				
			}
			console.log("Child contents loaded");

		});

		console.log($('.exp-tree').tree('getSelectedNode'));
	});

	//AJAX call with callback to returning specific contents by its ID
	function getContentByID(id,obj,cb) {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200 && this.response != "null") {
				var response = JSON.parse(this.response);
				if( typeof cb === 'function')
  			  	cb(response,obj);
			}
		};
		xhttp.open("GET", "AjaxController?service=get_contents&id="+id);
		xhttp.send();
	}
	
</script>
<script>
	/* function toggleevent(evt) {
		var allnodes_true = document.querySelectorAll('[contenteditable=true]');
		var allnodes_false = document
				.querySelectorAll('[contenteditable=false]');

		var nodes = "";
		var is_edit = "";

		if (allnodes_true.length > 0) {
			nodes = allnodes_true;
			is_edit = true;
			evt.target.textContent = "Enable ContentEditable";
		} else if (allnodes_false.length > 0) {
			nodes = allnodes_false;
			is_edit = false;
			evt.target.textContent = "Disable ContentEditable";
		}

		for (i = 0; i < nodes.length; i++) {
			if (is_edit) {
				nodes[i].contentEditable = "false";

			} else {
				nodes[i].contentEditable = "true";
			}

		}
	}

	function onDrop(event) {
		
		event.dataTransfer.clearData();

	}

	function onDragStart(event) {
		
		
		const dragging_node =  $('#exp-tree').tree('getNodeById', event.target.id);
		console.log(dragging_node);
				
             
		var newdiv_elem = document.createElement("DIV");
		newdiv_elem.innerHTML = dragging_node.content;
		newdiv_elem.className = "cnt_dragged";
		newdiv_elem.id = "cnt_dragged";
		
		event.dataTransfer.setData('text/html', newdiv_elem.outerHTML);

		//event.currentTarget.style.backgroundColor = 'yellow';

	}
	function onDragOver(event) {
		var get = event.dataTransfer.getData('text/html');
		
		event.preventDefault();
	} */

</script>
<body>
<!-- 	<button type="button" name="toggleContentEditable"
		onclick="toggleevent(event)">Disable Contenteditable</button> -->
	<div id="dragitemslistcontainer" class="exp-tree" style=""></div>
	<script src="preview/tree.jquery.js"></script>
</body>
</html>
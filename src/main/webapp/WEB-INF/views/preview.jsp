<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%String html = (String) session.getAttribute("content");%>
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
h1:hover, h2:hover, p:hover, img:hover {		
	background: #05f;
	opacity: 0.25;
}
ul, #myUL {
  list-style-type: none;
}

#myUL {
  margin: 0;
  padding: 0;
}

.caret {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret::before {
  content: "\25B6";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down::before {
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.nested {
  display: none;
}

.active {
  display: block;
}
/* end tree view styles */
.sidenav {
  height: 100%;
  width: 200px;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  padding-top: 20px;
}

.sidenav a {
  padding: 6px 6px 6px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
}

.sidenav a:hover {
  color: #f1f1f1;
}

.main {
  margin-left: 200px; /* Same as the width of the sidenav */
}
</style>
 
<!-- <script src="./assets/js/jquery-3.4.1.min.js"></script> -->
<script>
function close() {	
	window.history.back();
}
function add(){		
	var mousePosition;
	var offset = [0,0];
	var isDown = false;
		
	var dDiv = document.createElement('div');
	dDiv.id = 'block';
	dDiv.className = 'block';
	dDiv.innerHTML = "<h1>Hi I am your new Experience</h1><p>Coming to your page soon</p>";	
	document.getElementsByTagName('body')[0].appendChild(dDiv);
	
	dDiv.style.display = "block";
	dDiv.style.cursor = "move";
	dDiv.style.right = "300px";
	dDiv.style.top = "300px";
	dDiv.style.width = "500px";
	dDiv.style.height = "100px";	
	dDiv.style.position = "fixed";
	
	dDiv.addEventListener('mousedown', function(e) {
	    isDown = true;
	    offset = [
	    	dDiv.offsetLeft - e.clientX,
	    	dDiv.offsetTop - e.clientY
	    ];
	}, true);
	
	document.addEventListener('mouseup', function() {
	    isDown = false;		    
	    var parentPositionLeft = dDiv.getBoundingClientRect().left;
	    var parentPositionTop = dDiv.getBoundingClientRect().top;
	    //alert("parentPositionLeft: "+parentPositionLeft);
	    //alert("parentPositionTop: "+parentPositionTop);
	    dDiv.style.left = parentPositionLeft+'px';
	    dDiv.style.top = parentPositionTop+'px';
	    dDiv.style.position = "absolute";
        console.log(dDiv.style.left);      	
	    
	}, true);
	
	document.addEventListener('mousemove', function(event) {
	    event.preventDefault();
	    if (isDown) {
	        mousePosition = {	    
	            x : event.clientX,
	            y : event.clientY	    
	        };
	        dDiv.style.left = (mousePosition.x + offset[0]) + 'px';
	        dDiv.style.top  = (mousePosition.y + offset[1]) + 'px';	        
	    }	    	    	   
	}, true);	
}

function getStyle(el, styleProp) {
  var value, defaultView = (el.ownerDocument || document).defaultView;
  // W3C standard way:
  if (defaultView && defaultView.getComputedStyle) {
    // sanitize property name to css notation
    // (hypen separated words eg. font-Size)
    styleProp = styleProp.replace(/([A-Z])/g, "-$1").toLowerCase();
    return defaultView.getComputedStyle(el, null).getPropertyValue(styleProp);
  } else if (el.currentStyle) { // IE
    // sanitize property name to camelCase
    styleProp = styleProp.replace(/\-(\w)/g, function(str, letter) {
      return letter.toUpperCase();
    });
    value = el.currentStyle[styleProp];
    // convert other units to pixels on IE
    if (/^\d+(em|pt|%|ex)?$/i.test(value)) { 
      return (function(value) {
        var oldLeft = el.style.left, oldRsLeft = el.runtimeStyle.left;
        el.runtimeStyle.left = el.currentStyle.left;
        el.style.left = value || 0;
        value = el.style.pixelLeft + "px";
        el.style.left = oldLeft;
        el.runtimeStyle.left = oldRsLeft;
        return value;
      })(value);
    }
    return value;
  }
}
</script>


<div class="sidenav">
  <a href="#">About</a>
  <a href="#">Services</a>
  <a href="#">Clients</a>
  <a href="#">Contact</a>
  <ul id="myUL">
  <li><span class="caret">Beverages</span>
    <ul class="nested">
      <li>Water</li>
      <li>Coffee</li>

    </ul>
  </li>
</ul>
</div>


<div class="main">
   <%=html%>
</div>
<script>
var toggler = document.getElementsByClassName("caret");
var i;
debugger;
for (i = 0; i < toggler.length; i++) {
  toggler[i].addEventListener("click", function() {
    this.parentElement.querySelector(".nested").classList.toggle("active");
    this.classList.toggle("caret-down");
  });
}
</script>



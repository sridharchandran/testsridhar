<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%-- Comment testing commit by sremugaan --%>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<style>
body {
    background: url(http://www.magic4walls.com/wp-content/uploads/2014/05/minimalist-picture-bridge-river-dreaming-art-picture-landscape-sky.jpg)no-repeat;
}

.container {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: 327px;
}

.pic-container {
    float: left;
}

.parent {
    position: relative;
    width: 109px;
    height: 109px;
    margin: 0 auto;
}

.wrapper {
    width: 109px;
    height: 109px;
    cursor: pointer;
    position: absolute;
    overflow: hidden;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    transition-timing-function: cubic-bezier(0.4, 0.0, 0.2, 1);
    transition: transform 375ms, width 275ms 100ms, height 375ms;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
}

.wrapper.open {
    width: 330px;
    height: 330px;
    translate transition: transform 375ms, width 375ms, height 275ms 100ms;
}

.wrapper div.content {
    position: absolute;
    margin: auto;
    left: -9999px;
    right: -9999px;
    transform-origin: top;
    width: 330px;
    transform: scale(0.62);
    height: 330px;
    border-radius: 3px;
    background: #fff;
    overflow: hidden;
    transition: transform 375ms cubic-bezier(0.4, 0.0, 0.2, 1);
}

.wrapper.open .content {
    transform: scale(1);
}

.wrapper .img {
    height: 180px;
    background-size: cover;
    background-position: center;
}

.thumb-1 .img {
    background-image: url(http://i.imgur.com/UGQA9bu.jpg);
}

.thumb-2 .img {
    background-image: url(https://timesjourneys.files.wordpress.com/2015/11/day9-iran-shirkuh-timesjourneys2.jpg?w=1200&h=550&crop=1);
}

.thumb-3 .img {
    background-image: url(http://cdn-image.travelandleisure.com/sites/default/files/styles/tnl_redesign_article_landing_page/public/1453920892/DUBAI-554088081-ABOVE0116.jpg?itok=dcoZnCrc);
}

.text {
    padding: 30px;
}

.text .line {
    height: 13px;
    background: #999;
    opacity: 0.7;
    margin-top: 20px;
}

.title {
    width: 80%;
}

.subtitle {
    width: 60%;
}
	
</style>
<script type="text/javascript">
$(function() {
	  $('.wrapper').click(function() {
	      $('.wrapper').each(function() {
	         $(this).css('z-index', 0); 
	      });
	      	$(this).css('z-index', 10); 
	      	$(this).toggleClass('open');    
	  }) 
	})
function getImageURL(x)
{
    var imageID=x;
	var imageUrl=document.getElementById(imageID).src;
	document.getElementById("url").value = imageUrl;
}
</script>
<title>wem</title>
<!-- test comment -->
</head>
<body>

<div class="container-fluid">
	<h2>Select an image from the gallery</h2>
	<h4>Image URL: <input type="text" id="url" size="100"value=""></h4>
</div><!-- container-fluid -->

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<div class="container">

	<!-- h1 class="font-weight-light text-center text-lg-left mt-4 mb-0">Thumbnail Gallery</h1>
	<hr class="mt-2 mb-5">
	<div class="row text-center text-lg-left">
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image1" onclick="getImageURL('image1')" src="http://www.moneysmylife.com/wp-content/uploads/2016/08/Associated-Bank.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>  
	    <div class="col-lg-3 col-md-4 col-6">
	      	<a href="#" class="d-block mb-4 h-100">
				<img id="image2" onclick="getImageURL('image2')" src="http://cms.ipressroom.com.s3.amazonaws.com/231/files/20150/Assoc._Bank_Sanderson_Photography_GB_WI_08.jpg" class="img-fluid img-thumbnail"/>
	    	</a>
	    </div>
		<div class="col-lg-3 col-md-4 col-6">
	      <a href="#" class="d-block mb-4 h-100">
			<img id="image3" onclick="getImageURL('image3')" src="https://www.poblocki.com/wp-content/uploads/2017/04/associated-bank-exterior-sign-main.jpg" class="img-fluid  img-thumbnail" />
		  </a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image4" onclick="getImageURL('image4')" src="http://madisonregion.org/wp-content/uploads/2015/03/University-Express-Branch-e1426797585930.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image5" onclick="getImageURL('image5')" src="https://www.poblocki.com/wp-content/uploads/2017/04/associated-bank-exterior-sign-1.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image6" onclick="getImageURL('image6')" src="https://pbs.twimg.com/media/DNL5E-DXcAIXaB3.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		
		<div class="col-lg-3 col-md-4 col-6">
	      <a href="#" class="d-block mb-4 h-100">
			<img id="image7" onclick="getImageURL('image7')" src="https://www.bankcheckingsavings.com/wp-content/uploads/2016/06/Associated-Bank-Logo-B.png" class="img-fluid  img-thumbnail" />
		  </a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image8" onclick="getImageURL('image8')" src="http://www.billburmaster.com/lecentre/bank/images/assocmontgomeryil0113.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image9" onclick="getImageURL('image9')" src="https://s3-media4.fl.yelpcdn.com/bphoto/7IagS1cUCXC1nGrA8niOFQ/o.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image10" onclick="getImageURL('image10')" src="https://media.nbcchicago.com/images/1200*675/associated-bank-richmond-1.jpg" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image11" onclick="getImageURL('image11')" src="https://www.associatedbank.com/content/image/Packers_Debit_MasterCard_PPC" class="img-fluid  img-thumbnail" />
			</a>
		</div>
		<div class="col-lg-3 col-md-4 col-6">
			<a href="#" class="d-block mb-4 h-100">
				<img id="image12" onclick="getImageURL('image12')"  src="https://www.associatedbank.com/content/image/brewers-checking-debit-card-tilt" class="img-fluid  img-thumbnail" />
			<a href="#" class="d-block mb-4 h-100">
		</div>		
	</div> -->
	
	
	<!-- minimalistic -->
	
	<hr>
	<h1>Heading</h1>
		  <div class="container">
		    <div class="row">
		      <div class="pic-container">
		        <div class="parent">
		          <div class="wrapper thumb-1">
		            <div class="content">
		              <div class="img"></div>
		              <div class="text">
		                <div class="line title"></div>
		                <div class="line subtitle"></div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="pic-container">
		        <div class="parent">
		          <div class="wrapper thumb-2">
		            <div class="content">
		              <div class="img"></div>
		              <div class="text">
		                <div class="line title"></div>
		                <div class="line subtitle"></div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="pic-container">
		        <div class="parent">
		          <div class="wrapper thumb-3">
		            <div class="content">
		              <div class="img"></div>
		              <div class="text">
		                <div class="line title"></div>
		                <div class="line subtitle"></div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		    </div>
		  </div>
	
	
	<!-- minimalistic -->
	
	
	
	
</div>
	






</body>
</html>
<% String contextPath=request.getContextPath();%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Employee Availability</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Raleway:200" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Droid+Serif:700i" rel="stylesheet">
<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		getData();
	});
	
	function getData(){
		var x = new XMLHttpRequest();
	 	x.onreadystatechange = function() {
	 		if (x.readyState == 4 && x.status == 200) {
	 			var items = x.responseText.trim();
 				var htmldata='';
 				var image='';
	 			var availability='';
 				for(var i=0;i<items.split(",").length;i++){
 	 				var temp=items.split(",")[i].split("::");
 	 				
 	 				if(temp[2]=='M'){
 	 					if(temp[3]=='1'){
 	 						image='<div class="overlay available-class img-rounded"></div><img src="../../../../icons/avatar1.jpg" class="img-rounded">';
 	 	 				}
 	 	 				else if(temp[3]=='2'){
 	 	 					image='<div class="overlay busy-class img-rounded"></div><img src="../../../../icons/avatar1.jpg" class="img-rounded">';
 	 	 				}
 	 	 				else if(temp[3]=='3'){
 	 	 					image='<div class="overlay absent-class img-rounded"></div><img src="../../../../icons/avatar1.jpg" class="img-rounded">';
 	 	 				}
 	 				}
 	 				else{
 	 					if(temp[3]=='1'){
 	 						image='<div class="overlay available-class img-rounded"></div><img src="../../../../icons/avatar3.jpg" class="img-rounded">';
 	 	 				}
 	 	 				else if(temp[3]=='2'){
 	 	 					image='<div class="overlay busy-class img-rounded"></div><img src="../../../../icons/avatar3.jpg" class="img-rounded">';
 	 	 				}
 	 	 				else if(temp[3]=='3'){
 	 	 					image='<div class="overlay absent-class img-rounded"></div><img src="../../../../icons/avatar3.jpg" class="img-rounded">';
 	 	 				}
 	 				}
 	 				if(temp[3]=='1'){
 	 					availability='<div class="availability available-class">available</div>';
 	 				}
 	 				else if(temp[3]=='2'){
 	 					availability='<div class="availability busy-class">busy</div>';
 	 				}
 	 				else if(temp[3]=='3'){
 	 					availability='<div class="availability absent-class">absent</div>';
 	 				}
 	 				htmldata+='<div class="emp-container img-rounded">'+image+'<div class="emp-details"><h1>'+temp[0]+'</h1><p>'+temp[1]+'</p>'+availability+'</div></div>';
 	 			}
 	 			$('.container').append(htmldata);		
	 		
	 		} else {
	 			}
	 		}
	 		x.open("GET", "getEmployeeData.jsp", true);
	 		x.send();
	}
</script>
<style type="text/css">
	.emp-container .overlay{
        width: 100%;
        height: 100%;
        position: absolute;
        opacity: 0.3;
    }
	@keyframes jackInTheBox {
	    0% {
	        opacity: 0;
	        transform: scale(.1) rotate(30deg);
	        transform-origin: center bottom
	    }
	    50% {
	        transform: rotate(-10deg)
	    }
	    70% {
	        transform: rotate(3deg)
	    }
	    100% {
	        opacity: 1;
	        transform: scale(1)
	    }
	}
	
    .emp-container{
        width: 200px;
        height:300px;
        display: block;
        box-shadow: 0 19px 38px rgba(0,0,0,0.30), 0 15px 12px rgba(0,0,0,0.22);
        position: relative;
        margin-top: 30px;
        float: left;
        margin-right: 10px;
        margin-left: 10px;
        animation-name: jackInTheBox;
    	animation-duration:1s;
    }
    .emp-container img{
        width: 100%;
        height: 100%;
    }
	
    .emp-container .emp-details{
        position: absolute;
        bottom: 0;
        padding-left: 15px;
        padding-right: 15px;
        width: 100%;
    }
    .emp-details h1{
        font-family: 'Raleway', sans-serif;
        color: #000;
        font-size: 30px;
    }
    .emp-details p{
        font-family: 'Droid Serif', serif;
        color: #464746;
    }
    .emp-details .availability{
        padding: 15px 25px 15px 25px;
        text-transform: uppercase;
        color: #fff;
        width: 100%;
        font-weight: bold;
        letter-spacing: 3px;
        text-align: center;
        margin-bottom: 10px;
        border-radius: 25px;
    }
    .available-class{
        background: #56ab2f;  /* fallback for old browsers */
        background: -webkit-linear-gradient(to left, #a8e063, #56ab2f);  /* Chrome 10-25, Safari 5.1-6 */
        background: linear-gradient(to left, #a8e063, #56ab2f); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
    }
    .busy-class{
        background: #EB3349;  /* fallback for old browsers */
        background: -webkit-linear-gradient(to left, #F45C43, #EB3349);  /* Chrome 10-25, Safari 5.1-6 */
        background: linear-gradient(to left, #F45C43, #EB3349); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
    }
    .absent-class{
    	background: #000000;  /* fallback for old browsers */
		background: -webkit-linear-gradient(to left, #434343, #000000);  /* Chrome 10-25, Safari 5.1-6 */
		background: linear-gradient(to left, #434343, #000000); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
    	
    }
    .hidden-scrollbar {
   overflow: auto; 
  height: 560px;   
} 
</style>
</head>
<body>
<div class="hidden-scrollbar">
	<div class="container">
    </div>
	<br><br><br>
</div>

        
</body>
</html>
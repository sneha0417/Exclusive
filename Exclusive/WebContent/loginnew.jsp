
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html >
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/mystyle.css">
<link rel="shortcut icon" href="<%=contextPath+"/"%>gatelogo.ico" > 
<title>Gateway ERP(Integrated) Copyright &#169; 2017 GW INNOVATIONS Pvt Ltd</title>
<%-- <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script> --%>

<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/icon.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- <link href="https://fonts.googleapis.com/css?family=Raleway:200" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Droid+Serif:700i" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet"> -->
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:900" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css" />
<style type="text/css">

            body{
                width: 100%;
                height: 100%;
                color: #000;
                background-color: #F2F2F4;
                overflow: hidden;
            }
            .bg-svg{
                width: 100%;
                height: 100%;
            }
            svg{
                width: 100%;
                height: 100%;    
            }
            .vertical-login{
                
                position: absolute;
                top:120px;
                left:70px;
                /*transform: rotate(-90deg);*/
                text-align: center;
            }
            .login-text{
                text-transform: uppercase;
                color: #C8C8C8;
                font-family: 'Raleway', sans-serif;
                letter-spacing: 2px;
            }
            .login-line{
                display: inline-block;
                width: 0px;
                height:3px;
                background-color: #C8C8C8;
                margin-bottom:3px; 
                animation-name:showLine;
                animation-duration:1s;
                animation-delay: 1.5s;
                animation-fill-mode: forwards;
            }
            @keyframes showLine{
            from{
                width: 0px;
            }
            to{
                width: 80px;
            }
        }
            .block-login{
                position: absolute;
                z-index: -5;
                bottom: 10px;
                left: 5%;

            }
            .block-login h2{
                font-size: 18.5em;
                font-family: 'Raleway', sans-serif;
                text-transform: capitalize;
                color: #E1E1E1;
                text-shadow: -1px -1px 1px #111, 2px 2px 1px #363636;
                color: #E1E1E1;
  /*background-color: #2d2d2d;*/
text-shadow: -1px 5px 5px #d8d8d8, 2px 2px 1px #C8C8C8;
            
            }
            .login-container{
                width: 60%;
                height: 600px;
                background-color: #fff;
                box-shadow: 0 19px 38px rgba(0,0,0,0.30), 0 15px 12px rgba(0,0,0,0.22);
                position: absolute;
                display: block;
                z-index: 999;
                top: 20px;
                right: 20px;
                float: right;
                animation-delay: 0.2s;

            }
            .login-container .first,.login-container .second{
                height: 100%;
                float: left;

            }
            .first{
                width: 40%;
                padding-top: 10%;    
            }
            .second{
                width: 60%;
                background:url(icons/logincover4.jpg);
                background-size: cover;
                border-top-right-radius: 7px;
                border-bottom-right-radius: 7px;
            }
            .second .header-image{
                bottom: 0;
                position: absolute;
                padding-right: 10px;
                padding-left: 10px;
                margin-top: 30px;
                margin-bottom: 30px;
            }
            .second .header-image img{
                width: 50%;
                float: right;
                transition: all 0.5s ease-in;
                cursor: pointer;

            }
            .second .header-image img:hover{
                transform: scale(0.7);
            }
            .first .header-image{
                padding-right: 10px;
                padding-left: 10px;
            }
            .login-control-container{
                margin-left: 30px;
                margin-right: 30px;
            }
            .first .header-image img{

                float: right;
            }
            .rowgap{
                margin-bottom: 15px;
            }
            .forgotpwd-container,.btnlogin-container{
                display: inline-block;
            }
            .btnlogin-container{
                float: right;
            }
            
            .btnlogin{
                background-color: #4486D9;
                text-transform: uppercase;
                color: #fff;
                font-weight: bold;
                border-color: #4486D9;
                letter-spacing: 1px;
                box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
                padding-left: 18px;
                padding-right: 18px;
                transition: all 0.5s ease-in;
            }
            .forgotpwd-container{
                padding-top: 7px;
            }
            .forgotpwd{
                text-decoration: none;
                cursor: progress;
            }
            .forgotpwd:hover{
                text-decoration: none;   
            }
            .input-group-addon{
                background-color: #fff;
            }
            .input-group-addon i{
                color: #C8C8C8;
            }
            
            .btnlogin:hover,.btnlogin:active,.btnlogin:focus{
                background-color: #fff;
                border-color: #4486D9;
                color: #4486D9;

/*  
                background-color: #FF0000;
                border-color: #FF0000;
                color: #fff;*/
                
            }
            @keyframes slideInLeft {
              from {
                -webkit-transform: translate3d(-100%, 0, 0);
                transform: translate3d(-100%, 0, 0);
                opacity: 0;
              }

              to {
                -webkit-transform: translate3d(0, 0, 0);
                transform: translate3d(0, 0, 0);
                opacity: 1;
              }
            }

            @keyframes slideInRight {
              from {
                -webkit-transform: translate3d(100%, 0, 0);
                transform: translate3d(100%, 0, 0);
               opacity: 0;
              }

              to {
                -webkit-transform: translate3d(0, 0, 0);
                transform: translate3d(0, 0, 0);
                opacity: 1;
              }
            }
            
            
            .wizard-container{
                width: 450px;
                height: 250px;
                position: absolute;
                z-index: 9999;
                top: 50%;
                left: 50%;
                background-color: #fff;
                transform: translate(-50%,-50%);
                box-shadow: 0 19px 38px rgba(0,0,0,0.30), 0 15px 12px rgba(0,0,0,0.22);
                opacity: 0;          
                transition: all 0.25s ease-in; 
            }
            .wizard-container.active{
                opacity: 1;
            }
            .tabcontrols-container{
                width: 100%;
            }
            .tabcontrols-container .tab-control{
                width: 50%;
                float: left;
                transition: all 0.35s ease-in; 
                margin-bottom: 25px;
            }
            .tab-control.active{
                background-color: #2672E7;
                transform: scale(1.1);
                color: #fff;
                box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
            }
            .tab-content{
                width: 100%;
                display: none;
            }
            .btn-next{
                float: right;
                margin-top: 15px;
                margin-right: 15px;
                border-radius: 50%;
                transition: all 0.25s ease-in;
            }
            .btn-next:hover,.btn-next:active,.btn-next:hover,.btn-dismiss:hover,.btn-dismiss:active,.btn-dismiss:hover{
                background-color: #2672E7;
                border-color: #2672E7;
                color: #fff;
                box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
            }
            .btn-dismiss{
                margin-top: 15px;
                transition: all 0.25s ease-in;    
                text-transform: uppercase;
                padding-left: 20px;
                padding-right: 20px;
            }
            .instructions{
            	text-align:center;
            }
            .btnwizardclose-container{
            	float:right;
            	margin-right:15px;
            	margin-top:15px;
            	
            }
            .btnwizardclose-container a i{
            	color:#000;
            }
        </style>
</head>
<%-- <body background="icons/car.jpg" style="overflow:hidden;background-repeat: no-repeat;" autocomplete="off" onload="getComp();"> 
	<div class="content">
	   <form method="post" action="login" autocomplete="off">
		<table class="loginTable" border="0" align="center" cellpadding="10" cellspacing="0">
		<tr>
		    <td colspan="3"><select name="company" id="company" required="required" ></select></td>
		</tr>
		<tr>
		    <td width="150"><p style="margin-left:20px;">USERNAME</p></td>
			<td style="width:10px;">:</td>
			<td width="110"><input type="text" name="userid" value="" placeholder="Username" autofocus></td>
		</tr>
		<tr>
		    <td><p style="margin-left:20px;">PASSWORD</p></td>
			<td>:</td>
			<td><input type="password" name="password" value="" placeholder="Password"></td>
		</tr>
		<tr>
			<td colspan="3" style="text-align:center;"><input class="buttonStyle" type="submit" id="btnlogin" name="commit" value="Login"  onclick=""/></td>
		</tr>
	</table>
	<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
 
		</form>
	</div> --%>
<body  autocomplete="off" onload="getComp();">	
	<div class="outer-container">
            <div class="block-login">
                <h2></h2>
            </div>
            <div class="vertical-login">
                <span class="login-text"></span>
                <span class="login-line"></span>
            </div>
            <div class="bg-svg">
<?xml version="1.0" encoding="utf-8"?>
<!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
     viewBox="0 0 960 560" style="enable-background:new 0 0 960 560;" xml:space="preserve">
<style type="text/css">
    .st0{fill:none;stroke:#999999;stroke-miterlimit:10;opacity: 0;}
    .st1{fill:none;stroke:#FF0000;stroke-width:11;stroke-miterlimit:10;opacity: 0;}
    .st2{fill:none;stroke:#0000FF;stroke-width:11;stroke-miterlimit:10;opacity: 0;}
    .st3{fill:none;stroke:#C111B0;stroke-width:11;stroke-miterlimit:10;opacity: 0;}
</style>
<ellipse id="inner-circle" class="st0" cx="280.7" cy="267.5" rx="84.3" ry="83"/>
<ellipse id="middle-circle" class="st0" cx="280.7" cy="267.1" rx="166.3" ry="164.2"/>
<ellipse id="outer-circle" class="st0" cx="276.5" cy="267" rx="238.5" ry="242"/>
<ellipse id="outer-sub-circle" class="st1" cx="175.7" cy="47.9" rx="16.3" ry="16"/>
<ellipse id="middle-sub-circle" class="st2" cx="131" cy="338.6" rx="16.3" ry="16"/>
<ellipse id="inner-sub-circle" class="st3" cx="306.7" cy="192.9" rx="16.3" ry="16"/>
</svg>


            </div>
        </div>  

        <div class="login-container img-rounded animated slideInRight" style="animation-delay: 1s;">
            <div class="first">
                <div class="header-image">
                    <img src="icons/gwinnobanner.png" alt="" class="img-responsive animated flipInX" style="animation-delay: 1.5s;">
                </div>
                <div class="container-fluid login-control-container">
                	<form method="post" action="login" autocomplete="off">
	                    <div class="row rowgap">
	                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	                            <div class="input-group  login-group animated slideInRight" style="animation-delay: 1.2s;">
	                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
	                                <input id="username" type="text" class="form-control" name="userid" placeholder="Username" >
	                            </div>
	                        </div>
	                    </div>
	                    <div class="row rowgap">
	                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	                            <div class="input-group  login-group animated slideInLeft" style="animation-delay: 1.2s;">
	                                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
	                                <input id="password" type="password" class="form-control" name="password" placeholder="Password">
	                            </div>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	                            <div class="forgotpwd-container  login-group  animated fadeInDown" style="animation-delay: 1.2s;">
	                                <a class="forgotpwd" tabindex="-1">Forgot Password ?</a>
	                            </div>
	                            <div class="btnlogin-container login-group animated fadeInDown" style="animation-delay: 1.2s;">
	                                <button type="submit" class="btn btn-default btnlogin" id="btnlogin"><span>login</span></button>
	                            </div>
	                        </div>
	                    </div>
	                    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <select name="company" id="company" required="required" hidden="true"></select>
	                </form>
                </div>
            </div>
            <div class="second">
                <div class="header-image">
                    <img src="icons/gateway_logo.gif" alt="" class="img-responsive">
                </div>
            </div>
        </div>
        <div class="wizard-container img-rounded">
        	<span class="btnwizardclose-container"><a href="" class="btnwizardclose"><i class="fa fa-times"></i></a></span>
            <h3 class="text-center">Forgot Password Wizard</h3>
            <div class="tabcontrols-container">
                <button type="button" class="btn btn-default tab-control active" data-tab="step1" id="btnstep1">Step 1</button>
                <button type="button" class="btn btn-default tab-control" data-tab="step2" id="btnstep2">Step 2</button>
            </div>
            <div class="tab-content-container">
                <div class="tab-content" id="step1">
                    <div class="container-fluid" >
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <div class="form-group ">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                                        <input type="email" class="form-control" id="forgotemail" name="forgotemail" placeholder="Enter Email">    
                                    </div>
                                    <span class="glyphicon form-control-feedback"></span>
                                    <span class="help-block">&nbsp;</span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <button type="button" class="btn btn-default btn-next"><i class="fa fa-chevron-right"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-content" id="step2">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <p class="instructions"></p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <div class="text-center"><button type="button" class="btn btn-default btn-dismiss">dismiss</button></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%-- <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.2/TimelineMax.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.2/TweenMax.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lettering.js/0.7.0/jquery.lettering.min.js"></script> --%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/2.0.2/anime.min.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jquery.easyui.min.js"></script>
    <script type="text/javascript">
    	
    	$(document).ready(function(){

    		if($('#msg').val()!="" ) {
    			$.messager.alert('Login Failed',$('#msg').val());
    		}
    		
    		 $('body').keydown(function (evt) {
    			  if (evt.keyCode == 8) {
    				  var d = event.srcElement || event.target;
    			        if ((d.tagName.toUpperCase() === 'INPUT' && 
    			             (
    			                 d.type.toUpperCase() === 'TEXT' ||
    			                 d.type.toUpperCase() === 'PASSWORD' || 
    			                 d.type.toUpperCase() === 'FILE' || 
    			                 d.type.toUpperCase() === 'EMAIL' || 
    			                 d.type.toUpperCase() === 'SEARCH' || 
    			                 d.type.toUpperCase() === 'DATE' )
    			             ) || 
    			             d.tagName.toUpperCase() === 'TEXTAREA') {
    			            doPrevent = d.readOnly || d.disabled;
    			        }
    			        else {
    			            doPrevent = true;
    			        }
    			    }
    			    if (doPrevent) {
    			        event.preventDefault();
    				}
    		}); 

    		
    	    $("input").not($(":button")).keypress(function (evt) {
    	        if (evt.keyCode == 13) {
    	            iname = $(this).val();
    	            if (iname !== 'Submit') {
    	                var fields = $(this).parents('form:eq(0),body').find('button, input, textarea, select');
    	                var index = fields.index(this);
    	                if (index > -1 && (index + 1) < fields.length) {
    	                    fields.eq(index + 1).focus();
    	                }
    	                return false;
    	            }
    	        }
    	    });
    		
    		var theLetters = "abcdefghijklmnopqrstuvwxyz#%&^+=-"; //You can customize what letters it will cycle through
    		var ctnt = "Login"; // Your text goes here
    		var speed = 50; // ms per frame
    		var increment = 8; // frames per step. Must be >2

    		    
    		var clen = ctnt.length;       
    		var si = 0;
    		var stri = 0;
    		var block = "";
    		var fixed = "";
    		//Call self x times, whole function wrapped in setTimeout
    		(function rustle (i) {          
    		setTimeout(function () {
    		  if (--i){rustle(i);}
    		  nextFrame(i);
    		  si = si + 1;        
    		}, speed);
    		})(clen*increment+1); 
    		function nextFrame(pos){
    		  for (var i=0; i<clen-stri; i++) {
    		    //Random number
    		    var num = Math.floor(theLetters.length * Math.random());
    		    //Get random letter
    		    var letter = theLetters.charAt(num);
    		    block = block + letter;
    		  }
    		  if (si == (increment-1)){
    		    stri++;
    		  }
    		  if (si == increment){
    		  // Add a letter; 
    		  // every speed*10 ms
    		  fixed = fixed +  ctnt.charAt(stri - 1);
    		  si = 0;
    		  }
    		  $(".login-text").html(fixed + block);
    		  $(".block-login h2").html(fixed + block);
    		  
    		  block = "";
    		}
    		anime({
    			  targets: '#inner-circle',
    			  strokeDashoffset: [anime.setDashoffset, 0],
    			  opacity:1,
    			  duration: 5000,
    			  delay: 200
    		});
   			anime({
   			  targets: '#middle-circle,#inner-sub-circle',
   			  strokeDashoffset: [anime.setDashoffset, 0],
   			  opacity:1,
   			  duration: 5000,
   			  delay: 700
   			});
   			anime({
   			  targets: '#outer-circle,#middle-sub-circle',
   			  strokeDashoffset: [anime.setDashoffset, 0],
   			  opacity:1,
   			  duration: 5000,
   			  delay: 1200
   			});
   			anime({
   			  targets: '#outer-sub-circle',
   			  strokeDashoffset: [anime.setDashoffset, 0],
   			  opacity:1,
   			  duration: 5000,
   			  delay: 1700
   			});
   			$('.wizard-container').fadeOut();
   			$('.forgotpwd').click(function(){
   				$("#forgotemail").val('');
   				$('#btnstep2').removeClass('active');
   				$('#btnstep1').addClass('active');
   			    if($('.wizard-container').hasClass('active')){
   			        $('.wizard-container').fadeOut();
   			    }
   			    else{
   			    	$('#step2').fadeOut();
   	   				$('#step1').fadeIn();
   			    	$('.wizard-container').fadeIn();    
   			    }
   			    $('.wizard-container').toggleClass('active');
   			    
   			});
   			
   			$('.wizard-container').keyup(function(e){
   			    if (e.keyCode == 27) { 
   			        $(this).fadeOut();
   			    }
   			});
   			$('.btnwizardclose').click(function(){
   				$('.wizard-container').toggleClass('active');
   				$('.wizard-container').fadeOut('fast');
   				return false;
   			});
   			$('.btn-next').click(function(){
   			    var email = $("#forgotemail").val();
   			    if (validateEmail(email)) {
   			        if($('#step1 .form-group').hasClass('has-error has-feedback')){
   			            $('#step1 .form-group').removeClass('has-error has-feedback');   
   			            $('#step1 .form-group .form-control-feedback').removeClass('glyphicon-remove');
   			            $('.help-block').text("");
   			        }
   			     validateEmailDB(email);
   			    }
   			    else{
   			        $('#step1 .form-group').addClass('has-error has-feedback');
   			        $('#step1 .form-group .form-control-feedback').addClass('glyphicon-remove');
   			        $('.help-block').text("Please enter valid email");
   			    }
   			});

   			$('.btn-dismiss').click(function(){
   				$('.wizard-container').toggleClass('active');
   				$('.wizard-container').fadeOut('fast');
   				
   			});
    	});

    	   function validateEmail(email) {
               var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
               return re.test(email);
           }

           function validateEmailDB(email)
        	{ 
        	   var x=new XMLHttpRequest();
               x.onreadystatechange=function(){
                   if (x.readyState==4 && x.status==200)
                   {
                       items= x.responseText.trim();
                       if(items=="1"){
                    	   $('#step1').hide();
                    	   if($('#step1 .form-group').hasClass('has-error has-feedback')){
          			            $('#step1 .form-group').removeClass('has-error has-feedback');   
          			            $('#step1 .form-group .form-control-feedback').removeClass('glyphicon-remove');
          			            $('.help-block').text("");
          			        }
                    	   $('#btnstep1').removeClass('active');
                    	   $('#btnstep2').addClass('active');
                           
                           $('.instructions').text("The login credentials has been sent to the Email "+email+".Thank You");
                           $('#step2').fadeIn();
                       }
                       else{
                    	   $('#step1 .form-group').addClass('has-error has-feedback');
          			       $('#step1 .form-group .form-control-feedback').addClass('glyphicon-remove');
                           $('.help-block').text("We couldn't find any account related this email.Please enter valid email");
                       }
                       
                   }
               else
                   {
                   }
           }
           x.open("GET","checkForgotEmail.jsp?email="+email,true);
           x.send();
       
           }

           
    	function getComp()
    	{
	   		var x=new XMLHttpRequest();
	   		var items,cmpItems;
    		x.onreadystatechange=function(){
    	    	if (x.status == 500) {
    	        	chkcompany();
    		    }
    			if (x.readyState==4 && x.status==200)
    				{
    			        items= x.responseText;
    			        if(items.trim()=="NOTGET")
    			        	{
    			        	chkcompany();
    			        	return 0;
    			        	}
    			        else
    			        	{
	    			         items=items.split('####');
    				         var cmpItems = items[0].split(",");
    					     var cmpIdItems = items[1].split(",");
    			        	 var optionscmp = '';
    			       		 for ( var i = 0; i < cmpItems.length; i++) {
    			    	   		optionscmp += '<option value="' + cmpIdItems[i] + '">' + cmpItems[i] + '</option>';
    			        	 }
    			        	 $("select#company").html(optionscmp);
    			        	 
    			        	}
    				}
    			else
    				{
    				}
    		}
    		x.open("GET","getCompany.jsp",true);
    		x.send();
    	}

    	  function chkcompany()
    		{
    		 var company=$("#company").val();
    		 if(!(parseInt(company)>0))
    		 	{  
	    	       setInterval(function(){ 
			    		window.location.reload(true);
    			   }, 3000);
    			}
    			else
    				{
    				}
    		}
    </script>
</body>
</html>
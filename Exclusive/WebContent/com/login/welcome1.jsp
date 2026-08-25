<!DOCTYPE html >
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="<%=contextPath+"/"%>gatelogo.ico" > 
<title>Gateway ERP(Integrated)</title>
<style type="text/css">

 body {
    /* padding-left: 11em; */
    font-family: Tahoma,Georgia, "Times New Roman",Times, serif;
    color: black;
    }
 h1 {
    color: red;
    font-family: Raleway;/* Helvetica, Geneva, Arial,
          SunSans-Regular, sans-serif */ }
  ul.navbar {
    list-style-type: none;
    padding: 0;
    margin: 0;
    position: absolute;
    top: 2em;
    left: 1em;
    width: 9em }
 ul.navbar li {
    background: white;
    color: red;
    margin: 0.5em 0;
    padding: 0.3em;
    border-right: 1em solid black;
    cursor:pointer }
  ul.navbar a {
    text-decoration: none }
  a:link {
    color: red }
  a:visited {
    color: red }
 address {
    color: blue;
    margin-top: 1em;
    padding-top: 1em;
    /* border-top: thin dotted */
    text-shadow: #ccc 0 1px 0, #c9c9c9 0 2px 0, #bbb 0 3px 0, #b9b9b9 0 4px 0, #aaa 0 5px 0,rgba(0,0,0,.1) 0 6px 1px, rgba(0,0,0,.1) 0 0 5px, rgba(0,0,0,.3) 0 1px 3px, rgba(0,0,0,.15) 0 3px 5px, rgba(0,0,0,.2) 0 5px 10px, rgba(0,0,0,.2) 0 10px 10px, rgba(0,0,0,.1) 0 20px 20px;
    }
 
 .buttonWelcome{
    font-family: "Myriad Pro";
	font-weight: bold;
	font-size: 11px;
	color: white;
	background: #149BCC;
	border:none;
	padding:8px 4px;
	height:30px;
	width:100px;
	cursor:pointer;
	float: right;
}   
          
  
</style>
<script type="text/javascript">
	
	function openNewWindow()
	 {
	 var url=document.URL;
	     var reurl=url.split("login");
	     
	      var newWindow = window.open(reurl[0]+"login.jsp", "GatewayERP(i)",'resizable=0,scrollbars=0,'+
	       'menubar=0,location=no,directories=0,fullscreen=0,channelmode=1,titlebar=0,statusbar=0,addressbar=0,width=1366,height=768'); 
	       
	     if (window.focus) {newWindow.focus()}
	     return false;
	 }
	
</script>
</head>
<body background="<%=contextPath%>/icons/gatewaywelcome.png" style="overflow:hidden;background-repeat: no-repeat;">

 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
 <br><br><br><br><br><br><br><br><br><br><br>
 <input class="buttonWelcome" type="button" name="gateway" value="To Know More"  onclick="window.open('http://gatewayerp.com')"/>
 <input class="buttonWelcome" type="submit" name="commit" value="Login"  onclick="openNewWindow();"/>
 
 
<!-- Sign and date the page, it's only polite! -->
 <address><marquee>Business Process Management is essential to CONTROL & GROW</marquee></address>
</body>
</html>
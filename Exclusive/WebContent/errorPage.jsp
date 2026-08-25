<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<style type="text/css">
h1{
    margin-top:300px; 
    color: red;
    font-family: Raleway;/* Helvetica, Geneva, Arial,
          SunSans-Regular, sans-serif */
}

a:hover {
 cursor:pointer;
}

h1 {
  -moz-animation-duration: 400ms;
  -moz-animation-name: blink;
  -moz-animation-iteration-count: infinite;
  -moz-animation-direction: alternate;
  
  -webkit-animation-duration: 400ms;
  -webkit-animation-name: blink;
  -webkit-animation-iteration-count: infinite;
  -webkit-animation-direction: alternate;
  
  animation-duration: 400ms;
  animation-name: blink;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

@-moz-keyframes blink {
  from {
    opacity: 1;
  }
  
  to {
    opacity: 0;
  }
}

@-webkit-keyframes blink {
  from {
    opacity: 1;
  }
  
  to {
    opacity: 0;
  }
}

@keyframes blink {
  from {
    opacity: 1;
  }
  
  to {
    opacity: 0;
  }
}

</style>

</head>
<body background="<%=contextPath%>/icons/errorbg.jpg" style="overflow:hidden;background-repeat: no-repeat;">
<h1 align="center"><font color="blue">Something isn't quite right here.</font></h1>
<center>It has been reported to the Administrator.</center>
</body>
</html>
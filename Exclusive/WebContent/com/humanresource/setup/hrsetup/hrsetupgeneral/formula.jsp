<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">

/* body {
	font: 10px Tahoma;
	color: #404040;
	background: #E0ECF8;
	overflow:hidden;
} */

 
.closebtn {
 
	background-color:#e4685d;
	-moz-border-radius:8px;
	-webkit-border-radius:8px;
	border-radius:8px;
	border:1px solid #ffffff;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:3px 10px;
	text-decoration:none;
}
.closebtn:hover {
	background-color:#eb675e;
}
.closebtn:active {
	position:relative;
	top:1px;
}


 

 .okbtn {
	background-color:#44c767;
	-moz-border-radius:8px;
	-webkit-border-radius:8px;
	border-radius:8px;
	border:1px solid #ffffff;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:3px 10px;
	text-decoration:none;
}
.okbtn:hover {

	background-color:#5cbf2a;
}
.okbtn:active {
	position:relative;
	top:1px;
}


.myButtonEX {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7d5d3b), color-stop(1, #634b30));
	background:-moz-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:-webkit-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:-o-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:-ms-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:linear-gradient(to bottom, #7d5d3b 5%, #634b30 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7d5d3b', endColorstr='#634b30',GradientType=0);
	background-color:#7d5d3b;
	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	border-radius:3px;
	border:1px solid #54381e;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:2px 8px;
	text-decoration:none;
}
.myButtonEX:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #634b30), color-stop(1, #7d5d3b));
	background:-moz-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:-webkit-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:-o-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:-ms-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:linear-gradient(to bottom, #634b30 5%, #7d5d3b 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#634b30', endColorstr='#7d5d3b',GradientType=0);
	background-color:#634b30;
}
.myButtonEX:active {
	position:relative;
	top:1px;
}
#mysearch {
    background-color: #E0ECF8;
}
  #new
  {
  background-color: #E0ECF8;
  } 
  
  #expression {
  text-transform: uppercase;
}


#days{
    color: RED;
}

#years{
    color: RED;
}

 
#hrs{
    color: RED;
}


#nh{
    color: RED;
}


#basic{
    color: RED;
}

#amount{
    color: RED;
}
</style>
<% String id = request.getParameter("id")==null?"0":request.getParameter("id");%>
<script type="text/javascript">


$(document).ready(function () {    
	
	var ided='<%=id%>';
	document.getElementById("expression").value=document.getElementById(""+ided).value;
	
	$('#days').click(function(){
	 	 
		document.getElementById("desc").innerText=" No.of Days Within The Month";
	 		 
	}); 
	
	$('#years').click(function(){
	 	 
		document.getElementById("desc").innerText=" No.of Days Within The Year";
	 		 
	}); 
	
 
	$('#hrs').click(function(){
	 	 
		document.getElementById("desc").innerText=" Minimum Hours To Be Worked";
	 		 
	}); 
	
	 
	$('#nh').click(function(){
	 	 
		document.getElementById("desc").innerText=" Per Hour Rate";
	 		 
	}); 
	$('#basic').click(function(){
	 	 
		document.getElementById("desc").innerText=" Basic Salary";
	 		 
	}); 
	
	$('#amount').click(function(){
	 	 
		document.getElementById("desc").innerText=" Calculating Field Value (Salary/Allowance)";
	 		 
	}); 
	
	
	$('#closebtn').click(function(){
	 	 
		 $('#formulawindow').jqxWindow('close');
	 		 
	}); 
	
	
	
	$('#days').dblclick(function(){
	 	 
		setval("[DAYS]");
	 		 
	}); 
	
	$('#years').dblclick(function(){
	 	 
		setval("[YEARS]");
	 		 
	}); 
	
 
	$('#hrs').dblclick(function(){
	 	 
		setval("[HRS]");
	 		 
	}); 
	
	 
	$('#nh').dblclick(function(){
	 	 
		setval("[NH]");
	 		 
	}); 
	$('#basic').dblclick(function(){
	 	 
		setval("[BASIC]");
	 		 
	}); 
	
	$('#amount').dblclick(function(){
	 	 
		setval("[GROSS]");
	 		 
	}); 
	
	
	
	//-------------
	
//	a s m d ex equal less grater amp sep open close
	
	$('#a').click(function(){
	 	 
		setval("+");
	 		 
	}); 
	
	
	$('#s').click(function(){
	 	 
		setval("-");
	 		 
	}); 
	
	
	$('#m').click(function(){
	 	 
		setval("*");
	 		 
	}); 
	
	$('#d').click(function(){
	 	 
		setval("/");
	 		 
	}); 
	$('#ex').click(function(){
	 	 
		setval("!");
	 		 
	}); 
	$('#equal').click(function(){
	 	 
		setval("=");
	 		 
	}); 
	$('#less').click(function(){
	 	 
		setval("<");
	 		 
	}); 
	$('#grater').click(function(){
	 	 
		setval(">");
	 		 
	}); 
	$('#amp').click(function(){
	 	 
		setval("&");
	 		 
	});
	$('#sep').click(function(){
	 	 
		setval("|");
	 		 
	});
	$('#open').click(function(){
		setval("(");
		
	 		 
	});
	$('#close').click(function(){
		setval(")");
		
	 		 
	});
	$('#okbtn').click(function(){
	var ids='<%=id%>';
	
	///
	var no=document.getElementById("expression").value;
	
	  if(no.indexOf('+')== -1 && no.indexOf('-')== -1 && no.indexOf('*')== -1 &&  no.indexOf('/')== -1 &&  no.indexOf('!')== -1 &&  no.indexOf('=')== -1 &&  no.indexOf('<')== -1 &&  no.indexOf('>')== -1 &&  no.indexOf('|')== -1 &&  no.indexOf('&')== -1 &&  no.indexOf('(')== -1 &&  no.indexOf(')') == -1)
	{  
	  
	  document.getElementById("errormsg").innerText=" Not A Valid Expression	";
		document.getElementById("expression").focus();
		return 0;
	  
	}
	else
		{
		  document.getElementById("errormsg").innerText="";
		document.getElementById(""+ids).value="";
		document.getElementById(""+ids).value=document.getElementById("expression").value;
		 $('#formulawindow').jqxWindow('close');
		}
	
	});
});   




function setval(values)

{
	document.getElementById("expression").value=document.getElementById("expression").value+values;
}


 
</script>

</head>



<body >
<div  id="mysearch" >
<table   width="100%" >
<tr>
<td width="40%" >
<fieldset>
<legend>Fields-Double Click To Insert</legend>

<table width="100%" id="new">
<tr><td><input type="text"  style="border:0px;background-color: #E0ECF8 ";   name="days" id="days"  value="DAYS"  readonly="readonly" ></td></tr>
<tr><td><input type="text" style="border:0px ;background-color: #E0ECF8";  name="years" id="years"   value="YEARS"  readonly="readonly" ></td></tr>
<tr><td><input type="text" style="border:0px ;background-color: #E0ECF8";  name="hrs" id="hrs"   value="HRS"  readonly="readonly" ></td></tr>
<tr><td><input type="text" style="border:0px ;background-color: #E0ECF8";  name="nh" id="nh"  value="NH"  readonly="readonly" ></td></tr>
<tr><td><input type="text" style="border:0px ;background-color: #E0ECF8";  name="basic" id="basic"  value="BASIC"  readonly="readonly" ></td></tr>
<tr><td><input type="text" style="border:0px ;background-color: #E0ECF8";  name="amount" id="amount"   value="GROSS"  readonly="readonly" ></td></tr>
</table>

<br>
<br>
</fieldset>
</td>
<td width="60%">
<fieldset>
<legend>Expression</legend>
<table width="100%">
<tr><td><textarea id="expression" style="height:150px;width:300px;font: 15px Tahoma;resize:none; border:0px;" name="expression" onkeypress="if (this.value.length > 100) { return false; }"  ></textarea></td></tr>
</table>
</fieldset>


</td>

</tr>


</table>
<br>
<fieldset>                  
<table width="100%">
<tr><td  width="7%"><input  type="button" class="myButtonEX"   name="a" id="a"  value="+"  readonly="readonly" ></td> 
 <td  width="7%"><input type="button"   class="myButtonEX"    name="s" id="s"   value="-"  readonly="readonly" ></td> 
 <td  width="7%"><input type="button"   class="myButtonEX"   name="m" id="m"   value="*"  readonly="readonly" ></td> 
 <td  width="7%"><input type="button"  class="myButtonEX"    name="d" id="d"  value="/"  readonly="readonly" ></td> 
 <td  width="7%"><input type="button"    class="myButtonEX"   name="ex" id="ex"  value="!"  readonly="readonly" ></td> 
 <td  width="7%"><input type="button"   class="myButtonEX"    name="equal" id="equal"   value="="  readonly="readonly" ></td> 


 <td  width="7%"><input type="button"   class="myButtonEX"     name="less" id="less"   value="<"  readonly="readonly" ></td> 

 <td  width="7%"><input type="button"  class="myButtonEX"    name="grater" id="grater"   value=">"  readonly="readonly" ></td> 

 <td  width="7%"><input type="button"   class="myButtonEX"    name="amp" id="amp"   value="&"  readonly="readonly" ></td>  

 <td  width="7%"><input type="button"   class="myButtonEX"   name="sep" id="sep"   value="|"  readonly="readonly" ></td>

 <td  width="7%"><input type="button"   class="myButtonEX"   name="open" id="open"   value="("  readonly="readonly" ></td> 
 <td  width="7%"><input type="button"   class="myButtonEX"    name="close" id="close"   value=")"  readonly="readonly" ></td> 
 
 <td  width="2%">&nbsp;</td> 
 <td  width="8%"><input type="button" class="okbtn"   name="okbtn" id="okbtn"   value="OK"  readonly="readonly" ></td> 
 
 <td  width="8%"><input type="button"  class="closebtn"  name="closebtn" id="closebtn"   value="Close"  readonly="readonly" ></td></tr>
</table> 
</fieldset>
 <br>
&nbsp;&nbsp;&nbsp;<font size="2" color="#b22222" ><label id="desc" >&nbsp; </label> </font>
<br>
<br>
</div>
</body>
</html>
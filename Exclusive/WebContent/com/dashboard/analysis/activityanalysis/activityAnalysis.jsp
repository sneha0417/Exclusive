<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<style type="text/css">
 
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
</style>
<script type="text/javascript">
$(document).ready(function () {

	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	 $('#usersearch').jqxWindow({ width: '25%', height: '55%',  maxHeight: '85%' ,maxWidth: '30%' ,title: 'User Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#usersearch').jqxWindow('close');
	 $('#highLsearch').jqxWindow({ width: '25%', height: '55%',  maxHeight: '85%' ,maxWidth: '30%' ,title: 'HighLight Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#highLsearch').jqxWindow('close');
	       
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 $('#txthigh').dblclick(function(){
		   
    	 $('#highLsearch').jqxWindow('open');
         hlSearchContent('highLightSearch.jsp?', $('#highLsearch')); 
		   		
		 });
	 $('#txtuser').dblclick(function(){
		   
    	 $('#usersearch').jqxWindow('open');
    	 userSearchContent('userNameSearch.jsp?', $('#usersearch')); 
		   		
		 });
});
    function gethlinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#highLsearch').jqxWindow('open');
	  hlSearchContent('highLightSearch.jsp?', $('#highLsearch'));    }
	 else{
		 }
	 } 
    function hlSearchContent(url) {
          
       $.get(url).done(function (data) {
       $('#highLsearch').jqxWindow('setContent', data);
      }); 
     }
    
    
    function getuserinfo(event){
   	 var x= event.keyCode;
   	 if(x==114){
   	  $('#usersearch').jqxWindow('open');
   	 userSearchContent('userNameSearch.jsp?', $('#usersearch'));    }
   	 else{
   		 }
   	 } 
       function userSearchContent(url) {
             
          $.get(url).done(function (data) {
          $('#usersearch').jqxWindow('setContent', data);
         }); 
        }
    
    function funExportBtn(){
    	JSONToCSVCon(activityexcel, 'Activity Analysis', true);
	}
    function funreload()
    {
    	var userid=document.getElementById("txtuserid").value;
    	var highlight=document.getElementById("txthigh").value;
    	$("#Countgrid").load("countUsergrid.jsp?user="+userid+"&high="+highlight.replace(/ /g, "%20")+"&test="+1);
    		 
    }
	function funClearData(){
		
		 document.getElementById("txtuser").value="";
		 document.getElementById("txthigh").value="";
		 $("#activitygrid").jqxGrid('clear');
		 $("#jqxCount").jqxGrid('clear');
		 
	}
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
         <tr>
	      <td align="right"><label class="branch">User Name</label></td>
	      <td ><input style="height:19px;" type="text" name="txtuser" id="txtuser" value='<s:property value="txtuser"/>' onKeyDown="getuserinfo(event);" readonly placeholder="Press F3 to Search">
               <input type="hidden" id="txtuserid" name="txtuserid" value='<s:property value="txtuserid"/>'></td>
         </tr>      
           <tr>
	      <td align="right"><label class="branch">Highlight</label></td>
	      <td ><input style="height:19px;" type="text" name="txthigh" id="txthigh" value='<s:property value="txthigh"/>' onKeyDown="gethlinfo(event);" readonly placeholder="Press F3 to Search">
               <input type="hidden" id="txthighid" name="txthighid" value='<s:property value="txthighid"/>'></td>
         </tr>          
                    
          <tr>
	         <td colspan="2" ><div id="Countgrid"><jsp:include page="countUsergrid.jsp"></jsp:include>
	         </div></td>
	      </tr> 
	       <tr>
            <td align="center" colspan="2"><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></td>
          </tr>        
   </table>
	</fieldset>
</td>
<td width="80%">
    <table width="100%">
		<tr><div id="activitygrid1"><jsp:include page="activityGrid.jsp"></jsp:include></div></tr>
    </table>
</td>
</tr>
</table>
</div>
<div id="highLsearch">
   <div ></div>
</div>
<div id="usersearch">
   <div ></div>
</div> 
</div>
</body>
</html>
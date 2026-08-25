 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
 <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
<style>
/* .myButtons {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7d5d3b), color-stop(1, #634b30));
	background:-moz-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:-webkit-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:-o-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:-ms-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:linear-gradient(to bottom, #7d5d3b 5%, #634b30 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7d5d3b', endColorstr='#634b30',GradientType=0);
	background-color:#7d5d3b;
	-moz-border-radius:1px;
	-webkit-border-radius:1px;
	border-radius:1px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:3px 17px;
	text-decoration:none;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #634b30), color-stop(1, #7d5d3b));
	background:-moz-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:-webkit-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:-o-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:-ms-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:linear-gradient(to bottom, #634b30 5%, #7d5d3b 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#634b30', endColorstr='#7d5d3b',GradientType=0);
	background-color:#634b30;
}
.myButtons:active {
	position:relative;
	top:1px;
}
 */
 .myButtons {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7892c2), color-stop(1, #476e9e));
	background:-moz-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-webkit-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-o-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-ms-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7892c2', endColorstr='#476e9e',GradientType=0);
	background-color:#7892c2;
	border:1px solid #4e6096;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 7px;
	text-decoration:none;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #476e9e), color-stop(1, #7892c2));
	background:-moz-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-webkit-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-o-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-ms-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:linear-gradient(to bottom, #476e9e 5%, #7892c2 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#476e9e', endColorstr='#7892c2',GradientType=0);
	background-color:#476e9e;
}
.myButtons:active {
	position:relative;
	top:1px;
}      

        

</style>
	<script type="text/javascript">

	$(document).ready(function () { 
	    
		  /*  $("#datess").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); */ 
		   
	});   
		   
  	function loadSearchss() {
 		
 		var servtypes=document.getElementById("txtservtypes").value;
 		var id=1;
 		
 	
		getdatas(servtypes,id);
 

	}
	function getdatas(servtypes,id){
		
		    var sertypeids=document.getElementById("sertypeids").value;
		    
			 $("#refsearch").load('subsertypeSearch.jsp?sertype='+servtypes+'&sertypeid='+sertypeids+'&id='+id);
		

		}  
	
	
	function searchdata()
	{
		
		  var rows = $('#sertypeSearch').jqxGrid('getrows');
          var aa=0;
          var sid=0;
          for(var i=0 ; i < rows.length ; i++){
      	    
              if(rows[i].chk==true)
           	   
           	   {
           	   
           	  aa=1;
           	   
           	   }
               	    
               	   } 
          
          if(parseInt(aa)==0)
        	  {
        	  
        	  document.getElementById("errormsg").innerText="Choose at least one Service Type";
        		 

        		 return 0;
        	  }
           for(var i=0 ; i < rows.length ; i++){
        	 
    	   if(rows[i].chk==true)
        	   
    	   {
    		   sid=sid+rows[i].doc_no+",";
    	  
    	   }
        	    
        	   }
           $("#servtypeDetailsDiv").load("servtypeDetailsGrid.jsp?sid="+sid);
		 $('#sertypesearchwindow').jqxWindow('close'); 
		
	  }
	

	function funUpdate(){
	    var rows = $("#sertypeSearch").jqxGrid('selectedrowindexes');
	   var aid=0;
	   var sertypeids=document.getElementById("sertypeids").value;
	    var selectedRecords = new Array();
	    for (var m = 0; m < rows.length; m++) {
	    	
	        var row = $("#sertypeSearch").jqxGrid('getrowdata', rows[m]);
	        var rowlength=$("#servtypeDetailsGridID").jqxGrid('rows').records.length;
	        
	        if(rowlength==0)
	        {
	        $("#servtypeDetailsGridID").jqxGrid('addrow', null, {});
	        $('#servtypeDetailsGridID').jqxGrid('setcellvalue',m,"servtype",row.name);
	        $('#servtypeDetailsGridID').jqxGrid('setcellvalue',m,"doc_no",row.doc_no);
	        aid=aid+sertypeids+",";
	        aid=row.doc_no;
	       	}
	        else
	        	{
	        	var totrow=0;
	        	totrow=row.length+rowlength;
	        	var test=0;
	        	for (var n =rowlength;n < totrow; n++) {
	        		var rowspec = $("#servtypeDetailsGridID").jqxGrid('getrowdata',n);
	        		
	        		if((rowspec.doc_no==row.doc_no))
	        			{
	        			
	        				test=1;
	        				break;
	            		}
	        	}
	        	if(test==0){
	        		$("#servtypeDetailsGridID").jqxGrid('addrow', null, {});
	     	        $('#servtypeDetailsGridID').jqxGrid('setcellvalue',n,"servtype",row.name);
	     	        $('#servtypeDetailsGridID').jqxGrid('setcellvalue',n,"doc_no",row.doc_no);
	     	       aid=aid+sertypeids+",";
	     	       aid=aid+row.doc_no+",";
	        	}
	        	}
	        //aid=aid.replace(/,(?=[^,]*$)/, '');
	        selectedRecords[selectedRecords.length] = row;
	    }
	    
	    
	    document.getElementById("sertypeids").value=aid;
	    
	    $('#sertypesearchwindow').jqxWindow('close');
	    
	}
	
	
	
	

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
 
    </td>
  </tr>
  <tr>
  <td>
    
  <table width="100%" >
  
        <tr> 
       
            
    <td align="right" width="10%">Service Type</td>
    <td align="left" width="30%"><input type="text" name="txtservtypes" id="txtservtypes"  style="width:90%;" value='<s:property value="txtservtypes"/>'></td>
    <td align="center" width="22%" ><input type="button" name="searchss" id="searchss" class="myButton" value="Search"  onclick="loadSearchss()">
     <td align="right" width="22%" ><input type="button" name="searchs" id="searchs" class="myButtons" value="Submit"  onclick="funUpdate()">
     
</td>

 <%-- <tr>
 <td align="right" width="6%">Client </td>
 <td align="left" width="20%"><input type="text" name="clientname" id="clientname"  style="width:150%;" value='<s:property value="clientname"/>'></td>
 </tr> --%>
 

    </tr> 
    
    </table>

  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refsearch">
      
   <jsp:include  page="subsertypeSearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>
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
 		
 		var activity=document.getElementById("txtactivities").value;
 		var section=document.getElementById("txtsections").value;
 		var project=document.getElementById("txtprojects").value;
 		var id=1;
 		
 	
		getdatas(activity,section,project,id);
 

	}
	function getdatas(activity,section,project,id){
		
		    var activid=document.getElementById("activitiesid").value;
		    
			 $("#refsearch").load('subactivitysearch.jsp?activity='+activity+'&section='+section+'&project='+project+'&activid='+activid+'&id='+id);
		

		}  
	
	
	function searchdata()
	{
		
		  var rows = $('#activitySearch').jqxGrid('getrows');
          var pid="";
          var sid="";
          var aid="";
          var aa=0;
          for(var i=0 ; i < rows.length ; i++){
      	    
              if(rows[i].chk==true)
           	   
           	   {
           	   
           	  aa=1;
           	   
           	   }
               	    
               	   } 
          
          if(parseInt(aa)==0)
        	  {
        	  
        	  document.getElementById("errormsg").innerText="Choose at least one Activity";
        		 

        		 return 0;
        	  }
           for(var i=0 ; i < rows.length ; i++){
        	    
      /*  if(rows[i].chk==true)
    	   
    	   {
    	   
    	   if(i=0){
    		   pid=rows[i].projectid;
    		   sid=rows[i].sectionid;
    		   aid=rows[i].tr_no;
    	   }
    	   else{
    		
    	   pid=pid+","+rows[i].projectid;
    	   sid=sid+","+rows[i].sectionid;
    	   aid=aid+","+rows[i].tr_no;
    	   }
    	   } */
    	   
    	   
    	   if(rows[i].chk==true)
        	   
    	   {
    	  
    	   pid=pid+rows[i].projectid+",";
    	   sid=sid+rows[i].sectionid+",";
    	   aid=aid+rows[i].tr_no+",";
    	  
    	   }
        	    
        	   }
           $("#activityDetailsDiv").load("activityDetailsGrid.jsp?pid="+pid+"&sid="+sid+"&aid="+aid);
		 $('#activitysearchwindow').jqxWindow('close'); 
		// importsearchcontent('importoption.jsp');	
	     /*   $.messager.confirm('Message', 'Do you want to Import?', function(r){
	        	  
 		       
		        	if(r==false)
		        	  {
		        		$("#activityDetailsGridID").jqxGrid('clear');
		 			    $("#activityDetailsGridID").jqxGrid('addrow', null, {});
		        		return false; 
		        	  }
		        	else{
		       		  
		       		  $("#activityDetailsDiv").load("activityDetailsGrid.jsp?pid="+pid+"&sid="+sid+"&aid="+aid);	
		        		
		        		
		        		
		        	   }
     });  */ 
	      
	}
	

	function funUpdate(){
	    var rows = $("#activitySearch").jqxGrid('selectedrowindexes');
	   var aid=0;
	   var activeid=document.getElementById("activitiesid").value;
	    var selectedRecords = new Array();
	    for (var m = 0; m < rows.length; m++) {
	    	
	        var row = $("#activitySearch").jqxGrid('getrowdata', rows[m]);
	        var rowlength=$("#activityDetailsGridID").jqxGrid('rows').records.length;
	        
	        if(rowlength==0)
	        {
	        $("#activityDetailsGridID").jqxGrid('addrow', null, {});
	        $('#activityDetailsGridID').jqxGrid('setcellvalue',m,"activity",row.activity);
	        $('#activityDetailsGridID').jqxGrid('setcellvalue',m,"project",row.project);
	        $('#activityDetailsGridID').jqxGrid('setcellvalue',m,"section",row.section);
	        $('#activityDetailsGridID').jqxGrid('setcellvalue',m,"projectid",row.projectid);
	        $('#activityDetailsGridID').jqxGrid('setcellvalue',m,"sectionid",row.sectionid);
	        $('#activityDetailsGridID').jqxGrid('setcellvalue',m,"tr_no",row.tr_no);
	        aid=aid+activeid+",";
	        aid=row.tr_no;
	       	}
	        else
	        	{
	        	var totrow=0;
	        	totrow=row.length+rowlength;
	        	var test=0;
	        	for (var n =rowlength-1;n < totrow; n++) {
	        		var rowspec = $("#activityDetailsGridID").jqxGrid('getrowdata',n);
	        		
	        		if((rowspec.tr_no==row.tr_no))
	        			{
	        			
	        				test=1;
	        				break;
	            		}
	        	}
	        	if(test==0){
	        		$("#activityDetailsGridID").jqxGrid('addrow', null, {});
	     	        $('#activityDetailsGridID').jqxGrid('setcellvalue',n,"activity",row.activity);
	     	        $('#activityDetailsGridID').jqxGrid('setcellvalue',n,"project",row.project);
	     	        $('#activityDetailsGridID').jqxGrid('setcellvalue',n,"section",row.section);
	     	        $('#activityDetailsGridID').jqxGrid('setcellvalue',n,"projectid",row.projectid);
	     	        $('#activityDetailsGridID').jqxGrid('setcellvalue',n,"sectionid",row.sectionid);
	     	        $('#activityDetailsGridID').jqxGrid('setcellvalue',n,"tr_no",row.tr_no);
	     	       aid=aid+activeid+",";
	     	       aid=aid+row.tr_no+",";
	        	}
	        	}
	        
	        selectedRecords[selectedRecords.length] = row;
	    }
	    aid=aid.replace(/,(?=[^,]*$)/, '');
	    
	    document.getElementById("activitiesid").value=aid;
	    
	    $('#activitysearchwindow').jqxWindow('close');
	    
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
       
            
    <td align="right" width="6%">Activity</td>
    <td align="left" width="20%"><input type="text" name="txtactivities" id="txtactivities"  style="width:90%;" value='<s:property value="txtactivities"/>'></td>
          <td align="right" width="6%">Section</td>
    <td align="left" width="20%"><input type="text" name="txtsections" id="txtsections"  style="width:90%;" value='<s:property value="txtsections"/>'></td>  
         <td align="right" width="6%">Project</td>
    <td align="left" width="20%"><input type="text" name="txtprojects" id="txtprojects"  style="width:90%;" value='<s:property value="txtprojects"/>'></td>
    
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
      
   <jsp:include  page="subactivitysearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>
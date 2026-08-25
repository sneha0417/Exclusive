
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

.bicon {
    background-color: #ECF8E0;
	width: 1em;
	height: 1em;
	border: none;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	
	/* $('#loadsalikdata').hide();
	  $('#loadtrafficdata').hide(); */
	  pChange();
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#grpinfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Group' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#grpinfowindow').jqxWindow('close');
			
			$('#teaminfowindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Team' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#teaminfowindow').jqxWindow('close');
			
	   		
			 $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#areainfowindow').jqxWindow('close');
			
	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  
		  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			
		  
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(todates).setMonth(todates.getMonth()-1)); 
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
    
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
		 });
	 
    
     
     
     $('#txtgrpmember').dblclick(function(){
		   
    	 var id=2;
    	 
    	 if(id==1){
 			
			 assgnid=document.getElementById("sergroupid").value;
   	    }
       
		  $('#teaminfowindow').jqxWindow('open');
		 
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid+'&id='+id);
		   		
		 });
     
     
    
     //-----------------------------------------------------------------------
      $('#txtsergroup').dblclick(function(){
		   
    	 var id=1;
    	 $('#grpinfowindow').jqxWindow('open');
	      //grpSearchContent('servicegrpsearch.jsp');
    	 grpSearchContent('servicegrpsearch.jsp?id='+id);
		   		
		 });
     
     
     $('#txtsergrpemp').dblclick(function(){
		   
    	 var id=1;
    	 
    	 if(id==1){
 			
			 assgnid=document.getElementById("sergroupid").value;
   	    }
       
		  $('#teaminfowindow').jqxWindow('open');
		 
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid+'&id='+id);
		   		
		 });
     
     
     $('#txtassignarea').dblclick(function(){
		   
    	 $('#areainfowindow').jqxWindow('open');
	        areaSearchContent('area.jsp');
		   		
		 });
    
    //---------------------------------------------------------------------------
	  
});


function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientsearch1').jqxWindow('open');
	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
	 else{
		 }
	 } 
     function clientSearchContent(url) {
           
               $.get(url).done(function (data) {
  
	           $('#clientsearch1').jqxWindow('setContent', data);

    	}); 
         	}
     
     
     function getareas(event){
    	 var x= event.keyCode;
    	 if(x==114){
		  $('#areainfowindow').jqxWindow('open');
	        areaSearchContent('area.jsp');
	     	 }
     }
	     	 
	function areaSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#areainfowindow').jqxWindow('setContent', data);

	            	}); 
	  	}

	function funExportBtn(){
		
	  	   JSONToCSVCon(exceldata,'AssignJobFollowUp',true);
	  	 

	  }



function funreload()
{
	
     var id=1;
  
   
    if(id>0){
    	
    	countload(id);
    }
     
	}
	
	
function pChange(){
	 if(document.getElementById("priority").checked){
		 
		 document.getElementById("isprior").value=1;
		
	 }
	 else{
		 document.getElementById("isprior").value=0;
		
	 }
	 
	}
		

	 function countload(id){
		 
		 var clientid=$('#clientid').val();
		 var date=$('#todate').val();
		 var chkfromdate = $('#hidchckfromdate').val();
		 var fromdate = $('#fromdate').val();
		 var barchval = document.getElementById("cmbbranch").value;
		 var isprior=document.getElementById("isprior").value;
		 var bttnview=document.getElementById("bttnview").value;
		 var grp=document.getElementById("sergroupid").value;
		 var emp=document.getElementById("grpserempid").value;
		 var mem=document.getElementById("grpsermemberid").value;
		 var area=document.getElementById("txtareaid").value;
		
		 
		    $("#jqxloaddataGrid").jqxGrid('clear'); 
			$("#jqxSerCount").jqxGrid('clear');
			//$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
			
		 
$("#serCountgrid").load("serCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&isprior="+isprior+"&grp="+grp+"&emp="+emp+"&mem="+mem+"&area="+area+'&chkfromdate='+chkfromdate+'&fromdate='+fromdate+"&bttnview="+bttnview);
		
		
		 
	 }
	 
	 
	 function getgrpcode(event,id){
		 
		 var x= event.keyCode;
		 if(x==114){
		  $('#grpinfowindow').jqxWindow('open');
	      grpSearchContent('servicegrpsearch.jsp?id='+id);
	   	 }
		 else{
			 }
		 }
	   	 
	function grpSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#grpinfowindow').jqxWindow('setContent', data);

	          	}); 
		}
		
	function getteam(event,id){
		 var x= event.keyCode;
		 if(x==114){
			 var assgnid;
			 if(id==1){
        			
				 assgnid=document.getElementById("sergroupid").value;
       	    }
           
			 
		
		  $('#teaminfowindow').jqxWindow('open');
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid+'&id='+id);
	 	 }
		 else{
			 }
		 }
	 	 
	function teamSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#teaminfowindow').jqxWindow('setContent', data);

	        	}); 
		}	
	
	
     
	

	   
	   function funClear(){
			$("#jqxloaddataGrid").jqxGrid('clear'); 
			$("#jqxSerCount").jqxGrid('clear');
			//$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
			disablebtn();
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   
		   document.getElementById("txtsergroup").value="";
		   document.getElementById("sergroupid").value="0";
		   
		   document.getElementById("txtsergrpemp").value="";
		   document.getElementById("grpsermemberid").value="0";
		   document.getElementById("grpserempid").value="0";
		   
		   document.getElementById("txtassignarea").value="";
		   document.getElementById("txtareaid").value="0";
		   
		   $("#txtclient").attr("placeholder", "press F3 for Search");
		   $("#txtsergroup").attr("placeholder", "press F3 for Search");
		   $("#txtsergrpemp").attr("placeholder", "press F3 for Search");
		   $("#txtassignarea").attr("placeholder", "press F3 for Search");
		   document.getElementById("txtper").value="";
		   document.getElementById("rect").value="";
		   document.getElementById("txtdesc").value="";
		   document.getElementById("test").innerText="";
	   }
	   
	   
		  function funPrintBtn() {
				
			   
			    
	  }
		  function fromdatecheck(){
				 if(document.getElementById("chckfromdate").checked){
					 document.getElementById("hidchckfromdate").value = 1;
					 $('#fromdate').jqxDateTimeInput({ disabled: false});
				 }
				 else{
					 document.getElementById("hidchckfromdate").value = 0;
					 $('#fromdate').jqxDateTimeInput({ disabled: true});
				 }
			 }
		  function disablebtn()
			{
			  funselect();
				 $('#btnsave').attr("disabled",true);
				 $('#btnattach').attr("disabled",true);
				 $('#btnconfirm').attr("disabled",true);
				
			}
	function attach(){
		var fcode="SRVE";
		var fname="Sevice Report";
		 var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+fcode+"&docno="+document.getElementById("srdocno").value+"&brchid="+document.getElementById("srbrhid").value+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				  myWindow.focus();
		
	}
	function serviceview(){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	 items=items.split('###');
			 	 var res=items[0];
			 	
			 	if(res>0){             
			            
			 		document.getElementById("bttnview").value="1";
			   			
		    		
					  }
			 	else{
			 		document.getElementById("bttnview").value="0";
			 	}
			 	 
				}
		       else
			  {}
	     }
	      x.open("GET","checkview.jsp?",true);
	     x.send();
	    
	   }
	function save(event){   
		 var btnaction = event.target.id;
		var msg="Save";
		if(btnaction=="btnconfirm")
			{
		
			msg="Confirm";
			
			}
		 var txtsrtrno=$('#txtsrtrno').val();
		 var txtsrdocno =  $('#txtsrdocno').val();
		 var txtxper=$('#txtper').val();
		 var rect =  $('#rect').val();
		 var txtdesc = $('#txtdesc').val();
		 var rectval=0;
		if(txtxper==''){
			 $.messager.alert('Message','Please Enter Percentage','warning');
			 return 0;
		 }
		
		 if(rect>0){
			 if(txtdesc==''){
				 $.messager.alert('Message','Please Enter Description','warning');   
				 return 0;
			 }
			 rectval=1; 
		 }
		
		var txtcustomerdocno=document.getElementById("txtcustomerdocno").value;
			var txtcustomeracno=document.getElementById("txtcustomeracno").value;

			var cmbcontracttype=document.getElementById("cmbcontracttype").value;
			var txtcontracttrno=document.getElementById("txtcontracttrno").value;
			
			var txtsiteid=document.getElementById("txtsiteid").value;
			var txtareaid=document.getElementById("txtareaid").value;
			var txtscheduleno=document.getElementById("txtscheduleno").value;
			var servicetype=document.getElementById("servicetype").value;
		   $.messager.confirm('Confirm', 'Do you want to '+msg+' ? ', function(r){
	 			if (r){
	 				
	 			  		saveGridData(txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,txtsiteid,txtareaid,txtscheduleno,servicetype,txtxper,txtdesc,rectval,txtsrtrno,txtsrdocno,btnaction,msg);
						
						}
			 			
			 	 		});
		
		 
	}
	
		
	function saveGridData(txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,txtsiteid,txtareaid,txtscheduleno,servicetype,txtxper,txtdesc,rectval,txtsrtrno,txtsrdocno,btnaction,msg){
var msg12="Saved";
		if(msg=="Confirm")
	{
			msg12="Confirmed";
	}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				if(parseInt(items)==1)  
				{	
					 var rowindex=document.getElementById("rowindex").value;
		             $('#jqxloaddataGrid').jqxGrid('setcellvalue', rowindex, "gridrow",1);
		             $('#jqxloaddataGrid').jqxGrid('setcellvalue', rowindex, "workper",parseFloat($('#txtper').val()));
					 
				//	funselect();
					disablebtn();
					/*  document.getElementById("txtper").value="";
					   document.getElementById("rect").value="";
					   document.getElementById("txtdesc").value="";
					   document.getElementById("test").innerText="";
						$("#jqxSerCount").jqxGrid('clear');
						$("#jqxloaddataGrid").jqxGrid('clear'); */
				$.messager.alert('Message', msg12+' Successfully ');
			
				}
				else
				{
				$.messager.alert('Message', ' Not '+msg12);
				}
				}
		}
   x.open("GET","saveData.jsp?txtcustomerdocno="+txtcustomerdocno+"&txtcustomeracno="+txtcustomeracno+"&cmbcontracttype="+cmbcontracttype
		   +"&txtcontracttrno="+txtcontracttrno+"&txtsiteid="+txtsiteid+"&txtareaid="+txtareaid+"&txtscheduleno="+txtscheduleno
		   +"&servicetype="+servicetype+"&txtxper="+txtxper+"&txtdesc="+txtdesc+"&rectval="+rectval+"&txtsrtrno="+txtsrtrno+"&txtsrdocno="+txtsrdocno+"&btnaction="+btnaction,true);		
	x.send();
			
	}
	//msg=='Confirm'?'Not Confirmed ':'Not Saved '
			//msg=='Confirm'?'Confirmed Successfully ':'Saved Successfully '
					
					
					
	function funselect(){
		var rect =  $('#rect').val();
		if(rect=="1")
			{
			$('#txtdesc').attr("disabled",false);
			}
		else{
			document.getElementById("txtdesc").value ="";
			$('#txtdesc').attr("disabled",true);
		}
	}
	
	
</script>
</head>
<body onload="getBranch();disablebtn();fromdatecheck();serviceview();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" height="100%" >
<tr>
<td width="20%" style=" vertical-align: top;">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
<!-- <tr><td colspan="2">&nbsp;</td></tr> -->
<%--  <tr ><td colspan="2" ><input type="checkbox" id="chckfromdate" name="chckfromdate" value="" onchange="fromdatecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                 <input type="hidden" id="hidchckfromdate" name="hidchckfromdate" value='<s:property value="hidchckfromdate"/>'/></td></tr>
    --%>
 <tr>  <td align="right">
 <input type="checkbox" id="chckfromdate" name="chckfromdate" value="" onchange="fromdatecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                 <input type="hidden" id="hidchckfromdate" name="hidchckfromdate" value='<s:property value="hidchckfromdate"/>'/>
 
 <label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr>
     
     
	  <tr><td width="27%"  align="right" ><label class="branch">Upto</label></td><td width="73%" align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
   <tr>
	      <td align="right"><label class="branch">Client</label></td>
	      <td ><input style="height:19px;" type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'>
      <button type="button" class="bicon" id="clear" title="clear" onclick="funClear()"> 
							<img alt="clear" src="<%=contextPath%>/icons/clear.png">
						</button></td>
	      </tr>
	      <tr>
	      <td align="right"><label class="branch">Assign Group</label></td>
	      <td ><input style="height:19px;" type="text" name="txtsergroup" id="txtsergroup" value='<s:property value="txtsergroup"/>' onKeyDown="getgrpcode(event,1);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="sergroupid" name="sergroupid" value='<s:property value="sergroupid"/>'></td>
	      </tr>
	      
	 <tr>
	      <td align="right"><label class="branch">Group Member</label></td>
	      <td ><input style="height:19px;" type="text" name="txtsergrpemp" id="txtsergrpemp" value='<s:property value="txtsergrpemp"/>' onKeyDown="getteam(event,1);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="grpsermemberid" name="grpsermemberid" value='<s:property value="grpsermemberid"/>'>
      <input type="hidden" id="grpserempid" name="grpserempid" value='<s:property value="grpserempid"/>'>
      </td>
	      </tr>  
	      
	       <tr>
	      <td align="right"><label class="branch"> Area</label></td>
	      <td ><input style="height:19px;" type="text" name="txtassignarea" id="txtassignarea" value='<s:property value="txtassignarea"/>' onKeyDown="getareas(event);" readonly placeholder="Press F3 to Search">
	      <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'>
	      </td></tr>
	      <tr>
	     <td colspan="2"  align="center"><label class="branch">Priority</label>	        
	     <input type="checkbox" name="priority" id="priority" onchange="pChange();">
	     <button type="button" class="icon" id="btnPrint" hidden="true" title="Print current Document" onclick="funPrintBtn()">  
							<img alt="printDocument" src="<%=contextPath%>/icons/print_new.png">
						</button>
						</td>
       
	      
	      </tr>
	     <%--  <tr><td colspan="2" align="center">
			<button type="button" class="icon" id="btnPrint" title="Print current Document" onclick="funPrintBtn()">  
							<img alt="printDocument" src="<%=contextPath%>/icons/print_new.png">
						</button>
			</td></tr> --%>
	    <tr>
	<td colspan="2" ><div id="serCountgrid"><jsp:include page="serCountgrid.jsp"></jsp:include>
	</div></td>
	</tr> 
	 <tr>
		<td colspan="2" align="center">
		<!-- <fieldset> -->
		<label id="test"  class="branch" style="font-family: comic sans ms;font-weight: bold;color:blue;"></label>
		<!-- </fieldset> -->
		</td></tr>
	</table>
	
	<table >
	 
	<tr>
	      <td width="32%" align="right"><label class="branch">Percentage</label></td>
	      <td colspan="2" ><input style="height:19px;" type="text" name="txtper" id="txtper" value='<s:property value="txtper"/>' >
     </td>
	      </tr>
	      
	 <tr>
	      <td align="right"><label class="branch">Rectification</label></td>
	      <td colspan="2" ><select id="rect" name="rect" onChange="funselect();">
	      <option value="" selected>--SELECT--</option>
	      <option value="1">YES</option>
	      <option value="0">NO</option>
	      </select>
      </td>
	      </tr>  
	        
	      
	      <tr>
	      <td align="right"><label class="branch">Description</label></td>
	      <td colspan="2" ><input style="height:19px;width:180px;" type="text" name="txtdesc" id="txtdesc" value='<s:property value="txtdesc"/>'>
         </td>
	      </tr> 
	     
	     
	      
	       <tr>
	      <td></td>
	     <td colspan="2" align="left">&nbsp;&nbsp;&nbsp;<input type="button" name="btnsave" id="btnsave" class="myButton"
						value="Save" style="width: 80px;" onclick="save(event);" />
	      </td>
	      
	      </tr>    
	      <tr><td colspan="2"></td></tr>
	       <tr>
	      <td colspan="3" align="center">
	      <input type="button" name="btnattach" id="btnattach" class="myButton"
						value="Attach" style="width: 80px;" onclick="attach();" />
						&nbsp;
						<input type="button" name="btnconfirm" id="btnconfirm" class="myButton"
						value="Confirm" style="width: 80px;" onclick="save(event);" />
	      </td>
	    	      
	      </tr>    
	
	</table>
	
	<table>
	
	       
	       <tr>
	      
	      <td >
      <input type="hidden" id="assignid" name="assignid" value='<s:property value="assignid"/>'>
      <input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'>
      <input type="hidden" id="srno" name="srno" value='<s:property value="srno"/>'>
      <input type="hidden" id="dtype" name="dtype" value='<s:property value="dtype"/>'>
      <input type="hidden" id="isprior" name="isprior" value='<s:property value="isprior"/>'>
      <input type="hidden" id="rowindex" name="rowindex" value='<s:property value="rowindex"/>'>
      
      </td>
      
      
      <td >
      <input type="hidden" id="srdocno" name="srdocno" value='<s:property value="srdocno"/>'>
      <input type="hidden" id="srbrhid" name="srbrhid" value='<s:property value="srbrhid"/>'>
      
      <input type="hidden" id="txtcustomerdocno" name="txtcustomerdocno" value='<s:property value="txtcustomerdocno"/>'>
     <input type="hidden" id="txtcustomeracno" name="txtcustomeracno" value='<s:property value="txtcustomeracno"/>'>
     <input type="hidden" id="cmbcontracttype" name="cmbcontracttype" value='<s:property value="cmbcontracttype"/>'>
     <input type="hidden" id="txtcontracttrno" name="txtcontracttrno" value='<s:property value="txtcontracttrno"/>'>
     <input type="hidden" id="txtsiteid" name="txtsiteid" value='<s:property value="txtsiteid"/>'>
     <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'>
     <input type="hidden" id="txtscheduleno" name="txtscheduleno" value='<s:property value="txtscheduleno"/>'>
     <input type="hidden" id="servicetype" name="servicetype" value='<s:property value="servicetype"/>'>
     <input type="hidden" id="txtsrtrno" name="txtsrtrno" value='<s:property value="txtsrtrno"/>'>
     <input type="hidden" id="txtsrdocno" name="txtsrdocno" value='<s:property value="txtsrdocno"/>'>
     <input type="hidden" id="bttnview" name="bttnview" value='<s:property value="bttnview"/>'>
      
      
      </td>
	      </tr>  
	      
		
	<!-- <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> -->
	</table>
	</fieldset>

</td>
<td width="80" style=" vertical-align: top;">
	<table width="100%"  >
		<tr><td><div id="serschedulediv">
				<jsp:include page="serScheduleDetails.jsp"></jsp:include> 
			</div>
			<br/>
			</td>
			</tr>

	</table>
	</td>
</tr>
</table>
</div>
<div id="clientsearch1">
   <div ></div>
</div> 
<div id="grpinfowindow">
   <div ></div>
</div>
<div id="teaminfowindow">
   <div ></div>
</div>

<div id="areainfowindow">
   <div ></div>
</div>
</div>
</body>
</html>
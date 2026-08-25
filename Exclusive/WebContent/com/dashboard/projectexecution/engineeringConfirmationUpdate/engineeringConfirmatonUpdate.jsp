<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  


<style type="text/css">


.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
.hidden-scrollbar {
    overflow: auto;
    
    height: 550px;
}
</style>

<script type="text/javascript">



	$(document).ready(function () {
		
		
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		   $("#followupdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		   
		   $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			
			 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
			  
		     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		     $('#todate').on('change', function (event) {
					
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			
				   // out date
				 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
				 	 
				   if(fromdates>todates){
					   
					   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
					 
				   return false;
				  }})
		   
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#sidesearchwndow').jqxWindow({ width: '30%', height: '70%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 300, y: 0 }, keyboardCloseKey: 27});
			$('#sidesearchwndow').jqxWindow('close'); 
			 $('#servicetypewindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#servicetypewindow').jqxWindow('close');
			  $('#sitewindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '60%' ,maxWidth: '80%' ,title: ' Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#sitewindow').jqxWindow('close');

	});
	
	 function productSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#sidesearchwndow').jqxWindow('open');
      		$('#sidesearchwndow').jqxWindow('setContent', data);
      
      	}); 
      } 
	
	
	 
	function getservicetype(rowBoundIndex){
		 
		  $('#servicetypewindow').jqxWindow('open');

	        serviceSearchContent('servicesearch.jsp?rowBoundIndex='+rowBoundIndex);
	     	 }
	     	 
	function serviceSearchContent(url) {
	
		 $.get(url).done(function (data) {
			
	$('#servicetypewindow').jqxWindow('setContent', data);

	            	}); 
	  	}
	function getsite(rowBoundIndex,reftrno,id){
		 
		  $('#sitewindow').jqxWindow('open');
	  var reftype="ENQ";
	 // $('#accountWindow').jqxWindow('focus');
	        siteSearchContent("sitesearch.jsp?rowBoundIndex="+rowBoundIndex+"&reftrno="+reftrno+"&id="+id+"&reftype="+reftype);
	     	 }
	     	 
	function siteSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#sitewindow').jqxWindow('setContent', data);

	            	}); 
	  	}
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim()+'">'
					+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	
	function disable(){
		 
		
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
		
		 $("#engconfirmsubgrid").jqxGrid('clear');
		 $("#engconfirmsubgrid").jqxGrid("addrow", null, {}); 
		 $("#engconfirmsubgrid").jqxGrid({ disabled: true});
		 
		 $("#materialEstPriceGrid").jqxGrid('clear');
		 $("#materialEstPriceGrid").jqxGrid("addrow", null, {}); 
		 $("#materialEstPriceGrid").jqxGrid({ disabled: true});
	}
	
	
	function funreload(event){
		disable();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var branchval = document.getElementById("cmbbranch").value;
		 var chkfollowup = $('#hidchckfollowup').val();
		 var followupdate = $('#followupdate').val();
		
		 $("#overlay, #PleaseWait").show();  
		 $("#engConfirmDiv").load("engineeringConfirmationGrid.jsp?branchval="+branchval+"&followupdate="+followupdate+'&fromdate='+fromdate+'&todate='+todate+"&chkfollowup="+chkfollowup+"&check=1");
	}
	
	function funUpdate(event){ 
	    var gridarray=new Array();    
		$("#materialEstPriceGrid").jqxGrid('clearfilters');
		
		 var rdocno=$('#txtrdocno').val();
		 var date =  $('#date').val();
		 var remarks = $('#txtremarks').val();
	     var proid=$('#cmbprocess').val();
	     //alert(proid);
	   
		 var branchid =$("#txtbrchid").val(); 
		 var userid=$("#txtuserid").val(); 
		 var contracttrno=$("#hidcontracttrno").val(); 
		if(proid==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }
		
		if(proid==3 || proid==4){
		var rows1 = $("#materialEstPriceGrid").jqxGrid('getrows');
	    
	  	//document.getElementById("errormsg").innerText="";

	  	 $('#estimationgrdlen').val(rows1.length);
	  	 
	  	 for(var i=0 ; i < rows1.length ; i++){
	  	        $('#hiddesc').val(rows1[i].desc1);
			    if (($(hiddesc).val()).includes('$')) { $(hiddesc).val($(hiddesc).val().replace(/$/g, ''));};if (($(hiddesc).val()).includes('%')) { $(hiddesc).val($(hiddesc).val().replace(/%/g, ''));};
		    	if (($(hiddesc).val()).includes('^')) { $(hiddesc).val($(hiddesc).val().replace(/^/g, ''));};if (($(hiddesc).val()).includes('`')) { $(hiddesc).val($(hiddesc).val().replace(/`/g, ''));};
		    	if (($(hiddesc).val()).includes('~')) { $(hiddesc).val($(hiddesc).val().replace(/~/g, ''));};if ($(hiddesc).val().indexOf('\'')  >= 0 ) { $(hiddesc).val($(hiddesc).val().replace(/'/g, ''));};
		    	if (($(hiddesc).val()).includes(',')) { $(hiddesc).val($(hiddesc).val().replace(/,/g, ''));}
		    	if ($(hiddesc).val().indexOf('"') >= 0) { $(hiddesc).val($(hiddesc).val().replace(/["']/g, ''));};
		    	if (($(hiddesc).val()).match(/\\/g)) { $(hiddesc).val($(hiddesc).val().replace(/\\/g, ''));};     
	  		  
	  	  		    gridarray.push($(hiddesc).val()+" :: "+rows1[i].prodoc+" :: "+rows1[i].psrno+" :: "+rows1[i].unitdocno+" :: "+rows1[i].qty+" :: "+
	  	  				   rows1[i].amount+" :: "+rows1[i].total+" :: "+rows1[i].margin+" :: "+rows1[i].nettotal+" :: "+rows1[i].activityid+" :: "+
	  	  				   rows1[i].site+" :: "+rows1[i].stypeid+" :: "+rows1[i].sitesrno+" :: ");
	  		  $('#hiddesc').val('');     
	  				}	
	 
		

	
          }


		 if(remarks==''){
			 $.messager.alert('Message','Please Enter Remarks.','warning');   
			 return 0;
		 }
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		
		     		saveGridData(rdocno,date,remarks,proid,branchid,userid,contracttrno,gridarray);	
		     	}
		});
	 
		 
	}
	
	function followupcheck(){
		 if(document.getElementById("chckfollowup").checked){
			 document.getElementById("hidchckfollowup").value = 1; 
			
			 $('#followupdate').jqxDateTimeInput({ disabled: false});
			 $('#fromdate').jqxDateTimeInput({ disabled: true});
			 $('#todate').jqxDateTimeInput({ disabled: true});
		 }
		 else{
			 document.getElementById("hidchckfollowup").value = 0;
			 $('#followupdate').jqxDateTimeInput({ disabled: true});
			 $('#fromdate').jqxDateTimeInput({ disabled: false});
			 $('#todate').jqxDateTimeInput({ disabled: false});
		 }
	 }
		
	function saveGridData(rdocno,date,remarks,proid,branchid,userid,contracttrno,gridarray){

		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				if(parseInt(items)==1)  
				{	
				 $('#cmbprocess').val('');
				$('#date').val(new Date());
				$('#txtbrchid').val('');
				$('#txtremarks').val('');
				$('#txtrdocno').val('');
				$('#txtcldocno').val('');
				$('#txtuserid').val('');
				$('#hidcontracttrno').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ');
			//	funreload(event); 
				disable();
				}
				else
				{
				$.messager.alert('Message', '  Not Updated  ');
				}
				}
		}
		
    x.open("GET","saveData.jsp?trdocno="+rdocno+"&fldate="+date+"&remark="+remarks+"&bibpid="+proid+"&brchid="+branchid+"&userid="+userid+"&contracttrno="+contracttrno+"&productarray="+gridarray,true);			
	x.send();
			
	}
	   function setValues(){

			 if($('#msg').val()!=""){
				 
	   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	   		  }
		}
	   
	   
	   function funExportBtn(){
		   JSONToCSVCon(loadSubGridDataexcel, 'EngineeringConformation1', true);
			JSONToCSVCon(engineeringconfexcel, 'EngineeringConformation', true);
		}
	   
	   /* function JSONToCSVCon1(JSONData, ReportTitle, ShowLabel) {

		    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
		    
		   // alert("arrData");
		    var CSV = '';    
		    //Set Report title in first row or line
		    
		    CSV += ReportTitle + '\r\n\n';

		    //This condition will generate the Label/Header
		    if (ShowLabel) {
		        var row = "";
		        
		        //This loop will extract the label from 1st index of on array
		        for (var index in arrData[0]) {
		            
		            //Now convert each value to string and comma-seprated
		            row += index + ',';
		        }

		        row = row.slice(0, -1);
		        
		        //append Label row with line break
		        CSV += row + '\r\n';
		    }
		    
		    //1st loop is to extract each row
		    for (var i = 0; i < arrData.length; i++) {
		        var row = "";
		        
		        //2nd loop will extract each column and convert it in string comma-seprated
		        for (var index in arrData[i]) {
		            row += '"' + arrData[i][index] + '",';
		        }

		        row.slice(0, row.length - 1);
		        
		        //add a line break after each row
		        CSV += row + '\r\n';
		    }

		    if (CSV == '') {        
		        alert("Invalid data");
		        return;
		    }   
		    
		    //Generate a file name
		    var fileName = "";
		    //this will remove the blank-spaces from the title and replace it with an underscore
		    fileName += ReportTitle.replace(/ /g,"_");   
		    
		    //Initialize file format you want csv or xls
		    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
		    
		    // Now the little tricky part.
		    // you can use either>> window.open(uri);
		    // but this will not work in some browsers
		    // or you will not get the correct file extension    
		    
		    //this trick will generate a temp <a /> tag
		    var link = document.createElement("a");    
		    link.href = uri;
		    
		    //set the visibility hidden so it will not effect on your web-layout
		    link.style = "visibility:hidden";
		    link.download = fileName + ".csv";
		    
		    //this part will append the anchor tag and remove it after automatic click
		    document.body.appendChild(link);
		    link.click();
		    document.body.removeChild(link);
		} */
		
</script>
</head>
<body onload="getBranch();getProcess();disable();followupcheck();setValues();">
<form id="frmconfirm" action="savedetails" method="post" autocomplete="off">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td colspan="2"></td></tr>
	 <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>                 
	 
     <tr><td colspan="2"><input type="checkbox" id="chckfollowup" name="chckfollowup" value="" onchange="followupcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                 <input type="hidden" id="hidchckfollowup" name="hidchckfollowup" value='<s:property value="hidchckfollowup"/>'/></td></tr>
     <tr><td align="right"><label class="branch">FollowUp</label></td>
     <td align="left"><div id="followupdate" name="followupdate" value='<s:property value="followupdate"/>'></div></td></tr>
     
	 <tr><td colspan="2">&nbsp;</td></tr> 
	  <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td align="right"><label class="branch">Process</label></td>
	  <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:40%;" name="cmbprocess"  value='<s:property value="cmbprocess"/>'></select></td></tr>
	 
	
	 <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td></tr>
     <tr><td align="right"><label class="branch">Remarks</label></td>
	 <td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
	 <tr><td colspan="2"></td></tr>
	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
	 <tr><td colspan="2">
	 	<input type="text" name="gridtext" id="gridtext" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext1"/>' />
	 </td></tr>
	<tr><td colspan="2"></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2"></td></tr>
	 <tr><td colspan="2">
	 <input type="hidden" id="txtdocno" name="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <input type="hidden" id="txtsalid" name="txtsalid" style="width:100%;height:20px;" value='<s:property value="txtsalid"/>'/>
     <input type="hidden" id="txtrdocno" name="txtrdocno" style="width:100%;height:20px;" value='<s:property value="txtrdocno"/>'/>
     <input type="hidden" id="txtbrchid" name="txtbrchid" style="width:100%;height:20px;" value='<s:property value="txtbrchid"/>'/>
     <input type="hidden" id="txtuserid" name="txtuserid" style="width:100%;height:20px;" value='<s:property value="txtuserid"/>'/>
     <input type="hidden" id="txtnettotal" name="txtnettotal" style="width:100%;height:20px;" value='<s:property value="txtnettotal"/>'/> 
     <input type="hidden" id="txtmatotal" name="txtmatotal" style="width:100%;height:20px;" value='<s:property value="txtmatotal"/>'/> 
       <input type="hidden" id="hidsurtrno" name="hidsurtrno" value='<s:property value="hidsurtrno"/>' />
  <input type="hidden" id="hidenqtrno" name="hidenqtrno" value='<s:property value="hidenqtrno"/>' />
  <input type="hidden" id="hiddesc" name="hiddesc" value='<s:property value="hiddesc"/>' />
  <input type="hidden" id="estimationgrdlen" name="estimationgrdlen" style="width:100%;height:20px;" value='<s:property value="estimationgrdlen"/>'/>
  
  
  <input type="hidden" id="hidcontracttrno" name="hidcontracttrno" value='<s:property value="hidcontracttrno"/>' />
  <input type="hidden" id="productchk" name="productchk"  value='<s:property value="productchk"/>' />  
 
     </td></tr> 
	 </table>
	</fieldset>
</td>
<td width="80%" class='hidden-scrollbar'>
	<table width="100%">
		<tr><td><div id="engConfirmDiv"><jsp:include page="engineeringConfirmationGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td>
	
		
		<div id="EstDiv"><jsp:include page="EstDetailGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="detailDiv"><jsp:include page="engineeringConfirmationSubGrid.jsp"></jsp:include></div></td></tr>
	</table>
	</td>
</tr>
</table>
</div>
<div id="sidesearchwndow">
   <div ></div> 
</div>
<div id="servicetypewindow">
   <div ></div>
</div>
<div id="sitewindow">
   <div ></div>
</div>
</div> 
</form>
</body>
</html>
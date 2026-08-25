<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
$(document).ready(function () {
	   $("body").prepend('<div id="overlay1" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait1' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
		
			<%String main2=request.getParameter("main")==null?"":request.getParameter("main");%>
			<%String name2=request.getParameter("name")==null?"":request.getParameter("name");%>
			<%String docno=request.getParameter("docno")==null?"":request.getParameter("docno");%>
			
			if($('#detailname').val()==""){
				document.getElementById("lbldetailname").innerText='<%=name2%>';
				document.getElementById("lbldetail").innerText='<%=main2.equalsIgnoreCase("0")?"Project":main2%>';
				$('#detailname').val(document.getElementById("lbldetail").innerText);
				document.getElementById("txtdetailpermissiondocno").value='<%=docno%>';
			}
			else{
				document.getElementById("lbldetailname").innerText=$('#detailname').val();
				document.getElementById("lbldetail").innerText=$('#detail').val();
				document.getElementById("txtdetailpermissiondocno").value='<%=docno%>';
			}
			 
			$('#windowattach').jqxWindow({width: '51%', height: '61%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Attach',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
			$('#windowattach').jqxWindow('close');
			
			$('#windowguideline').jqxWindow({width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Guideline',position: { x: 280, y: 10 } , theme: 'energyblue', showCloseButton: true, showCollapseButton: true});
			$('#windowguideline').jqxWindow('close');
			    
		    $("input").click(function (evt) {
				this.placeholder = '' ;
			});
			
			funChkHeaderButton();
});
function funDateInPeriod(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
    if(value<styear || value>edyear){
    	$.messager.alert('Warning',"Transaction prior or after Account Period is not valid.");
     $('#txtvalidation').val(1);
     return 0;
    }
     if(value>currentDate){
    	 $.messager.alert('Warning',"Future Date, Transaction Restricted. ");
     $('#txtvalidation').val(1);
     return 0;
    } 
    if(value<=mclose){
    	$.messager.alert('Warning',"Closing Done, Transaction Restricted. ");
     	$('#txtvalidation').val(1);
     	return 0;
    }
    var tempdtype=document.getElementById("lbldetailname").innerText;
     var taxDate=new Date(window.parent.taxdateval.value);
     taxDate.setHours(0,0,0,0);
    if(tempdtype=='Invoice Processing'){
    	if(value<=taxDate){
    		$.messager.alert('Warning',"Tax Closing Done, Transaction Restricted. ");
	        $('#txtvalidation').val(1);
	        return 0;
	       }
 	   }
    
    
    $('#txtvalidation').val(0);
     return 1;
 }
 
function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {

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
    
	 // newly added 
    var temp = CSV;
    blob = new Blob([temp],{type: 'text/csv'});
    var bigcsv= window.webkitURL.createObjectURL(blob);
   
	
    //Initialize file format you want csv or xls
  //  var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
    
    // Now the little tricky part.
    // you can use either>> window.open(uri);
    // but this will not work in some browsers
    // or you will not get the correct file extension    
    
    //this trick will generate a temp <a /> tag
    var link = document.createElement("a");    
     //  link.href = uri;
      link.href = bigcsv;
    
    //set the visibility hidden so it will not effect on your web-layout
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";
    
    //this part will append the anchor tag and remove it after automatic click
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

function JSONToSIFCon(JSONData,ReportTitle, ShowLabel) {
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    
    var SIF = '';    

    for (var i = 0; i < arrData.length; i++) {
    	
    	var row = "";
        
        for (var index in arrData[i]) {
            row += '' + arrData[i][index] + ',';
        }

        row.slice(0, row.length - 1);
        
        SIF += row.slice(0, -1) + '\r\n';
    
    }

    if (SIF == '') {        
        alert("Invalid data");
        return;
    }   
    
    var fileName = "";
    fileName += ReportTitle.replace(/ /g,"_");   
    
    var uri = 'data:text/csv;charset=utf-8,' + escape(SIF);
    var link = document.createElement("a");    
    link.href = uri;
    
    link.style = "visibility:hidden";
    link.download = fileName + ".sif";
    
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

 function funDateInPeriodNew(value){
	//Date Validation Method without Future date Validation
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
    if(value<styear || value>edyear){
    	$.messager.alert('Warning',"Transaction prior or after Account Period is not valid.");
     $('#txtvalidation').val(1);
     return 0;
    }
    
    if(value<=mclose){
    	$.messager.alert('Warning',"Closing Done, Transaction Restricted. ");
     $('#txtvalidation').val(1);
     return 0;
    }
    
    $('#txtvalidation').val(0);
     return 1;
 }
 
 function funIBDateInPeriod(date,branch){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				 items = items.split('***');
			     var monthCloseDate = items[0];
			     var monthClose = items[1];
			     var Date = items[2].trim();
			   
			   if(parseInt(monthClose)==1){
				 $.messager.alert('Message','Closing Done on '+Date+' For Inter-Branch, Transaction Restricted. ','warning');
				 $('#txtibvalidation').val(1);$('#txtibbranchid').val('');$('#txtibbranch').val('');
				 
				 if (document.getElementById("txtibbranch").value == "") {
				        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
				  }
				 
				 return 0;
		   }
			   
			 $('#txtibvalidation').val(0);
		     return 1;
	   }
	}
	x.open("GET", "<%=contextPath%>/com/dashboard/getIBMonthClose.jsp?date="+date+"&branch="+branch, true);
	x.send();
}

function funChkHeaderButton() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			items = items.split('##');
			    
			    var email  = items[0].split(",");
				var excel  = items[1].split(",");

					if(parseInt(email)==0)	{
						$("#btnSendingEmail").attr('disabled', true );
	     			} else {
	   		    		 $("#btnSendingEmail").attr('disabled', false );
	    		    }

					if(parseInt(excel)==0) {
		        		$("#btnExcel").attr('disabled', true );
	     			} else {
	     				$("#btnExcel").attr('disabled', false );
	     			}
					
			
		 } else {}
	}
	
	x.open("GET","<%=contextPath%>/com/dashboard/chkheaderbuttons.jsp?docno="+$('#txtdetailpermissiondocno').val().trim(),true);
	x.send();

}

	function getMessengerCount() {
		var x=new XMLHttpRequest();
		var msgcnt;
		var user;
		x.onreadystatechange=function(){
			
			if (x.readyState==4 && x.status==200)
				{
				
					items= x.responseText;
				
					items=items.trim().split('####');
					user=items[0];
					msgcnt=items[1];
		
						if(msgcnt>0){
							window.parent.document.getElementById("iconnm").style.display = 'none';
							window.parent.document.getElementById("iconym").style.display = 'inline-block';
						}
						else{
							window.parent.document.getElementById("iconym").style.display = 'none';
							window.parent.document.getElementById("iconnm").style.display = 'inline-block';
		
						}
					
				    
				}
			else
				{
				}
		}
		x.open("GET",<%=contextPath+"/"%>+"com/messenger/getMsgCount.jsp",true);
		x.send();
	}

	function changeDashBoardAttachContent(url) {
		$.get(url).done(function (data) {
			    $('#windowattach').jqxWindow('open');
				$('#windowattach').jqxWindow('setContent',data);
				$('#windowattach').jqxWindow('bringToFront');
	}); 
	}
	
	function changeDashBoardGuidelineContent(url) {
		 $('#windowguideline').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		 $('#windowguideline').jqxWindow('setContent', data);
	}); 
	}

function getBranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			//alert(items);
				items = items.split('####');
				
				var branchIdItems  = items[0].split(",");
				var branchItems = items[1].split(",");
				var perm = items[2];
				 mcloseItems=items[3].split(",");
		        taxdate=items[4].split(",");
				var optionsbranch;
				if(perm==0){
				 optionsbranch = '<option value="a" selected>All</option>';
				}
				else{
					
				}
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#cmbbranch").html(optionsbranch);
				
				window.parent.monthclosed.value=mcloseItems[0];
	        	window.parent.taxdateval.value=taxdate[0];
				/* if ($('#hidcmbbranch').val() != null) {
					$('#cmbbranch').val($('#hidcmbbranch').val());
				} */
			} else {
				//alert("Error");
			}
		}
		x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
		x.send();
	}
function funRoundAmt(value,id){
    var res=parseFloat(value).toFixed(window.parent.amtdec.value);
    var res1=(res=='NaN'?"0":res);
    document.getElementById(id).value=res1;  
   }
   
 function funRoundRate(value,id){
    var res=parseFloat(value).toFixed(window.parent.curdec.value);
    var res1=(res=='NaN'?"0":res);
   document.getElementById(id).value=res1;  
 }
 
 function funGuideline() {
		
	 $('#windowguideline').jqxWindow('setContent', '');
	 $('#windowguideline').jqxWindow('open'); 
	
	 changeDashBoardGuidelineContent("<%=contextPath%>/com/dashboard/viewDashBoardGuideline.action?formDetail="+document.getElementById("lbldetail").innerText+"&formDetailName="+document.getElementById("lbldetailname").innerText);
}

function funMclose(value){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				items=items.split('####');
				if(items!='null'){
					
					window.parent.monthclosed.value=items[0];
					window.parent.taxdateval.value=items[1];
				}
				else{
					window.parent.monthclosed.value=window.parent.txtaccountperiodfrom.value;	
				}

			} else {
				//alert("Error");
			}
		}
		x.open("GET","<%=contextPath%>/com/dashboard/getMclose.jsp?branch="+value, true);
		x.send();
 }
 
 function getformbranch(){
	$('#cmbbranch').attr('disabled',false);
	var branchval=document.getElementById('cmbbranch').value;
	if($('#cmbbranch').val()!=null && $('#cmbbranch').val()!='a'){
		window.parent.branchid.value=$('#cmbbranch').val();	
	}
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText.trim();
		 	if(parseInt(items)==0)
	 		{
	 		 
	 		
	 		// $.messager.alert('Message','Your Secure Session Has Expired ,Please Login Again.....!','warning');
	 		$.messager.confirm('Confirm', 'Your Secure Session Has Expired ,Please Login Again.....!', function(r){
				if (r){
					window.parent.location.href=<%=contextPath+"/"%>+"login.jsp";
				}
			});
	 		
	 		
	 		 /* window.history.back(); */
	 		 				 		 
	 		Exit();
	 		return 0;
	 		}
     }
	}
      x.open("GET", "<%=contextPath%>/com/dashboard/sessionset.jsp?sessionbrch="+branchval,true);
     x.send();
  
   }
 
</script>

</head>
<body onload="getformbranch();" onclick="getMessengerCount();">
<tr><td colspan="2"><center><label class="detail" name="lbldetail" id="lbldetail">&nbsp;&nbsp;</label>
&nbsp;-&nbsp;<label class="details" name="lbldetailname" id="lbldetailname"></label></center>
	
	<hr  size=1 color="red"  width="100%"></td></tr>
	<tr><td colspan="2" align="center"><button type="button" class="icon" id="btnGuideline" title="Guideline" onclick="funGuideline();">  
							<img alt="Guideline" src="<%=contextPath%>/icons/guidelinedb.png">
						</button>&nbsp;
						
						<button type="button" class="icon" id="btnSendingEmail" title="Send Email" style="cursor: pointer;" onclick="funSendingEmail();">  
							<img alt="Send Email" src="<%=contextPath%>/icons/sendemail.png">
						</button>&nbsp;
			
						<button type="button" class="icon" id="btnExcel" title="Export current Document to Excel" onclick="funExportBtn();">
							<img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
						</button>&nbsp;&nbsp;&nbsp;&nbsp;
			
						<button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funCalculate();">
							<img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
						</button>&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" class="icon" id="btnSubmit" title="Submit" onclick="funreload(event)">
							<img alt="Submit" src="<%=contextPath%>/icons/submit_new.png">
						</button>&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td width="6%" align="right"><label class="branch" id="branchlabel">Branch</label></td>
		<td width="94%"><div class="styled-select" id="branchdiv"><select id="cmbbranch" name="cmbbranch"  value='<s:property value="cmbbranch"/>' onchange="funMclose(this.value);getformbranch();">
      <option value="">--Select--</option></select></div>
      <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/></td>
	</tr>
	<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'/>
	<input type="hidden" name="detail" id="detail" value="<s:property value="detail"/>" />
	<input type="hidden" name="detailname" id="detailname" value="<s:property value="detailname"/>" />
	<input type="hidden" name="txtdetailpermissiondocno" id="txtdetailpermissiondocno" value="<s:property value="txtdetailpermissiondocno"/>" />
	 <div id="windowattach">
   <div></div>
</div>
 <div id="windowguideline">
   <div></div>
</div>
</body>
</html>
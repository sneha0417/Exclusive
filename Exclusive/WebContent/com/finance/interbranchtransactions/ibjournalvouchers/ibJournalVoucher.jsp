<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 $("#jqxIbJournalVouchersDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#ibJournalVoucherGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#ibJournalVoucherGridWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Branch Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#branchSearchWindow').jqxWindow('close');
 		 
 		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costTypeSearchGridWindow').jqxWindow('close');
		 
		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
 		 
 		$('#jqxIbJournalVouchersDate').on('change', function (event) {
			 var ibjournaldate = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
			 var validdate=funDateInPeriod(ibjournaldate);
			 if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
		     }
		 });
 		
 		$('#txtdescription').keydown(function (evt) {
			  if (evt.keyCode==9) {
			          event.preventDefault();
			          $('#jqxIbJournalVoucher').jqxGrid('selectcell',0, 'branch');
			          $('#jqxIbJournalVoucher').jqxGrid('focus',0, 'branch');
			  }
		 });
		 
	});
	
	function BranchSearchContent(url) {
		$('#branchSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchSearchWindow').jqxWindow('setContent', data);
		$('#branchSearchWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function AccountSearchContent(url) {
		$('#ibJournalVoucherGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#ibJournalVoucherGridWindow').jqxWindow('setContent', data);
		$('#ibJournalVoucherGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	 function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtrefno').attr('readonly', false );$('#txtdescription').attr('readonly', false );
					 $('#txtdrtotal').attr('readonly', true );$('#txtcrtotal').attr('readonly', true );
					 $("#jqxIbJournalVoucher").jqxGrid({ disabled: false});
					 $('#docno').attr('readonly', true);  
			    }
			   });
	  }
	
	 function funReadOnly(){
		    $("#btnvaluechange").hide();
			$('#frmIbJournalVoucher input').attr('readonly', true );
			$('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: true});
			$("#jqxIbJournalVoucher").jqxGrid({ disabled: true});
			$('#fileexcelimport').attr('hidden', true );
			$('#btnsearch').attr('hidden', true );
	 }
	 function funRemoveReadOnly(){
			$('#frmIbJournalVoucher input').attr('readonly', false );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxIbJournalVoucher").jqxGrid({ disabled: false}); 
			$('#fileexcelimport').attr('hidden', false );
			$('#btnsearch').attr('hidden', false );
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIbJournalVoucher input').attr('readonly', true );
			    $("#jqxIbJournalVoucher").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $("#jqxIbJournalVoucher").jqxGrid('addrow', null, {});
   			    $('#fileexcelimport').attr('disabled', true );
				$('#btnsearch').attr('disabled', true );
			  }
			 else{
				$("#btnvaluechange").hide();
			}
			
			if ($("#mode").val() == "A") {
				document.getElementById("lblformposted").innerText="";
				$('#btnEdit').attr('disabled', false );
				$("#jqxIbJournalVoucher").jqxGrid('clear');
				$("#jqxIbJournalVoucher").jqxGrid('addrow', null, {});
			}
			
	 }
	 
	 function funSearchLoad(){
		   changeContent('ijvMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#jqxIbJournalVouchersDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 
	   $(function(){
	        $('#frmIbJournalVoucher').validate({
	                rules: {
	                   txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                   txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
			  /* Validation */
			  
			    var ibjournaldate = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(ibjournaldate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
				
				exceltypevalid=document.getElementById("txtexceltypevalidation").value;
				 if(exceltypevalid!=0){
					 document.getElementById("errormsg").innerText="Invalid Account-Type !!!";
					 return 0;
				 }
				 
				 excelaccvalid=document.getElementById("txtexcelaccvalidation").value;
				 if(excelaccvalid!=0){
					 document.getElementById("errormsg").innerText="Invalid Account !!!";
					 return 0;
				 }
				 
				 excelgrtypevalid=document.getElementById("txtexcelgrtypevalidation").value;
				 if(excelgrtypevalid!=0){
					 document.getElementById("errormsg").innerText="Invalid Cost-Type and Cost-Code !!!";
					 return 0;
				 }
				 
				 excelcostvalid=document.getElementById("txtexcelcostvalidation").value;
				 if(excelcostvalid!=0){
					 document.getElementById("errormsg").innerText="Invalid Cost-Type and Cost-Code !!!";
					 return 0;
				 }
				 
				 excelbranchvalid=document.getElementById("txtexcelbranchvalidation").value;
				 if(excelbranchvalid!=0){
					 document.getElementById("errormsg").innerText="Invalid Branch !!!";
					 return 0;
				 }
				
				 valid=document.getElementById("txtvalidation").value;
				 if(valid==1){
					 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
					 return 0;
				 }
			  
			    var drtot = document.getElementById("txtdrtotal").value;
		 		var crtot = document.getElementById("txtcrtotal").value;
		 		if(drtot>crtot || drtot<crtot){
		 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
	            return 0;
		 		}
		 		
		 		if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
		 			  document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
		              return 0;
			 		}
		    	document.getElementById("errormsg").innerText="";
		    	/* Validation  Ends*/
		    	
		    	/* Ib Journal Voucher Grid Saving */
		    	 var rows = $("#jqxIbJournalVoucher").jqxGrid('getrows');
		    	 var length=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chk=rows[i].docno;
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+i)
					    .attr("name", "test"+i)
					    .attr("hidden", "true");
						length=length+1;
						
					var amount,baseamount,id;
					if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
						 amount=rows[i].debit;
						 baseamount=rows[i].baseamount;
						 id=1;
					}
					if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
						 amount=rows[i].credit*-1;
						 baseamount=rows[i].baseamount*-1;
						 id=-1;
					}

					newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode+"::"+rows[i].brhid);
					newTextBox.appendTo('form');
					}
				 }
				 $('#gridlength').val(length);
		 		/* Ib Journal Voucher Grid Saving Ends */
		    	
	    		return 1;
		} 
	  
	  function setValues(){
		 
			  if($('#hidjqxIbJournalVouchersDate').val()){
				 $("#jqxIbJournalVouchersDate").jqxDateTimeInput('val', $('#hidjqxIbJournalVouchersDate').val());
			  }
			  
			  if($('#hidmaindate').val()){
					 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
				  }
			  
			  if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			  funSetlabel();
			  
			  if(document.getElementById("lblformposted").innerText.trim()!=""){
				    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
			  } else {
				    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
			  }
			  
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
				 var check = 1;
				 $("#jqxJournalVoucherGrid").load("ibJournalVoucherGrid.jsp?txtjournalvouchersdocno2="+indexVal+"&check="+check); 
			 }
			
		}
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				var url="";
		        var reurl="";
		        if ($("#msg").val().trim() == "") {
		        	url=document.URL;
		        	if( url.indexOf('saveIbJournalVoucher') >= 0){
		        		reurl=url.split("saveIbJournalVoucher");
		        	}else {
		        		reurl=url.split("ibJournalVoucher.jsp");
		        	}
		        }else if ($("#msg").val().trim() != "") {
		        	url=document.URL;
		        	reurl=url.split("saveIbJournalVoucher");
		        }
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printIbJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printIbJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function datechange(){
		  var date = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	  
	  function saveExcelDataData(docNo){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
					if(items==1){
						$("#jqxJournalVoucherGrid").load("ibJournalVoucherGrid.jsp?docNo="+docNo+'&date='+$('#maindate').val());
						$.messager.alert('Message', ' Successfully Imported.', function(r){
					});
					}
					
			  }
			}
				
		x.open("GET","saveData.jsp?docNo="+docNo,true);
		x.send();
		}
		
		function getAttachDocumentNo(){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
					if(items>0){
						
						var path=document.getElementById("fileexcelimport").value;
						var fsize = $('#fileexcelimport')[0].files[0].size;
						var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
						
						if((extn=='xls') || (extn=='csv')){ 
					        	ajaxFileUpload(items);	
					     }else{
					        	 $.messager.show({title:'Message',msg: 'File of xlsx Format is not Supported.',showType:'show',
			                         style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
			                     }); 
						            return;
					     } 
					}
					
			  }
			}
				
		x.open("GET","getAttachDocumentNo.jsp",true);
		x.send();
		}
		
		function upload(){
			 
			$('#txtexcelvalidation').val(1);
			getAttachDocumentNo();
			 
		 }
		
		function ajaxFileUpload(docNo) {  
			
			  var jvtdate = $("#jqxIbJournalVouchersDate").val();
 		      var newDate = jvtdate.split('.');
 		      jvtdate = newDate[0] + "-" + newDate[1] + "-" + newDate[2];
 		  
			    if (window.File && window.FileReader && window.FileList && window.Blob)
			    {
			        var fsize = $('#fileexcelimport')[0].files[0].size;
			        
			        if(fsize>1048576) {
			            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                        style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                    }); 
			            return;
			        }
			    }else{
			    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
			        return;
			    }
			
	          $.ajaxFileUpload  
	          (  
	              {  
	                  url:'fileAttachAction.action?formCode=IJVE&doc_no='+docNo+'&descpt=Excel Import' ,
	                  secureuri:false,  
	                  fileElementId:'fileexcelimport',    
	                  dataType: 'json', 
	                  success: function (data, status)   
	                  {  
	                     
	                     if(status=='success'){
	                         saveExcelDataData(docNo);
	                         $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
	                      }
	                     
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              $.messager.show({title:'Message',msg: data.error,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	                        }); 
	                          }else  
	                          {  
	                              $.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	              	          }); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e){  
	                      $.messager.alert('Message',e);
	                  }  
	              });  
	          return false;  
	      }

	  
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmIbJournalVoucher" action="saveIbJournalVoucher" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>

<table width="99%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="15%"><div id="jqxIbJournalVouchersDate" name="jqxIbJournalVouchersDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxIbJournalVouchersDate"/>'></div>
    <input type="hidden" id="hidjqxIbJournalVouchersDate" name="hidjqxIbJournalVouchersDate" value='<s:property value="hidjqxIbJournalVouchersDate"/>'/></td>
    <td width="28%" align="right"><input type="file" id="fileexcelimport" name="file"/></td>
    <td width="11%" align="center"> <button class="icon" id="btnsearch" name="btnsearch" title="Import Excel" type="button" onclick="return upload();">
							<img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png">
						</button></td>
    <td width="13%" align="center"><button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
    <td width="6%" align="right">Doc No</td>
    <td width="21%"><input type="text" id="docno" name="txtibjournalvouchersdocno" style="width:50%;" value='<s:property value="txtibjournalvouchersdocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Ref. No.</td>
    <td><input type="text" id="txtrefno" name="txtrefno" style="width:62%;" onblur="fungridfocus();" value='<s:property value="txtrefno"/>'/></td>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:80%;"  value='<s:property value="txtdescription"/>'/></td>
	<td align="left"><i><b><label id="lblformposted"  name="lblformposted"   style="font-size: 13px;font-family: Tahoma; color:#6000FC"><s:property value="lblformposted"/></label></b></i></td>
  </tr>
  <tr>
    <td colspan="7"><div id="jqxJournalVoucherGrid"><jsp:include page="ibJournalVoucherGrid.jsp"></jsp:include></div></td>
  </tr>
  <tr>
    <td align="right">Dr. Total</td>
    <td><input type="text" id="txtdrtotal" name="txtdrtotal" style="width:65%;text-align: right;" value='<s:property value="txtdrtotal"/>' tabindex="-1"/></td>
    <td colspan="4" align="right">Cr. Total</td>
    <td><input type="text" id="txtcrtotal" name="txtcrtotal" style="width:50%;text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="txtexceltypevalidation" name="txtexceltypevalidation" value='<s:property value="txtexceltypevalidation"/>'/>
<input type="hidden" id="txtexcelaccvalidation" name="txtexcelaccvalidation" value='<s:property value="txtexcelaccvalidation"/>'/>
<input type="hidden" id="txtexcelgrtypevalidation" name="txtexcelgrtypevalidation" value='<s:property value="txtexcelgrtypevalidation"/>'/>
<input type="hidden" id="txtexcelcostvalidation" name="txtexcelcostvalidation" value='<s:property value="txtexcelcostvalidation"/>'/>
<input type="hidden" id="txtexcelbranchvalidation" name="txtexcelbranchvalidation" value='<s:property value="txtexcelbranchvalidation"/>'/>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
</div>
</form>

<div id="ibJournalVoucherGridWindow">
	<div></div><div></div>
</div>

<div id="branchSearchWindow">
				<div></div><div></div>
</div>

<div id="costTypeSearchGridWindow">
	<div></div><div></div>
</div> 

<div id="costCodeSearchWindow">
	<div></div><div></div>
</div> 

</div>
</body>
</html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>

<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<jsp:include page="notification.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/loading.css">
<style>


.HeadIcons {
    font: 12px Tahoma;
    margin-top: 0px;
	line-height: 30px;
	background-color: #E0ECF8;
	height: 27px;
	width: 100%;
}
.icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}

label.branch{
   font-size: 12px;
   font-family: Tahoma;
   font-style: normal; 
   padding-left: 1%;
}

label.currency{
   font-size: 12px;
   font-family: Tahoma;
   font-style: normal;
   padding-left: 1%;
}

#errormsg {
  -moz-animation-duration: 1s;
  -moz-animation-name: blink;
  -moz-animation-iteration-count: infinite;
  -moz-animation-direction: alternate;
  
  -webkit-animation-duration: 2s;
  -webkit-animation-name: blink;
  -webkit-animation-iteration-count: infinite;
  -webkit-animation-direction: alternate;
  
  animation-duration: 1s;
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
button.icon:disabled { opacity: 0.5; };
</style>
<script type="text/javascript">
var APP_PATH='<%=contextPath%>';
var exefolio='<%=request.getParameter("exefolio")%>';
$(document).ready(function () { 

   if(exefolio==1){
	doformsubmit();
   }

     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	/* $("#txtaccperiodstartyear").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	$("#txtaccperiodendyear").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"}); */
	
		 $('body').keydown(function (evt) {
			  if (evt.keyCode == 8) {
				  var d = event.srcElement || event.target;
			        if ((d.tagName.toUpperCase() === 'INPUT' && 
			             (
			                 d.type.toUpperCase() === 'TEXT' ||
			                 d.type.toUpperCase() === 'PASSWORD' || 
			                 d.type.toUpperCase() === 'FILE' || 
			                 d.type.toUpperCase() === 'EMAIL' || 
			                 d.type.toUpperCase() === 'SEARCH' || 
			                 d.type.toUpperCase() === 'DATE' )
			             ) || 
			             d.tagName.toUpperCase() === 'TEXTAREA') {
			            doPrevent = d.readOnly || d.disabled;
			        }
			        else {
			            doPrevent = true;
			        }
			    }
			    if (doPrevent) {
			        event.preventDefault();
				}
		}); 
	
	if(window.parent.formName.value!="000"){
	funChkButtonchk();
	}
	    $("input").not($(":button")).keypress(function (evt) {
	        if (evt.keyCode == 13) {
	            iname = $(this).val();
	            if (iname !== 'Submit') {
	                var fields = $(this).parents('form:eq(0),body').find('button, input, textarea, select');
	                var index = fields.index(this);
	                if (index > -1 && (index + 1) < fields.length) {
	                    fields.eq(index + 1).focus();
	                }
	                return false;
	            }
	        }
	    });

	if(window.parent.formName.value!="000"){
	    document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
	}
	// alert(window.parent.branchid.value);
	 		

	 $("input").click(function (evt) {
			this.placeholder = '' ;
		});
  
	/* funDtype(); */
		$('#btnSave').mousedown(function () {
	   $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
		if (r){
		  var formId=$('form').attr('id');
		  
		  if($('#'+formId).valid()) {
		   var temp=funNotify();
		   if(temp>0){
			   funSetlabel();
			   $("#overlay, #PleaseWait").show();
			   $('#brchName').attr('disabled', false);$('#currency').attr('disabled', false);
			   $('#'+formId).submit();
			 //  $('#brchName').attr('disabled', true);$('#currency').attr('disabled', true);
		   }
		  }
		 }
	   });
	   });
			
 			 getBrchCurr();		
 			
	$("#mode").val("view");		funReadOnly();
	
	if(!($("#msg").val()=="Successfully Saved" || $("#msg").val().trim()=="" || $("#msg").val()=="Updated Successfully" || $("#msg").val()=="Successfully Deleted" || $("#msg").val()=="Not Deleted" || $("#msg").val()=="Successfully Released" ) ) {
	//	if($('#msg').val()=="Not Updated" || $('#msg').val()=="Not Saved" ) {
			//if($('#msg').val()!="Successfully Saved" || $('#msg').val()!="Updated Successfully" ) {
		 $.messager.alert('Message',$('#msg').val());
		
		if($('#msg').val()=="Not Updated" || $('#chkstatus').val()=="2"){
			$("#mode").val("E");	
		}
		
		if($('#msg').val()=="Not Saved"  || $('#chkstatus').val()=="1"){
			$("#mode").val("A");	
		}
		
		funNotSaved();
		
	}
	
	 $('#btnDelete').mousedown(function () {
			if (($("#mode").val() == "view") && ($("#docno").val() !="")) {
			$.messager.confirm('Confirm', 'Do you want to delete?', function(r){
				if (r){
					funSetlabel();
					var formId=$('form').attr('id');
					$("#mode").val("D");
					funRemoveReadOnly();
					$('#'+formId).submit();
				}
			});
			}
			else{
				$.messager.alert('Message','Select a Document....!','warning');
	    return;
		}
	}); 
	 if(window.parent.branchid.value!=""){
			$('#brchName').val(window.parent.branchid.value); 
		} 
		
 }); 

  
 function funCreateBtn(){
	 funReset();
 	 $("#mode").val("A");
	 $("#msg").val("");
	 funRemoveReadOnly();
	$("#btnSendmail").hide();
	 $("#status").val(1);	 $("#btnSave").show();		 $("#btnCancel").show();
	 $("#btnApproval").hide();	 $("#btnCreate").hide();	funFocus();
	 $("#btnEdit").hide();	 $("#btnPrint").hide();	 $("#btnExcel").hide();		 $("#btnDelete").hide();
	 $("#btnSearch").hide(); 		 $("#btnAttach").hide();  $("#btnGuideLine").hide();
 }
 function funCloseBtn(){
	
	 if($("#status").val()==1){

				

		 $("#msg").val("");    $("#mode").val("view");
		 /* funDtype(); */
		$("#btnSendmail").show();
		 $("#btnApproval").show();		 $("#btnCreate").show();		 $("#btnEdit").show(); 		 $("#btnPrint").show();
		 $("#btnExcel").show();		 $("#btnDelete").show();		 $("#btnSearch").show();	 $("#status").val(0);	
		 $("#btnSave").hide();		 $("#btnCancel").hide();		 funReadOnly();      $("#btnAttach").show();  $("#btnGuideLine").show();
		 $('#brchName').attr('disabled', false);                     $('#currency').attr('disabled', false);
		 document.getElementById("errormsg").innerText="";         document.getElementById("savemsg").innerText="";
		}
	 else{
		 return;
		 //alert("close form");
	 }
 }

 	function funEditBtn() {
	
			if(exefolio==1){
 			$.messager.alert('Message','Edit Not Possible...!!','warning');
 			return;
 		}
		
		if (($("#mode").val() == "view") && ($("#docno").val()!="") && ($("#deleted").val() =="")) {
			$("#mode").val("E");	$("#msg").val("");
			funRemoveReadOnly();
			$("#btnSendmail").hide();
			$('#brchName').attr('disabled', true);             $('#currency').attr('disabled', true);
			$("#status").val(1);			$("#btnApproval").hide();			$("#btnCreate").hide();
			$("#btnEdit").hide();			$("#btnPrint").hide();			$("#btnExcel").hide();				$("#btnDelete").hide();
			$("#btnSearch").hide();			$("#btnSave").show();		 $("#btnCancel").show();                $("#btnAttach").hide();   $("#btnGuideLine").hide();
			} else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
	}
	
 	function funSearchBtn() {
			$("#msg").val("");
			$("#deleted").val("");  $("#mode").val("view");  funReadOnly();
			$('#brchName').attr('disabled', false);   $('#currency').attr('disabled', false);
			funSearchLoad();
	}
	function funCancelBtn() {
		funReset();
	}
	
	function getBrchCurr()
		{
		var x=new XMLHttpRequest();
		var items,brchItems,currItems,mcloseItems;
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
		        items= x.responseText;
		        items=items.split('####');
		        brchIdItems=items[0].split(",");
		        brchItems=items[1].split(",");
		        currIdItems=items[2].split(",");
		        currItems=items[3].split(",");
		        mcloseItems=items[4].split(",");
		        curTypeItems=items[5].split(",");
		        	var optionsbrch = '';
		        	var optionscurr = '';
		       for ( var i = 0; i < brchItems.length; i++) {
		    	   optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
		        }
		       for ( var j = 0; j < currItems.length; j++) {
		    	   optionscurr += '<option value="' + currIdItems[j] + '">' + currItems[j] + '</option>';
		        }
		        	$("select#brchName").html(optionsbrch); 	
		        	$("select#currency").html(optionscurr);
		        	window.parent.monthclosed.value=mcloseItems[0];
		        	window.parent.formcurrencytype.value=curTypeItems[0];
		        	/* if(window.parent.branchid.value==""){
		        		window.parent.branchid.value=brchIdItems[0];	
		        	} */
		        	if(window.parent.branchid.value!=""){
		 				//alert("inside parent brch");
		 				$('#brchName').val(window.parent.branchid.value); 
		 			}
		        }
			else
				{
				}
		}
		x.open("GET",<%=contextPath+"/"%>+"getBranch.jsp?menubrch="+window.parent.branchid.value,true);
		x.send();
	}


	
	<%-- function getCurr(brch)
	{
		//alert("getCurr");
		var x=new XMLHttpRequest();
		var items,currIdItems,mcloseItems,currCodeItems;
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					items= x.responseText;
			        items=items.split('####');
			        currIdItems=items[0].split(",");
			        mcloseItems=items[1].split(",");
			        currCodeItems=items[2].split(",");
			        
			        var optionscurr = '';  
		            for ( var i = 0; i < currCodeItems.length; i++) {
				    	   optionscurr += '<option value="' + currIdItems[i] + '">' + currCodeItems[i] + '</option>';
				        }
		            $("select#currency").html(optionscurr);
		        	window.parent.monthclosed.value=mcloseItems;
		        	window.parent.branchid.value=brch;
		        	/* if(window.parent.branchid.value!=""){
		 				$('#brchName').val(window.parent.branchid.value); 
		 			} */
				}
			else
				{
				}
		}
		x.open("GET",<%=contextPath+"/"%>+"getCurrency.jsp?branch="+brch,true);
		x.send();
	} 
	
	--%>
	
	function getCurr(brch) {
                    funReset();
		  var x=new XMLHttpRequest();
		  x.onreadystatechange=function(){
		  if (x.readyState==4 && x.status==200)
		   {
		     items= x.responseText;
		     items=items.split('####');
		          var currIdItems=items[0];
		          var mcloseItems=items[1];
		          var currCodeItems=items[2];
		          var curtypeItems=items[3];
		          var multiItems=items[4];
		          var optionscurr = '';
		          
		       if(currCodeItems.indexOf(",")>=0){
		           var currencyid=currIdItems.split(",");
		           var currencycode=currCodeItems.split(",");
		           var currencytype=curtypeItems.split(",");
		           mcloseItems.split(",");
		           multiItems.split(",");
		         
		         for ( var i = 0; i < currencycode.length; i++) {
		          optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
		          }
		        
		           $("select#currency").html(optionscurr);
		           window.parent.monthclosed.value=mcloseItems[0];
		           window.parent.formcurrencytype.value=curtypeItems[i];
		      }
		  
		         else{
		          optionscurr += '<option value="' + currIdItems + '"selected>' + currCodeItems + '</option>';
		          
		         $("select#currency").html(optionscurr);
		         window.parent.monthclosed.value=mcloseItems;
		         window.parent.formcurrencytype.value=curtypeItems;
		         }
		       
		       window.parent.branchid.value=brch;
		        }
		      }
		       x.open("GET",<%=contextPath+"/"%>+"getCurrency.jsp?branch="+brch,true);
		      x.send();
		     
		    }
	
	
	function funDtype(){
		 
		 var dtype=document.getElementById("formdetailcode").value;
		  var x = new XMLHttpRequest();
		  x.onreadystatechange = function() {
		   if (x.readyState == 4 && x.status == 200) {
		    var item=x.responseText.trim();
		    var count = item[0];
		    if(count==0){
		     //$("#btnApproval").show();
		    	 $("#btnApproval").attr('disabled', true );
		    }
		    /* else{
		    // $("#btnApproval").hide();
		    } */
		   } else {
		   }
		  }
		  x.open("GET", <%=contextPath+"/"%>+"getDtype.jsp?dtype="+dtype, true);
		  x.send();  
		 }

		   function apprCheck(){
		  
		   var dtype=document.getElementById('formdetailcode').value;
		  
		   if(!(dtype=='FRO' || dtype=='OPN' || dtype=='LEC' || dtype=='FPP'|| dtype=='PREP'|| dtype=='BRCN'|| dtype=='MAPP'|| dtype=='UCPP' || dtype=='SAT' || dtype=='CUR' || dtype=='STE' )){
			   
			   getapprcount();
	   }
	}


		function funReset() {
				funSetlabel();
				$('input[type=text],[type=email],[type=hidden],[type=password], textarea').val('');
				$('select').find('option').prop("selected", false);
				$('input[type=radio]').prop("checked", false);
				$('input:checkbox').removeAttr('checked');
				
				document.getElementById("formdetail").value=window.parent.formName.value;
				document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
				if(window.parent.branchid.value!=""){
					$('#brchName').val(window.parent.branchid.value); 
				}
				if(window.parent.mode.value!=""){
					$('#mode').val(window.parent.mode.value); 
				}
				$("#status").val("1");
				//alert("in reset");
		   }
			
			function funSetlabel(){
				if(window.parent.formName.value!="000"){
							window.parent.formName.value=document.getElementById("formdetail").value;
							window.parent.formCode.value=document.getElementById("formdetailcode").value;
				}
				funDtype();
				//getapprcount();
				apprCheck();
				//alert("before get curr : "+window.parent.branchid.value+"========"+$('#brchName').val());
				if(!($('#brchName').val()==null)){
					window.parent.branchid.value=$('#brchName').val();
				}
				window.parent.mode.value=$('#mode').val();
				//alert("before get curr : "+window.parent.branchid.value);
			}

/*			function funExcelBtn(){
				if(jQuery.isFunction(footer.funExcelBtn)) {
					alert('This is a function');
				}
				else{
					$.messager.alert('Message','Excel Option is not Enabled.','warning');
				}
			}	*/
		  
			function funDateInPeriod(value){
			       var styear = new Date(window.parent.txtaccountperiodfrom.value);
			       var edyear = new Date(window.parent.txtaccountperiodto.value);
			       var mclose = new Date(window.parent.monthclosed.value);
			       mclose.setHours(0,0,0,0);
			       edyear.setHours(0,0,0,0);
			       styear.setHours(0,0,0,0);
			       var currentDate = new Date(new Date());
			       if(value<styear || value>edyear){
			        document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid. ";
			        $('#txtvalidation').val(1);
			        return 0;
			       }
			        if(value>currentDate){
			        document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
			        $('#txtvalidation').val(1);
			        return 0;
			       } 
			       if(value<=mclose){
			        document.getElementById("errormsg").innerText="Closing Done, Transaction Restricted. ";
			        $('#txtvalidation').val(1);
			        return 0;
			       }
			       document.getElementById("errormsg").innerText="";
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
		  				 document.getElementById("errormsg").innerText="Closing Done on "+Date+", Transaction Restricted. ";
		  				 $('#txtibvalidation').val(1);
		  				 return 0;
		  		   }
		  			   
		  			 document.getElementById("errormsg").innerText="";
		  			 $('#txtibvalidation').val(0);
					 return 1;
		  	   }
	  		}
	  		x.open("GET", <%=contextPath+"/"%>+"getIBMonthClose.jsp?date="+date+"&branch="+branch, true);
	  		x.send();
	    }
		
		/*Back Date Restriction in Rental Receipt*/
		function funBackDate(value){
				if(window.parent.backdateallowed.value==1){
				  if($("#mode").val()=="A"){
					var currentDate = new Date(new Date());
					currentDate.setHours(0,0,0,0);
					if(value<currentDate){		
						document.getElementById("errormsg").innerText="Past Date, Transaction Restricted.";
						$('#txtbackdatevalidation').val(1); 
						return 0;
					}else{
						document.getElementById("errormsg").innerText="";
					    $('#txtbackdatevalidation').val(0);
					    return 1;
					}
				  }
				} 
				document.getElementById("errormsg").innerText="";
			    $('#txtbackdatevalidation').val(0);
			    return 1;  
			}
		/*Back Date Restriction Ends*/
		
		/*PDC Date Restriction*/
		function funPDCDate(chckpdc,formDate,chequeDate){
				if(window.parent.pdcascdcdateallowed.value==0){
					if(chckpdc=='1'){
						if(chequeDate<=formDate){		
							document.getElementById("errormsg").innerText="Past/Current Cheque Date, Transaction Restricted.";
							$('#txtpdcdatevalidation').val(1); 
							return 0;
						}
					}else if(chckpdc=='0'  || chckpdc==''){
						if(chequeDate>formDate){		
							document.getElementById("errormsg").innerText="Future Cheque Date, Transaction Restricted.";
							$('#txtpdcdatevalidation').val(1); 
							return 0;
						}
					}  
				} 
				document.getElementById("errormsg").innerText="";
			    $('#txtpdcdatevalidation').val(0);
			    return 1;  
			}
		/*PDC Date Restriction Ends*/
		
			function funNotSaved(){
				 $("#msg").val("");
				 funRemoveReadOnly();
				 $("#btnSendmail").hide();
				 $("#status").val(1);	 $("#btnSave").show();		 $("#btnCancel").show();
				 $("#btnApproval").hide();	 $("#btnCreate").hide();	funFocus();
				 $("#btnEdit").hide();	 $("#btnPrint").hide();	 $("#btnExcel").hide();		 $("#btnDelete").hide();
				 $("#btnSearch").hide();  $("#btnAttach").hide(); 	$("#btnGuideLine").hide();	 
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
			
			function funAttachBtn(){
				if (($("#mode").val() == "view") && $("#docno").val()!="") {
					<%-- $("#windowattach").jqxWindow('setTitle',document.getElementById("formdetailcode").value+" - "+document.getElementById("docno").value);
				
					changeAttachContent("<%=contextPath%>/com/common/Attach.jsp?formCode="+document.getElementById("formdetailcode").value+"&docno="+document.getElementById("docno").value);		 --%>
				
					 var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+document.getElementById("formdetailcode").value
							 +"&docno="+document.getElementById("docno").value+"&brchid="+document.getElementById("brchName").value+"&frmname="+document.getElementById("formdetail").value,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
							  myWindow.focus();
				
				} else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
			}

			function funApproveBtn(){
				
				if (($("#mode").val() == "view") && $("#docno").val()!="") {
					$("#windowapprove").jqxWindow('setTitle',document.getElementById("formdetailcode").value+" - "+document.getElementById("docno").value);
					var brch='<%=session.getAttribute("BRANCHID")%>';
					var userid='<%=session.getAttribute("USERID")%>';
					<%-- changeAttachContent("<%=contextPath%>/com/common/Attach.jsp?formCode="+document.getElementById("formdetailcode").value+"&docno="+document.getElementById("docno").value); --%>
				 changeApproveContent("<%=contextPath%>/com/common/ApprovalForm.jsp?brch="+brch+"&userid="+userid+"&docno="+document.getElementById("docno").value+"&dtype="+document.getElementById("formdetailcode").value+"&aprstatus="+document.getElementById("apprstatus").value+"&isfirstappr="+document.getElementById("isfirstappr").value);
				} else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
			}
			
			function funGuideLineBtn() {
				
				 $('#windowGuideline').jqxWindow('setContent', '');
				 $('#windowGuideline').jqxWindow('open'); 
				
					changeGuidelineContent("<%=contextPath%>/com/GuideLine/viewGuideline.action?formName="+document.getElementById("formdetail").value+"&formCode="+document.getElementById("formdetailcode").value); 
		    }
			
function funChkButtonchk(){
				
				var FormNamechk=window.parent.formName.value;
				var doc_no=0;
				
				var dtype=window.parent.formCode.value.trim();
				
				
				   if(!(dtype=='FRO' || dtype=='LEC' || dtype=='OPN' || dtype=='FPP'|| dtype=='PREP'|| dtype=='BRCN'|| dtype=='MAPP'|| dtype=='UCPP' || dtype=='SAT'  || dtype=='CUR'  || dtype=='STE' )){
					  
					   doc_no=document.getElementById('docno').value;
			   }
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						items = items.split('##');
						
				 			var add  = items[0].split(",");
							var edit = items[1].split(",");
							var del  = items[2].split(",");
							var print = items[3].split(",");
							var attach = items[4].split(",");
							var excel  = items[5].split(",");
							var email  = items[6].split(",");
                                                        var other  = items[7].split(",");
                                                        var terms  = items[8].split(",");
                                 if(parseInt(other)==1)
						{                
           
					if(parseInt(add)==0)
						{		
							$("#btnCreate").attr('disabled', true ); 
					    }
					if(parseInt(edit)==0)
					   {
					        $("#btnEdit").attr('disabled', true );
					   }
					if(parseInt(del)==0)
					   {
						    $("#btnDelete").attr('disabled', true );
					   } 
					if(parseInt(print)==0)
					   {
					        $("#btnPrint").attr('disabled', true );
					   }
					if(parseInt(attach)==0)
					   {
					        $("#btnAttach").attr('disabled', true );
					   }	
					if(parseInt(excel)==0)
					   {
					        $("#btnExcel").attr('disabled', true );
				     	}
					if(parseInt(email)==0)
					   {
					        $("#btnSendmail").attr('disabled', true );
				     	}
					if(parseInt(terms)==0)
					   {
					        $("#btnTerms").attr('hidden', true );
				     	}
                                     }
						
					 }else {}
				}
				
				x.open("GET",<%=contextPath+"/"%>+"chkmenubuttons.jsp?formdetail="+FormNamechk+"&docno="+doc_no,true);
				x.send();
			
			
			}
			
	
/** set currency type for header values ends */
		function getCurrencyType(c){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	items = items.split('####');
			 		
			 		var typeItems = items[0].split(",");
			 		var rateItems  = items[1].split(",");
					window.parent.formcurrencytype.value=typeItems;
			    }
		       else
			  {}
	     }
	      x.open("GET", <%=contextPath+"/"%>+"getCurrencyType.jsp?curr="+c,true);
	     x.send();
	    
	   }


	     
function getapprcount(){
	
	var docno=document.getElementById('docno').value;
	var dtype=document.getElementById('formdetailcode').value;
	var brch='<%=session.getAttribute("BRANCHID")%>';
	var usrid='<%=session.getAttribute("USERID")%>';
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText;
		 	items = items.split('####');
		 		var count = items[0];
		 		var isfirstappr = items[2];
		 		document.getElementById('apprstatus').value=count;
		 		document.getElementById('isfirstappr').value=isfirstappr;
		 		
				if(count>=1){
					
					if(docno>=1){
						funApproveBtn();
					
					}
					}
		    }
	       else
		  {}
     }
      x.open("GET", <%=contextPath+"/"%>+"getApprCount.jsp?docno="+docno+"&dtype="+dtype+"&brch="+brch+"&usrid="+usrid,true);
     x.send();
    
   }
		
		/** set currency type for header values ends */
		
		/** set currency for finance forms strats */
		
		function getCurrencyId(date){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
				 	items=items.split('####');
			        var curidItems=items[0];
			        var curcodeItems=items[1];
			        var currateItems=items[2];
			        var curtypeItems=items[3];
			        var multiItems=items[4];
			        var optionscurr = '';
			        if(curcodeItems.indexOf(",")>=0){
			        	var currencyid=curidItems.split(",");
			        	var currencycode=curcodeItems.split(",");
			        	var currencyrate=currateItems.split(",");
			        	var currencytype=curtypeItems.split(",");
			        	multiItems.split(",");
			       
			       for ( var i = 0; i < currencycode.length; i++) {
			    	   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
			        }
			       
			       if($('#txtforsearch').val()==2){
			    	
			    	 $("select#cmbcurrency").html(optionscurr);
			       
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         } 
			         if($('#mode').val()=="A"){
			         	funRoundRate(currencyrate[0],"txtrate");
			         	$('#hidcurrencytype').val(currencytype[0]);
			         }
				     //$('#txtrate').attr('readonly', true);
				     $('#txtbaseamount').attr('readonly', true);
				     
			       }else{
				         $("select#cmbfromcurrency").html(optionscurr);
				         if ($('#hidcmbfromcurrency').val() != null && $('#hidcmbfromcurrency').val() != "") {
				       		 $('#cmbfromcurrency').val($('#hidcmbfromcurrency').val()) ;
				         } 
				        
					     $("select#cmbtocurrency").html(optionscurr);
					     if ($('#hidcmbtocurrency').val() != null && $('#hidcmbtocurrency').val() != "") {
					     	$('#cmbtocurrency').val($('#hidcmbtocurrency').val()) ;
					     }
					     
					     if($('#mode').val()=="A"){
					    	funRoundRate(currencyrate[0],"txtfromrate");
					        $('#hidfromcurrencytype').val(currencytype[0]);
					     	funRoundRate(currencyrate[0],"txttorate");
					     	$('#hidtocurrencytype').val(currencytype[0]);
					     }
					     
					     //$('#txtfromrate').attr('readonly', true);
					     $('#txtfrombaseamount').attr('readonly', true);
					     //$('#txttorate').attr('readonly', true);
					     $('#txttobaseamount').attr('readonly', true);
			            }
				     }
			
			       else
				  {
			    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
			    	   
			    	   if($('#txtforsearch').val()==2){
					    	
					    	 $("select#cmbcurrency").html(optionscurr);
					       
					         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
					       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
					         }
					         if($('#mode').val()=="A"){
					         	funRoundRate(currateItems,"txtrate");
					        	$('#hidcurrencytype').val(curtypeItems);
					         }
					         
					       }else{
					    	   
						    	   $("select#cmbfromcurrency").html(optionscurr);
						    	   if ($('#hidcmbfromcurrency').val() != null && $('#hidcmbfromcurrency').val() != "") {
						    	   		$('#cmbfromcurrency').val($('#hidcmbfromcurrency').val()) ;
						    	   } 
						    	   
								     $("select#cmbtocurrency").html(optionscurr);
								     if ($('#hidcmbtocurrency').val() != null && $('#hidcmbtocurrency').val() != "") {
										  $('#cmbtocurrency').val($('#hidcmbtocurrency').val()) ;
									     } 
								    
								     if($('#mode').val()=="A"){
								    	funRoundRate(currateItems,"txtfromrate");
							    	    $('#hidfromcurrencytype').val(curtypeItems);
								     	funRoundRate(currateItems,"txttorate");
								     	$('#hidtocurrencytype').val(curtypeItems);
								     }
								     //$('#txtfromrate').attr('readonly', true);
								     $('#txtfrombaseamount').attr('readonly', true);
								     //$('#txttorate').attr('readonly', true);
								     $('#txttobaseamount').attr('readonly', true);
					       }
				      }
				}
		     }
		      x.open("GET", <%=contextPath+"/"%>+"getCurrencyId.jsp?date="+date,true);
		     x.send();
		    
		   }
		
		
		/** set currency for finance forms end*/
		
		function getRatevalue(a,date){
		  var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	items = items.split('####');
						var ratesItems  = items[0].split(",");
						var typesItems = items[1].split(",");
						if($('#txtforsearch').val()==2){
							funRoundRate(ratesItems,"txtrate");
							$('#hidcurrencytype').val(typesItems);
							getBaseAmountFrom();
						}else{
							funRoundRate(ratesItems,"txttorate");
							$('#hidtocurrencytype').val(typesItems);
							getBaseAmountTo();
						}
				    }
			       else
				  {}
		     }
		      x.open("GET", <%=contextPath+"/"%>+"getRateTo.jsp?currs="+a+"&date="+date,true);
		     x.send();
		    
		   }

		function doformsubmit(){  
			var docno='<%=request.getParameter("docno")%>';
			var mode='<%=request.getParameter("mode")%>';
			<%-- var cmbagmttype='<%=request.getParameter("cmbagmttype")%>'; --%>
			document.getElementById('docno').value=docno;
			document.getElementById('mode').value=mode;
			/* document.getElementById('cmbagmttype').value=cmbagmttype; */
			var names = [];
			$("form").each(function() {
			  //alert(this.id);
			   names.push(this.id);
			}); 
			var form=names[0];
			   document.forms[form].submit();
	      }
		
		function getRate(b,date){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	items = items.split('####');
						var rateItems  = items[0].split(",");
						var typeItems = items[1].split(",");
						funRoundRate(rateItems,"txtfromrate");
						$('#hidfromcurrencytype').val(typeItems);
						getBaseAmountFrom();
				    }
			       else
				  {}
		     }
		      x.open("GET", <%=contextPath+"/"%>+"getRateFrom.jsp?curr="+b+"&date="+date,true);
		     x.send();
		    
		   }
		
		function getBaseAmountFrom(){
			 var currencytype ="";	
			 var fromrate = ""; 
			 var fromamount = "";
			    
			if($('#txtforsearch').val()==2){			
		    		fromrate = $('#txtrate').val(); 
            		fromamount = $('#txtamount').val();
		    	   	currencytype = $('#hidcurrencytype').val().trim();
		    }else{ 
		    	    fromrate = $('#txtfromrate').val(); 
		            fromamount = $('#txtfromamount').val();
			    	currencytype = $('#hidfromcurrencytype').val().trim();
			    }
		    if(!isNaN(fromamount)){
			    if(currencytype=="M"){
			    	if($('#txtforsearch').val()==2){	
			    		var result = parseFloat(fromamount) * parseFloat(fromrate);
					    funRoundAmt(result,"txtbaseamount");
			    	}else{
				    	var result = parseFloat(fromamount) * parseFloat(fromrate);
				    	funRoundAmt(result,"txtfrombaseamount");
			    	}
			    }else{
			    	if($('#txtforsearch').val()==2){	
			    		var result = parseFloat(fromamount) / parseFloat(fromrate);
					    funRoundAmt(result,"txtbaseamount");
			    	}else{
				    	var result = parseFloat(fromamount) / parseFloat(fromrate);
						funRoundAmt(result,"txtfrombaseamount");
			    	}
			    }
		    }
		    else if(isNaN(fromamount)){
		    	if($('#txtforsearch').val()==2){	
		    	 	 $('#txtbaseamount').val(0.00);
		    	 	 $('#txtamount').val(0.00);
		    	}else{ 
		    		 $('#txtfrombaseamount').val(0.00);
			    	 $('#txtfromamount').val(0.00);
		    	 }
		    }
		}
		
		function getBaseAmountTo(){
		    var torate = $('#txttorate').val(); 
		    var toamount = $('#txttoamount').val();
		    var currencytype = $('#hidtocurrencytype').val().trim();
		    if(!isNaN(toamount)){
		    	if(currencytype=="M"){
				    var toresult = parseFloat(toamount) * parseFloat(torate);
				    funRoundAmt(toresult,"txttobaseamount");
			    }else{
				    var toresult = parseFloat(toamount) / parseFloat(torate);
					funRoundAmt(toresult,"txttobaseamount");
			    }
		    }
		    else if(isNaN(toamount)){
		    	 $('#txttobaseamount').val(0.00);
		    	 $('#txttoamount').val(0.00);
		    }
		}
		
		function getBaseAmountInGrid(amount,rate,type){
			var baseamount = "";
			 if(!isNaN(amount)){
			    	if(type=="M"){
			    		baseamount = parseFloat(amount) * parseFloat(rate);
				    }else{
				    	baseamount = parseFloat(amount) / parseFloat(rate);
				    }
			    }
			    else if(isNaN(amount)){
			    	baseamount="0.00";
			    }
			 return baseamount;
		}



	function getformbranch(){
			$('#brchName').attr('disabled',false);
			$('#formdetailcode').attr('disabled',false);
			var branchval=document.getElementById('brchName').value;
			var formCode=document.getElementById('formdetailcode').value;
			var sessionbr='<%=session.getAttribute("BRANCHID")%>';
			//alert($('#brchName').val());
			if($('#brchName').val()!=null){
				window.parent.branchid.value=$('#brchName').val();	
			}
			if($('#formdetailcode').val()!=null){
				window.parent.formCode.value=$('#formdetailcode').val();	
			}
			if($('#formdetail').val()!=null){
				window.parent.formName.value=$('#formdetail').val();	
			}
			if(sessionbr==""||sessionbr=="null"||sessionbr==null||branchval.trim()=="")
				{
				 //document.getElementById("errormsg").innerText="  Your Secure Session Has Expired ..";
				 //return 0;
				}
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText.trim();
				 	
				 	if($('#mode').val=='E')
				 		{
						$('#brchName').attr('disabled',true);
				 		}
		     }
			}
		      x.open("GET", <%=contextPath+"/"%>+"sessionset.jsp?sessionbrch="+branchval+"&formCode1="+formCode,true);
		     x.send();
		  
		   }

		   function funSendMail(){
				if (($("#mode").val() == "view") && $("#docno").val()!="") {
					
					funSendmail();
					
				} else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
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
			}

                    	function funTermsCond(){
				
				<%-- changeTermsContent("<%=contextPath%>/com/common/termsForm.jsp?formCode="+document.getElementById("formdetailcode").value+"&docno="+document.getElementById("docno").value); --%>
				
				if (($("#mode").val() == "view") && $("#docno").val()!="") {
					$("#windowterms").jqxWindow('setTitle',document.getElementById("formdetailcode").value+" - "+document.getElementById("docno").value);
				
					changeTermsContent("<%=contextPath%>/com/common/termsForm.jsp?formCode="+document.getElementById("formdetailcode").value+"&docno="+document.getElementById("docno").value);		
				} else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
			}
			
</script>

</head>
<body onload="funChkButton();"  onclick="getformbranch();">
<div id="mainBG" class="homeContent" data-type="background">
<div class="HeadIcons" id="full">
	<font size=3px><label id="formdet" name="formdet" ></label></font> 
						
				<button type="button" class="icon" id="btnApproval" title="Document Status" onclick="funApproveBtn()" style="prop('disabled', true);" >
							<img alt="statusDocument" src="<%=contextPath%>/icons/approve_new.png">
</button>
				    <button type="button" class="icon" id="btnClose" title="Close Form" onclick="funCloseBtn()">
							<img alt="closeForm" src="<%=contextPath%>/icons/close_new.png">
						</button>
				    <button type="button" class="icon" id="btnCreate" title="Create a new Document" onclick="funCreateBtn()">
							<img alt="newDocument" src="<%=contextPath%>/icons/add_new.png">
						</button>
					<button type="button" class="icon" id="btnEdit" title="Change current Document" onclick="funEditBtn()" >
							<img alt="editDocument" src="<%=contextPath%>/icons/edit_new.png">
						</button>
					<button type="button" class="icon" id="btnPrint" title="Print current Document" onclick="funPrintBtn()">  
							<img alt="printDocument" src="<%=contextPath%>/icons/print_new.png">
						</button>
					<button type="button" class="icon" id="btnExcel" title="Export current Document to Excel" onclick="funExcelBtn()">
							<img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
						</button>
					<button class="icon" id="btnDelete" title="Delete current Document" >
							<img alt="deleteDocument" src="<%=contextPath%>/icons/delete_new.png">
						</button>
						
		 			<button class="icon" id="btnSave" title="Save Changes" hidden="true">
							<img alt="saveChanges" src="<%=contextPath%>/icons/save_new.png">
						</button>
						
					<button type="button" class="icon" id="btnCancel" title="Cancel Changes"  onclick="funCancelBtn()" hidden="true">
							<img alt="cancelChanges" src="<%=contextPath%>/icons/cancel_new.png">
						</button>
						
					<button type="button" class="icon" id="btnSearch" title="Search a Document" onclick="funSearchBtn()">
							<img alt="searchDocument" src="<%=contextPath%>/icons/search_new.png">
						</button>
						
					<button type="button" class="icon" type="button" id="btnAttach" title="Attachment" onclick="funAttachBtn()">
							<img alt="Attachment" src="<%=contextPath%>/icons/attachment_new.png">
						</button>
					
					<button type="button" class="icon" id="btnGuideLine" title="Guideline" onclick="funGuideLineBtn()">
							<img alt="Guideline" src="<%=contextPath%>/icons/guideline.png">
					</button>

					<button type="button" class="icon" id="btnSendmail" title="Send Document to Client" onclick="funSendMail()">
							<img alt="Sendmail" src="<%=contextPath%>/icons/mail_new.png">
					</button>

					<button type="button" class="icon" id="btnTerms" title="Terms and Conditions" onclick="funTermsCond()">
							<img alt="Terms" src="<%=contextPath%>/icons/tndc.png">
					</button>
						
			<label class="branch">Branch&nbsp;&nbsp;</label>
			<select name="brchName" id="brchName" onChange="getCurr(this.value)">
			</select>
				
       <label class="currency">Currency&nbsp;&nbsp;</label><select name="currency" id="currency" onchange="getCurrencyType(this.value);" >
					</select>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<label id="savemsg" name="savemsg" style="color:green;font-weight:bold;"></label>
					<label id="errormsg" name="errormsg" style="color:red;font-weight:bold;"><s:property value="errormsg"/></label>
		<input type="hidden" id="status" />
		<input type="hidden" id="apprstatus" />
		<input type="hidden" id="isfirstappr" />
		<input type="hidden" name="formdetail" id="formdetail" value='<s:property value="formdetail"/>' />
		<input type="hidden" name="formdetailcode" id="formdetailcode" value='<s:property value="formdetailcode"/>' />
		<input type="hidden" name="chkstatus" id="chkstatus" value='<s:property value="chkstatus"/>' />
	<!-- 	If Add=1,Edit=2 -->
		</div>
</div>	
	

</body>
</html>
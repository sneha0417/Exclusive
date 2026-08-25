<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<%
	String contextPath = request.getContextPath();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">
     
$(document).ready(function () {  
		
	$("#rtime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
	$("#rtime").val(new Date());
	
	$('#txttenant').dblclick(function(){
	 	refsearchContent2('tmainsearch.jsp');
	});		
	$('#txtproperty').dblclick(function(){
	 	refsearchContent1('pmainsearch.jsp');
	});	
	  	 /* Date */
	$("#jqxDate").jqxDateTimeInput({ width: '100%', height: '23px', formatString:"dd.MM.yyyy"});	  	 
	   //$('#requestDiv').load("requestGrid.jsp");
	  	 
  	 $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
 	 $('#refnosearchwindow').jqxWindow('close');  
 	 
 	$('#refnosearchwindow1').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	$('#refnosearchwindow1').jqxWindow('close'); 
	
	$('#vendoracwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Insurance Type Search' , position: { x: 150, y: 50 }, keyboardCloseKey: 27});
	$('#vendoracwindow').jqxWindow('close');
	
	$('#jobsearchwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Insurance Type Search' , position: { x: 150, y: 50 }, keyboardCloseKey: 27});
	$('#jobsearchwindow').jqxWindow('close');
	 
	$('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
    $('#sourcesearchwndow').jqxWindow('close'); 
    
    $('#txtsource').dblclick(function(){
    	$('#sourcesearchwndow').jqxWindow('open');
		 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));  
    });
});     
	function getSource(event){
		 var x= event.keyCode;
		 if(x==114){
			 $('#sourcesearchwndow').jqxWindow('open');
			 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));   
		}
		 else{
			 
		 }
	}        
	
    function sourceinfoSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#sourcesearchwndow').jqxWindow('open');
		$('#sourcesearchwndow').jqxWindow('setContent', data);

	}); 
	}
	function getvendorac(rowindex){   
	 	 $('#vendoracwindow').jqxWindow('open');
	 	 vendorSearchContent('vendorSearch.jsp?rowindex='+rowindex); 	 
	}

	function funClear(){
		$('#txttenantdocno').val('');
		$('#txttenant').val('');
	} 
	function vendorSearchContent(url) { 
	 	 $.get(url).done(function (data) { 
			 $('#vendoracwindow').jqxWindow('setContent', data); 
		 	 }); 
	     }
	
	function getjob(rowindex){   
	 	 $('#jobsearchwindow').jqxWindow('open');
	 	jobSearchContent('jobSearch.jsp?rowindex='+rowindex); 	 
	} 
	        	 
	function jobSearchContent(url) { 
	 	 $.get(url).done(function (data) { 
			 $('#jobsearchwindow').jqxWindow('setContent', data); 
		 	 }); 
	     }
	
	function getTenant(event){
		refsearchContent1('tmainsearch.jsp');
	}

	function refsearchContent2(url) {
		$('#refnosearchwindow1').jqxWindow('open');
		$.get(url).done(function (data) {
		//alert(data);
			$('#refnosearchwindow1').jqxWindow('setContent', data);
		}); 
	}	
	
	function getProperty(event){
		refsearchContent1('pmainsearch.jsp');
	}

	function refsearchContent1(url) {
		$('#refnosearchwindow').jqxWindow('open');
		  $.get(url).done(function (data) {
		//alert(data);
			$('#refnosearchwindow').jqxWindow('setContent', data);
		 }); 
	}	
	
	 function getGroup() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var groupItems = items[0].split(",");
  				var groupIdItems = items[1].split(",");
  				var optionsgroup = '<option value="">--Select--</option>';
  				for (var i = 0; i < groupItems.length; i++) {
  					optionsgroup += '<option value="' + groupIdItems[i] + '">'
  							+ groupItems[i] + '</option>';
  				}
  				$("select#cmbnation").html(optionsgroup);
  				if ($('#hidcmbnation').val() != null) {
  					$('#cmbnation').val($('#hidcmbnation').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getGroup.jsp", true);
  		x.send();
  	}  
	
	 function getCategory() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var categoryItems = items[0].split(",");
  				var categoryIdItems = items[1].split(",");
  				var optionscategory = '<option value="">--Select--</option>';
  				for (var i = 0; i < categoryItems.length; i++) {
  					optionscategory += '<option value="' + categoryIdItems[i] + '">'
  							+ categoryItems[i] + '</option>';
  				}
  				$("select#cmbcategory").html(optionscategory);
  				if ($('#hidcmbcategory').val() != null) {
					$('#cmbcategory').val($('#hidcmbcategory').val());
				}
  			} else {
  			}
  			
  		}
  		x.open("GET", "getCategory.jsp", true);
  		x.send();
  	}
	
	function getType() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var typeItems = items[0].split(",");
  				var typeIdItems = items[1].split(",");
  				var optionstype ;
  				for (var i = 0; i < typeItems.length; i++) {
  					optionstype += '<option value="' + typeIdItems[i] + '">'
  							+ typeItems[i] + '</option>';
  				}
  				$("select#cmbtype").html(optionstype);
  				if ($('#hidcmbtype').val() != null) {
  					$('#cmbtype').val($('#hidcmbtype').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getType.jsp", true);
  		x.send();
  	}
	
	function getTypeAllowed(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  			    if(parseInt(items)==1) {
  			    	$('#typeallowed').val(1);
  			    	document.getElementById("lbltypeentity").style.display = 'inline-block';
  			    	document.getElementById("lbltrnnoentity").style.display = 'none';
  			    	$('#cmbtype').attr('hidden', false);
  			    	$('#txtregisteredtrnno').attr('hidden', true);
  			    } else {
  			    	$('#typeallowed').val(0);
  			    	document.getElementById("lbltypeentity").style.display = 'none';
  			    	document.getElementById("lbltrnnoentity").style.display = 'none';
  			    	$('#cmbtype').attr('hidden', true);
  			    	$('#txtregisteredtrnno').attr('hidden', true);
  			    }
  			    
  		}
  		}
  		x.open("GET", "getTypeAllowed.jsp", true);
  		x.send();
 }
	
	function getCategoryAccountGroup(a) {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  			    $('#hidcmbaccgroup').val(items);
  				
  				if ($('#hidcmbaccgroup').val() != null || $('#hidcmbaccgroup').val() != "") {
  					$('#cmbaccgroup').val($('#hidcmbaccgroup').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
  		x.send();
  	} 
      
	function getCurrencyIds(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('####');
		        var curidItems=items[0];
		        var curcodeItems=items[1];
		        var multiItems=items[2];
		        var optionscurr = '';
		        
		     if(curcodeItems.indexOf(",")>=0){
		        	var currencyid=curidItems.split(",");
		        	var currencycode=curcodeItems.split(",");
		        	multiItems.split(",");
		       
		       for ( var i = 0; i < currencycode.length; i++) {
		    	   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
		        }
		      
		         $("select#cmbcurrency").html(optionscurr);
		         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
		       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
		         } 
				     
			   }
		
		       else{
		    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
		    	   
			    	 $("select#cmbcurrency").html(optionscurr);
			       
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         }
			      }
			}
	     }
	      x.open("GET", "getCurrencyId.jsp",true);
	     x.send();
	    
	   }
	   
	   function getVendorAlreadyExists(vendorname,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					 document.getElementById("errormsg").innerText="Vendor Already Exists.";
  					 return 0;
  				 }else{
  					$('#cmbaccgroup').attr('disabled', false);
  					$("#frmVendorDetails").submit();
  				 }
  			   
  		}
	}
	x.open("GET", "getVendorAlreadyExists.jsp?vendorname="+vendorname+"&docno="+docno+"&mode="+mode, true);
	x.send();
    }
	
	function getMobileNoAlreadyExists(mobileno,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					 $.messager.alert('Message','Mobile No. Already Exists.','warning');
  					 return 0;
  				 }
  		}
	}
	x.open("GET", "getMobileNoAlreadyExists.jsp?mobileno="+mobileno+"&docno="+docno+"&mode="+mode, true);
	x.send();
	}
	
	function typecheck() {
		 if($('#cmbtype').val()=='1'){
			 document.getElementById("lbltrnnoentity").style.display = 'inline-block';
			 if($('#mode').val()!='view'){
			 	$('#txtregisteredtrnno').val('');
			 }
		     $('#txtregisteredtrnno').attr('hidden', false);
		 }
		 else{
			 document.getElementById("lbltrnnoentity").style.display = 'none';
			 if($('#mode').val()!='view'){
				 	$('#txtregisteredtrnno').val('');
			 }
		     $('#txtregisteredtrnno').attr('hidden', true);
		 }
	 } 
      
	 function funReadOnly(){
		 $('#frmMaintenanceRequest input').attr('readonly', true );
	     $('#frmMaintenanceRequest select').attr('disabled', true); 
		 $('#jqxDate').jqxDateTimeInput({disabled: true});
		 
	 	 $('#txtproperty').attr('disabled', true); 
	 	 $('#txttenant').attr('disabled', true); 
 }
	 
	 function funRemoveReadOnly(){
		   /*  getCurrencyIds();getTypeAllowed(); */
		    
			$('#frmMaintenanceRequest input').attr('readonly', false );
			$('#frmMaintenanceRequest select').attr('disabled', false); 
			$('#jqxDate').jqxDateTimeInput({disabled: false}); 
			$('#vdocno').attr('readonly', true); 
			if ($("#mode").val() == "A") {
				$('#jqxDate').val(new Date()); 
				$("#jqxRequestGrid").jqxGrid('clear');  
			}
			$("#jqxRequestGrid").jqxGrid({disabled : false});
			$('#txtproperty').attr('disabled', false); 
			$('#txttenant').attr('disabled', false); 
			$('#txtrbsmnt').attr('readonly', false);   
			
	 }
	function funNotify(){	 
		 docno=document.getElementById("docno").value;
		 mode=document.getElementById("mode").value;
		 
		// set access grid into a textbox 		 
			var rqrows = $("#jqxRequestGrid").jqxGrid('getrows');
			var rqstlength = 0;
			for (var i = 0; i < rqrows.length; i++) {
				var chks = rqrows[i].job;
				if (typeof (chks) != "undefined" && typeof (chks) != "NaN"
						&& chks != "") {
					newTextBox = $(document.createElement("input"))
					.attr("type","dil")
							.attr("id", "txtrqst" + rqstlength)
							.attr("name", "txtrqst" + rqstlength)
							.attr("hidden","true");
					rqstlength = rqstlength + 1;
						//						0						1							2						3						4							5						7
					newTextBox.val(rqrows[i].job_docno+"::"+rqrows[i].vendor_acno+"::"+rqrows[i].priority+"::"+rqrows[i].est_cost+"::"+rqrows[i].notify_owner+"::"+rqrows[i].comments+"::"+rqrows[i].doc_no);
					newTextBox.appendTo('form');
				}
			}
			
			$('#txtrequestgridlength').val(rqstlength); 
			// set access grid into a textbox

		 
		return 1;
	} 
	 
	 function funSearchLoad(){
			changeContent('requestSearch.jsp'); 
		 }
	 
	 function funFocus()
	    {
	    	$('#jqxDate').jqxDateTimeInput('focus'); 	    		
	    }
	 function setValues(){
		
		 if($('#hidjqxDate').val()){ 
			 $("#jqxDate").jqxDateTimeInput('val', $('#hidjqxDate').val());     
		  }
		
		 
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 if(document.getElementById("docno").value>0){
			 if(document.getElementById("hidchkrbsmnt").value=="1"){                 
					  document.getElementById("txtrbsmnt").checked = true;      
				 }
			 } 
		// document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 editstatus();
		  $('#requestDiv').load("requestGrid.jsp?vocno=" + $("#vdocno").val()+"&brhid="+$("#hidbrhid").val()+"&id="+1);              
		 
		}
	 
	
		function isNumber(evt,id) {
			//Function to restrict characters and enter number only
				  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
			        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
			         {
			        	 //$.messager.alert('Warning','Enter Numbers Only');
			        	 $('#valmsg').html('Enter Numbers Only');
			        	 $('#validation_modal').modal('show');
			             $("#"+id+"").focus();
			             return false;
			            
			         }
			        
			        return true;
			    }
	 
		function ValidateNo(event,id) {
	        var phoneNo = document.getElementById('txtmobpho');
	        if(phoneNo.value.length == 0){
	        }
	        else if (phoneNo.value.length < 12 || phoneNo.value.length > 12 || phoneNo.value.length == 0) {
	        	 //$.messager.alert('Warning','Enter 12 Digit Mobile Number');
	        	  $('#valmsg').html('Enter 12 Digit Mobile Number');
	        	 $('#validation_modal').modal('show');
	            return false;
	        
	        }
	        return true;
	        }
		function  chkval()
		 {
			 if(document.getElementById("txtrbsmnt").checked==true)
				 {
				 document.getElementById("hidchkrbsmnt").value=1;
				 }
			 else
				 {
				 document.getElementById("hidchkrbsmnt").value=0;
				 }     	 
		 }
		 function editstatus(){
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();	
						
						if(parseInt(items)>0)
							{
					         
							 $("#btnEdit").attr('disabled', true );   
							 $('#btnDelete').attr('disabled', true );
							}
						else
							{
							
							 $("#btnEdit").attr('disabled', false );           
							 $('#btnDelete').attr('disabled', false );
							}
						
					} else {  
					}  
				}
				x.open("GET", "getEditStat.jsp?vocno=" + $("#vdocno").val()+"&brhid="+$("#hidbrhid").val(), true); 
				x.send();
			}    
</script>

<style>
.hidden-scrollbar {
	overflow: auto;
	height: 530px;
}
</style>

</head>
<body onload="setValues();editstatus();">
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmTenantRequest" action="saveTenantrequest"
			method="post" autocomplete="off">
			<jsp:include page="../../../header.jsp"></jsp:include><br />
			<div class='hidden-scrollbar'>
				<div class="clearfix"></div>
				<div class="container-fluid">
					<!-- margin: 5px; box-shadow: 1px 2px 7px 0px #ccc; -->
					<div class="row" style="padding: 1em 0px; border: #ccc;">
						<div class="col-md-2">
							<div class="col-md-5">Doc No</div>
							<div class="col-md-7">
								<input type="text" id="vdocno" name="vdocno"
									style="text-align: right;width:100%;" tabindex="-1"
									value='<s:property value="vdocno"/>' /> <input type="hidden"
									id="docno" name="docno" style="text-align: right" tabindex="-1"
									value='<s:property value="vdocno"/>' />
							</div>
						</div>
						<div class="col-md-2">
							<div class="col-md-3">Date</div>
							<div class="col-md-9">
								<div id="jqxDate" name="jqxDate"
									style="height: 23px !important;"
									value='<s:property value="jqxDate"/>'></div>
								<input type="hidden" id="hidjqxDate" name="hidjqxDate"
									value='<s:property value="hidjqxDate"/>' /> <input
									type="hidden" id="vocno" name="vocno" style="width: 50%;"
									tabindex="-1" value='<s:property value="vocno"/>' />
									
									
							</div>
						</div>
						<div class="col-md-2">
								<div class="col-md-3">Time</div>
									<div class="col-md-9">								  
												<div id="rtime" name="rtime"
											style="height: 23px !important;"
											value='<s:property value="rtime"/>'></div>
								</div>
						</div>
						<div class="col-md-3">
						         <div class="col-md-2">	
						                  <input type="checkbox" id="txtrbsmnt" name="txtrbsmnt" onchange="chkval();" value='<s:property value="txtrbsmnt"/>' />    
							              <input type="hidden" id="hidchkrbsmnt" name="hidchkrbsmnt" value='<s:property value="hidchkrbsmnt"/>' />
								</div>
								<div class="col-md-10">Reimbursement</div>  
						</div>
						<div class="col-md-3">   
							<div class="col-md-5">Source</div>  
							<div class="col-md-7">   
								<input type="text" id="txtsource" name="txtsource"
									style="text-align: left;width:100%;" tabindex="-1"
									value='<s:property value="txtsource"/>' readonly placeholder="Press F3 To Search" /> <input type="hidden"      
									id="sourceid" name="sourceid" style="text-align: left" tabindex="-1"
									value='<s:property value="sourceid"/>' />
							</div>
						</div>
					</div>

					<div class="row" style="padding-bottom: 1em;">
						<div class="col-md-5">
							<div class="col-md-2">Property</div>
							<div class="col-md-8">
								<input type="text" id="txtproperty" name="txtproperty"
									style="width: 100%;" placeholder="Press F3 to Search"
									value='<s:property value="txtproperty"/>'
									onkeydown="getProperty(event);" /> 
									<input type="hidden"
									id="txtpropertydocno" name="txtpropertydocno" value='<s:property value="txtpropertydocno"/>' />
							</div>
						</div>
						<div class="col-md-5">
							<div class="col-md-2">Tenant</div>
							<div class="col-md-8">
								<input type="text" id="txttenant" name="txttenant"
									style="width: 100%;" placeholder="Press F3 to Search"
									value='<s:property value="txttenant"/>'
									onkeydown="getTenant(event);" /> 
									<input type="hidden"
									id="txttenantdocno" name="txttenantdocno" value='<s:property value="txttenantdocno"/>' />
							</div> 
							<div class="col-md-2">
									<button type="button" class="bicon" id="clear" title="clear" onclick="funClear()"> 
										<img alt="clear" src="<%=contextPath%>/icons/clear.png">
									</button> </div>
							
						</div>
					</div> 
					<div class="row">
						<div class="col-md-12">  
							<div id="requestDiv">
								<jsp:include page="requestGrid.jsp"></jsp:include><br />
							</div>
						</div> 
					</div>
				</div>
				<input type="hidden" id="mode" name="mode" /> 
				<input type="hidden" id="hidbrhid" name="hidbrhid" value='<s:property value="hidbrhid"/>'/>    
				<input type="hidden"
					id="deleted" name="deleted" value='<s:property value="deleted"/>' />
				<input type="hidden" id="msg" name="msg"
					value='<s:property value="msg"/>' /> <input type="hidden"
					id="txtmobilevalidation" name="txtmobilevalidation"
					value='<s:property value="txtmobilevalidation"/>' /> <input
					type="hidden" id="typeallowed" name="typeallowed"
					value='<s:property value="typeallowed"/>' />
					 
					<input type="hidden"
					id="txtrequestgridlength" name="txtrequestgridlength"
					value='<s:property value="txtrequestgridlength"/>' />
			</div>
		</form>  
		<div id="sourcesearchwndow">      
			<div></div>
		</div>
		<div id="refnosearchwindow1">
			<div></div>
		</div>
		<div id="refnosearchwindow">
			<div></div>
		</div>
		<div id="jobsearchwindow">
			<div></div>
		</div>
		<div id="vendoracwindow">
			<div></div>
		</div>
	</div>
</body>
</html>
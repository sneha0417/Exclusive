<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

.modern-ui form label.error {
    color: red;
    font-weight: bold;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui input[type="email"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui input[type="email"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Tab overrides for modern UI matching */
.nav-tabs {
    border-bottom: 2px solid #c5d3e0;
    margin-bottom: 15px;
}
.nav-tabs > li > a {
    border-radius: 4px 4px 0 0;
    color: #444;
    font-weight: bold;
    font-size: 12px;
    padding: 8px 15px;
}
.nav-tabs > li.active > a, 
.nav-tabs > li.active > a:focus, 
.nav-tabs > li.active > a:hover {
    color: #0056b3;
    border: 2px solid #c5d3e0;
    border-bottom-color: transparent;
    background-color: #fff;
}
.tab-content {
    padding-top: 10px;
}

/* Button overrides for inline grid Add */
#btnaddtoGrid {
	background: #00c4ff;
	border: none;
	padding: 0 10px;
	color: #fff;
	height: 24px;
	border-radius:3px;
	font-weight: bold;
}
</style>

<script type="text/javascript">

$(document).ready(function () { 		
	 /* Date */
	 $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#nationalityWindow').jqxWindow('close');
	 $("#jqxDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
	 $("#jqxBirthDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
	 $("#jqxexpiryDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
	 
	 /* force internal alignment AFTER render */
     setTimeout(function () {
         $("#jqxDate, #jqxBirthDate, #jqxexpiryDate").find("input").css({
             "margin-top": "0px",
             "line-height": "24px",
             "font-size": "12px", 
             "font-family": "Arial, sans-serif", 
             "padding": "0 6px", 
             "box-sizing":"border-box"
         });
         $("#jqxDate, #jqxBirthDate, #jqxexpiryDate").find(".jqx-action-button").css({
             "top": "0px",
             "height": "24px"
         });
     }, 0);
	 
	 getCurrencyIds();getCategory();getGroup();getTypeAllowed();getType(); 
	 $('#txtnationality').dblclick(function(){
	 	 $('#nationalityWindow').jqxWindow('open');	 	   
	 	 bdcSearchContent('nationsearchGrid.jsp?'); 	         
	 }); 
});  

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
			$('#frmPropertyOwner input').attr('readonly', true );
		    $('#frmPropertyOwner select').attr('disabled', true); 
			$('#jqxDate').jqxDateTimeInput({disabled: true});
			
			$('#jqxBirthDate').jqxDateTimeInput({disabled: true});
			$('#jqxexpiryDate').jqxDateTimeInput({disabled: true});				
			 
	 }
	
function funRemoveReadOnly(){
			$('#frmPropertyOwner input').attr('readonly', false );
			$('#frmPropertyOwner select').attr('disabled', false); 
			$('#jqxDate').jqxDateTimeInput({disabled: false});
			$('#jqxBirthDate').jqxDateTimeInput({disabled: false});
			$('#jqxexpiryDate').jqxDateTimeInput({disabled: false});
			
			$('#txtaccount').attr('readonly', true);
			$('#txtcode').attr('readonly', true);
			$('#cmbaccgroup').attr('disabled', true);
			$('#docno').attr('readonly', true);
			$('#txtOwnerId').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#jqxDate').val(new Date());				
				$('#jqxBirthDate').val(new Date());
				$('#jqxexpiryDate').val(new Date());
				
				$("#jqxaccGrid").jqxGrid('clear'); 
				
				$('#lblowneraccount').hide();
			}
	 }

function funNotify(){	
		  var tel1=$('#txttelepho').val();		
		  if(tel1 !="")
		  {
			 if(!tel1.match(/^\d+$/))
			  {		  
				 document.getElementById("errormsg").innerText="Enter Numbers only in Telephone1.";
				 return 0;
		      }
		   }
			 
			 var tel2=$('#txttelepho2').val();		
			 if(tel2 !="")
			 {
				 if(!tel2.match(/^\d+$/))
				  {		  
					 document.getElementById("errormsg").innerText="Enter Numbers only in Telephone2.";
					 return 0;
			      }
			  }
			 
			 var mob1=$('#txtmobpho').val();		
			 if(mob1 !="")
			 {
				 if(!mob1.match(/^\d+$/))
				  {		  
					 document.getElementById("errormsg").innerText="Enter Numbers only in Mobile1.";
					 return 0;
			      }
			  }
			 
			 var mob2=$('#txtmobpho2').val();	
			 if(mob2 !="")
			 {	 
				 if(!mob2.match(/^\d+$/))
				  {		  
					 document.getElementById("errormsg").innerText="Enter Numbers only in Mobile2.";
					 return 0;
			      }
			  }
		
		        // spl ins grid
		        var rows1 = $("#jqxsplGrid").jqxGrid('getrows');
				var splinslen = 0;
				for (var i = 0; i < rows1.length; i++) {	
					  var desc=rows1[i].desc1;
					  if (typeof (desc) != "undefined" && typeof (desc) != "NaN" && desc != "") {  
								newTextBox = $(document.createElement("input"))
								.attr("type","dil")
										.attr("id", "splins" + splinslen)
										.attr("name", "splins" + splinslen)
										.attr("hidden","true");
								splinslen = splinslen + 1;
								newTextBox.val(rows1[i].rowno+"::"+rows1[i].desc1);   
								newTextBox.appendTo('form');
					}				
				}  
				$('#splgridlength').val(splinslen);   
		        // set acc grid into a textbox 		 
				var accrows = $("#jqxaccGrid").jqxGrid('getrows');
				var accllength = 0;
				var no_of_ticks=0;	
				for (var i = 0; i < accrows.length; i++) {	
					var defaultacc=0;
					var chks = accrows[i].chk;
					var bname=accrows[i].bankname;
					  if (typeof (bname) != "undefined" && typeof (bname) != "NaN" && bname != "") {  
						  //alert(chks);
							if (chks) { 
								no_of_ticks=no_of_ticks+1;
								defaultacc=1;
							} 
								newTextBox = $(document.createElement("input"))
								.attr("type","dil")
										.attr("id", "txtaccdet" + accllength)
										.attr("name", "txtaccdet" + accllength)
										.attr("hidden","true");
								accllength = accllength + 1;
								newTextBox.val(accrows[i].doc_no+"::"+accrows[i].bankname+"::"+accrows[i].accnumber+"::"+accrows[i].accname+"::"+accrows[i].bankaddress+"::"+accrows[i].countryid+"::"+accrows[i].currencyid+"::"+accrows[i].swiftcode+"::"+accrows[i].iban+"::"+accrows[i].remarks+"::"+defaultacc);
								newTextBox.appendTo('form');
					}				
				} 
				if(accrows.length>0)
				{
					if(no_of_ticks>1)
					{
						 document.getElementById("errormsg").innerText="Select Only one account as default.";
						 no_of_ticks=0;
						 return 0;	
					}
					if(no_of_ticks==0)
					{
						 document.getElementById("errormsg").innerText="Select atleast one account as default.";
						 no_of_ticks=0;
						 return 0;	
					}
				}
				$('#accgridlength').val(accllength); 
		       
		 docno=document.getElementById("docno").value;
		 mode=document.getElementById("mode").value;
		return 1;
		} 
	
function funSearchLoad(){
			changeContent('pownerMainSearch.jsp'); 
		 }
	
function funFocus()
	    {
	    	$('#jqxDate').jqxDateTimeInput('focus'); 	    		
	    }
	
function setValues(){
		 $("#formdetail").val("Property Owner");
	     $("#formdetailcode").val("RPRO");
	     $("#formdet").html("Property Owner(RPRO)");
		 window.parent.formCode.value="RPRO";
		 window.parent.formName.value="Property Owner"; 
		
		 getCurrencyIds();
		 if($('#hidjqxDate').val()){ 
			 $("#jqxDate").jqxDateTimeInput('val', $('#hidjqxDate').val());
		  }
		 if($('#hidjqxBirthDate').val()){
			 $("#jqxBirthDate").jqxDateTimeInput('val', $('#hidjqxBirthDate').val());
		  }
		 if($('#hidjqxexpiryDate').val()){
			 $("#jqxexpiryDate").jqxDateTimeInput('val', $('#hidjqxexpiryDate').val());
		  }
		 
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		  }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 
		 $("#accgriddiv").load("accountGrid.jsp?docno="+$("#docno").val());
		 $("#splinsdiv").load("splinstructionGrid.jsp?docno="+$("#docno").val()+"&id="+1);                           
		 
		 var acno=$('#hidowneraccount').val();
		 
		 if(acno!="")
		 {
			 $('#divownerac').show();
			 $('#lblowneraccount').text("Owner Account Number: " + acno);
		 }
		 funSetlabel();
		  
		}
		
function isNumber(evt,id) {
			//Function to restrict characters and enter number only
				  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
			        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
			         {
			         	 $.messager.alert('Warning','Enter Numbers Only');			         
			             $("#"+id+"").focus();
			             return false;			            
			         }
			        
			        return true;
			    }

function getBDcenter(event)	{
			var x= event.keyCode;
		    if(x==114){
		     bdcSearchContent('nationsearchGrid.jsp');
		    }
		    else{
		     }
		}

function bdcSearchContent(url) {
		    $('#nationalityWindow').jqxWindow('open');
		 $.get(url).done(function (data) {
		 $('#nationalityWindow').jqxWindow('setContent', data);
		 $('#nationalityWindow').jqxWindow('bringToFront');
		}); 
		 
		}

function ValidateNo(event,id) {
	        var phoneNo = document.getElementById(id);
	        if(phoneNo.value.length == 0){
	        }
	        else if (phoneNo.value.length < 12 || phoneNo.value.length > 12 || phoneNo.value.length == 0) {
	        	 $('#valmsg').html('Enter 12 Digit Mobile Number');
	        	 $('#validation_modal').modal('show');
	            return false;
	        
	        }
	        return true;
	        }
		
function getCountry() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var countryId  = items[0].split(":");
					var country = items[1].split(":");
					var optionscard = '<option value="">--Select--</option>';
					for (var i = 0; i < country.length; i++) {
						optionscard += '<option value="' + countryId[i] + '">'
								+ country[i] + '</option>';
					}
					$("select#cmbbankcountry").html(optionscard);
				} else {
				}
			};
			x.open("GET", "getCountry.jsp", true);
			x.send();
		}  
		
function funAddtoGrid() 
	{			
		var rowid=$('#gridrowindex').val();
		
		if( typeof (rowid) != "undefined" && typeof (rowid) != "NaN" && rowid != "")
		{ 
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "bankname", document.getElementById("txtbankname").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "accnumber", document.getElementById("txtaccountno").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "accname", document.getElementById("txtaccountname").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "bankaddress", document.getElementById("txtbankaddress").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "countryid", document.getElementById("cmbbankcountry").value);			
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "currencyid", document.getElementById("cmbcurrency").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "swiftcode", document.getElementById("txtbankswift").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "iban", document.getElementById("txtbankiban").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "remarks", document.getElementById("txtbankremarks").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "doc_no", document.getElementById("accdocno").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "chk", document.getElementById("defaultacc").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "currency",$("#cmbcurrency option:selected").text());
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "country", $("#cmbbankcountry option:selected").text());
		}
		else
		{
			 var bname = $('#txtbankname').val();
			 var ano=$('#txtaccountno').val();
			 var aname = $('#txtaccountname').val();
			 var baddr=$('#txtbankaddress').val();
			 var bcountryid = $('#cmbbankcountry').val();
			 var bcountry=$("#cmbbankcountry option:selected").text();
			 var currencyid=$('#cmbcurrency').val();
			 var currency=$("#cmbcurrency option:selected").text();
			 var swiftcode = $('#txtbankswift').val();
			 var iban=$('#txtbankiban').val();
			 var remark = $('#txtbankremarks').val(); 
			 var doc=$('#accdocno').val(); 
            
			 var data = {
             	 doc_no:doc,
                 bankname: bname,
                 accnumber:ano,
                 accname:aname,
                 bankaddress:baddr,
                 countryid:bcountryid,
                 country:bcountry,
                 currencyid:currencyid,
                 currency:currency,
                 swiftcode:swiftcode,
                 iban:iban,
                 remarks:remark,
                 chk:false
             };
             
             $("#jqxaccGrid").jqxGrid('addrow', null, data);
		 }
		    
       clearinput();
            
	 }
	
function clearinput()
		{
			  $('#txtbankname').val('');
			  $('#txtaccountno').val('');
			  $('#txtaccountname').val('');
			  $('#txtbankaddress').val('');
			  $('#cmbbankcountry').val('');
			  $('#cmbcurrency').val(''); 
			  $('#txtbankswift').val('');
			  $('#txtbankiban').val('');
			  $('#txtbankremarks').val(''); 
		}

</script>

</head>
<body onload="setValues();getCountry();">
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmPropertyOwner" action="savePropertyOwner" method="post" autocomplete="off">
			<jsp:include page="../../../header.jsp"></jsp:include>
			
			<div class='modern-ui hidden-scrollbar'>
                
                <div id="divownerac" style="display:none; padding:10px; margin-bottom: 10px;">
					<label id="lblowneraccount" style="color:green; font-weight: bold;"></label> 
				</div>

                <!-- Top Info Bar -->
                <div class="middle-panel">
                    <span class="middle-panel-title">General Info</span>
                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:80px;">Doc No</label>
                        <input type="text" id="docno" name="docno" style="width:120px;" tabindex="-1" readonly value='<s:property value="docno"/>' />
                        
                        <label class="lbl-right" style="width:80px; margin-left: 15px;">Owner ID</label>
                        <input type="text" id="txtOwnerId" name="txtOwnerId" readonly style="width:120px;" tabindex="-1" value='<s:property value="docno"/>' />
                        
                        <label class="lbl-right" style="width:80px; margin-left: 15px;">Ejari No</label>
                        <input type="text" id="txtejarino" name="txtejarino" style="width:120px;" value='<s:property value="txtejarino"/>' />
                        
                        <label class="lbl-right" style="width:80px; margin-left: auto;">Date</label>
                        <div style="width: 120px;">
                            <div id="jqxDate" name="jqxDate" value='<s:property value="jqxDate"/>'></div>
                            <input type="hidden" id="hidjqxDate" name="hidjqxDate" value='<s:property value="hidjqxDate"/>' /> 
                            <input type="hidden" id="vocno" name="vocno" tabindex="-1" value='<s:property value="vocno"/>' />
                        </div>
                    </div>
                </div>

                <!-- Tabs Section -->
                <div style="margin-top: 15px;">
                    <ul class="nav nav-tabs">
                        <li class="active"><a data-toggle="tab" href="#home">Owner Details</a></li>
                        <li><a data-toggle="tab" href="#menu1">Passport Details</a></li>
                        <li><a data-toggle="tab" href="#menu2">Account Details</a></li>
                        <li><a data-toggle="tab" href="#menu3">Special Instruction</a></li>        
                    </ul>

                    <div class="tab-content">
                        <!-- Owner Details Tab -->
                        <div id="home" class="tab-pane fade in active">
                            <div class="middle-panel" style="margin-top:0;">
                                <div class="field-row">
                                    <label class="lbl-right" style="width:120px;">Primary Owner</label>
                                    <input type="text" id="txtprimeowner" name="txtprimeowner" required style="flex:1; max-width:400px;" value='<s:property value="txtprimeowner"/>' />
                                    
                                    <label class="lbl-right" style="width:80px; margin-left:15px;">Co Owner 1</label>
                                    <input type="text" id="txtcoowner1" name="txtcoowner1" style="flex:1; max-width:400px;" value='<s:property value="txtcoowner1"/>' />
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:120px;">Alias Name</label>
                                    <input type="text" id="txtaliasname" name="txtaliasname" style="flex:1; max-width:400px;" value='<s:property value="txtaliasname"/>' />
                                    
                                    <label class="lbl-right" style="width:80px; margin-left:15px;">Co Owner 2</label>
                                    <input type="text" id="txtcoowner2" name="txtcoowner2" style="flex:1; max-width:400px;" value='<s:property value="txtcoowner2"/>' />
                                </div>
                                <div class="field-row" style="margin-bottom:0;">
                                    <label class="lbl-right" style="width:120px;">Special Instruction</label>
                                    <input type="text" id="txtspecialinstructions" name="txtspecialinstructions" style="flex:1;" value='<s:property value="txtspecialinstructions"/>' />
                                </div>
                            </div>
                            
                            <div class="middle-panel">
                                <span class="middle-panel-title">Personal Details</span>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:80px;">DOB</label>
                                    <div style="width: 120px;">
                                        <div id="jqxBirthDate" name="jqxBirthDate" value='<s:property value="jqxBirthDate"/>'></div>
                                        <input type="hidden" id="hidjqxBirthDate" name="hidjqxBirthDate" value='<s:property value="hidjqxBirthDate"/>' />
                                    </div>
                                    
                                    <label class="lbl-right" style="width:80px; margin-left:15px;">Address 1</label>
                                    <input type="text" id="txtaddress" name="txtaddress" style="flex:1;" value='<s:property value="txtaddress"/>' />
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:80px;">Telephone 1</label>
                                    <input type="text" id="txttelepho" name="txttelepho" maxlength="15" onkeypress="javascript:return isNumber (event,id)" style="width: 120px;" value='<s:property value="txttelepho"/>' />
                                    
                                    <label class="lbl-right" style="width:80px; margin-left:15px;">Address 2</label>
                                    <input type="text" id="txtaddress2" name="txtaddress2" style="flex:1;" value='<s:property value="txtaddress2"/>' />
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:80px;">Telephone 2</label>
                                    <input type="text" id="txttelepho2" name="txttelepho2" maxlength="15" onkeypress="javascript:return isNumber (event,id)" style="width: 120px;" value='<s:property value="txttelepho2"/>' />
                                    
                                    <label class="lbl-right" style="width:80px; margin-left:15px;">Mobile 1</label>
                                    <input type="text" id="txtmobpho" name="txtmobpho" maxlength="15" onkeypress="javascript:return isNumber (event,id)" style="width: 120px;" value='<s:property value="txtmobpho"/>' />
                                    
                                    <label class="lbl-right" style="width:80px; margin-left:15px;">Mobile 2</label>
                                    <input type="text" id="txtmobpho2" name="txtmobpho2" maxlength="15" onkeypress="javascript:return isNumber (event,id)" style="width: 120px;" value='<s:property value="txtmobpho2"/>' />
                                </div>
                                <div class="field-row" style="margin-bottom:0;">
                                    <label class="lbl-right" style="width:80px;">Email 1</label>
                                    <input type="email" id="txtemail" name="txtemail" style="flex:1; max-width:300px;" value='<s:property value="txtemail"/>' />
                                    
                                    <label class="lbl-right" style="width:80px; margin-left:15px;">Email 2</label>
                                    <input type="email" id="txtemail2" name="txtemail2" style="flex:1; max-width:300px;" value='<s:property value="txtemail2"/>' />
                                </div>
                            </div>
                        </div>

                        <!-- Passport Details Tab -->
                        <div id="menu1" class="tab-pane fade">
                            <div class="middle-panel" style="margin-top:0;">
                                <div class="field-row">
                                    <label class="lbl-right" style="width:120px;">Passport Number</label>
                                    <input type="text" id="txtpassport" name="txtpassport" style="width: 150px;" value='<s:property value="txtpassport"/>' />
                                    
                                    <label class="lbl-right" style="width:120px; margin-left:15px;">Place Of Issue</label>
                                    <input type="text" id="txtissuedplace" name="txtissuedplace" style="flex:1; max-width:300px;" value='<s:property value="txtissuedplace"/>' />
                                </div>
                                <div class="field-row" style="margin-bottom:0;">
                                    <label class="lbl-right" style="width:120px;">Expiry Date</label>
                                    <div style="width: 120px;">
                                        <div id="jqxexpiryDate" name="jqxexpiryDate" value='<s:property value="jqxexpiryDate"/>'></div>
                                        <input type="hidden" id="hidjqxexpiryDate" name="hidjqxexpiryDate" value='<s:property value="hidjqxexpiryDate"/>' />
                                    </div>
                                    
                                    <label class="lbl-right" style="width:120px; margin-left:15px;">Nationality</label>
                                    <div class="input-search-container" style="width: 150px;">
                                        <input type="text" id="txtnationality" name="txtnationality" placeholder="Press F3" onkeydown="getBDcenter(event)" value='<s:property value="txtnationality"/>' />
                                        <svg class="magnifier-icon" onclick="$('#nationalityWindow').jqxWindow('open'); bdcSearchContent('nationsearchGrid.jsp?');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                    </div>
                                    <input type="hidden" id="natid" name="natid" value='<s:property value="natid"/>' />
                                </div>
                            </div>
                        </div>
                        
                        <!-- Account Details Tab -->
                        <div id="menu2" class="tab-pane fade">
                            <div class="middle-panel" style="margin-top:0;">
                                <div class="field-row">
                                    <label class="lbl-right" style="width:100px;">Bank Name</label>
                                    <input type="text" id="txtbankname" name="txtbankname" style="flex:1; max-width:250px;" value='<s:property value="txtbankname"/>' />
                                    
                                    <label class="lbl-right" style="width:100px; margin-left:15px;">Account No.</label>
                                    <input type="text" id="txtaccountno" name="txtaccountno" style="flex:1; max-width:250px;" value='<s:property value="txtaccountno"/>' />
                                    
                                    <label class="lbl-right" style="width:100px; margin-left:15px;">Account Name</label>
                                    <input type="text" id="txtaccountname" name="txtaccountname" style="flex:1; max-width:250px;" value='<s:property value="txtaccountname"/>' />
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:100px;">Bank Address</label>
                                    <input type="text" id="txtbankaddress" name="txtbankaddress" style="flex:1;" value='<s:property value="txtbankaddress"/>' />
                                    
                                    <label class="lbl-right" style="width:100px; margin-left:15px;">Country</label>
                                    <select id="cmbbankcountry" name="cmbbankcountry" style="width: 250px;"></select>
                                </div>
                                <div class="field-row">
                                    <label class="lbl-right" style="width:100px;">Preferred Curr.</label>
                                    <select id="cmbcurrency" name="cmbcurrency" style="width: 250px;" value='<s:property value="cmbcurrency"/>'>
                                        <option value="">--Select--</option>
                                    </select> 
                                    <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>' />
                                    
                                    <label class="lbl-right" style="width:100px; margin-left:15px;">Swift code</label>
                                    <input type="text" id="txtbankswift" name="txtbankswift" style="flex:1; max-width:250px;" value='<s:property value="txtbankswift"/>' />
                                    
                                    <label class="lbl-right" style="width:100px; margin-left:15px;">IBAN</label>
                                    <input type="text" id="txtbankiban" name="txtbankiban" style="flex:1; max-width:250px;" value='<s:property value="txtbankiban"/>' />
                                </div>
                                <div class="field-row" style="margin-bottom:0;">
                                    <label class="lbl-right" style="width:100px;">Remarks</label>
                                    <input type="text" id="txtbankremarks" name="txtbankremarks" style="flex:1;" value='<s:property value="txtbankremarks"/>' />
                                    
                                    <button type="button" id="btnaddtoGrid" onclick="funAddtoGrid();" style="margin-left:15px;">Add</button>
                                </div>
                                
                                <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>' /> 
                                <input type="hidden" id="defaultacc" name="defaultacc" value='<s:property value="defaultacc"/>' />
                            </div>
                            
                            <div class="middle-panel">
                                <div id="accgriddiv" class="grid-container" style="border:none;">
                                    <jsp:include page="accountGrid.jsp"></jsp:include>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Special Instruction Tab -->
                        <div id="menu3" class="tab-pane fade">
                            <div class="middle-panel" style="margin-top:0;">
                                <div id="splinsdiv" class="grid-container" style="border:none;">
                                    <jsp:include page="splinstructionGrid.jsp"></jsp:include>
                                </div>
                            </div>
                        </div>       
                        
                    </div>
                </div>

				<input type="hidden" id="mode" name="mode" /> 
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
				<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' /> 
                <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>' /> 
                <input type="hidden" id="typeallowed" name="typeallowed" value='<s:property value="typeallowed"/>' /> 
                <input type="hidden" id="gridrowindex" name="gridrowindex" value='<s:property value="gridrowindex"/>' />       
                <input type="hidden" id="splgridlength" name="splgridlength" value='<s:property value="splgridlength"/>' />
                <input type="hidden" id="accgridlength" name="accgridlength" value='<s:property value="accgridlength"/>' />
                <input type="hidden" id="hidowneraccount" name="hidowneraccount" value='<s:property value="hidowneraccount"/>' />
			</div>
		</form>
		<div id="nationalityWindow"><div></div></div>
	</div>
</body>
</html>
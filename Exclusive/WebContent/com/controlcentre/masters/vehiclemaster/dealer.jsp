<%@page import="com.controlcentre.masters.vehiclemaster.dealer.ClsDealerAction" %>
<%ClsDealerAction cda=new ClsDealerAction(); %>


<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
      $(document).ready(function () {          
    	  $("#dealerdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
    	  $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		  $('#accountWindow').jqxWindow('close');
		  
		  document.getElementById("formdet").innerText="Dealer(VDR)";
		  document.getElementById("formdetail").value="Dealer";
		  document.getElementById("formdetailcode").value="VDR";
		  window.parent.formCode.value="VDR";
		  window.parent.formName.value="Dealer";
 		 var data1= '<%=cda.searchDetails() %>';
             
             var num = 0; 
             var source =
             {
                 datatype: "json",
                 datafields: [
                           	{name : 'DOC_NO' , type: 'int' },
      						{name : 'name', type: 'String'  },
                           	{name : 'acc_no', type: 'String'  },
                           	{name : 'date',type:'date'},
                           	{name : 'description',type:'string'}
                           	
                  ],
                  localdata: data1,
                 
                 
                 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
             };
             
             var dataAdapter = new $.jqx.dataAdapter(source,
             		 {
                 		loadError: function (xhr, status, error) {
 	                    alert(error);    
 	                    }
 		            }		
             );
           
             $("#jqxDealerSearch1").jqxGrid(
                     {
                     	width: '100%',
                         height: 315,
                         source: dataAdapter,
                         showfilterrow: true,
                         filterable: true,
                         selectionmode: 'singlerow',
                       //  pagermode: 'default',
                         sortable: true,
                         //pageable: true,
                         altrows:true,
                         //Add row method
                         columns: [
         					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '10%' },
         					{ text: 'Dealer',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
         					{ text: 'Acc No',columntype: 'textbox', filtertype: 'input', datafield: 'acc_no', width: '20%',hidden:true },
         					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
         					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '40%' },
         					]
                     });

             $('#jqxDealerSearch1').on('rowdoubleclick', function (event) 
             		{ 
 		            	var rowindex1=event.args.rowindex;
 		                document.getElementById("docno").value= $('#jqxDealerSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
 		                document.getElementById("dealername").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "name");
 		                $("#dealerdate").jqxDateTimeInput('val',$("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
 		                document.getElementById("txtaccname").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "description");
 		                document.getElementById("txtaccno").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "acc_no");
             		 });           		 
           		 });
      function accountSearchContent(url) {
		  $('#accountWindow').jqxWindow('open');
			 $.get(url).done(function (data) {
				// alert(data);
			$('#accountWindow').jqxWindow('setContent', data);
		}); 
		}
     function funSearchdblclick(){
       	 //alert("here");

		//  $('#txtaccname').dblclick(function(){
			  var url=document.URL;
			     var reurl=url.split("com/");
				  	  accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
			//  });  
	}
    function getAcc(event){
   	
         var x= event.keyCode;
         if(x==114){
       	 //alert("here");
        	 var url=document.URL;
		     var reurl=url.split("com/");
			  	  accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
         }
         else{
          }
         }
      function funSearchLoad(){
			changeContent('dealerSearch.jsp', $('#window')); 
		 }
         /*  function getAcc(event){
           			 var x= event.keyCode;
           			 if(x==114){
           			  $('#accountWindow').jqxWindow('open');
       		  	    $('#accountWindow').jqxWindow('focus');
           			 }
           			 else{
           				 }
           			 }  */
           		
	function funReadOnly() {
		$('#frmDealer input').attr('readonly', true);
		 $('#dealerdate').jqxDateTimeInput({ disabled: true}); 
	}
	function funRemoveReadOnly() {
		$('#frmDealer input').attr('readonly', false);
		 $('#dealerdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
		$('#dealername').attr('readonly', true);
	}


	/* function getAccount() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var accItems = items[0].split(",");
				var accnoItems = items[1].split(",");
				var optionsacc = '<option value="">--Select--</option>';
				for (var i = 0; i < accItems.length; i++) {
					optionsacc += '<option value="' + accnoItems[i] + '">'
							+ accItems[i] + '</option>';
				}
				$("select#accno").html(optionsacc);
				$('#accno').val($('#accnohidden').val());

			} else {
			}
		}
		x.open("GET", "getAccount.jsp", true);
		x.send();
		//document.write(document.getElementById("authname").value);

	} */
	 function setValues(){	
		    if($('#dealerdatehidden').val()){
				$("#dealerdate").jqxDateTimeInput('val', $('#dealerdatehidden').val());
			}
			
		    if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }

			}
		    function funFocus()
		    {
		    	document.getElementById("dealername").focus();
		    		
		    }
		    $(function(){
		    
		        $('#frmDealer').validate({
		                 rules: {
		                 dealername:{
		                	 required:true,
		                	 maxlength:45
		                 } 
		             
		                
		                 },
		                 messages: {
		                  dealername:{
		                	  required:" *",
		                	  maxlength:"max 45 chars"
		                  }
		              
		                 }
		        });
		        });
		     function funNotify(){
		    		//alert($('#txtaccname').val());	 
		    		if(document.getElementById("txtaccname").value==''){
		    			document.getElementById("errormsg").innerText="A/c is Mandatory";
		    		/* 	//document.getElementById("txtaccname").focus;
		    			$('#txtaccname').focus();
 */		    		return 0;
		    		}
		    		else{
		    			document.getElementById("errormsg").innerText="";
		    		}
		    		return 1;
			} 
		     function funExcelBtn(){
				  $("#jqxDealerSearch1").jqxGrid('exportdata', 'xls', 'Dealer');
			  }
</script>
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmDealer" action="saveActionDealer" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Dealer Details</legend>
<table width="100%">  
  <tr>
    <td width="103" align="right">Date</td>
    <td width="196"><div id="dealerdate" name="dealerdate" value='<s:property value="dealerdate"/>'></div></td>
    <td width="102">&nbsp;</td>
    <td colspan="2">&nbsp;</td>
    <td width="99"><div align="right">Doc No</div></td>
    <td colspan="2"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly></td>
  </tr>
  <tr>
    <td><div align="right">Acc. No.</div></td>
    <td colspan="2"><input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' style="width:99%;" ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" readonly placeholder="Press F3 to Search" required ></td>
    <td width="96">&nbsp;</td>
    <td width="400"></td>
    <td><div align="right">Dealer</div></td>
    <td width="240"><!--   -->
      <input type="text" name="dealername"  id="dealername"  value='<s:property value="dealername"/>'></td>
    <td width="43">&nbsp;</td>
  </tr>
</table>
<input type="hidden" id="txtaccno" name="txtaccno" value='<s:property value="txtaccno"/>'>
<input type="hidden" id="dealerdatehidden" name="dealerdatehidden" value='<s:property value="dealerdatehidden"/>'>
<input type="hidden" id="mode" name="mode"/>
				        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
</fieldset>
</form>
<br/>
<div id="jqxDealerSearch1"></div>
<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="dealerSearch.jsp"></jsp:include>
	</div></div> --%>
</div>
 <div id="accountWindow">
				<div></div><div></div>
				</div> 
 </body>
</html>
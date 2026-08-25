<%@page import="com.controlcentre.masters.vehiclemaster.insurance.ClsInsuranceAction" %>
<% ClsInsuranceAction cia =new ClsInsuranceAction();%>
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
          $("#insurdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
          $('#accountWindow').jqxWindow({width: '51%', height: '61%',  maxHeight: '61%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		  $('#accountWindow').jqxWindow('close');
		  
		    document.getElementById("formdet").innerText="Insurance(VIS)";
			document.getElementById("formdetail").value="Insurance";
			document.getElementById("formdetailcode").value="VIS";
			window.parent.formCode.value="VIS";
			window.parent.formName.value="Insurance";
		  var data1= '<%=cia.searchDetails() %>';
             
             var num = 0; 
             var source =
             {
                 datatype: "json",
                 datafields: [
                           	{name : 'doc_no' , type: 'number' },
      						{name : 'inname', type: 'String'  },
                           	{name : 'date', type: 'date'  },
                           	{name : 'description',type:'String'},
                           	{name : 'acc_no',type:'String'}
                           	
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
        
             $("#jqxInsuranceSearch1").jqxGrid(
                     {
                     	width: '100%',
                         height: 350,
                         source: dataAdapter,
                         showfilterrow: true,
                         filterable: true,
                         selectionmode: 'singlerow',
                         //pagermode: 'default',
                         sortable: true,
                        // pageable: true,
                         altrows:true,
                         //Add row method
                         columns: [
 							{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
 					{ text: 'Insurance', datafield: 'inname', width: '50%' },
 					{text: 'Date',datafield:'date',width:'20%',cellsformat:'dd.MM.yyyy'},
 					{text: 'Account',datafield:'description',width:'20%'},
 					{text: 'Acc No',datafield:'acc_no',width:'20%',hidden:true}
         			  ]
                     });
             $('#jqxInsuranceSearch1').on('rowdoubleclick', function (event) 
             		{ 
 		            	var rowindex1=event.args.rowindex;
 		                document.getElementById("docno").value= $('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
 		                document.getElementById("insurcompany").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "inname");
 		                $("#insurdate").jqxDateTimeInput('val',$("#jqxInsuranceSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
 						document.getElementById("txtaccname").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "description");
 						document.getElementById("txtaccno").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "acc_no");
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
	function funReadOnly() {
		$('#frmInsurance input').attr('readonly', true);
		 $('#insurdate').jqxDateTimeInput({ disabled: true}); 
	}
	function funRemoveReadOnly() {
		$('#frmInsurance input').attr('readonly', false);
		$('#insurdate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
		$('#insurcompany').attr('readonly', true);
	}
	function setValues() {
		 if($('#insurdatehidden').val()){
				$("#insurdate").jqxDateTimeInput('val', $('#insurdatehidden').val());
			}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }

	}
	function funSearchLoad(){
		changeContent('insuranceSearch.jsp', $('#window')); 
	 }
	 function funFocus()
	    {
	    	document.getElementById("insurcompany").focus();
	    		
	    }
	    $(function(){
	        $('#frmInsurance').validate({
	                 rules: {
	                 insurcompany:{
	                	 required:true,
	                	 maxlength:40
	                 }, 
	                txtaccname:{
	                	required:true
	                	}
	                
	                 },
	                 messages: {
	                  insurcompany:{
	                	  required:" *",
	                	  maxlength:"max 40 chars"
	                  },
	                  txtaccname:{
	                	  required:" *"
	                  }
	                 }
	        });});
	     function funNotify(){
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
			  $("#jqxInsuranceSearch1").jqxGrid('exportdata', 'xls', 'Insurance');
		  }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmInsurance" action="saveActionInsurance"  autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<fieldset>
 <table width="100%"><legend>Insurance Details</legend>
  <tr>
    <td width="11%"><div align="right">Date</div></td>
    <td width="24%"><div id="insurdate" name="insurdate" value='<s:property value="insurdate"/>'></div></td>
    <td width="16%"><div align="right">Doc No</div></td>
    <td width="49%" ><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td style="text-align: right"><div align="right">Account</div></td>
    <td><input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' style="width:85%;" ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" placeholder="Press F3 to Search"></td>
    <td ><div align="right">Company</div></td>
     <td><input type="text" name="insurcompany" id="insurcompany"  value='<s:property value="insurcompany"/>' style="width:50%;"></td><input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>     </tr> 
</table>
<input type="hidden" id="mode" name="mode"/>
										        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
<input type="hidden" id="insurdatehidden" name="insurdatehidden" value='<s:property value="insurdatehidden"/>'/>

</fieldset>
</form>
<br/>
<div id="jqxInsuranceSearch1"></div>
<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="insuranceSearch.jsp"></jsp:include>
	</div></div>
</div>
	<div id="accountWindow">
	<div class="windowsHead">
	<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Accounts
	</span>
	</div>
	<div class="windowsCont">
	<jsp:include page="../../../search/accountsearch/accountsSearchAP.jsp"></jsp:include>
	</div>
	 </div>  --%> 
	  <div id="accountWindow">
				<div></div><div></div>
				</div> 

</body>
</html>
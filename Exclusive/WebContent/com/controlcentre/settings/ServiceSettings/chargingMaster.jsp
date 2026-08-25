<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%@page import="com.controlcentre.settings.servicesettings.ClsServiceSettingDAO"%>
<%ClsServiceSettingDAO DAO= new ClsServiceSettingDAO();
String doctype = request.getParameter("doctype")==null?"0":request.getParameter("doctype").trim();
 String name=request.getParameter("formname"); 
String code=request.getParameter("formcode");
String lblname=request.getParameter("lblname");
String lbldrp=request.getParameter("lbldrp");
String mode=request.getParameter("mode");

%> 
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
      $(document).ready(function () { 
    	  
    	document.getElementById("formdet").innerText="Charging Master(CHM)";
   		document.getElementById("formdetail").value="Charging Master";
   		document.getElementById("formdetailcode").value="CHM";
   		window.parent.formCode.value="CHM";
   		window.parent.formName.value="Charging Master";
    	  
    	  <%if(!(name==null)) {%>
  	    document.getElementById("formdet").innerText="<%=name%>(<%=code%>)";
  		document.getElementById("formdetail").value="<%=name%>";
  		document.getElementById("formdetailcode").value="<%=code%>";
  		 window.parent.formCode.value="<%=code%>";
  		window.parent.formName.value="<%=name%>"; 
  		document.getElementById("txtcategory").value="<%=lbldrp%>";
  		document.getElementById("test").innerText="<%=lblname%>";
  		document.getElementById("mode").value="<%=mode%>";  
  		<%}%>
  		
  		
  		
    	  $('#btnSearch').attr('disabled', true);
    	  //$('#btnDelete').attr('disabled', true);
    	  
    	  
    	  
    	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
    	 
          var data='<%=DAO.cmList(session,doctype) %>';
              
              var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'doc_no' , type: 'int' },
       						    {name : 'groupname', type: 'String'  },
                            	{name : 'description', type: 'String'  },
                            	{name : 'codeno',type:'String'},
                            	{name : 'dtype',type:'String'},
                            	{name : 'hdtype',type:'String'},
                            	{name : 'date',type:'String'},
                            	
                   ],
                   localdata: data,
                  
                  
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
      


              $("#jqxChargingMaster").jqxGrid(
                      {
                      	width: '90%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'multiplecellsextended',
                          sortable: true,
                          altrows:true,
                          //Add row method
                          columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '10%',editable:false  },	
							{ text: 'Category', datafield: 'dtype', width: '15%',editable:false },
							{ text: 'Code', datafield: 'codeno', width: '15%',editable:false  },
							{ text: 'Name', datafield: 'groupname', width: '30%',editable:false },
							{ text: 'Rate', datafield: 'description', width: '30%',editable:false  },
							{ text: 'date', datafield: 'date', width: '30%',hidden:true  },
							{ text: 'hdtype', datafield: 'hdtype', width: '30%',hidden:true  },
          	              ]
                      });

              $('#jqxChargingMaster').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;
  		                document.getElementById("docno").value= $('#jqxChargingMaster').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		                document.getElementById("txtcategory").value = $("#jqxChargingMaster").jqxGrid('getcellvalue', rowindex1, "hdtype");
  		              $('#frmChargingMaster select').attr('disabled', false);
  		    		   $('#date').jqxDateTimeInput({disabled: false});
  		                $("#date").jqxDateTimeInput('val',$("#jqxChargingMaster").jqxGrid('getcellvalue', rowindex1, "date"));
  		                $('#txtcode').val($("#jqxChargingMaster").jqxGrid('getcellvalue', rowindex1, "codeno")) ;
  		                $('#txtname').val($("#jqxChargingMaster").jqxGrid('getcellvalue', rowindex1, "groupname")) ;
  		                $('#txtdesc').val($("#jqxChargingMaster").jqxGrid('getcellvalue', rowindex1, "description")) ;
  		              $('#frmChargingMaster select').attr('disabled', true);
  		    		$('#date').jqxDateTimeInput({disabled: true});
              		 }); 

          });
    
      function funSearchLoad(){
			changeContent('modelSearch.jsp', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmChargingMaster input').attr('readonly', true);
		$('#frmChargingMaster select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		
	}
	function funRemoveReadOnly() {
		$('#frmChargingMaster input').attr('readonly', false);
		$('#frmChargingMaster select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		

		<%if(!(name==null)) {%>
		document.getElementById("txtcategory").value="<%=lbldrp%>";  
  		<%}%>
		
	}

	
	function funFocus(){
		document.getElementById("txtcode").focus();
	}
	 $(function(){
	        $('#frmChargingMaster').validate({
	                 rules: {
	                 brand:{
	                	 required:true
	                 },
	                 model:{
	                	 required:true,
	                	 maxlength:20
	                 }
	                 },
	                 messages: {
	                  brand:{
	                	  required:" *"
	                  },
	                  model:{
	                	  required:" *",
	                	  maxlength:"max 20 chars"
	                  }
	                 }
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     
	function setValues() {
		
		if ( $('#hidtxtcategory').val() != null && $('#hidtxtcategory').val() !="") {
		
					$('#txtcategory').val($('#hidtxtcategory').val());
		}
		
		
if ($('#brandid').val() != null) {
	//alert("ghcj");
			$('#brand').val($('#brandid').val());
}
if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }
	}
	
	function refChange(){
		
		
		
		var value=document.getElementById("txtcategory").value;
		
		if(value=="lcm"){
			document.getElementById("test").innerText="Labour Charging Master";
		}
		if(value=="ecm"){
			document.getElementById("test").innerText="Equipment Charging Master";
		}
		
	}
	
</script>
</head>
<body onLoad="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmChargingMaster" action="saveChargingMaster"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend><labal id="test" >Labour Charging Master</labal></legend>
<table width="100%">
<tr>
  <td width="12%"><div align="right">Date</div></td>
  <td width="22%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
  <td width="7%"><div align="right">Doc No</div></td>
  <td width="59%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly  tabindex="-1"></td>
</tr>
<tr><td><div align="right">Category</div></td>
<td> 

 <select name="txtcategory" id="txtcategory" onchange="refChange();" style="width:60%;" >
<option value="lcm">Labour Charging Master</option>
<option value="ecm">Equipment Charging Master</option>
 </select></td>
 <td><div align="right">Code</div></td><td><input type="text" name="txtcode"  id="txtcode" value='<s:property value="txtcode"/>'></td></tr>
 
 <tr><td><div align="right">Name</div></td>
<td><input type="text" name="txtname"  id="txtname" style="width:80%;" value='<s:property value="txtname"/>'></td>
 <td><div align="right">Rate/Hr</div></td><td><input type="text" style="width:19%;" name="txtdesc"  id="txtdesc" value='<s:property value="txtdesc"/>'></td></tr>

<td><input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
<input type="hidden" id="hidtxtcategory" name="hidtxtcategory" value='<s:property value="hidtxtcategory"/>' />
</td>

</table> 
</fieldset>    
</form>
<br/>
<div id="jqxChargingMaster"></div>
	
</div>
</body>
</html>
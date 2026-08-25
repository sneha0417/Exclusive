<%@page import="com.controlcentre.settings.areamaster.country.ClsCountryDAO"%>
<%ClsCountryDAO DAO= new ClsCountryDAO();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%> 
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
      $(document).ready(function () {          
    	  $("#date_coun").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
       	
         var data= '<%=DAO.searchDetails()  %>';
        // var data;
               var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'doc_no' , type: 'int' },
                            	{name : 'country_name',type:'String'},
                            	{name : 'country_code',type:'String'},
       						    {name : 'date', type: 'String'  },
                            	{name : 'region', type: 'String'  },
                            	{name : 'reg_id' , type: 'String' }
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
      


              $("#jqxCountrySearch1").jqxGrid(
                      {
                      	width: '100%',
                          height: 350,
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
          					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '5%' },
          					{ text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '15%'},
          					{ text: 'Country',columntype: 'textbox', filtertype: 'input', datafield: 'country_name', width: '35%' },
          					{ text: 'Country Code',columntype: 'textbox', filtertype: 'input', datafield: 'country_code', width: '10%' },
          					{ text: 'Region id', datafield: 'reg_id' } ,
          					{ text: 'Region',columntype: 'textbox', filtertype: 'input', datafield: 'region', width: '35%' }
          					/* { text: 'Region id',columntype: 'number', datafield: 'reg_id', width: '5%' } */
          					

          	              ]
                      });

              $('#jqxCountrySearch1').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;
  		                document.getElementById("docno").value= $('#jqxCountrySearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		                document.getElementById("country").value = $("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "country_name");
  		                document.getElementById("contry_code").value = $("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "country_code");
  		                document.getElementById("region").value = $("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "reg_id");
  		              $('#frmModel select').attr('disabled', false);
  		    		$('#date_coun').jqxDateTimeInput({disabled: false});
  		                $("#date_coun").jqxDateTimeInput('val',$("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "date"));
  		               // $('#brandid').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
  		              //  $('#region').val($("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "region")) ;
  		              $('#frmModel select').attr('disabled', true);
  		    		$('#date_coun').jqxDateTimeInput({disabled: true});
              		 }); 
              $("#jqxCountrySearch1").jqxGrid('hidecolumn', 'reg_id'); 
              //$("#jqxModelSearch").jqxGrid('hidecolumn', 'brandid'); 

          });
    
      function funSearchLoad(){
			changeContent('countrySearch.jsp', $('#window')); 
		 }

	function funReset() {
		document.getElementById("frmCountry").reset();
		//getRegion();
	}
	function funReadOnly() {
		$('#frmCountry input').attr('readonly', true);
		$('#frmCountry select').attr('disabled', true);
		$('#date_coun').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		
	}
	function funRemoveReadOnly() {
		 $('#frmCountry input').attr('readonly', false);
		$('#frmCountry select').attr('disabled', false);
		$('#date_coun').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		if(document.getElementById("mode").value=='A'){
			$('#jqxCountrySearch1').jqxGrid({ disabled: true});
		}
		 
	}

	 function getRegion() {
		 
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				
				items = items.split('***');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}
				/* alert("ssss"+optionsbrand); */
				$("select#region").html(optionsbrand);
				$('#region').val($('#reg_id').val());
				} else {
			}
		}
		x.open("GET", "getRegion.jsp", true);
		x.send();
	} 
	
	function funFocus(){
		document.getElementById("region").focus();
	}
	 $(function(){
	        $('#frmCountry').validate({
	                 rules: {
	                	 region:{
	                	 required:true
	                 },
	                 country:{
	                	 required:true,
	                	 maxlength:45
	                 }
	                 },
	                 messages: {
	                	 region:{
	                	  required:" *"
	                  },
	                  country:{
	                	  required:" *",
	                	  maxlength:"max 45 chars"
	                  }
	                 }
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     
	function setValues() {
		//$('#region').val($('#brandid').val());
if ($('#reg_id').val() != null) {
	//alert("ghcj");
			$('#region').val($('#reg_id').val());
}
if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }
document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
</script>
</head>
<body onLoad="getRegion();funReadOnly();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCountry" action="saveCountry"  autocomplete="off">
 <script>
			window.parent.formName.value="Country";
			window.parent.formCode.value="COU";
	</script> 
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Country Details</legend>
<input type="text" id="reg_id" name="reg_id" value='<s:property value="reg_id"/>' hidden="true">
<table width="100%">
<tr>
  <td width="14%"><div align="right">Date</div></td>
  <td width="12%"><div id="date_coun" name="date_coun" value='<s:property value="date_coun"/>'></div></td>
  <td width="23%"><div align="right">Doc No</div></td>
  <td width="51%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly"  tabindex="-1"></td>
</tr>
<tr><td><div align="right">Region</div></td>
<td> 
  
 <select name="region" id="region" style="width:100%;">
 </select>
</td>
</tr>
<tr>

<td><div align="right">Country</div></td><td><input type="text" name="country" id="country" style="width:98%;" value='<s:property value="country"/>'></td>
<td><div align="right">Country Code</div></td>
<td><input type="text" name="contry_code" id="contry_code" value='<s:property value="contry_code"/>'></td>
</tr>
</table> 
</fieldset>
		  <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
</form>
<br/>
<div id="jqxCountrySearch1"></div>

<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="modelSearch.jsp"></jsp:include>
	</div></div> --%>
	
</div>
</body>
</html>
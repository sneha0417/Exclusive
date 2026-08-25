<%@page import="com.controlcentre.settings.areamaster.city.ClsCityDAO"%>
<%ClsCityDAO DAO= new ClsCityDAO();%>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
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
    	  $("#date_city").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
     
           var data= '<%=DAO.searchDetails() %>'; 
       	
              
          //var data;
               var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'doc_no' , type: 'int' },
       						    {name : 'city_name', type: 'String'},
       						    {name : 'city_code', type: 'String'},
                            	{name : 'date', type: 'String'  },
                            	{name : 'region',type:'String'},
                            	{name : 'reg_id',type:'String'},
                            	{name : 'country',type:'String'},
                            	{name : 'cou1_id',type:'String'}
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
      


              $("#jqxCitySearch1").jqxGrid(
                      {
                      	width: '70%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'multiplecellsextended',
                        //  pagermode: 'default',
                          sortable: true,
                          //pageable: true,
                          altrows:true,
                          //Add row method
                          columns: [
          					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '5%'},
          					{ text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '15%'},         					
          					{ text: 'City',columntype: 'textbox', filtertype: 'input', datafield: 'city_name', width: '25%' },
          					{ text: 'City Code',columntype: 'textbox', filtertype: 'input', datafield: 'city_code', width: '15%' },
          					{ text: 'Country id', datafield: 'cou1_id' } ,
          					{ text: 'Country',columntype: 'textbox', filtertype: 'input', datafield: 'country', width: '20%' },
          					{ text: 'Region id', datafield: 'reg_id' } ,
          					{ text: 'Region',columntype: 'textbox', filtertype: 'input', datafield: 'region', width: '20%' } 

          	              ]
                      });

              $('#jqxCitySearch1').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;
  		                document.getElementById("docno").value= $('#jqxCitySearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		                document.getElementById("city").value = $("#jqxCitySearch1").jqxGrid('getcellvalue', rowindex1, "city_name");
		                document.getElementById("city_code").value = $("#jqxCitySearch1").jqxGrid('getcellvalue', rowindex1, "city_code");
		                document.getElementById("country").value = $("#jqxCitySearch1").jqxGrid('getcellvalue', rowindex1, "cou1_id");
  		                document.getElementById("region").value = $("#jqxCitySearch1").jqxGrid('getcellvalue', rowindex1, "reg_id");
  		              $('#frmCity select').attr('disabled', false);
  		    		$('#date_city').jqxDateTimeInput({disabled: false});
  		                $("#date_city").jqxDateTimeInput('val',$("#jqxCitySearch1").jqxGrid('getcellvalue', rowindex1, "date"));
  		               // $('#brandid').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
  		               // $('#brand').val($("#jqxCitySearch1").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
  		              $('#frmCity select').attr('disabled', true);
  		    		$('#date_city').jqxDateTimeInput({disabled: true});
              		 }); 
              $("#jqxCitySearch1").jqxGrid('hidecolumn', 'reg_id'); 
              $("#jqxCitySearch1").jqxGrid('hidecolumn', 'cou1_id'); 
              //$("#jqxModelSearch").jqxGrid('hidecolumn', 'brandid'); 

          });
    
      function funSearchLoad(){
			changeContent('citySearch.jsp', $('#window')); 
		 }

	function funReset() {
		document.getElementById("frmCity").reset();
	}
	function funReadOnly() {
		$('#frmCity input').attr('readonly', true);
		$('#frmCity select').attr('disabled', true);
		$('#date_city').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		
	}
	function funRemoveReadOnly() {
		$('#frmCity input').attr('readonly', false);
		$('#frmCity select').attr('disabled', false);
		$('#date_city').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		
		if(document.getElementById("mode").value=='A'){
			$('#jqxCitySearch1').jqxGrid({ disabled: true});
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
	 function getCountry() {
		 	var region=document.getElementById("region").value;
		 	//alert("==region"+region);
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
					$("select#country").html(optionsbrand);
					$('#country').val($('#cou_id').val());
					} else {
				}
			}
			x.open("GET", "getCountry.jsp?region="+region, true);
			x.send();
		} 
	
	function funFocus(){
		document.getElementById("region").focus();
	}
	 $(function(){
	        $('#frmCity').validate({
	                 rules: {
	                	 region:{
	                	 required:true
		                 },
		                 country:{
		                	 required:true,		                	
		                 },
		                 city:{
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
		                	  
		                  },
		                  city:{
		                	  required:" *",
		                	  maxlength:"max 65 chars" 
		                  }
	                 }
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     
	function setValues() {
		//$('#brand').val($('#brandid').val());
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
<body onLoad="getRegion();getCountry();funReadOnly();setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmCity" action="saveCity"  autocomplete="off">
<script>
			window.parent.formName.value="State / Province";
			window.parent.formCode.value="PRO";
	</script>
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>state / Province Details</legend>
<input type="text" id="cou_id" name="cou_id" value='<s:property value="cou_id"/>' hidden="true">
<input type="text" id="reg_id" name="reg_id" value='<s:property value="reg_id"/>' hidden="true">
<table width="100%">
<tr>
  <td width="14%"><div align="right">Date</div></td>
  <td width="12%"><div id="date_city" name="date_city" value='<s:property value="date_city"/>'></div></td>
  <td width="23%"><div align="right">Doc No</div></td>
  <td width="51%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly"  tabindex="-1"></td>
</tr>
<tr><td><div align="right">Region</div></td>
<td> 
<!-- <option value="">--Select--</option> -->
 <select name="region" id="region" onchange="getCountry();" style="width:100%;">
</select>
<td><div align="right">Country</div></td>
<td> 
<!-- <option value="">--Select--</option> -->
 <select name="country" id="country" style="width:23%;">
</select></td></tr>
<tr>
<td><div align="right">State</div></td><td><input type="text" name="city" id="city"  value='<s:property value="city"/>' style="width:98%;"></td>
<td><div align="right">State Code</div></td><td><input type="text" name="city_code" id="city_code"  value='<s:property value="city_code"/>' style="width:22%;"></td>
</tr>
</table> 
</fieldset>
 <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>    
</form>
<br/>
<div id="jqxCitySearch1"></div>

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
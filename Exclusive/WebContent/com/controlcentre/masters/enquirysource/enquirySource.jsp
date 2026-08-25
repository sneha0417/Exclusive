<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.enquirysource.ClsEnquirySourceDAO"%>
<%ClsEnquirySourceDAO DAO= new ClsEnquirySourceDAO();

%>
<script type="text/javascript">
				
		$(document).ready(function() {
			$("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		
			var datas='<%=DAO.descLoad(session) %>';
              
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'date', type: 'date'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'mobile', type: 'String'  },
                         	{name : 'email', type: 'String'  },
                         	{name : 'address', type: 'String'  },
                         	{name : 'description', type: 'String'  }
                          	
                 ],
                localdata: datas,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#enquiryServiceGridID").jqxGrid(
                    {
                    	width: "100%",
                    	height:375,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '15%' },
        					{ text: 'Mobile',columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '10%' },
        					{ text: 'Email',columntype: 'textbox', filtertype: 'input', datafield: 'email', width: '15%' },
        					{ text: 'Address',columntype: 'textbox', filtertype: 'input', datafield: 'address', width: '20%' },
        					{ text: 'Description',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '20%' },
        	              ]
                    });
            
         $('#enquiryServiceGridID').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#enquiryServiceGridID').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#date").jqxDateTimeInput('val', $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("txtname").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("txtmobile").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "mobile");
                document.getElementById("txtemail").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "email");
                document.getElementById("txtaddress").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "address");
                document.getElementById("txtdescription").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "description");
                
            });
		
		});
		
		function funReadOnly(){
			$('#frmEnquirysource input').attr('readonly', true );
			$('#date').jqxDateTimeInput({disabled: true});
		}
		
		function funRemoveReadOnly(){
			$('#frmEnquirysource input').attr('readonly', false );
			$('#date').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#date').val(new Date());
			}
		}
		
		function funSearchLoad(){
			  /*changeContent('cpsMainSearch.jsp');*/   
		 }
			
		function funChkButton() {
				/* funReset(); */
		}
		 
		function funFocus(){
			$('#date').jqxDateTimeInput('focus'); 	    		
		}
		
		function funNotify(){	
  			 return 1;
			} 
		  
		  function setValues(){
			  
			  if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			  
			  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			  funSetlabel();
			  
			}
		
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEnquirysource" action="saveEnquirysource" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="66%"><div id='date' name='date' value='<s:property value="date"/>'></div>
                   <input type="hidden" id="hidendate" name="hidendate" value='<s:property value="hidendate"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="24%"><input type="text" id="docno" name="docno" style="width:40%" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table><br/>

<fieldset style="background-color: #EBDEF0;">
<table width="100%">
  <tr>
    <td width="4%" align="right">Name</td>
    <td width="25%"><input type="text" id="txtname" name="txtname" style="width:90%;" value='<s:property value="txtname"/>'/></td>
    <td width="4%" align="right">Mobile</td>
    <td width="67%"><input type="text" id="txtmobile" name="txtmobile" style="width:25%;" value='<s:property value="txtmobile"/>'/></td>
  </tr>
  <tr>
    <td align="right">Email</td>
    <td><input type="text" id="txtemail" name="txtemail" style="width:90%;" value='<s:property value="txtemail"/>'/></td>
    <td align="right">Address</td>
    <td><input type="text" id="txtaddress" name="txtaddress" style="width:51%;" value='<s:property value="txtaddress"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:66%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset>

<table width="100%">
  <tr><td><div id="enquiryServiceGridID"></div></td></tr>
</table>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>

</div>
</body>
</html>
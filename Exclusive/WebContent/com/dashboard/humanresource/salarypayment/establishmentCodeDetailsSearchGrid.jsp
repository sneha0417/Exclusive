<%@page import="com.dashboard.humanresource.salarypayment.ClsSalaryPaymentDAO"%>
<%ClsSalaryPaymentDAO DAO= new ClsSalaryPaymentDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <% String establishmentscode = request.getParameter("establishmentscode")==null?"0":request.getParameter("establishmentscode");
    String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 
	var data6='<%=DAO.establishmentCodeDetails(establishmentscode,check)%>';
	
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
 						{name : 'est_code', type: 'string'  }
                    ],
            		localdata: data6, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#establishmentCodeDetailsSearchGridID").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Est. Code', datafield: 'est_code', width: '100%' },
					]
        });
        
         $('#establishmentCodeDetailsSearchGridID').on('rowdoubleclick', function (event) {
            	var rowindex1 = event.args.rowindex;
            
	        	document.getElementById("txtestablishmentcode").value = $('#establishmentCodeDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "est_code");

	        	$('#establishedCodeDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="establishmentCodeDetailsSearchGridID"></div>
    
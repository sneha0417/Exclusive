<%@page import="com.controlcentre.masters.vehiclemaster.financier.ClsFinancierDAO" %>
<%ClsFinancierDAO cfd=new ClsFinancierDAO(); %>


  <jsp:include page="../../../../includes.jsp"></jsp:include> 

<script type="text/javascript">
    var data= '<%=cfd.acclist() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'description', type: 'String'  }
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
            $("#jqxAccountsGrid").jqxGrid(
            {
                width: '100%',
                height: 315,
                source: dataAdapter,
                columnsresize: true,
                pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no',filtertype:'number', width: '10%' },
					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '50%' }
	              ]
            });

            $('#jqxAccountsGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("txtaccno").value= $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description"); 
		                document.getElementById("accnohidden").value = $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		                //alert(document.getElementById("txttest1"));
		                //alert(document.getElementById("id1"));
		                //document.frmVehicle.interest_amt.focus();
		                //$('#interest_amt').focus();
		             // document.getElementById("interest_amt").autofocus();
            		 }); 
           
        });
    </script>
    <div id="jqxAccountsGrid"></div>

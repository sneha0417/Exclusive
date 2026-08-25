<%@page import="com.controlcentre.masters.salesmanmaster.salesman.ClsSalesmanDAO" %>
<%ClsSalesmanDAO csd=new ClsSalesmanDAO(); %>

<script type="text/javascript">
  		
  		var datasm= '<%=csd.list()%>';
        
  		$(document).ready(function () { 	
         
            var source =
            {
            		
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'sal_id', type: 'String'  },
                          	{name : 'sal_name', type: 'String'  },
                          	{name : 'acc_no', type: 'String'  },
                          	{name : 'description', type: 'String' },
                          	{name : 'mob_no', type: 'String'  },
                          	{name : 'mail',type:'String'},
                          	{name : 'date',type:'String'},
                          	{name :  'acdoc',type:'String'}
                          	
                 ],
               localdata: datasm,
        
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
            $("#jqxSalesmanSearch").jqxGrid(
            {
            	width: '100%',
                height: 340,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                showfilterrow:true,
                
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
					{ text: 'Salesman Name', datafield: 'sal_name', width: '40%' },
					 { text: 'Account No', datafield: 'acc_no', width: '40%',hidden:true },
					 { text: 'Account Name', datafield: 'description', width: '40%',hidden:true},
  					{ text: 'Mobile', datafield: 'mob_no', width: '40%' },
  					{ text: 'Mail',datafield:'mail',width:'40%',hidden:true},
  					{ text: 'Date',datafield:'date',width:'40%',hidden:true},
  					{ text: 'Ac Doc',datafield:'acdoc',width:'40%',hidden:true}
	              ]
            });
            
            $('#jqxSalesmanSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxSalesmanSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("salesmanid").value = $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "sal_id");
                document.getElementById("salesmanname").value = $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "sal_name");
                document.getElementById("txtaccno").value = $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "acc_no");
                document.getElementById("txtaccname").value= $('#jqxSalesmanSearch').jqxGrid('getcellvalue', rowindex1, "description"); 
                document.getElementById("telephone").value = $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "mob_no");
                document.getElementById("salesmanmail").value= $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "mail");
                $("#salesmandate").jqxDateTimeInput('val', $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("hidacno").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "acdoc");
               
                $('#window').jqxWindow('close');
            }); 
           
        });
    </script>
    <div id="jqxSalesmanSearch"></div>

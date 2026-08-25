<%@page import="com.dashboard.audit.applieddelete.ClsAppliedDeleteDAO"%>
<%ClsAppliedDeleteDAO DAO= new ClsAppliedDeleteDAO(); %>
<%   String trno = request.getParameter("trno")==null?"0":request.getParameter("trno").trim();
     String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno").trim();%> 
 
 <style type="text/css">
  .appliedClass
  {
     color: #0101DF;
  }
  .balanceClass
  {
	color: #FF0000;      
  }
  
</style>
 <script type="text/javascript">
 
 var data1 ='<%=DAO.applyInvoiceDeleteGridLoading(trno,accountno)%>';
        $(document).ready(function () { 

         var source = 
            {
                datatype: "json",
                datafields: [
	                 			{name : 'transno', type: 'int' },
	     						{name : 'transtype', type: 'string'   },
	     						{name : 'date', type: 'date' },
	     						{name : 'description', type: 'string'   },
	     						{name : 'tramt', type: 'number' },
	     		     		    {name : 'applying', type: 'number'   },
	     						{name : 'balance', type: 'number'   },
	     						{name : 'out_amount', type: 'number'   },
	     						{name : 'tranid', type: 'int'   },
	     						{name : 'acno', type: 'int'   },
	     						{name : 'currency', type: 'string'   }
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#appliedDetailsGrid").jqxGrid({ 
            	width: '98%',
                height: 152,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Doc No.', datafield: 'transno', editable: false, width: '7%' },			
							{ text: 'Doc Type', datafield: 'transtype', editable: false, width: '7%' },	
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , editable: false, width: '7%' },	
							{ text: 'Remarks', datafield: 'description', editable: false, width: '44%' },	
							{ text: 'Amount', datafield: 'tramt', width: '10%', cellsformat: 'd2', editable: false, cellsalign: 'right', align: 'right' },
							{ text: 'Applied', datafield: 'applying', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], cellclassname: 'appliedClass' },
							{ text: 'Balance', datafield: 'balance', width: '10%',cellsformat: 'd2', editable: false, cellsalign: 'right', align: 'right', aggregates: ['sum'], cellclassname: 'balanceClass' },
							{ text: 'Out Amount',hidden: true, datafield: 'out_amount',  width: '5%',cellsformat: 'd2' },
							{ text: 'Tran Id' ,hidden: true, datafield: 'tranid',  width: '5%' },
							{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currency',  width: '5%' }
					]
            });
         
        });
                       
</script>
<div id="appliedDetailsGrid"></div>
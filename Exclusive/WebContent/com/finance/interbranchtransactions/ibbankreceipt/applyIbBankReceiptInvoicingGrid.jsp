<%@page import="com.finance.interbranchtransactions.ibbankreceipt.ClsIbBankReceiptDAO" %>
<%  ClsIbBankReceiptDAO DAO=new ClsIbBankReceiptDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<% String toAccId = request.getParameter("txttoaccid1")==null?"0":request.getParameter("txttoaccid1"); 
   String trNo = request.getParameter("txttotrno1")==null?"0":request.getParameter("txttotrno1"); 
   String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
   String atype = request.getParameter("atype"); 
   String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>

<script type="text/javascript">
         var data5;  
        $(document).ready(function () { 	
              
             var tempToAcc='<%=toAccId%>'; 
             var temp='<%=accountno%>';
             
             if(temp>0)
           	 { 
            	     data5='<%=DAO.applyIbInvoicingGrid(accountno,atype,check)%>';    
           	 }
             else if(tempToAcc>0)
             {
            	     data5='<%=DAO.applyIbInvoicingGridReloading(trNo,toAccId,check)%>';   
             } 

             // prepare the data
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
                		    localdata: data5,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });

            $("#jqxApplyIbBankInvoicing").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Doc No.', datafield: 'transno', editable: false, width: '10%' },			
							{ text: 'Doc Type', datafield: 'transtype', editable: false, width: '10%' },	
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , editable: false, width: '10%' },	
							{ text: 'Remarks', datafield: 'description', editable: false, width: '30%' },	
							{ text: 'Amount', datafield: 'tramt', width: '10%', editable: false, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Applying', datafield: 'applying', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Balance', datafield: 'balance', width: '15%', editable: false, cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Out Amount',hidden: true, datafield: 'out_amount',  cellsformat: 'd2', width: '5%' },
							{ text: 'Tran Id' ,hidden: true, datafield: 'tranid',  width: '5%' },
							{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currency',  width: '5%' }
						]
            });   
            
            //Add empty row
            if(temp==0 && tempToAcc==0){
          	   $("#jqxApplyIbBankInvoicing").jqxGrid('addrow', null, {});
            }
          	
            if(tempToAcc>0){
            	$("#jqxApplyIbBankInvoicing").jqxGrid('disabled', true);
            }
            
        	 var applied1="";
          	 $("#jqxApplyIbBankInvoicing").on('cellvaluechanged', function (event){
                 var rowindex1=event.args.rowindex;
                 var value = $('#jqxApplyIbBankInvoicing').jqxGrid('getcellvalue', rowindex1, "tramt");
                 var value1=$("#jqxApplyIbBankInvoicing").jqxGrid('getcellvalue', rowindex1, "applying");
                 var balance= value - value1;
                 $('#jqxApplyIbBankInvoicing').jqxGrid('setcellvalue', rowindex1, "balance",balance);
                
                var applied=$('#jqxApplyIbBankInvoicing').jqxGrid('getcolumnaggregateddata', 'applying', ['sum'], true);
                applied1=applied.sum;
                document.getElementById("txtapplyinvoiceapply").value=applied1;
                
                var totamount = $('#txtapplyinvoiceamt').val();
      		    var totapply = $('#txtapplyinvoiceapply').val();
      		    if(!isNaN(totamount || totapply)){
      		    var totbalance= parseFloat(totamount) - parseFloat(totapply);
      		    funRoundAmt(totbalance,"txtapplyinvoicebalance");
      		  }
      		else{
		    	 $('#txtapplyinvoiceamt').val(0.00);
		    }
              }); 
             
          	 
          	$("#jqxApplyIbBankInvoicing").on('cellvaluechanged', function (event) {
          		var dataField = event.args.datafield;
                var rowIndex = event.args.rowindex;
                var value = $('#jqxApplyIbBankInvoicing').jqxGrid('getcellvalue', rowIndex, "tramt");
                var value1=$("#jqxApplyIbBankInvoicing").jqxGrid('getcellvalue', rowIndex, "applying");
          		var amount = document.getElementById("txtapplyinvoiceamt").value;
          		var applied=$('#jqxApplyIbBankInvoicing').jqxGrid('getcolumnaggregateddata', 'applying', ['sum'], true);
          		applied1=parseFloat(applied.sum); 
          		if(dataField=="applying"){
          			if(applied1>amount){ 
          		        $("#jqxApplyIbBankInvoicing").jqxGrid('showvalidationpopup', rowIndex, "applying", "Limit Already Reached,Invalid Amount.");
          		        $('#txtvalidation').val(1);
          		         return true;  
          		        }
          		    else if(value1>value){
          		    	$("#jqxApplyIbBankInvoicing").jqxGrid('showvalidationpopup', rowIndex, "applying", "Invalid Amount.");
          		    	$('#txtvalidation').val(1);
         		         return true; 
          		    }  
          		    else{  
          		        $("#jqxApplyIbBankInvoicing").jqxGrid('hidevalidationpopups');
          		         $('#txtvalidation').val(0);
          		        return false;  
          		        }
          		}      		
          	});
        });
    </script>
    <div id="jqxApplyIbBankInvoicing"></div>
 
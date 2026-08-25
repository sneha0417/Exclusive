<%@page import="com.finance.posting.manualapplying.ClsManualApplyingDAO"%>
<%ClsManualApplyingDAO DAO= new ClsManualApplyingDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String atype = request.getParameter("accType")==null?"0":request.getParameter("accType"); 
   String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>


<script type="text/javascript">
       var data1;
        $(document).ready(function () { 	
              
             var temp='<%=accountno%>';
             
             if(temp>0)
           	 { 
            	  data1='<%=DAO.appliedInvoiceGridLoading(session, accountno, atype, check)%>';  
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
     		     		    {name : 'applied', type: 'number'   },
     						{name : 'balance', type: 'number'   },
     						{name : 'out_amount', type: 'number'   },
     						{name : 'tranid', type: 'int'   },
     						{name : 'acno', type: 'int'   },
     						{name : 'currency', type: 'string'   },
     						{name : 'tr_no', type: 'int'   }
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
		            });

            $("#jqxAppliedInvoicing").jqxGrid(
            {
                width: '99%',
                height: 150,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                 //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxAppliedInvoicing').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxAppliedInvoicing').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'applying' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxAppliedInvoicing").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                }, 
                    
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Doc No.', datafield: 'transno',  width: '7%' },			
							{ text: 'Doc Type', datafield: 'transtype',  width: '7%' },	
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' ,  width: '7%' },	
							{ text: 'Remarks', datafield: 'description',  width: '44%' },	
							{ text: 'Amount', datafield: 'tramt', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Applied', datafield: 'applied', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Balance', datafield: 'balance', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Out Amount',hidden: true, datafield: 'out_amount',  cellsformat: 'd2', width: '5%' },
							{ text: 'Tran Id' ,hidden: true, datafield: 'tranid',  width: '5%' },
							{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currency',  width: '5%' },
							{ text: 'Tran No' , hidden: true, datafield: 'tr_no',  width: '5%' },
						]
            });   
            
            if(temp==0){
            //Add empty row
               $("#jqxAppliedInvoicing").jqxGrid('clear');
            }
            
            $("#overlay, #PleaseWait").hide();
          	
        	 var applied1="";
          	 $("#jqxAppliedInvoicing").on('cellvaluechanged', function (event){
                 var rowindex1=event.args.rowindex;
                 var value = $('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "tramt");
                 var value1=$("#jqxAppliedInvoicing").jqxGrid('getcellvalue', rowindex1, "applied");
                 var balance= (parseFloat(value)-parseFloat(value1)).toFixed(2);
                 $('#jqxAppliedInvoicing').jqxGrid('setcellvalue', rowindex1, "balance",balance);
              }); 
          	
          	$('#jqxAppliedInvoicing').on('rowdoubleclick', function (event) {
          		$("#jqxApplyInvoicing").jqxGrid({ disabled: false});
          		$("#btnUpdate").show();
                var rowindex1 = event.args.rowindex;
                var docNo=$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "transno");
                document.getElementById("txtgriddocno").value=docNo;
                var docType=$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "transtype");
                document.getElementById("txtdoctype").value=docType;
                var amount=$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "balance");
                //document.getElementById("txtapplyinvoiceamt").value=amount;
                funRoundAmt(amount,"txtapplyinvoiceamt");
                funRoundAmt(amount,"txtapplyinvoicebalance");
                //$('#txtapplyinvoicebalance').val(amount);
                $('#txtapplyinvoiceapply').val(0.00);
                
                document.getElementById("txttrno").value= $('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "tr_no");
                document.getElementById("txtoutamount").value= $('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "out_amount");
                document.getElementById("txttranid").value= $('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "tranid");
                
                var indexVal =  $('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("txtacno").value=indexVal;
                var accType = document.getElementById("cmbacctype").value;
                
  			     if(indexVal>0){
  			    	 var check = 1;
  			    	/* $('#jqxApplyInvoicing').jqxGrid('setcellvalue', 0, "doc_no" ,$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "doc_no"));
  			    	$('#jqxApplyInvoicing').jqxGrid('setcellvalue', 0, "dtype" ,$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "dtype"));
  			    	$('#jqxApplyInvoicing').jqxGrid('setcellvalue', 0, "date" ,$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "date"));
  			    	$('#jqxApplyInvoicing').jqxGrid('setcellvalue', 0, "description" ,$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "description"));
  			    	$('#jqxApplyInvoicing').jqxGrid('setcellvalue', 0, "tramt" ,$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "balance"));
  			    	$('#jqxApplyInvoicing').jqxGrid('setcellvalue', 0, "out_amount" ,$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "out_amount"));
  			    	$('#jqxApplyInvoicing').jqxGrid('setcellvalue', 0, "tranid" ,$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "tranid"));
  			    	$('#jqxApplyInvoicing').jqxGrid('setcellvalue', 0, "acno" ,$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "acno"));
  			    	$('#jqxApplyInvoicing').jqxGrid('setcellvalue', 0, "currency" ,$('#jqxAppliedInvoicing').jqxGrid('getcellvalue', rowindex1, "currency")); */
  	                
  			    	$("#overlay, #PleaseWait").show();
  			    	
  			    	$("#jqxManualApplingGrid").load("applyInvoicingGrid.jsp?accNo="+indexVal+'&accType='+accType+'&check='+check); 
  			     }

           });  
			
        });
    </script>
    <div id="jqxAppliedInvoicing"></div>
 
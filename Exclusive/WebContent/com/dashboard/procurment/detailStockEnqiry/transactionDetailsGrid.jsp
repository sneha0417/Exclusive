<%@page import="com.dashboard.procurment.detailStockEnqiry.ClsStockEnqiry"%>
<%ClsStockEnqiry DAO= new ClsStockEnqiry(); %>
 <%String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String rpttype = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype").trim();
 String productid = request.getParameter("productid")==null?"0":request.getParameter("productid").trim();
 String trtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
 String aa = request.getParameter("aa")==null?"0":request.getParameter("aa").trim();
 
 %>
 <script type="text/javascript">
 
 var trdetdata;
 var temp='<%=branchval%>';
 
 	if(temp!='NA'){ 
 		trdetdata='<%=DAO.transactionDetails(session,branchval,fromDate, toDate, productid,trtype,aa)%>';
    }
 	
        $(document).ready(function () { 	
    
        	$("#btnExcel").click(function() {
    			$("#transactionDetailsGridID").jqxGrid('exportdata', 'xls', 'TransactionDetails');
    		});            
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'date', type: 'date'  },
     						{name : 'docno', type: 'int'    },
     						{name : 'partyname', type: 'string'    },
     						{name : 'unit', type: 'int'    },
     						{name : 'qty', type: 'number'    },
     						{name : 'trhead', type: 'number'    },
     						{name : 'size', type: 'number'   },
     						{name : 'balance', type: 'number'  },
     						{name : 'detailinfo', type: 'string'  }
     						
                 ],
                 localdata: trdetdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#transactionDetailsGridID").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '10%' },
							{ text: 'Doc No', datafield: 'docno', width: '10%' },
							{ text: 'Party Name', datafield: 'partyname', width: '25%' },
							{ text: 'Unit', datafield: 'unit', width: '5%'  },
							{ text: 'Qty', datafield: 'qty', width: '10%',cellsformat: 'd2' },
							{ text: 'Issued', datafield: 'trhead', width: '12%',cellsformat: 'd2'  },
							{ text: 'Size', datafield: 'size', width: '14%',cellsformat: 'd2'  },
							{ text: 'Balance(SKU)', datafield: 'balance', width: '14%',cellsformat: 'd2' },
							{ text: 'Detail Info', datafield: 'detailinfo', hidden:true, width: '10%' },
	              ]
            });
            
            if(temp=='NA'){
                $("#transactionDetailsGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#transactionDetailsGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                var values= $('#transactionDetailsGridID').jqxGrid('getcellvalue',rowindex1, "detailinfo");
                
                var details = values.toString().replace(/\*/g, '\n');
             
                document.getElementById("detailinfo").value=details;
            });  
        });
        
</script>
<div id="transactionDetailsGridID"></div>
<input type="hidden" name="gridhead" id="gridhead" value='<s:property value="gridhead"/>'>

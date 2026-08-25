 <%@page import="com.dashboard.procurment.detailStockEnqiry.ClsStockEnqiry"%>
<%ClsStockEnqiry DAO= new ClsStockEnqiry(); %>
 <%String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String rpttype = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype").trim();
 String productid = request.getParameter("productid")==null?"0":request.getParameter("productid").trim(); 
 
  String aa = request.getParameter("aa")==null?"0":request.getParameter("aa").trim();
  
	
  %>
 
 <script type="text/javascript">
 
 var data;
 var temp='<%=branchval%>';
 
 	if(temp!='NA'){ 
 		 data='<%=DAO.currentStock(session,branchval,fromDate, toDate, productid,aa)%>'; 
    }
 	
        $(document).ready(function () { 	
    
        	$("#btnExcel").click(function() {
    			$("#currentStockGridID").jqxGrid('exportdata', 'xls', 'CurrentStock');
    		});            
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'brname', type: 'string'  },
     						{name : 'locm', type: 'string'    },
     						{name : 'rsvqty', type: 'number'    },
     						{name : 'delqty', type: 'number'    },
     						{name : 'reserved', type: 'number'    },
     						{name : 'balqty', type: 'number'    },
     						{name : 'balval', type: 'number'   },
     						{name : 'cpu', type: 'number'  },
     						{name : 'psrno', type: 'string'  }
     						
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#currentStockGridID").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
              
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							
							{ text: 'Branch', datafield: 'brname'  },
							{ text: 'Location', datafield: 'locm', width: '30%' },
							{ text: 'Pending Order', datafield: 'rsvqty', width: '15%',cellsformat: 'd2'  },
							{ text: 'Pending Delivery', datafield: 'delqty', width: '15%',cellsformat: 'd2'  },
							{ text: 'Reserved', datafield: 'reserved', width: '15%',cellsformat: 'd2',cellsalign: 'right',hidden:true },
							{ text: 'Stock', datafield: 'balqty', width: '15%',cellsformat: 'd2'  },
							 
							{ text: 'psrno', datafield: 'psrno', hidden:true, width: '10%' },
	              ]
            });
            
            if(temp=='NA'){
                $("#currentStockGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#currentStockGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                var values= $('#currentStockGridID').jqxGrid('getcellvalue',rowindex1, "detailinfo");
                
                var details = values.toString().replace(/\*/g, '\n');
             
                document.getElementById("detailinfo").value=details;
            });  
        });

</script>
<div id="currentStockGridID"></div>

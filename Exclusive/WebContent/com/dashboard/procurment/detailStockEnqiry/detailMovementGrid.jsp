<%-- <%@page import="com.dashboard.salik.ClsSalikDAO"%>
<%ClsSalikDAO DAO= new ClsSalikDAO(); %> --%>
 <%String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String rpttype = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype").trim();
 String product = request.getParameter("product")==null?"0":request.getParameter("product").trim();
 String unit = request.getParameter("unit")==null?"0":request.getParameter("unit").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
 String aa = request.getParameter("aa")==null?"0":request.getParameter("aa").trim();
 
 %>
 <script type="text/javascript">
 
 var data2;
 var temp='<%=branchval%>';
 
 	if(temp!='NA'){ 
 		<%-- data2='<%=DAO.detailStockEnquiryGridLoading(branchval,fromDate, toDate, rpttype, product, unit, check)%>'; --%>
    }
 	
        $(document).ready(function () { 	
    
        	$("#btnExcel").click(function() {
    			$("#detailMovementGridID").jqxGrid('exportdata', 'xls', 'DetailMovement');
    		});            
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'date', type: 'date'  },
     						{name : 'type', type: 'string'    },
     						{name : 'docno', type: 'int'    },
     						{name : 'quantity', type: 'int'    },
     						{name : 'costprice', type: 'number'    },
     						{name : 'avlquantity', type: 'number'   },
     						{name : 'detailinfo', type: 'string'  }
     						
                 ],
                 localdata: data2,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#detailMovementGridID").jqxGrid(
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
							
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '15%' },
							{ text: 'Type', datafield: 'type', width: '30%' },
							{ text: 'Doc No', datafield: 'docno', width: '15%' },
							{ text: 'Qty', datafield: 'quantity', width: '12%' },
							{ text: 'Cost Price', datafield: 'costprice', width: '14%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
							{ text: 'Avail. Qty', datafield: 'avlquantity', width: '14%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
							{ text: 'Detail Info', datafield: 'detailinfo', hidden:true, width: '10%' },
	              ]
            });
            
            if(temp=='NA'){
                $("#detailMovementGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#detailMovementGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                var values= $('#detailMovementGridID').jqxGrid('getcellvalue',rowindex1, "detailinfo");
                
                var details = values.toString().replace(/\*/g, '\n');
             
                document.getElementById("detailinfo").value=details;
            });  
        });
        
</script>
<div id="detailMovementGridID"></div>

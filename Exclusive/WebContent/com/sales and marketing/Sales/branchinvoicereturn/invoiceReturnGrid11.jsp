<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%-- <jsp:include page="../../../includes.jsp"></jsp:include> --%>
<% String docNo = request.getParameter("txtcashpaydocno2")==null?"0":request.getParameter("txtcashpaydocno2");%> 
<script type="text/javascript">
		 var data;  
        $(document).ready(function () { 
           
            var temp='<%=docNo%>';
             
            <%--  if(temp>0){   
            	 data='<%=com.finance.transactions.cashpayment.ClsCashPaymentDAO.cashPaymentGridReloading(session,docNo)%>';     
           	 } --%>
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'product', type: 'string' }, 
     						{name : 'productname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'size', type: 'string'   },
     						{name : 'quantity', type: 'int'   },
     						{name : 'refqty', type: 'int'  },
							{name : 'totwtkg', type: 'number' },
							{name : 'kgprice', type: 'number'  },
     						{name : 'unitprice', type: 'number' },
							{name : 'discountperc', type: 'number' },
							{name : 'discount', type: 'number' }
                        ],
                         localdata: data,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxInvoice").jqxGrid(
            {
                width: '99.5%',
                height: 150,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Product', datafield: 'product',  width: '10%' },
							{ text: 'Product Name', datafield: 'productname', width: '20%' },	
							{ text: 'Unit', datafield: 'unit', width: '7%' },	
							{ text: 'Size', datafield: 'size', width: '7%' },
							{ text: 'Quantity', datafield: 'quantity', width: '7%' },
							{ text: 'Ref. Qty', datafield: 'refqty', width: '7%' },
							{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Unit price', datafield: 'unitprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Discount %', datafield: 'discountperc', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Discount', datafield: 'discount', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
						]
            });
            
            //Add empty row
            /* if(temp==0){   
         	   $("#jqxInvoice").jqxGrid('addrow', null, {});
          	 }
         	  
            if(temp>0){
            	$("#jqxInvoice").jqxGrid('disabled', true);
            } */
          
        });
</script>
<div id="jqxInvoice"></div>

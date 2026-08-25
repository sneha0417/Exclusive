<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO"%>
<% ClspurchaseinvoiceDAO purchaseDAO = new ClspurchaseinvoiceDAO();  
String rowindex2 = request.getParameter("rowindex2")==null?"0":request.getParameter("rowindex2");
String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 
%>
<script type="text/javascript">
var temp='<%=dtype%>';
var rowindex2='<%=rowindex2%>';
     var termssearch= '<%=purchaseDAO.payableaccount() %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'sr_no', type: 'int'  },
                              {name : 'account', type: 'string'  },
                              {name : 'accountname', type: 'string'  },
                              {name : 'headdocno', type: 'string'  },
                              
                              {name : 'desc1', type: 'string'  },
                              
                            ],
                       localdata: termssearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#expgrid").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'SR_NO', datafield: 'sr_no', width: '10%'},
                              { text: 'Account', datafield: 'account', width: '20%' },
                              { text: 'Account Name', datafield: 'accountname', width: '30%' },
                              { text: 'Description', datafield: 'desc1', width: '40%' },
                              
                              { text: 'headdoc', datafield: 'headdocno', width: '20%',hidden:true },
						]
            });
            
 
             
          $('#expgrid').on('celldoubleclick', function (event) {       
        	
                var rowindex1= event.args.rowindex;
                
                $('#purchexpgrid').jqxGrid('setcellvalue', rowindex2, "accountdono" ,$('#expgrid').jqxGrid('getcellvalue', rowindex1, "headdocno"));
                $('#purchexpgrid').jqxGrid('setcellvalue', rowindex2, "desc1" ,$('#expgrid').jqxGrid('getcellvalue', rowindex1, "desc1"));
                
                
                
                $('#purchexpgrid').jqxGrid('setcellvalue', rowindex2, "account" ,$('#expgrid').jqxGrid('getcellvalue', rowindex1, "account"));
                $('#purchexpgrid').jqxGrid('setcellvalue', rowindex2, "accountname" ,$('#expgrid').jqxGrid('getcellvalue', rowindex1, "accountname"));
                
                
                
                $('#purchexpgrid').jqxGrid('setcellvalue', rowindex2, "descsrno" ,$('#expgrid').jqxGrid('getcellvalue', rowindex1, "sr_no"));
                
                
                
                
            	 var rows = $('#purchexpgrid').jqxGrid('getrows');
                 var rowlength= rows.length;
    
                 
                 if(rowindex2 == rowlength-1)
                 	{  
                 $("#purchexpgrid").jqxGrid('addrow', null, {});
                 	} 
            	
                
                
                
              $('#expencewindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="expgrid"></div> 
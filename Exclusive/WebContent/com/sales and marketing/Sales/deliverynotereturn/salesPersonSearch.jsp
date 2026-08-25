<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.marketing.salesorder.ClsSalesOrderDAO"%>
<%ClsSalesOrderDAO DAO= new ClsSalesOrderDAO();%>
<script type="text/javascript">

     var typesearch= '<%=DAO.searchSalesPerson(session) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'sal_name', type: 'string'  },
                              
                            ],
                       localdata: typesearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#spsearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%'},
                              { text: 'Sales Person', datafield: 'sal_name', width: '60%' },
                              
						]
            });
            
             
          $('#spsearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                document.getElementById("txtsalesperson").value=$('#spsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
                document.getElementById("salespersonid").value=$('#spsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
              $('#salespersonwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="spsearch"></div> 
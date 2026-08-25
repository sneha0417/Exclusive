<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>
 
<%

ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();

%>
<script type="text/javascript">

     var typesearch= '<%=viewDAO.typeFormSearch(session) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'ptype', type: 'string'  },
                              {name : 'per', type: 'number'  },
                              {name : 'taxaccount', type: 'number'  },
                              
                              
                              
                              
                              
                            ],
                       localdata: typesearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#typesearch").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%',hidden:true},
                              { text: 'Type', datafield: 'ptype', width: '100%' },
                              { text: 'Tax Per', datafield: 'per', width: '10%',hidden:true },
                              
						]
            });
            
             
          $('#typesearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                document.getElementById("txtproducttype").value=$('#typesearch').jqxGrid('getcellvalue', rowindex1, "ptype");
                document.getElementById("hideproducttype").value=$('#typesearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("taxpers").value=$('#typesearch').jqxGrid('getcellvalue', rowindex1, "per");
                
                document.getElementById("taxaccount").value=$('#typesearch').jqxGrid('getcellvalue', rowindex1, "taxaccount");
                
                
                
                
              $('#typesearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="typesearch"></div> 
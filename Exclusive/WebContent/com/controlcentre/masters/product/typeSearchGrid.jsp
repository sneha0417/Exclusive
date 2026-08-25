<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();%>
<script type="text/javascript">
 	var uomrow='<%=request.getParameter("rowno") %>';
     var typesearch= '<%=DAO.typeSearch(session) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'ptype', type: 'string'  },
                              
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
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%'},
                              { text: 'Product Type', datafield: 'ptype', width: '60%' },
                              
						]
            });
            
             
          $('#typesearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'ptype',$('#typesearch').jqxGrid('getcellvalue', rowindex1, "ptype"));
                $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'typeid',$('#typesearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                
              $('#typesearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="typesearch"></div> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();%>
<script type="text/javascript">
 	var uomrow='<%=request.getParameter("rowno") %>';
     var brandsearch= '<%=DAO.brandSearch(session) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'string'  },
                              {name : 'brand', type: 'string'  }
                            ],
                       localdata: brandsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#brandsearch").jqxGrid(
            {
                width: '100%',
                height: 370,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%',hidden:true},
                              { text: 'Brand', datafield: 'brand', width: '100%' },
                              
						]
            });
            
             
          $('#brandsearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'brand',$('#brandsearch').jqxGrid('getcellvalue', rowindex1, "brand"));
                $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'brandid',$('#brandsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                
              $('#brandsearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="brandsearch"></div> 
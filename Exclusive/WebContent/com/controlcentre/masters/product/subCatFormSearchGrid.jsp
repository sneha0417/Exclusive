<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();%>
<%String catid=request.getParameter("catid").toString();%>
<script type="text/javascript">
 
     var subcatsearch= '<%=DAO.subCatFormSearch(session,catid) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'subcategory', type: 'string'  }
                            ],
                       localdata: subcatsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#subcategorysearch").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%',hidden:true},
                              { text: 'SubCategory', datafield: 'subcategory', width: '100%' },
                              
						]
            });
            
             
          $('#subcategorysearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                document.getElementById("txtsubcategory").value=$('#subcategorysearch').jqxGrid('getcellvalue', rowindex1, "subcategory");
                document.getElementById("cmbsubcategory").value=$('#subcategorysearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
              $('#subcatsearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="subcategorysearch"></div> 
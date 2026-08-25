<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
  
 
 <%@page import="com.dashboard.pricemanagement.review.ClsreviewDAO"%>
 <% ClsreviewDAO searchDAO = new ClsreviewDAO();  %>
<script type="text/javascript">
 
     var catsearch= '<%=searchDAO.catFormSearch(session) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'category', type: 'string'  }
                            ],
                       localdata: catsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#categorysearch").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%',hidden:true},
                              { text: 'Category', datafield: 'category', width: '100%' },
                              
						]
            });
            
             
          $('#categorysearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                document.getElementById("name").value=$('#categorysearch').jqxGrid('getcellvalue', rowindex1, "category");
                document.getElementById("catid").value=$('#categorysearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
              $('#catsearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="categorysearch"></div> 
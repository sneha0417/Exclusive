<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();%>
<script type="text/javascript">

     var deptsearch= '<%=DAO.deptSearch(session) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'department', type: 'string'  }
                            ],
                       localdata: deptsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#deptsearch").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no',  width: '40%',hidden:true},
                              { text: 'Department', datafield: 'department', width: '100%' }
						]
            });
            
             
          $('#deptsearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                document.getElementById("textdept").value=$('#deptsearch').jqxGrid('getcellvalue', rowindex1, "department");
                document.getElementById("cmbdept").value=$('#deptsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
              $('#deptsearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="deptsearch"></div> 
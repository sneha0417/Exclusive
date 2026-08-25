<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();%>
<%String brandid=request.getParameter("brandid");%>
<script type="text/javascript">
 	var uomrow='<%=request.getParameter("rowno") %>';
     var modelsearch= '<%=DAO.modelSearch(session,brandid) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'string'  },
                              {name : 'model', type: 'string'  },
                              {name : 'brand', type: 'string'  }
                            ],
                       localdata: modelsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#modelsearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', hidden:true, width: '20%'},
                              { text: 'Model', datafield: 'model', width: '40%' },
                              { text: 'Brand', datafield: 'brand', width: '60%' },
						]
            });
            
             
          $('#modelsearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'model',$('#modelsearch').jqxGrid('getcellvalue', rowindex1, "model"));
                $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'modelid',$('#modelsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                
              $('#modelsearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="modelsearch"></div> 
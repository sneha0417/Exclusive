<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();%>
<%String modelid=request.getParameter("modelid");%>
<script type="text/javascript">
 	var uomrow='<%=request.getParameter("rowno") %>';
     var submodelsearch= '<%=DAO.subModelSearch(session,modelid) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'string'  },
                              {name : 'submodel', type: 'string'  },
                              {name : 'model', type: 'string'  }
                            ],
                       localdata: submodelsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#submodelsearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', hidden:true, width: '20%'},
                              { text: 'Sub Model', datafield: 'submodel', width: '40%' },
                              { text: 'Model', datafield: 'model', width: '60%' },
						]
            });
            
             
          $('#submodelsearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'submodel',$('#submodelsearch').jqxGrid('getcellvalue', rowindex1, "submodel"));
                $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'submodelid',$('#submodelsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                
              $('#submodelsearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="submodelsearch"></div> 
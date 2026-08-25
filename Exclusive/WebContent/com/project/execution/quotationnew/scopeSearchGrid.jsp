 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.quotationnew.ClsQuotationDAO"%> 
<%ClsQuotationDAO DAO= new ClsQuotationDAO();%>
<script type="text/javascript">
 	 var uomrow='<%=request.getParameter("rowno") %>';
     
 	 var scopesearch= '<%=DAO.scopeSearch(session) %>' ;
		
     $(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'scode', type: 'string'  },
                              {name : 'sname', type: 'string'  }
                            ],
                       localdata: scopesearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#scopeSearchGridId").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', hidden:true, width: '20%'},
                              { text: 'Code', datafield: 'scode', width: '40%' },
                              { text: 'Scope', datafield: 'sname', width: '60%' },
						]
            });
            
             
          $('#scopeSearchGridId').on('rowdoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                $('#serviceGrid').jqxGrid('setcellvalue', uomrow, 'scope',$('#scopeSearchGridId').jqxGrid('getcellvalue', rowindex1, "scode"));
                $('#serviceGrid').jqxGrid('setcellvalue', uomrow, 'scopeid',$('#scopeSearchGridId').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                
              $('#scopesearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="scopeSearchGridId"></div> 
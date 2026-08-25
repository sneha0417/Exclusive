 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.marketing.quotationdetail.ClsQuotationDetailDAO"%>
<%ClsQuotationDetailDAO DAO= new ClsQuotationDetailDAO();%>
<script type="text/javascript">
 	var uomrow='<%=request.getParameter("rowno") %>';
     var unitsearchGrid1= '<%=DAO.unitSearch(session) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'unit', type: 'string'  },
                              {name : 'unit_desc', type: 'string'  }
                            ],
                       localdata: unitsearchGrid1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#unitsearchGrid").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', hidden:true, width: '20%'},
                              { text: 'Unit', datafield: 'unit', width: '40%' },
                              { text: 'Unit Desc', datafield: 'unit_desc', width: '60%' },
						]
            });
            
             
          $('#unitsearchGrid').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                $('#qutDetGrid').jqxGrid('setcellvalue', uomrow, 'unit',$('#unitsearchGrid').jqxGrid('getcellvalue', rowindex1, "unit"));
                $('#qutDetGrid').jqxGrid('setcellvalue', uomrow, 'unitid',$('#unitsearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                
              $('#unitsearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="unitsearchGrid"></div> 
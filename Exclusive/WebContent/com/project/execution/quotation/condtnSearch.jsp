<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.quotation.ClsQuotationDAO"%>
<%ClsQuotationDAO DAO= new ClsQuotationDAO();
String rowindex2 = request.getParameter("rowindex2")==null?"0":request.getParameter("rowindex2");
String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
String tdocno = request.getParameter("tdocno")==null?"0":request.getParameter("tdocno");
%>
<script type="text/javascript">
var temp='<%=dtype%>';
var rowindex2='<%=rowindex2%>';
     var consearch= '<%=DAO.condtnSearch(session,dtype,tdocno) %>';
		$(document).ready(function () { 	
           
			
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'string'  },
                              {name : 'rdocno', type: 'string'  },
                              {name : 'termsfooter', type: 'string'  },
                              
                            ],
                       localdata: consearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxcondtnSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'doc_no', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'rdocno', datafield: 'rdocno', width: '40%',hidden:true },
                              { text: 'Description', datafield: 'termsfooter', width: '100%',editable:false },
                              
						]
            });
            
             
          $('#jqxcondtnSearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                $('#jqxTerms').jqxGrid('setcellvalue', rowindex2, "conditions" ,$('#jqxcondtnSearch').jqxGrid('getcellvalue', rowindex1, "termsfooter"));
                //$('#jqxTerms').jqxGrid('setcellvalue', rowindex2, "voc_no" ,$('#jqxcondtnSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                
              $('#searchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxcondtnSearch"></div> 
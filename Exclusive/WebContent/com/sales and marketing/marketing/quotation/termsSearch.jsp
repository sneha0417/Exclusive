<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.marketing.salesquotation.ClsSalesQuotationDAO"%>
<%ClsSalesQuotationDAO DAO= new ClsSalesQuotationDAO();
String rowindex2 = request.getParameter("rowindex2")==null?"0":request.getParameter("rowindex2");
String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
System.out.println("==rowindex2==="+rowindex2+"=dtype==="+dtype);
%>
<script type="text/javascript">
var temp='<%=dtype%>';
var rowindex2='<%=rowindex2%>';
     var termssearch= '<%=DAO.termsSearch(session,dtype) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'voc_no', type: 'int'  },
                              {name : 'dtype', type: 'string'  },
                              {name : 'header', type: 'string'  },
                              
                            ],
                       localdata: termssearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxtermsSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'voc_no', width: '10%',hidden:true},
                              { text: 'Dtype', datafield: 'dtype', width: '40%',hidden:true },
                              { text: 'Terms', datafield: 'header', width: '100%' },
                              
						]
            });
            
             
          $('#jqxtermsSearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                $('#jqxTerms').jqxGrid('setcellvalue', rowindex2, "terms" ,$('#jqxtermsSearch').jqxGrid('getcellvalue', rowindex1, "header"));
                $('#jqxTerms').jqxGrid('setcellvalue', rowindex2, "voc_no" ,$('#jqxtermsSearch').jqxGrid('getcellvalue', rowindex1, "voc_no"));
                
              $('#searchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxtermsSearch"></div> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.ClsTerms"%>
<%ClsTerms DAO= new ClsTerms();
String rowindex2 = request.getParameter("rowindex2")==null?"0":request.getParameter("rowindex2");
String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
%>
<script type="text/javascript">
var temp='<%=dtype%>';
var rowindex2='<%=rowindex2%>';
     var comtermssearch= '<%=DAO.termsSearch(session,dtype) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
							  {name : 'doc_no', type: 'string'  },
                              {name : 'voc_no', type: 'string'  },
                              {name : 'dtype', type: 'string'  },
                              {name : 'header', type: 'string'  },
                              
                            ],
                       localdata: comtermssearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxcomTermsSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                /* showfilterrow: true, 
                filterable: true,  */
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'voc_no', width: '20%'},
                              { text: 'Dtype', datafield: 'dtype', width: '40%' },
                              { text: 'Terms', datafield: 'header', width: '40%' },
                              { text: 'Docno', datafield: 'doc_no', width: '20%',hidden:true},
                              
						]
            });
            
             
          $('#jqxcomTermsSearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                $('#jqxComTerms').jqxGrid('setcellvalue', rowindex2, "terms" ,$('#jqxcomTermsSearch').jqxGrid('getcellvalue', rowindex1, "header"));
                $('#jqxComTerms').jqxGrid('setcellvalue', rowindex2, "voc_no" ,$('#jqxcomTermsSearch').jqxGrid('getcellvalue', rowindex1, "voc_no"));
                $('#jqxComTerms').jqxGrid('setcellvalue', rowindex2, "doc_no" ,$('#jqxcomTermsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                
                $("#jqxComTerms").jqxGrid('addrow', null, {});
                
              $('#comsearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxcomTermsSearch"></div> 
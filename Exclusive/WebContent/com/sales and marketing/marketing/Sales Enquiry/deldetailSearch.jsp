 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.marketing.salesenquiry.ClsSalesEnquiryDAO"%>
<%
	ClsSalesEnquiryDAO DAO = new ClsSalesEnquiryDAO();
%>

<script type="text/javascript">
 
     var detdata= '<%=DAO.deldetailsSearch() %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'desc1', type: 'string'  },
                             
                              
                            ],
                       localdata: detdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#delgrid").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '20%',hidden:true},
                              
                              { text: 'Description', datafield: 'desc1', width: '100%' },
                              
						]
            });
            
             
          $('#delgrid').on('rowdoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                var rowindex2= $('#rowindex2').val();
                $('#shipdata').jqxGrid('setcellvalue', rowindex2, "doc_nos" ,$('#delgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                $('#shipdata').jqxGrid('setcellvalue', rowindex2, "desc1" ,$('#delgrid').jqxGrid('getcellvalue', rowindex1, "desc1"));
                
                var rows = $('#shipdata').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex2 == rowlength - 1)
                	{  
                $("#shipdata").jqxGrid('addrow', null, {});
                	} 
                	  
                
              $('#tremwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="delgrid"></div> 
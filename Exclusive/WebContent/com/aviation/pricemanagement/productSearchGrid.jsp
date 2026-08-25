<%@page import="com.aviation.pricemanagement.ClsPriceManagementDAO"%>
<% ClsPriceManagementDAO DAO = new ClsPriceManagementDAO(); %> 

 <%
 String name = request.getParameter("name")==null?"0":request.getParameter("name");
 String code = request.getParameter("pcode")==null?"0":request.getParameter("pcode");
 String docnos = request.getParameter("docnos")==null?"0":request.getParameter("docnos");
 String load = request.getParameter("load")==null?"0":request.getParameter("load");
%> 

<script type="text/javascript">
var check='<%=load%>';
var data3;
if(check=="yes"){
	data3= '<%=DAO.productSearch(session,name,code,docnos,load) %>'; 
}
else{
	data3;
}
        $(document).ready(function () { 
        	      
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'brand', type: 'string'   },
     						{name : 'category', type: 'string'   },
     						{name : 'subcategory', type: 'string'   },
     						{name : 'productcode', type: 'string'  },
     						{name : 'productname', type: 'string'  },
     						{name : 'docno', type: 'string'  },
     						{name : 'psrno', type: 'string'  }
                        ],
                		localdata: data3, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxProductSearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                selectionmode: 'singlerow',
                columnsresize: true,

                columns: [
                            { text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
                            { text: 'psrno', hidden : true, datafield: 'psrno', width: '15%' },
							{ text: 'Product Code', datafield: 'productcode', width: '45%' },
							{ text: 'Product Name', datafield: 'productname', width: '65%' },
							
						]
            });
            
             $('#jqxProductSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("errormsg").innerText="";
                document.getElementById("part_no").value = $('#jqxProductSearch').jqxGrid('getcellvalue', rowindex1, "productcode");
                document.getElementById("pname").value = $('#jqxProductSearch').jqxGrid('getcellvalue', rowindex1, "productname");
                document.getElementById("hidpsrno").value = $('#jqxProductSearch').jqxGrid('getcellvalue', rowindex1, "psrno");
                $("#jqxProductSearch").jqxGrid('clear');
             	$('#productSearchwindow').jqxWindow('close');
            });  
        });
    </script>
    <div id="jqxProductSearch"></div>
 
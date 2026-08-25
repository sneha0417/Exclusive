<%@page import="com.aviation.aviationinvoice.ClsaviationInvoiceDAO"%>
<% ClsaviationInvoiceDAO DAO = new ClsaviationInvoiceDAO(); %> 

 <%
 String name = request.getParameter("name")==null?"0":request.getParameter("name");
 String code = request.getParameter("pcode")==null?"0":request.getParameter("pcode");
 String cat = request.getParameter("cat")==null?"0":request.getParameter("cat");
 String subcat = request.getParameter("subcat")==null?"0":request.getParameter("subcat");
 String brand = request.getParameter("brand")==null?"0":request.getParameter("brand");
 String docnos = request.getParameter("docnos")==null?"0":request.getParameter("docnos");
 String load = request.getParameter("load")==null?"0":request.getParameter("load");
%> 

<script type="text/javascript">
var check='<%=load%>';

        $(document).ready(function () { 
        	      
        	var data21;
        	if(check=="yes"){
        		  data21= '<%=DAO.productSearch(session,name,code,brand,cat,subcat,docnos,load) %>'; 
        	}
        	else{
        		  data21;
        	}
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
     						{name : 'doc_no', type: 'string'  }
                        ],
                		localdata: data21, 
                
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
                            { text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' ,hidden:true},
							{ text: 'Product Code', datafield: 'productcode', width: '30%' },
							{ text: 'Product Name', datafield: 'productname', width: '70%' },
							{ text: 'Brand',  datafield: 'brand', width: '15%',hidden:true},
							{ text: 'Category', datafield: 'category', width: '15%' ,hidden:true},
							{ text: 'Sub Category', datafield: 'subcategory', width: '13%' ,hidden:true },
						]
            });
            
             $('#jqxProductSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("errormsg").innerText="";
                document.getElementById("part_no").value = $('#jqxProductSearch').jqxGrid('getcellvalue', rowindex1, "productcode");
                document.getElementById("pname").value = $('#jqxProductSearch').jqxGrid('getcellvalue', rowindex1, "productname");
                document.getElementById("psrno").value = $('#jqxProductSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	$('#productSearchwindow').jqxWindow('close');
            });  
        });
    </script>
    <div id="jqxProductSearch"></div>
 
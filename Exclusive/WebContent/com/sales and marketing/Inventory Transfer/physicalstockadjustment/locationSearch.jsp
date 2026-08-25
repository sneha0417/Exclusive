<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.InventoryTransfer.physicalstockadjustment.ClsphysicalStockadjustmentDAO"%>
<%ClsphysicalStockadjustmentDAO DAO= new ClsphysicalStockadjustmentDAO();

String brch=request.getParameter("brch")==null?"0":request.getParameter("brch").trim();

%>
<script type="text/javascript">

     var locsearch= '<%=DAO.searchLocation(brch) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'location', type: 'string'  },
                              {name : 'branch', type: 'string'  },
                              
                            ],
                       localdata: locsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#locationsearch").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '10%',hidden:true},
                              { text: 'Location', datafield: 'location', width: '60%' },
                              { text: 'Branch', datafield: 'branch', width: '40%' },
                              
						]
            });
            
             
          $('#locationsearch').on('rowdoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
            	document.getElementById("errormsg").innerText=""; 
        		$("#jqxstkAdjustment").jqxGrid('clear'); 
				$("#jqxstkAdjustment").jqxGrid('addrow', null, {});
            	
                document.getElementById("txtlocation").value=$('#locationsearch').jqxGrid('getcellvalue', rowindex1, "location");
                document.getElementById("locationid").value=$('#locationsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
              $('#locationwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="locationsearch"></div> 
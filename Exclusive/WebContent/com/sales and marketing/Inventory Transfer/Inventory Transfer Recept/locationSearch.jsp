<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.InventoryTransfer.InventoryTransferRecept.ClsTransferReceptDAO"%>
<%ClsTransferReceptDAO DAO= new ClsTransferReceptDAO();%>
<%
String branchid=request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
String searchtype=request.getParameter("searchtype")==null?"0":request.getParameter("searchtype").trim();
%>

<script type="text/javascript">
	var searchtype='<%=searchtype%>';
     var locsearch= '<%=DAO.searchLocation(session,branchid,searchtype) %>';
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
                if(searchtype=="1"){
                	 document.getElementById("txtfrmlocation").value=$('#locationsearch').jqxGrid('getcellvalue', rowindex1, "location");
                     document.getElementById("locationfrmid").value=$('#locationsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                }
                if(searchtype=="2"){
               	 document.getElementById("txttolocation").value=$('#locationsearch').jqxGrid('getcellvalue', rowindex1, "location");
                    document.getElementById("locationtoid").value=$('#locationsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               }
               
                document.getElementById("errormsg").innerText=""; 
              $('#locationwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="locationsearch"></div> 
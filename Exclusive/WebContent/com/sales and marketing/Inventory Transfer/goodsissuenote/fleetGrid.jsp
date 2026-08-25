<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.InventoryTransfer.goodsissuenote.ClsGoodsissuenoteDAO"%>
<% ClsGoodsissuenoteDAO searchDAO = new ClsGoodsissuenoteDAO(); %> 



 
 <%

String typedocno=request.getParameter("docno")==null?"0":request.getParameter("docno");
 String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
 String refnames=request.getParameter("refnames")==null?"0":request.getParameter("refnames");
 
 String search="yes";
 

%>
 
 

<script type="text/javascript">



  
var costcode1='<%=searchDAO.fleetSearch() %>'; 

  	 $(document).ready(function () { 	
  		 
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'fleetno', type: 'string'  },
						 
                            {name : 'fleetname', type: 'string'  },
                            {name : 'regno', type: 'string'  }
                        ],
                      localdata: costcode1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }                          
            };
         
		    
			
            var dataAdapter = new $.jqx.dataAdapter(source); 
            
            $("#fleetsearch").jqxGrid(
            {
                width: '100%',
                height: 370,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Fleet No', datafield: 'fleetno', width: '20%'},
					 
                              { text: 'Fleet Name', datafield: 'fleetname'},
                              { text: 'Reg No', datafield: 'regno', width: '20%' },
						]
            });
            
           $('#fleetsearch').on('rowdoubleclick', function (event) {
        	   
        	   var rowindex1 = event.args.rowindex;      
               document.getElementById("itemdocno").value=$('#fleetsearch').jqxGrid('getcellvalue', rowindex1, "fleetno");
            	   document.getElementById("itemname").value=$('#fleetsearch').jqxGrid('getcellvalue', rowindex1, "fleetname");
            	   
            	   
            	   document.getElementById("costtr_no").value=$('#fleetsearch').jqxGrid('getcellvalue', rowindex1, "fleetno");
            	   
            	   
                
                $('#searchwindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="fleetsearch"></div> 
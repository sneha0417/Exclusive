<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.InventoryTransfer.materialrequest.ClsMaterialrequestDAO"%>
<% ClsMaterialrequestDAO searchDAO = new ClsMaterialrequestDAO(); %> 



 
 <%

String typedocno=request.getParameter("docno")==null?"0":request.getParameter("docno");
 String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
 String refnames=request.getParameter("refnames")==null?"0":request.getParameter("refnames");
 
 String search="yes";
 

%>
 
 

<script type="text/javascript">



  
var costcode='<%=searchDAO.costunitsearch(session,"1","0","0",search) %>'; 

  	 $(document).ready(function () { 	
  		 
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'doc_no', type: 'string'  },
						 
                            {name : 'code', type: 'string'  },
                            {name : 'name', type: 'string'  }
                        ],
                      localdata: costcode,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }                          
            };
         
		    
			
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costcodeSearch").jqxGrid(
            {
                width: '100%',
                height: 370,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Docno', datafield: 'doc_no', width: '20%', hidden: true},
					 
                              { text: 'Cost Code', datafield: 'code', width: '20%'},
                              { text: 'Cost Group', datafield: 'name' },
						]
            });
            
           $('#costcodeSearch').on('rowdoubleclick', function (event) {
        	   
        	   var rowindex1 = event.args.rowindex;      
               document.getElementById("itemdocno").value=$('#costcodeSearch').jqxGrid('getcellvalue', rowindex1, "code");
            	   document.getElementById("itemname").value=$('#costcodeSearch').jqxGrid('getcellvalue', rowindex1, "name");
            	   
            	   
            	   document.getElementById("costtr_no").value=$('#costcodeSearch').jqxGrid('getcellvalue', rowindex1, "code");
            	   
            	   
                
                $('#searchwindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="costcodeSearch"></div> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 
 <%@page import="com.dashboard.purchases.purchaserequestfollowup.ClsPurchaseRequestFollowupDAO"%>
 <% ClsPurchaseRequestFollowupDAO searchDAO = new ClsPurchaseRequestFollowupDAO(); 

 
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
 
 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 

 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 
 String descriptions = request.getParameter("descriptions")==null?"NA":request.getParameter("descriptions"); 
 
 String refnoss = request.getParameter("refnoss")==null?"NA":request.getParameter("refnoss"); 
 
 
%>

<script type="text/javascript">


var purordermain= '<%=searchDAO.mainsearch(session,docnoss,datess,aa,descriptions,refnoss) %>'; 

 


        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            
                            {name : 'voc_no', type: 'int'   },
                         
                            {name : 'date', type: 'date'   },
     					
     						{name : 'refno', type: 'string'   },
     		 
     						{name : 'description', type: 'string'   },
     					 
     						
                        ],
                		localdata: purordermain, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mainsearshgrid").jqxGrid(
            {
                width: '100%',
                height: 310,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                          { text: 'master No', datafield: 'doc_no', width: '6%',hidden:true },
                         
                            { text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
						 
								 { text: 'Ref No', datafield: 'refno', width: '10%'    },
								 
										{ text: 'Description', datafield: 'description', width: '65%' },
										 
										
						]
            });
            
             $('#mainsearshgrid').on('rowdoubleclick', function (event) {
                 var rowindex1 = event.args.rowindex;
        		 document.getElementById("docnosss").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
        		 document.getElementById("reqdocno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
  				 $('#Searchwindow').jqxWindow('close');  
           
            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>
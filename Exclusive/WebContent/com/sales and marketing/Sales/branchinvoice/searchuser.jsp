<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <%@page import="com.dashboard.pricemanagement.pricemanagementreview.ClsPriceManagementReviewDAO"%>
 <% ClsPriceManagementReviewDAO searchDAO = new ClsPriceManagementReviewDAO(); %>


 
<script type="text/javascript">


var userdata= '<%=searchDAO.usersearch() %>';   

 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [


                             {name : 'doc_no', type: 'String'  },    
      						{name : 'user_name', type: 'String'  },
      						{name : 'user_id', type: 'String'  },
                             
      						
                        ],
                		localdata: userdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#usergrid").jqxGrid(
            {
                width: '100%',
                height: 335,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                          
          				{ text: 'ID', datafield: 'doc_no', width: '20%',hidden:true},
    					{ text: 'User Name', datafield: 'user_id', width: '100%' },
    					 
    					
    					
										
						]
            });
            
             $('#usergrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;  
           	 $('#pass_wordss').attr('disabled', false);
               
                document.getElementById("userdocno").value = $('#usergrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                document.getElementById("user_namess").value = $('#usergrid').jqxGrid('getcellvalue', rowindex1, "user_id");
                
                
                document.getElementById("userids").value = $('#usergrid').jqxGrid('getcellvalue', rowindex1, "user_id");

              $('#userwindow').jqxWindow('close');  
        
            }); 
             
        });
    </script>
    <div id="usergrid"></div>
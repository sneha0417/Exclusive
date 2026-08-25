

 
 <%@page import="com.dashboard.purchases.purchaseorderfollowup.ClsPurchaseorderFollowupDAO"%>
 <% ClsPurchaseorderFollowupDAO searchDAO = new ClsPurchaseorderFollowupDAO(); 
 
String rdoc = request.getParameter("rdoc")==null?"0":request.getParameter("rdoc");

System.out.println("---rdoc---"+rdoc);
String refrowno = request.getParameter("refrowno")==null?"0":request.getParameter("refrowno");


 %>
 <script type="text/javascript">
 


 
 var details; 
 var rdocs='<%=rdoc%>';
       if(rdocs>0)
    	   {
    	   details='<%=searchDAO.Details(rdoc)%>';  
    	   }
	 else
	 {
		 details; 
	 }
	 
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'detdate', type: 'date'  },
                 		
     						{name : 'user', type: 'String'},
     						
     						 {name : 'remk', type: 'String'},
     						{name : 'fdate' , type : 'date'}
     						
                          	],
                          	localdata: details,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#duedetailsgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 102,
                source: dataAdapter,
                
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
                columns: [
						
							{ text: 'Date', datafield: 'detdate', width: '10%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'User', datafield: 'user', width: '18%' },
				
							 { text: 'Follow-Up Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy'},	
							 
							 { text: 'Remarks', datafield: 'remk', width: '62%' },
							
					
					]
            });
         
        
           
        });
        
        
				       
                       
    </script>
    <div id="duedetailsgrid"></div>
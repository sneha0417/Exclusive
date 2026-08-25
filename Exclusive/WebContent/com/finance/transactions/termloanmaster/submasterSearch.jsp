<%@page import="com.finance.transactions.termloanmaster.ClstermloanmasterDAO" %>
<%
ClstermloanmasterDAO cvp=new ClstermloanmasterDAO();
%>
<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
 String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 
 String reftypess = request.getParameter("reftypess")==null?"NA":request.getParameter("reftypess"); 
 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 %>
<script type="text/javascript">

var vahOrdermaster= '<%=cvp.searchmaster(session,docnoss,accnamess,datess,aa) %>'; 
 
        $(document).ready(function () { 	
        
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             
                             
                             
				            {name : 'voc_no', voc_no: 'int'},
     						{name : 'doc_no', type: 'int'},
     						{name : 'date', type: 'date'  },
     					 
     						{name : 'desc1', type: 'string'  },
     					 
     						{name : 'loanentrydate', type: 'date'  },
     					 
     						{name : 'tr_no', type: 'string' },
     					 
     						
     						
     						
     			 
     											
                 ],
                 localdata: vahOrdermaster,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#vehpurchase").jqxGrid(
            {
                width: '100%',
                height: 308,
                source: dataAdapter,
                
                selectionmode: 'singlerow',
             
                
          
          

                       
                columns: [

                           { text: 'masterDoc NO', datafield: 'doc_no', width: '7%',hidden:true },	
							{ text: 'Doc NO', datafield: 'voc_no', width: '7%' },	
							{ text: 'Date', datafield: 'date', width: '13%' ,cellsformat:'dd.MM.yyyy'},
						 
							{ text: 'Description', datafield: 'desc1'  },	
						 
							{ text: 'INV DATE', datafield: 'loanentrydate', width: '5%' ,cellsformat:'dd.MM.yyyy',hidden:true},
							
							{ text: 'tr_no', datafield: 'tr_no', width: '5%'  ,hidden:true },
							
							
			              ]
               
            });
            
            $('#vehpurchase').on('rowdoubleclick', function (event) {
            
                var rowindex2 = event.args.rowindex;
                $('#vehrefno').attr('disabled', false);
     
              
    			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
    			$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                           	
    			
    			
    			   document.getElementById("tranno").value=$('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "tr_no");
                   document.getElementById("docno").value=$('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "voc_no");
                   
                   document.getElementById("masterdoc_no").value=$('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "doc_no");
                   
                   
                   $('#vehpurorderDate').val ($('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "date"));
                   
                   if(document.getElementById("tranno").value>0)
                	   {
                   $('#vehpurinvDate').val ($('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "loanentrydate"));
                   
                	   }
                   
                   
                 
      
                  
                   
                  document.getElementById("vehdesc").value  = $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "desc1");
             
             
              $('#window').jqxWindow('close'); 
       
        	 $('#vehpurorderDate').jqxDateTimeInput({ disabled: false});
        	 $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
         
        	 funSetlabel();
            document.getElementById("frmtermloan").submit();
            }); 
              	  
   
        });
    </script>
    <div id="vehpurchase"></div>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%@page import="com.procurement.purchase.purchaserequest.ClsPurchaserequestDAO"%>
<% ClsPurchaserequestDAO  PurchaserequestDAO = new ClsPurchaserequestDAO(); %> 

<%
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
 
 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 

 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 
 String descriptions = request.getParameter("descriptions")==null?"NA":request.getParameter("descriptions"); 
 
 String refnoss = request.getParameter("refnoss")==null?"NA":request.getParameter("refnoss"); 
 
 
%>

<script type="text/javascript">


var purordermain= '<%=PurchaserequestDAO.mainsearch(session,docnoss,datess,aa,descriptions,refnoss) %>'; 
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
                height: 283,
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
           	 $('#reqmasterdate').jqxDateTimeInput({ disabled: false});
        	  
        	 document.getElementById("docno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
        	 document.getElementById("masterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
             document.getElementById("refno").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "refno");
             document.getElementById("purdesc").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "description");
   /*              document.getElementById("docno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
                $('#nipurchaseorderdate').val($("#mainsearshgrid").jqxGrid('getcellvalue', rowindex1, "date")) ;
                $('#deliverydate').val($("#mainsearshgrid").jqxGrid('getcellvalue', rowindex1, "deldate")) ;
              
                document.getElementById("refno").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "refno");
                
                $('#acctypeval').val($('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "type"));
                
                $('#cmbcurrval').val($('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "curid"));
                
        
            	  document.getElementById("currate").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "rate");
                  
                  document.getElementById("delterms").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "delterm");
              	document.getElementById("payterms").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "payterm");
                document.getElementById("purdesc").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "desc1");
                
                document.getElementById("puraccid").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "account");
            	document.getElementById("puraccname").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "description");
                
               document.getElementById("nettotal").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "netamount");
               
               document.getElementById("accdocno").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "acno"); */
           	 $('#reqmasterdate').jqxDateTimeInput({ disabled: false});

              $('#window').jqxWindow('close');  
         
        	 funSetlabel();
        	 document.getElementById("frmpurReq").submit();
        	 
        	 
           
            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>
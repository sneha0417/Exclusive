<%@page import="com.procurement.purchase.purchaserequestforquote.ClspurchaserequestforquoteDAO"%>
<% ClspurchaserequestforquoteDAO  purchaserequestforquoteDAO = new ClspurchaserequestforquoteDAO(); %> 

 <%
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String masterdate = request.getParameter("masterdate")==null?"0":request.getParameter("masterdate");
 //System.out.println("-----masterdate----"+masterdate);
 
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 
 
 String cmbreftype = request.getParameter("cmbreftype")==null?"0":request.getParameter("cmbreftype");
 String reqmasterdocno = request.getParameter("reqmasterdocno")==null?"0":request.getParameter("reqmasterdocno");
 
 
 
%> 

<script type="text/javascript">
        
        

   var data2= '<%=purchaserequestforquoteDAO.accountsDetailsFrom(masterdate,accountno,accountname,currency,check,cmbreftype,reqmasterdocno) %>'; 

        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'curid', type: 'int'  },
     						{name : 'currency', type: 'string'  },
     						{name : 'rate', type: 'number'  }
                        ],
                		localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsSearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
                            { text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '55%' },
							{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%'},
							{ text: 'Currency', datafield: 'currency', width: '15%' },
							{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%'  },
						]
            });
            
             $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
             
                document.getElementById("errormsg").innerText="";
                document.getElementById("accdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            
                 document.getElementById("puraccid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
             	document.getElementById("puraccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
             
            	getCurrencyIds();
            	
            	
            	var cmbreftype=document.getElementById("reftype").value;
            	
 
            	
            	if(cmbreftype=="CEQ")
            		{
            	
            		
            		if(document.getElementById("reqmasterdocno").value!="")
            			{
            		
            	 $.messager.confirm('Message', 'Do you want to Import?', function(r){
   	        	  
       		       
 		        	if(r==false)
 		        	  {
 		        		 $("#serviecGrid").jqxGrid('clear');
 		 			    $("#serviecGrid").jqxGrid('addrow', null, {});
 		        		return false; 
 		        	  }
 		        	else{
 				 
 		        		
 		        		 var chk="req";
 		       		  
 		       		  var from="pro";
 		       		  
 		       	  var types="acc";
 		       		
 		       		var acno=$('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
 		       		  
 		       		  $("#sevdesc").load("serviecgrid.jsp?reqdoc="+document.getElementById("reqmasterdocno").value+"&chk="+chk+"&from="+from+"&acno="+acno+"&cmbreftype="+cmbreftype+"&types="+types);	
 		        		
 		        		
 		        		
 		        	   }
                });  
            			}
            		}
            	
             	$('#accountSearchwindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="jqxAccountsSearch"></div>
 
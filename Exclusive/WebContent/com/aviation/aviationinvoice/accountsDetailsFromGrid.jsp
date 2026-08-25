<%@page import="com.aviation.aviationinvoice.ClsaviationInvoiceDAO"%>
<% ClsaviationInvoiceDAO DAO = new ClsaviationInvoiceDAO(); %> 

 <%
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String masterdate = request.getParameter("masterdate")==null?"0":request.getParameter("masterdate");
 String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
 //System.out.println("-----masterdate----"+masterdate);
 
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 String aa = request.getParameter("aa")==null?"0":request.getParameter("aa");
 
 
 
%> 

<script type="text/javascript">
var check='<%=check%>';

        $(document).ready(function () { 
        	
        	var data2;
        	if(check==1){
        		  data2= '<%=DAO.accountsDetailsFrom(masterdate,accountno,accountname,currency,type,check,aa) %>'; 
        	}
        	else{
        		  data2;
        	}
                     
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
     						{name : 'rate', type: 'number'  },
     						{name : 'c_rate', type: 'number'  },
     						
     						{name : 'cldocno', type: 'number'  },
     						
     						
     						
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
						{ text: 'DOC_NO', datafield: 'cldocno', width: '8%'  },
                            { text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							
							{ text: 'Name', datafield: 'description'  },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%'},
							{ text: 'Currency', datafield: 'currency', width: '15%' },
							
							
							{ text: 'Rate', datafield: 'rate', hidden: true, cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%'  },
							
						]
            });
            
             $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;

                document.getElementById("errormsg").innerText="";
                document.getElementById("accdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("puraccid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
                
                
            	document.getElementById("account").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
                
             	document.getElementById("puraccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
             	document.getElementById("txtcurrency").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "currency");
             	document.getElementById("currate").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "rate");
             	
            	document.getElementById("usdrate").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "c_rate");
            	
           
            	
            	
            	
         		 $("#detdiv").load("detailsGrid.jsp?cldocno="+$('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "cldocno")
         				 +"&fromdate="+document.getElementById("fromdate").value+"&todate="+document.getElementById("todate").value+"&psrno="+document.getElementById("psrno").value); 
            	
            	
             	$('#accountSearchwindow').jqxWindow('close');
            });  
        });
    </script>
    <div id="jqxAccountsSearch"></div>
 
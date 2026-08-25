<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.nisales.cuttinginvoice.ClsCuttingInvoiceDAO"%>
<% ClsCuttingInvoiceDAO  sDAO = new ClsCuttingInvoiceDAO();    


 
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
 String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 

 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 
 String descriptions = request.getParameter("descriptions")==null?"NA":request.getParameter("descriptions"); 
 
 String refnoss = request.getParameter("refnoss")==null?"NA":request.getParameter("refnoss"); 
 
 String slpono = request.getParameter("slpono")==null?"NA":request.getParameter("slpono"); 
 
%>
<script type="text/javascript">


var datamain= '<%=sDAO.mainsearch(session,docnoss,accountss,accnamess,datess,aa,descriptions,refnoss,slpono) %>'; 
        $(document).ready(function () {  
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            
                            {name : 'voc_no', type: 'int'   },
                         
                            {name : 'date', type: 'date'   },
     					 
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     				 
     						{name : 'desc1', type: 'string'   },
     						{name : 'acno', type: 'string'   },
     						 
     						{name : 'costcode', type: 'string'   },
     						{name : 'prjname', type: 'string'   },
							{name : 'amount', type: 'number'  },
     						
     						{name : 'lpono', type: 'string'   },
     						
     						
     						  
                        ],
                		localdata: datamain, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mainsearshgrid").jqxGrid(
            {
                width: '100%',
                height: 265,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                
                columns: [
                          
                         
                            { text: 'Doc No', datafield: 'voc_no', width: '6%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Account', datafield: 'account', width: '8%' },
								{ text: 'Account Name', datafield: 'description', width: '30%' },
								{ text: 'Group', datafield: 'prjname', width: '15%'  },
								  { text: 'Job No', datafield: 'costcode', width: '8%'  },
									{ text: 'Amount', datafield: 'amount', width: '12%', cellsformat:'d2', cellsalign:'right', align:'right'  },
									 
									 
									 { text: 'LPO NO', datafield: 'lpono', width: '15%'  },
								
								{ text: 'Description', datafield: 'desc1', width: '23%' },
										
						]
            });
            
             $('#mainsearshgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
   
        	 document.getElementById("docno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
        	 document.getElementById("masterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
   

              $('#window').jqxWindow('close');  
         	 
        	 funSetlabel();
          
            
            document.getElementById("frmsave").submit();
            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>
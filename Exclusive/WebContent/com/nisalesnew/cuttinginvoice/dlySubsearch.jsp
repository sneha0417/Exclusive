<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.nisalesnew.cuttinginvoice.ClsCuttingInvoiceDAO"%>
<% ClsCuttingInvoiceDAO  sDAO = new ClsCuttingInvoiceDAO(); 


 
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
 String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 

 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 
 String descriptions = request.getParameter("descriptions")==null?"NA":request.getParameter("descriptions"); 
 
 String refnoss = request.getParameter("refnoss")==null?"NA":request.getParameter("refnoss"); 
 
 
%>
<script type="text/javascript">


var datamain= '<%=sDAO.dlymainsearch(session,docnoss,accountss,accnamess,datess,aa,descriptions,refnoss) %>'; 
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
     						
     						{name : 'costtr_no', type: 'string'   },
     						
     						{name : 'atype', type: 'string'   },
     						{name : 'code', type: 'string'   },
     						{name : 'curid', type: 'string'   },
     						
     						{name : 'rate', type: 'number'   },
     						{name : 'lpono', type: 'string'   },
     						{name : 'sal_name', type: 'string'   },
     						{name : 'sal_id', type: 'string'   },
     						
     						{name : 'deldate', type: 'date'   },
     						{name : 'fixdate', type: 'date'   },
     						{name : 'deltime', type: 'string'   },
     						{name : 'costtype', type: 'string'   },
     						
     						{name : 'taxper', type: 'number'   },
     						
     						
     						
     						
     						
     						
     						//atype code curid rate lpono sal_name sal_id deldate deltime fixdate costtr_no costtype
     						  
                        ],
                		localdata: datamain, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#dlymainsearshgrid").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                          
                         
                            { text: 'Doc No', datafield: 'voc_no', width: '6%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Account', datafield: 'account', width: '8%' },
								{ text: 'Account Name', datafield: 'description', width: '30%' },
								{ text: 'Group', datafield: 'prjname', width: '15%'  },
								  { text: 'Job No', datafield: 'costcode', width: '8%'  },
							    
								{ text: 'Description', datafield: 'desc1', width: '23%' },
										
						]
            });
            
             $('#dlymainsearshgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
   
        	 document.getElementById("rrefno").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
        	 document.getElementById("masterrrefno").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
        	 document.getElementById("remarks").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "desc1");
        	 
        	
        	 
        	 document.getElementById("itemtype").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "costtype");
        	 document.getElementById("itemdocno").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "costcode");
        	 document.getElementById("itemname").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "prjname");
        	 document.getElementById("costtr_no").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "costtr_no");
        	 document.getElementById("acctype").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "atype");
        	 
        	 document.getElementById("accid").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "account");
        	 document.getElementById("accname").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "description");
        	 document.getElementById("hidtaxper").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "taxper");
    	     
        	 document.getElementById("currsid").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "curid");
        	 document.getElementById("acno").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "acno");
        	 document.getElementById("currs").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "code");
        	 document.getElementById("ratess").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "rate");
        	 
        	 document.getElementById("salesmanname").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "sal_name");
        	 document.getElementById("salid").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "sal_id");
        	 document.getElementById("lpono").value = $('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "lpono");
        	 
        	 $('#deliveryDate').val($("#dlymainsearshgrid").jqxGrid('getcellvalue', rowindex1, "deldate")) ;
        	 $('#deliveryTime').val($("#dlymainsearshgrid").jqxGrid('getcellvalue', rowindex1, "deltime")) ;
        	 $('#fixDate').val($("#dlymainsearshgrid").jqxGrid('getcellvalue', rowindex1, "fixdate")) ;
        	 $("#Gridid").load("prdgrid.jsp?masterrefno="+$('#dlymainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no"));
        	 calculatedatanet();	 
        	  $('#refnosearchwindow').jqxWindow('close'); 
        	 
             
            }); 
             
        });
    </script>
    <div id="dlymainsearshgrid"></div>
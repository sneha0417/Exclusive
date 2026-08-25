<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.aviation.aviationinvoice.ClsaviationInvoiceDAO"%>
<% ClsaviationInvoiceDAO DAO = new ClsaviationInvoiceDAO(); 


 
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
	String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");
	String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
	String descriptions = request.getParameter("descriptions")==null?"0":request.getParameter("descriptions");
	String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
String refnoss = request.getParameter("refnoss")==null?"NA":request.getParameter("refnoss"); 
%>
<script type="text/javascript">


var datamain= '<%=DAO.mainsearch(session,docnoss,accountss,accnamess,datess,aa,refnoss,descriptions) %>'; 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             
                     		
             	       
                            {name : 'doc_no', type: 'int'   },
                            
                            {name : 'voc_no', type: 'int'   },
                         
                            {name : 'date', type: 'date'   },
     						{name : 'refname', type: 'string'   },
     						{name : 'productname', type: 'string'   },
     						{name : 'notes', type: 'string'   }
     					 
     						
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
                height: 283,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                          { text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true  },
                         
                            { text: 'Doc No', datafield: 'voc_no', width: '6%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
						 
								{ text: 'Client', datafield: 'refname', width: '32%' },
							 
								 { text: 'productname', datafield: 'productname', width: '18%'  },
							 
										{ text: 'Description', datafield: 'notes'  },
										 
										
						]
            });
            
             $('#mainsearshgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
           	 $('#masterdate').jqxDateTimeInput({ disabled: false});
        	 $('#fromdate').jqxDateTimeInput({ disabled: false});
        	 $('#todate').jqxDateTimeInput({ disabled: false});
        	 $('#duedate').jqxDateTimeInput({ disabled: false});
         
        	 document.getElementById("docno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
        	 document.getElementById("masterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
 
      
              $('#window').jqxWindow('close');  
            	 $('#masterdate').jqxDateTimeInput({ disabled: true});
            	 $('#fromdate').jqxDateTimeInput({ disabled: true});
            	 $('#todate').jqxDateTimeInput({ disabled: true});
            	 $('#duedate').jqxDateTimeInput({ disabled: true});

        	 
        	 funSetlabel();
            document.getElementById("frmaninv").submit();
            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>
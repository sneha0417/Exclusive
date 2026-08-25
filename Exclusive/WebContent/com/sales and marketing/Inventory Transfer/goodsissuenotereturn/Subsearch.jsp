<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.InventoryTransfer.goodsissuenotereturn.ClsGoodsissuenotereturnDAO"%>
<% ClsGoodsissuenotereturnDAO searchDAO = new ClsGoodsissuenotereturnDAO(); %> 


<%
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String types = request.getParameter("types")==null?"NA":request.getParameter("types");
 

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 

 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 String prjdocnos = request.getParameter("prjdocnos")==null?"NA":request.getParameter("prjdocnos");  
%>
<script type="text/javascript">

 


var datamain= '<%=searchDAO.mainsearch(session,docnoss,types,datess,aa,prjdocnos) %>'; 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {                            
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            
                            {name : 'voc_no', type: 'int'   },
                         
                            {name : 'date', type: 'date'   },
     					 
     						{name : 'type', type: 'string'   },
     				 
     						{name : 'desc1', type: 'string'   },
     						{name : 'refno', type: 'string'   },
     						{name : 'prjname', type: 'string'   },
     						{name : 'costgroup', type: 'string'   },
     						{name : 'costdocno', type: 'string'   },
     						
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
                          
                            { text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true },
                            { text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
	 
							{ text: 'Type', datafield: 'type', width: '12%'},
							{ text: 'Group', datafield: 'costgroup', width: '10%'  },
							{ text: 'Job No', datafield: 'costdocno', width: '11%'  },
						    { text: 'Name', datafield: 'prjname', width: '20%'  },
						  					      
						    { text: 'Ref No', datafield: 'refno', width: '8%'  },
							{ text: 'Description', datafield: 'desc1', width: '19%' },
				 
							
							 
					 
										
						]
            });
           
             $('#mainsearshgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
           	 $('#masterdate').jqxDateTimeInput({ disabled: false});
         
        	  $('#type').attr('disabled', false);
        	 $('#itemtype').attr('disabled', false);
        	 document.getElementById("docno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
        	 document.getElementById("masterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
 

              $('#window').jqxWindow('close');  
         	 $('#masterdate').jqxDateTimeInput({ disabled: false});
        	 

        	  $('#type').attr('disabled', false);
        	 $('#itemtype').attr('disabled', false);
        	 funSetlabel();
            document.getElementById("frmgir").submit();
            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>
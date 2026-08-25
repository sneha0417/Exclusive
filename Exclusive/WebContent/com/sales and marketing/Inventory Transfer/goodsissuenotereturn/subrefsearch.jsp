<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.InventoryTransfer.goodsissuenotereturn.ClsGoodsissuenotereturnDAO"%>
<% ClsGoodsissuenotereturnDAO searchDAO = new ClsGoodsissuenotereturnDAO(); %> 


<%
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String types = request.getParameter("types")==null?"NA":request.getParameter("types");
 

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 

 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
%>
<script type="text/javascript">


var datamain= '<%=searchDAO.subrefmainsearch(session,docnoss,types,datess,aa) %>'; 
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
     						
     						
     						{name : 'issuetype', type: 'string'   },
     						{name : 'locid', type: 'string'   },
     						{name : 'loc_name', type: 'string'   },
     						{name : 'costtype', type: 'string'   },
     						{name : 'siteid', type: 'string'   },
     						
     						{name : 'site', type: 'string'   },
     						{name : 'refname', type: 'string'   },
     						{name : 'cldocno', type: 'string'   },
     						
     						{name : 'costdocno', type: 'string'   },
     						{name : 'prjname', type: 'string'   },
     						{name : 'costtr_no', type: 'string'   },
     						
     					//	issuetype locid loc_name costtype siteid site refname cldocno costdocno prjname
     						
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
	 
							{ text: 'Type', datafield: 'type', width: '15%'},
							{ text: 'Group', datafield: 'costgroup', width: '10%'  },
						    { text: 'Name', datafield: 'prjname', width: '20%'  },
						  					      
						    { text: 'Ref No', datafield: 'refno', width: '10%'  },
							{ text: 'Description', datafield: 'desc1', width: '25%' },
				 
									
							 { text: 'issuetype', datafield: 'issuetype', width: '10%' ,hidden:true },
							 { text: 'loc_name', datafield: 'loc_name', width: '10%'  ,hidden:true},
							 { text: 'locid', datafield: 'locid', width: '10%' ,hidden:true },
							 { text: 'costtype', datafield: 'costtype', width: '10%' ,hidden:true },
							 { text: 'siteid', datafield: 'siteid', width: '10%' ,hidden:true },
							 { text: 'site', datafield: 'site', width: '10%'  ,hidden:true},
							
							 
							 { text: 'refname', datafield: 'refname', width: '10%' ,hidden:true },
							 { text: 'cldocno', datafield: 'cldocno', width: '10%',hidden:true  },
							 
							 { text: 'costtr_no', datafield: 'costtr_no', width: '10%' ,hidden:true },
							 
					/* 		 { text: 'costdocno', datafield: 'costdocno', width: '10%'  },
							 
							 { text: 'prjname', datafield: 'prjname', width: '10%'  },
							  */
						
							
						]
            });
           
             $('#mainsearshgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
           
         
        	  $('#type').attr('disabled', false);
        	 $('#itemtype').attr('disabled', false);
        	 document.getElementById("rrefno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
        	 document.getElementById("refmasterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
        	 
 
        	 
        	 
        	  document.getElementById("type").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "issuetype");
        	// document.getElementById("type").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "type");
        	 document.getElementById("txtlocation").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "loc_name");
        	 document.getElementById("txtlocationid").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "locid");
        	 document.getElementById("itemtype").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "costtype");
        	 document.getElementById("itemdocno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "costdocno");
        	 
        	 document.getElementById("itemname").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "prjname");
        	 document.getElementById("clientname").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "refname");
        	 document.getElementById("cldocno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "cldocno");
        
        	 document.getElementById("site").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "site");
        	 
        	 document.getElementById("siteid").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "siteid");
        	 
        	 document.getElementById("costtr_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "costtr_no");
        	  $.messager.confirm('Message', 'Do you want to Import?', function(r){
	        	  
    		       
		        	if(r==false)
		        	  {
		    
		        		 
		        		 $("#serviecGrid").jqxGrid('clear');
		 			    $("#serviecGrid").jqxGrid('addrow', null, {});
		 			    $('#refnosearchwindow').jqxWindow('close');  
		 			   $('#type').attr('disabled', true);
		 	        	 $('#itemtype').attr('disabled', true);
		 			    
		        		return false; 
		        	  }
		        	else{
				 
        	 $("#sevdesc").load("serviecgrid.jsp?masterdoc="+$('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no")+"&locaid="+$('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "locid"));
		        	}
       	  
             });  

              $('#refnosearchwindow').jqxWindow('close');  
    
        	 

        	  $('#type').attr('disabled', true);
        	 $('#itemtype').attr('disabled', true);
         
            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>
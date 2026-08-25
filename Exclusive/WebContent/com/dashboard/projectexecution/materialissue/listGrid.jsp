<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.materialissue.ClsMaterialIssueDAO"%>
<% ClsMaterialIssueDAO searchDAO = new ClsMaterialIssueDAO(); %> 


<%
 String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 
 String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno"); 
 String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
%>
<script type="text/javascript">


 var datamain= '<%=searchDAO.listsearch(session,barchval,aa,cldocno,docnoss) %>'; 
 
 var datamain2= '<%=searchDAO.listsearchex(session,barchval,aa,cldocno,docnoss) %>'; 
 
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
     						
     						{name : 'loc_name', type: 'string'   },
     						{name : 'site', type: 'string'   },
     						{name : 'refname', type: 'string'   },
     						
     						
     						
     						{name : 'costdocno', type: 'string'   },
     						
     						{name : 'brhid', type: 'string'   },
     						{name : 'locid', type: 'string'   },
     						
     						
     						
     						
     						 
     						
     						
                        ],
                		localdata: datamain, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mainlistgrid").jqxGrid(
            {
            	  width: '99.5%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
	filterable: true,
	showfilterrow: true,
	selectionmode: 'singlerow', 
                
                columns: [
                          
                            { text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true },
                            { text: 'Doc No', datafield: 'voc_no', width: '5%' },
							{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Type', datafield: 'type', width: '8%'},
							{ text: 'Group', datafield: 'costgroup', width: '8%'  },
							{ text: 'Job No', datafield: 'costdocno', width: '6%'  },
						    { text: 'Name', datafield: 'prjname', width: '20%'  },
						    { text: 'Client', datafield: 'refname', width: '15%'  },
						    { text: 'Site', datafield: 'site', width: '18%'  },
						    { text: 'Location', datafield: 'loc_name', width: '15%'  },
						    { text: 'Ref No', datafield: 'refno', width: '8%'  },
							{ text: 'Description', datafield: 'desc1', width: '20%' },
							{ text: 'brhid', datafield: 'brhid', width: '5%',hidden:true },
							{ text: 'locid', datafield: 'locid', width: '5%' ,hidden:true},
				 
							 
						]
            });
           
             $('#mainlistgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
           	 $("#updatdata").attr('disabled', false );
        	 var barchval = $('#mainlistgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
        	 
        	 var locid = $('#mainlistgrid').jqxGrid('getcellvalue', rowindex1, "locid");
        	 var docno=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
        	 
        	 document.getElementById("masterdocno").value=docno;
        	 
        	 
        	 
        	
        	  
        	   $("#overlay, #PleaseWait").show(); 
         	  $("#sublistdiv").load("sublistGrid.jsp?barchvals="+barchval+"&docno="+docno+"&locid="+locid);
                
                
            }); 
             
             
             $("#overlay, #PleaseWait").hide(); 
        });
    </script>
    <div id="mainlistgrid"></div>
 
 
 
    
    </body>
</html>

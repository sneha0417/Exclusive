<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.serviceCompletion.ClsServiceCompletionDAO"%>
<%
ClsServiceCompletionDAO DAO=new ClsServiceCompletionDAO(); 
  String uptodate =request.getParameter("date")==null?"0":request.getParameter("date").toString();
  String branchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();
  String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString(); 
  int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
  String type =request.getParameter("type")==null?"0":request.getParameter("type").toString();
  int isradio =request.getParameter("isradio")==null?0:Integer.parseInt(request.getParameter("isradio").toString());
%>

 <script type="text/javascript">
 var perdata1;
 
      perdata1= '<%=DAO.loadContractData(uptodate, branchval, clientid,id,type,isradio)%>';
      
 
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'date', type: 'date' },
     						{name : 'rdtype', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'clientid', type: 'number' },
     						{name : 'status', type: 'String' },
     						{name : 'cpersonid', type: 'number' },
     						{name : 'clacno', type: 'number' },
     						{name : 'refdtype', type: 'String' },
     						{name : 'refno', type: 'String' },
     						{name : 'sdate', type: 'date' },
     						{name : 'edate', type: 'date' },
     						{name : 'cval', type: 'number' },
     						{name : 'tobeinvamt', type: 'number' },
     						{name : 'duedate', type: 'date' },
     						{name : 'dueno', type: 'String' },
     						{name : 'dueamt', type: 'number' },
     						{name : 'lfee', type: 'number' },
     						{name : 'brch', type: 'String' },
     						{name : 'iserv', type: 'String' },
     						{name : 'tr_no', type: 'String' },
     						{name : 'pdid', type: 'String' },
     						{name : 'ptype', type: 'String' },
     						
     						{name : 'approvalstatus', type: 'String' },
     						{name : 'totalschedule', type: 'String' },
     						{name : 'completedschedule', type: 'String' },
     						{name : 'totalinvoices', type: 'String' },
     						{name : 'pendinginvoice', type: 'String' },
     			 ],
                 localdata: perdata1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed...tobeinvamt
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxpinvGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                //filterable: true,
                //pagermode: 'default',
                columns: [
                          
					{ text: 'Name', datafield: 'client', width: '29%' },
					{ text: 'Doc Type',  datafield: 'rdtype', width: '9%' },
					{ text: 'Doc No',  datafield: 'doc_no', width: '5%' },
					{ text: 'Tr No',  datafield: 'tr_no', width: '5%',hidden:true},
					{ text: 'brhid',  datafield: 'brch', width: '5%',hidden:false},
					{ text: 'iserv',  datafield: 'iserv', width: '5%',hidden:true},
					{ text: 'Date',  datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy' },
					{ text: 'RefNo', datafield: 'refno', width: '10%' },
					{ text: 'Start Date', datafield: 'sdate', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'End Date', datafield: 'edate', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Status', datafield: 'status', width: '8%' },
					{ text: 'Contract Amount',  datafield: 'cval', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'Legal Amount',  datafield: 'lfee', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					
					{ text: 'Approval Status', datafield: 'approvalstatus', width: '8%' },
					{ text: 'Total Schedule', datafield: 'totalschedule', width: '8%' },
					{ text: 'Completed Schedule', datafield: 'completedschedule', width: '10%' },
					{ text: 'Total Invoices', datafield: 'totalinvoices', width: '8%' },
					{ text: 'Pending Invoices', datafield: 'pendinginvoice', width: '8%' }
				 ]
            });
            
            $('#jqxpinvGrid').on('rowdoubleclick', function (event) 
            		{ 
            	
            		    var rowindex = event.args.rowindex;
            		    
            		    
        				$("#jqxpinvDetGrid").jqxGrid('clear');
        				$("#jqxpsrvDetGrid").jqxGrid('clear'); 
        				hidcolumn(0);
        				
            		    var clientid=$('#clientid').val();
            			 var date=$('#todate').val();
            			 var barchval =$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "brch");
            		     var dtype=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "rdtype");
            		     var tr_no=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "tr_no");
            		     var doc_no=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "doc_no");
            		     var iserv=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "iserv");
            		     var id=1;
            		     
            		     $('#dtype').val(dtype);
            		     $('#trno').val(tr_no);
            		     $('#docno').val(doc_no);
            		     $('#brch').val(barchval);
            		   
            		    $("#overlay, #PleaseWait").show();
            		
            		 $("#profserdetdiv").load("serviceDetGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&type="+dtype+"&tr_no="+tr_no+"&doc_no="+doc_no+"&iserv="+iserv);
            		 if( dtype!='CREG' ){
            		 $("#profinvdetdiv").load("invDetGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&type="+dtype+"&tr_no="+tr_no+"&doc_no="+doc_no);
            		 } 		  
            		});
           

                 $("#overlay, #PleaseWait").hide();
                 
                
        });
    </script>
    <div id="jqxpinvGrid"></div>

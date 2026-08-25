<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.invoiceProcessing.ClsInvoiceProcessingDAO"%>
<%
	ClsInvoiceProcessingDAO DAO=new ClsInvoiceProcessingDAO(); 
  String uptodate =request.getParameter("date")==null?"0":request.getParameter("date").toString();
  String branchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();
  String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString(); 
  int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
  int type =request.getParameter("type")==null?0:Integer.parseInt(request.getParameter("type").toString());
  
  String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString(); 
  
  
%>

 <script type="text/javascript">
 var perdata;
 var exceldata;
      perdata= '<%=DAO.loadContractData(uptodate, branchval, clientid,id,type,dtype)%>';
      exceldata='<%=DAO.loadContractExcel(uptodate, branchval, clientid,id,type,dtype)%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",  
                datafields: [
                         	{name : 'sitess', type: 'String'  },
							{name : 'doc_no', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'rdtype', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'clientid', type: 'number' },
     						{name : 'cperson', type: 'String' },
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
     						{name : 'tr_no', type: 'String' },
     						{name : 'pdid', type: 'String' },
     						{name : 'ptype', type: 'String' },
						    {name : 'site', type: 'String' },
     						{name : 'interserv', type: 'number' },
     					     						
                 ],
                 localdata: perdata,
                
                
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
                filterable: true,
                showfilterrow: true,
                //showfilterrow: true,
                //pagermode: 'default',
                columns: [
                          
					{ text: 'Name', datafield: 'client', width: '18%' },
					{ text: 'Site', datafield: 'sitess', width: '18%' },   
					{ text: 'Doc Type',  datafield: 'rdtype', width: '5%' },
					{ text: 'Doc No',  datafield: 'doc_no', width: '5%' },
					{ text: 'RefNo', datafield: 'refno', width: '8%' },
					{ text: 'Start Date', datafield: 'sdate', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'End Date', datafield: 'edate', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Due Date', datafield: 'duedate', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Contract Amount',  datafield: 'cval', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'Legal Amount',  datafield: 'lfee', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'Due Amount', datafield: 'dueamt', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
					{ text: 'Other',  datafield: 'tobeinvamt', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'clientid', datafield: 'clientid', width: '15%',hidden:true },
					{ text: 'Branch Id',  datafield: 'brch', width: '10%' ,hidden:true },
					{ text: 'Clacno',  datafield: 'clacno', width: '10%' ,hidden:true },
					{ text: 'Tr No',  datafield: 'tr_no', width: '10%',hidden:true },
					{ text: 'pdid',  datafield: 'pdid', width: '10%',hidden:true },
					{ text: 'dtype',  datafield: 'dtype', width: '10%',hidden:true },
					{ text: 'ptype',  datafield: 'ptype', width: '10%',hidden:true },
					{ text: 'site',  datafield: 'site', width: '10%',hidden:true },
					{ text: 'interserv',  datafield: 'interserv', width: '10%',hidden:true },
				 ]
            });
            
            $('#jqxpinvGrid').on('rowdoubleclick', function (event) 
            		{ 
            	
            		    var rowindex = event.args.rowindex;
            		    
					 document.getElementById("interstate").checked=false;
						 document.getElementById("hiddeninterstate").value=0;

            		    var clientid=$('#clientid').val();
            			 var date=$('#todate').val();
            			 var barchval = document.getElementById("cmbbranch").value;
            		     var dtype=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "dtype");
            		     var type=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "ptype");
            		     document.getElementById("ptype").value=type;
            		     var tr_no=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "tr_no");
            		     var doc_no=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "doc_no");
 var interserv=$('#jqxpinvGrid').jqxGrid('getcellvalue', rowindex, "interserv");  
            		     if(interserv==1)
            		    	 {
            		    	 document.getElementById("interstate").checked=true;
							 document.getElementById("hiddeninterstate").value=1;
            		    	 }

            		     var id=1;
            		    
         				$("#jqxpinvDetGrid").jqxGrid('clear'); 
            		    $("#overlay, #PleaseWait").show();
            		 
            		var id=1;
            		
            		 $("#profinvdetdiv").load("InvoiceDetGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&type="+type+"&tr_no="+tr_no+"&doc_no="+doc_no);
            				  
            				
            		});
           

                 $("#overlay, #PleaseWait").hide();
                 
                
        });
    </script>
    <div id="jqxpinvGrid"></div>

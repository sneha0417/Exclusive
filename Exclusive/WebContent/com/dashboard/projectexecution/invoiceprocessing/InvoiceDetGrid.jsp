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
  int trno =request.getParameter("tr_no")==null?0:Integer.parseInt(request.getParameter("tr_no").toString());
  int docno =request.getParameter("docno")==null?0:Integer.parseInt(request.getParameter("docno").toString());
%>

 <script type="text/javascript">
 var perdata;
 var ptype='<%=type%>';
      perdata= '<%=DAO.loadGridData(uptodate, branchval, clientid,id,type,trno,docno)%>';
 
	
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
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
     						{name : 'inctax', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'nontax', type: 'String' },
     					//	{name : 'siteadd', type: 'String' },
     					     						
                 ],
                 localdata: perdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed...tobeinvamt
                }
            };
  $("#jqxpinvDetGrid").on("bindingcomplete", function (event) {
            	
            	// your code here.
            if(ptype=="2"){
            	$('#jqxpinvDetGrid').jqxGrid('setcolumnproperty','tobeinvamt','hidden',false);
                        	
            }	
            });              
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxpinvDetGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                //pagermode: 'default',
                columns: [
                          
					{ text: 'Name', datafield: 'client', width: '17%' },
					{ text: 'Doc Type',  datafield: 'rdtype', width: '6%' },
					{ text: 'Doc No',  datafield: 'doc_no', width: '5%' },
					{ text: 'RefNo', datafield: 'refno', width: '10%' },
					{ text: 'Start Date', datafield: 'sdate', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Site', datafield: 'site', width: '12%' },
					//{ text: 'Site Details', datafield: 'siteadd', width: '15%' },
					{ text: 'End Date', datafield: 'edate', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Due Date', datafield: 'duedate', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Contract Amount',  datafield: 'cval', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'Legal Amount',  datafield: 'lfee', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'Due Amount', datafield: 'dueamt', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
					{ text: 'Other',  datafield: 'tobeinvamt', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'clientid', datafield: 'clientid', width: '15%',hidden:true },
					{ text: 'Branch Id',  datafield: 'brch', width: '10%' ,hidden:true },
					{ text: 'Clacno',  datafield: 'clacno', width: '10%' ,hidden:true },
					{ text: 'Tr No',  datafield: 'tr_no', width: '10%',hidden:true },
					{ text: 'pdid',  datafield: 'pdid', width: '10%',hidden:true },
					{ text: 'dtype',  datafield: 'dtype', width: '10%',hidden:true },
					{ text: 'ptype',  datafield: 'ptype', width: '10%' },
					{ text: 'inctax',  datafield: 'inctax', width: '10%',hidden:true },
					{ text: 'nontax',  datafield: 'nontax', width: '10%',hidden:true },
					
				 ]
            });
           

                 $("#overlay, #PleaseWait").hide();
                 
                
        });
    </script>
    <div id="jqxpinvDetGrid"></div>

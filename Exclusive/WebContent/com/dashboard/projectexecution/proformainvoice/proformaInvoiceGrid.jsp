<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.proformaInvoice.ClsProformaInvoiceDAO"%>
<%
	ClsProformaInvoiceDAO DAO=new ClsProformaInvoiceDAO(); 
  String uptodate =request.getParameter("date")==null?"0":request.getParameter("date").toString();
  String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();
  String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString(); 
  int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
  
%>

 <script type="text/javascript">
 var perdata;
 
      perdata= '<%=DAO.loadGridData(uptodate, branchval, clientid,id)%>';
 
	
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'site', type: 'String'  },
							{name : 'doc_no', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
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
     						{name : 'duedate', type: 'date' },
     						{name : 'dueno', type: 'String' },
     						{name : 'lfee', type: 'number' },
     						{name : 'brch', type: 'String' },
     						{name : 'tr_no', type: 'String' },
						{name : 'contractval', type: 'number' },
     					     						
                 ],
                 localdata: perdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxproinvGrid").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                selectionmode: 'checkbox',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '5%' },
					{ text: 'Doc Type',  datafield: 'dtype', width: '5%' },
					{ text: 'Client', datafield: 'client', width: '15%' },
					{ text: 'Site', datafield: 'site', width: '15%' },     
					{ text: 'Contact Person', datafield: 'cperson', width: '10%' },
					{ text: 'Ref Dtype', datafield: 'refdtype', width: '5%' },
					{ text: 'Ref No', datafield: 'refno', width: '9%' },
					{ text: 'Start Date', datafield: 'sdate', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'End Date', datafield: 'edate', width: '8%',cellsformat:'dd.MM.yyyy' },
				    { text: 'Contract Value',  datafield: 'contractval', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'Invoice Amount',  datafield: 'cval', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'Due Date', datafield: 'duedate', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Due No', datafield: 'dueno', width: '4%'},
					{ text: 'Legal Fees',  datafield: 'lfee', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					{ text: 'clientid', datafield: 'clientid', width: '15%',hidden:true },
					{ text: 'cpersonid', datafield: 'cpersonid', width: '15%',hidden:true },
					{ text: 'Branch Id',  datafield: 'brch', width: '10%' ,hidden:true},
					{ text: 'Clacno',  datafield: 'clacno', width: '10%' ,hidden:true},
					{ text: 'Tr No',  datafield: 'tr_no', width: '10%',hidden:true },
					
					
					
	              ]
            });
           

                 $("#overlay, #PleaseWait").hide();
                 
                
        });
    </script>
    <div id="jqxproinvGrid"></div>

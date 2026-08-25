<%@page import="com.humanresource.setup.employeemaster.ClsEmployeeMasterDAO"%>
<%ClsEmployeeMasterDAO DAO= new ClsEmployeeMasterDAO(); %>
<% String mode = request.getParameter("mode")==null?"view":request.getParameter("mode");%>
<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
<script type="text/javascript">
		var tempMode1='<%=mode%>';
		var tempDocNo1='<%=docNo%>';
		var temp1='0';
		
		var data2;
		
        $(document).ready(function () { 	
        	
        	if(tempMode1=='A')
        	 { 
        		
        		data2='<%=DAO.documentsLoading()%>';
        		
        	 } else if(tempDocNo1>0 && tempMode1=='E') {
         		 
          		data2='<%=DAO.documentsEditReloading(docNo)%>';
          		
          	 } else if(tempDocNo1>0) {
          		 
           		data2='<%=DAO.documentsReloading(docNo)%>';
           		
           	 } else {
           		 
         		 temp1='1';
         		 
         	 }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'documentid', type: 'string' },
     						{name : 'document', type: 'string' },
							{name : 'documentno', type: 'string' },
     						{name : 'issue_date', type: 'date'   },
     						{name : 'exp_date', type: 'date' },
     						{name : 'place_of_issue', type: 'string' },
     						{name : 'location', type: 'string' },
     						{name : 'remarks', type: 'string' }
                        ],
                		 localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#documentsGridID").jqxGrid(
            {
            	width: '100%',
                height: 150,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'S#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Document ID', datafield: 'documentid', hidden: true, width: '10%' },
							{ text: 'Document', datafield: 'document', width: '15%' },	
							{ text: 'Document No.', datafield: 'documentno', width: '12%' },								
							{ text: 'Issue Date', datafield: 'issue_date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '8%' },
							{ text: 'Exp. Date', datafield: 'exp_date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '8%' },
							{ text: 'Place of Issue', datafield: 'place_of_issue', width: '15%' },
							{ text: 'Location', datafield: 'location', width: '16%' },
							{ text: 'Remarks', datafield: 'remarks', width: '21%' },
						]
            });
            
            //Add empty row
            if(temp1=='1'){
           	   $("#documentsGridID").jqxGrid('addrow', null, {});
             }
            
            if(tempDocNo1>0 && tempMode1=='view'){
            	$("#documentsGridID").jqxGrid('disabled', true);
            }
            
        });
    </script>
    <div id="documentsGridID"></div>
 
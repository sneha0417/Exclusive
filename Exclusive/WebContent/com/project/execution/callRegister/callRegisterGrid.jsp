<%@page import="com.project.execution.callRegister.ClsCallRegisterDAO"%>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO(); %>
<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>  

<script type="text/javascript">

	    var data1;
	    
        $(document).ready(function () { 

        	var temp1='<%=docNo%>';
        	
        	if(temp1>0){   
        		data1= '<%=DAO.complaintsGridReLoading(docNo) %>';     
          	} 
        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
     						{name : 'stype', type: 'string' },
     						{name : 'sertypeid', type: 'int' },
     						{name : 'item', type: 'string'   },
     						{name : 'complaint', type: 'string'  },
     						{name : 'complaintid', type: 'int'  },
     						{name : 'description', type: 'string'  }
                 ],
                 localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );

            
            
            $("#callRegisterGridID").jqxGrid(
            {
            	width: '99%',
                height: 220,
                source: dataAdapter,
                columnsresize: true,
                editable: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
				handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#callRegisterGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'stype') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	serviceSearchContent('callRegisterServiceSearch.jsp'); 
                          }
                    }
                    
                    var cell2 = $('#callRegisterGridID').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'complaint') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	complaintSearchContent('callRegisterSearch.jsp'); 
                          }
                    }
                },
                
                columns: [
						  { text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Service Type', datafield: 'stype', editable: false,width: '15%' },
							{ text: 'Service Id', datafield: 'sertypeid', hidden: true, width: '10%' },
							{ text: 'Item', datafield: 'item', editable: false, width: '20%' },	
							{ text: 'Complaint', datafield: 'complaint', editable: false, width: '20%' },
							{ text: 'Complaint Id', datafield: 'complaintid', hidden: true, width: '10%' },
							{ text: 'Description', datafield: 'description', width: '40%' },
						 ]
            });
            
            if(temp1>0){
            	$("#callRegisterGridID").jqxGrid('disabled', true);
            }
            
            $('#callRegisterGridID').on('celldoubleclick', function (event) {
            	
            	if(event.args.columnindex == 1) {
          			var rowindextemp = event.args.rowindex;
          			document.getElementById("rowindex").value = rowindextemp;
          			serviceSearchContent('callRegisterServiceSearch.jsp');
                 } 
            	
          	  	if(event.args.columnindex == 4) {
          			var rowindextemp = event.args.rowindex;
          			document.getElementById("rowindex").value = rowindextemp;
          			complaintSearchContent('callRegisterSearch.jsp');
                 } 
          	  
             });
            
            
        });

</script>

<div id="callRegisterGridID"></div>
<input type="hidden" id="rowindex"/> 
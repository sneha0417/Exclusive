 <script type="text/javascript">
    var data;
   
    $(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'number' },
     						{name : 'empid', type: 'String'  },
     						{name : 'empcode', type: 'String'  },
                          	{name : 'empname', type: 'String'  },
                          	],
                 localdata: data,
                
                
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
            $("#serviceteamGrid").jqxGrid(
            {
                width: '80%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'Sr No', datafield: 'srno', width: '25%',editable:true, filterable: false, editable: false,
                        groupable: false, draggable: false, resizable: false,datafield: '',
                        columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
                        cellsrenderer: function (row, column, value) {
                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        }  
 },
					{ text: 'EmployeeId', datafield: 'empid', width: '30%',editable:true,hidden:true },
					{ text: 'Employee code', datafield: 'empcode', width: '38%',editable:true },
					{text: 'Employee Name',datafield:'empname',editable:true}
					]
            });
        });
    </script>
    <div id="serviceteamGrid"></div>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<script type="text/javascript">
       
        $(document).ready(function () { 	
        	var url = "specification.txt";
             var num = 0; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'NAME', type: 'string'  },
     						{name : 'DESCRIPTION', type: 'string'   }							
                 ],
                 url: url,
                
                
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

            
            
            $("#jqxSpecification").jqxGrid(
            {
                width: '85%',
                height: 315,
                source: dataAdapter,
                columnsresize: true,
                pageable: true,
                editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxSpecification').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxSpecification").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '', width: '5%' },	
							{ text: 'Name', datafield: 'NAME', width: '25%' },			
							{ text: 'Description', datafield: 'DESCRIPTION', width: '70%' },					
			              ]
            });
            $("#jqxSpecification").on("celldoubleclick", function () {
                var row1=event.args.rowindex;
                if(event.args.columnindex == 1){
                	$('#specwindow').jqxWindow('open');
              		$('#specwindow').jqxWindow('focus');
               	  specSearchContent('specSearch.jsp?', $('#specwindow'));
                }
                });
        });
    </script>
    <div id="jqxSpecification"></div>

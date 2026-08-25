<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.operations.vehicletransactions.movement.ClsMovementDAO"%>
<%ClsMovementDAO movdao=new ClsMovementDAO(); %>
<script type="text/javascript">
 
      // alert("ID:"+id);
       var datagarage= '<%=movdao.garageSearch()%>';
      // alert(datasearch); 
       $(document).ready(function () { 	 
    	      
             var num = 0; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
							{name : 'doc_no', type: 'int' },
     						{name : 'name', type: 'string'  }
     						
                 ],               
                /* localdata: data, */
               localdata:datagarage,
                
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
            //var list = ['M', 'D'];
            
            
            $("#garageSearch").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
              //  showfilterrow: true,
              // filterable: true, 
                //sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#garageSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'name' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#garageSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text:'Doc No',datafield:'doc_no',width:'10%'},
							{ text: 'Name', datafield: 'name', width: '90%' }
							
	              ]
            });
            $('#garageSearch').on('rowdoubleclick', function (event) {
            	
            	var row2=event.args.rowindex;
            	
            		document.getElementById("garage").value=$('#garageSearch').jqxGrid('getcellvalue', row2, "name");
            		document.getElementById("hidgarage").value=$('#garageSearch').jqxGrid('getcellvalue', row2, "doc_no");
            	
                $('#garagewindow').jqxWindow('close');

                });
            var rows= $("#garageSearch").jqxGrid("getrows");
            if(rows.length==0){
            	$("#garageSearch").jqxGrid("addrow", null, {});	
            }
            

        });
    </script>
    <div id="garageSearch"></div>
 <%@page import="com.operations.vehicletransactions.movement.ClsMovementDAO"%>
<%
 String trancode=request.getParameter("trancode")==null?"":request.getParameter("trancode");
 ClsMovementDAO movdao=new ClsMovementDAO();
 %>
 
<script type="text/javascript">
 
      // alert("ID:"+id);
       var datadriver= '<%=movdao.driverSearch(trancode)%>';
      // alert(datasearch); 
       $(document).ready(function () { 	 
    	   var id='<%=request.getParameter("id")%>';   
             var num = 0; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
							{name : 'doc_no', type: 'int' },
     						{name : 'sal_name', type: 'string'  }
     						
                 ],               
                /* localdata: data, */
               localdata:datadriver,
                
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
            
            
            $("#driverSearch").jqxGrid(
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
                    var cell = $('#driverSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'sal_name' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#driverSearch").jqxGrid('addrow', null, {});
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
							{ text: 'Name', datafield: 'sal_name', width: '90%' }
							
	              ]
            });
            $('#driverSearch').on('rowdoubleclick', function (event) {
            	
            	var row2=event.args.rowindex;
            	if(id==1){
            		document.getElementById("driver").value=$('#driverSearch').jqxGrid('getcellvalue', row2, "sal_name");
            		document.getElementById("hiddriver").value=$('#driverSearch').jqxGrid('getcellvalue', row2, "doc_no");
            		document.getElementById("outremarks").focus();
            	}
            	else if(id==2){
            		document.getElementById("closedriver").value=$('#driverSearch').jqxGrid('getcellvalue', row2, "sal_name");
            		document.getElementById("hidclosedriver").value=$('#driverSearch').jqxGrid('getcellvalue', row2, "doc_no");
            		document.getElementById("cmbaccidents").focus();
            	}
            	else{
            		//alert("ELSE");
            	}
                $('#driverwindow').jqxWindow('close');

                });
/*             var rows=$("#driverSearch").jqxGrid("getrows");
            if(rows.length==0)
            $("#driverSearch").jqxGrid("addrow", null, {});
 */
        });
    </script>
    <div id="driverSearch"></div>
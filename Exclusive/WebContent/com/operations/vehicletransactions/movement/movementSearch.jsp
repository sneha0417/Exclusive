
<%@page import="com.operations.vehicletransactions.movement.ClsMovementDAO"%>
<%@page import="com.connection.ClsConnection"%>
<%String session1=session.getAttribute("BRANCHID").toString();
ClsMovementDAO movdao=new ClsMovementDAO();
%>
<script type="text/javascript">
    
       var data5 ='<%=movdao.mainSearch(session1)%>';
       // alert(data5);
        $(document).ready(function () { 	
        	
             var num = 68; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name:'doc_no',type:'int'},
     						{name:'date',type:'String'},
     						{name:'fleet_no',type:'String'},
     						{name:'status',type:'String'}
                 ],               
                 localdata: data5,
                //url: url,
                
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

            
            
            $("#mvmainsearch").jqxGrid(
            {
                width: '100%',
                height: 370,
                source: dataAdapter,
                columnsresize: true,
                
                //pageable: true,
                //editable: true,
                altRows: true,
                 showfilterrow: true, 
                 filterable: true, 
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#mvmainsearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'fleet_no' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#mvmainsearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [							
							{ text: 'Doc No', datafield: 'doc_no', width: '10%',filtertype:'number' },
							{ text: 'Date', datafield: 'date', width: '15%',columntype:'input' },
							{ text: 'Fleet No', datafield: 'fleet_no', width: '50%',columntype:'input' },
							{ text: 'Status', datafield: 'status', width: '25%',columntype:'input' }
							
	              ]
            });
            $('#mvmainsearch').on('rowdoubleclick', function (event) {
                var row2=event.args.rowindex;
                document.getElementById("txtfleetno").value=$('#mvmainsearch').jqxGrid('getcellvalue', row2, "fleet_no");
                document.getElementById("docno").value=$('#mvmainsearch').jqxGrid('getcellvalue', row2, "doc_no");
                $("#date").jqxDateTimeInput('val',$("#mvmainsearch").jqxGrid('getcellvalue', row2, "date"));
            	$('#date').jqxDateTimeInput({ disabled: false});
            	$('#dateout').jqxDateTimeInput({ disabled: false});
            	
            	$('#closedate').jqxDateTimeInput({ disabled: false});
            	
            	$('#garagedeldate').jqxDateTimeInput({ disabled: false});
            	$('#garagecollectdate').jqxDateTimeInput({ disabled: false});
            	
            	if($('#mvmainsearch').jqxGrid('getcellvalue', row2, "status")=="OUT"){
            		document.getElementById("movtempstatus").value="OUT";
            	}
            	document.getElementById("frmMovement").submit();
				 $('#window').jqxWindow('close');
                });
            var rows=$("#mvmainsearch").jqxGrid('getrows');
            var rowlength=rows.length;
            if(rowlength==0){
          	  $("#mvmainsearch").jqxGrid('addrow', null, {});

            }
        });
    </script>
    <div id="mvmainsearch"></div>

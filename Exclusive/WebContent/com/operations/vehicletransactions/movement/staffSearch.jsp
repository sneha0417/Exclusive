<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>
 --%>
 <%@page import="com.operations.vehicletransactions.movement.ClsMovementDAO"%>
<%String session1=session.getAttribute("BRANCHID").toString(); 
 ClsMovementDAO movdao=new ClsMovementDAO();
 %>
 <script type="text/javascript">
 
      // alert("ID:"+id);
       var datastaff= '<%=movdao.staffSearch(session1)%>';
      // alert(datasearch); 
       $(document).ready(function () { 	 
    	   var id='<%=request.getParameter("id")%>';   
             var num = 0; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
							{name : 'dr_id', type: 'int' },
     						{name : 'name', type: 'string'  }
     						
                 ],               
                /* localdata: data, */
               localdata:datastaff,
                
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
            
            
            $("#staffSearch").jqxGrid(
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
                    var cell = $('#staffSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'name' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#staffSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text:'Doc No',datafield:'dr_id',width:'10%'},
							{ text: 'Name', datafield: 'name', width: '90%' }
							
	              ]
            });
            $('#staffSearch').on('rowdoubleclick', function (event) {
            	
            	var row2=event.args.rowindex;
            	if(id==1){
            		document.getElementById("staff").value=$('#staffSearch').jqxGrid('getcellvalue', row2, "name");
            		document.getElementById("hidstaff").value=$('#staffSearch').jqxGrid('getcellvalue', row2, "dr_id");
            		//alert("LLLL");
            	
            		
            	}
            	else if(id==2){
            		document.getElementById("closestaff").value=$('#staffSearch').jqxGrid('getcellvalue', row2, "name");
            		document.getElementById("hidclosestaff").value=$('#staffSearch').jqxGrid('getcellvalue', row2, "dr_id");
            		
            	}
            	else{
            		//alert("ELSE");
            		
            	}
            	$('#staffwindow').jqxWindow('close');
					
            	if(id==1){
            		//alert("Here");
            	//	document.getElementById("outremarks").focus();
            		/* $('#outremarks').siblings('input:visible').focus(); */
            	}
                });
            /* var rows=$("#staffSearch").jqxGrid("getrows");
            if(rows.length==0){
            	$("#staffSearch").jqxGrid("addrow", null, {});	
            } */
            

        });
    </script>
    <div id="staffSearch"></div>
<%@page import="com.humanresource.setup.hrsetup.leavesetup.ClsLeavesetupDAO"%>
<% ClsLeavesetupDAO showDAO = new ClsLeavesetupDAO(); %>  
<% String docnos = request.getParameter("docno")==null?"0":request.getParameter("docno");
   String leaveid = request.getParameter("leaveid")==null?"0":request.getParameter("leaveid");%>
   
 <style>
 .greenClass{
            background-color: #ACF6CB;
        }
.whiteClass{
           background-color: #fff;
        }
	        
.saveClass{
      /*   background-color: #ffa07a; */
       background-color: #d8bfd8;
        }     
        
 </style>

<script type="text/javascript">
       var leavedata;
       var docnoss='<%=docnos%>';
       var leaveid='<%=leaveid%>';
       
       if(docnoss>0) {
    		leavedata='<%=showDAO.searchsaveLeaverelode(docnos)%>';  
       } else {
    		leavedata='<%=showDAO.searchLeave()%>';  
       }
		
       var cellclassname = function (row, column, value, data) {
    		    
    	  if(parseInt(data.checkclick)==0){
    			   return "whiteClass";   
    	  } else if(parseInt(data.checkclick)==1){
   	        	return "greenClass";
   	      } else if(document.getElementById("newmode").value=='Saved') {
			  var leaveid=document.getElementById("leaveid").value;
			 
			  if(parseInt(data.ldocno)==parseInt(leaveid)) {
				return "saveClass";
			   }
		  } else {
    	        return "whiteClass"; 
    	  }
    	};   
			 
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'sr_no', type: 'string'  },
                            {name : 'leavetype', type: 'string'  },
                            {name : 'cf', type: 'bool'  },
                            {name : 'deduct', type: 'bool'  },
                            {name : 'l1', type: 'number'  },
                            {name : 'l2', type: 'number'  },
                            {name : 'l3', type: 'number'  },
                            {name : 'l1ded', type: 'number'  },
                            {name : 'l2ded', type: 'number'  },
                            {name : 'l3ded', type: 'number'  },
                        	{name : 'btnsave', type: 'String'  }, 
                        	{name : 'ldocno', type: 'String'  }, 
                        	{name : 'checkclick', type: 'String'  }, 
                        ],
                        localdata: leavedata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#leavesetupgrid").jqxGrid(
            {
            	 width: '100%',
                 height: 300,
                 source: dataAdapter,
                 editable: true,
                 selectionmode: 'singlecell',
                       
                 columns: [
					       { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                     	   },	
						 { text: 'Leave Type', datafield: 'leavetype', width: '27%',cellclassname: cellclassname, editable: false},
						 { text: 'C F', datafield: 'cf', columntype: 'checkbox', editable: true, checked: false, width: '4%',cellsalign: 'center', align: 'center',cellclassname: cellclassname},
						 { text: 'Deduct', datafield: 'deduct', width: '7%',columntype: 'checkbox', editable: true, checked: false,cellsalign: 'center', align: 'center',cellclassname: cellclassname},
						 { text: 'Limit', datafield: 'l1', width: '8%',cellclassname: cellclassname,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
						 { text: 'L-2', datafield: 'l2', width: '8%' ,cellclassname: cellclassname,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
						 { text: 'L-3', datafield: 'l3', width: '7%',cellclassname: cellclassname,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
						 { text: 'L1 Ded.Per', datafield: 'l1ded', width: '9%',cellclassname: cellclassname,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
						 { text: 'L2 Ded.Per', datafield: 'l2ded', width: '9%',cellclassname: cellclassname,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
						 { text: 'L3 Ded.Per', datafield: 'l3ded', width: '9%',cellclassname: cellclassname,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
						 { text: ' ', datafield: 'btnsave', width: '8%',columntype: 'button',editable:false, filterable: false,cellclassname: cellclassname},
						 { text: 'ldocno', datafield: 'ldocno', width: '9%',hidden:true}, 
						 { text: 'checkclick', datafield: 'checkclick', width: '9%',hidden:true},
						]
            });
            
            $("#leavesetupgrid").on('cellclick', function (event) {
           		 
           		    var datafield = event.args.datafield;
           		    var rowBoundIndex = event.args.rowindex;
           		    var columnindex = event.args.columnindex;
  
                    if(datafield=="btnsave"){

                    	if($('#leavesetupgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Apply"){
                   	 
                 			var rows1 = $("#leavesetupgrid").jqxGrid('getrows');      
                      	 
                  	   		for(var i=0;i<rows1.length;i++){
                  		   		$("#leavesetupgrid").jqxGrid('setcellvalue', i , "checkclick", 0);
                  	   		}
                	    
                			var rows = $("#leavesetupgrid").jqxGrid('getrows');      
                	 
                	   		for(var i=0;i<rows.length;i++){

                           		if(i==rowBoundIndex){
                        	   
                        	   		$("#leavesetupgrid").jqxGrid('setcellvalue', rowBoundIndex , "checkclick", 1); 
                        	   
                        	   		var disdata="show";
                        	   		$("#lsetup2").load("condtiongrid.jsp?disdata="+disdata);
                        	   		$("#condtiongrid").jqxGrid({ disabled: false});	
                          			$('#condtiongrid').jqxGrid('refresh');
                       	    		$('#savebtn').attr('disabled', false);
                       	    		$('#deltbtn').attr('disabled', false);
		                        	   return 0;
        		                   } else {
                        	   			$("#leavesetupgrid").jqxGrid('setcellvalue', i , "checkclick", 0);
	                        	   }
                	   		}
                   	 	}
                	    
                 	 	if($('#leavesetupgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="View"){
	                   		 $("#condtiongrid").jqxGrid({ disabled: false});	
	                    	 $('#condtiongrid').jqxGrid('refresh');
                	    	 $('#savebtn').attr('disabled', false);
                	         $('#deltbtn').attr('disabled', false);
                	    
                			 var rows1 = $("#leavesetupgrid").jqxGrid('getrows');      
                   	 
                 	   		 for(var i=0;i<rows1.length;i++){
	                 		   $("#leavesetupgrid").jqxGrid('setcellvalue', i , "checkclick", 0);
     		            	 }
                 	   
    	            		var rows = $("#leavesetupgrid").jqxGrid('getrows');      
                	 
	                	    for(var i=0;i<rows.length;i++){

                            if(i==rowBoundIndex){
                        	   
                        	   $("#leavesetupgrid").jqxGrid('setcellvalue', rowBoundIndex , "checkclick", 1); 
                        	   $("#leavesetupgrid").jqxGrid('setcellvalue', rowBoundIndex , "btnsave", "Apply");
                        	   var leaveid=$('#leavesetupgrid').jqxGrid('getcellvalue',rowBoundIndex, "ldocno");
             				   var refno= document.getElementById("refno").value;
             				   var disdata="show"; 
                        	   $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&leaveid="+leaveid+"&disdata="+disdata);
                        	   return 0;
                            } else {
                        	   $("#leavesetupgrid").jqxGrid('setcellvalue', i , "checkclick", 0);
                        	}
                	   }
                   	  }
                   	 }
           		}); 
         
            $("#leavesetupgrid").on('cellendedit', function (event) {
                 var dataField = event.args.datafield;
                 var rowIndex = event.args.rowindex;
                 
               	 if(dataField=="l1ded" || dataField=="l2ded" || dataField=="l3ded"){
                	var value1 = event.args.value;
               
                 if(parseFloat(value1)>100){ 
                       $("#leavesetupgrid").jqxGrid('showvalidationpopup', rowIndex, dataField, "Limit Already Reached,Invalid Amount.");
                        return true;  
                  } else if(parseFloat(value1)<=100){
                       $("#leavesetupgrid").jqxGrid('hidevalidationpopups');
                       return false;  
                  }
                
               	}        
             }); 
            
        });
		
</script>
<div id="leavesetupgrid"></div>
<%@page import="com.humanresource.setup.hrsetup.leavesetup.ClsLeavesetupDAO"%>
<% ClsLeavesetupDAO showDAO = new ClsLeavesetupDAO(); %>    
<% String disdata = request.getParameter("disdata")==null?"0":request.getParameter("disdata");
   String docnos = request.getParameter("docno")==null?"0":request.getParameter("docno");
   String leaveid = request.getParameter("leaveid")==null?"0":request.getParameter("leaveid");%>

<script type="text/javascript">

       var docnoss='<%=docnos%>';
       
       var leaveid='<%=leaveid%>';
       var disdata='<%=disdata%>' ;  
   	   if(docnoss>0) {
   			var alldata='<%=showDAO.searchAllowancerelode(docnos,leaveid)%>';
   	   } else {
   		   var alldata='<%=showDAO.searchAllowance()%>';
   		   var dis="dis";
   	   }
			 
			 
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'sr_no', type: 'string'  },
                            {name : 'allowance', type: 'string'  },
                            {name : 'allowanceid', type: 'string'  },
                            {name : 'ckecked', type: 'number'  },
                        ],
                		
                 localdata: alldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#condtiongrid").on("bindingcomplete", function (event) {
            	  var rows = $("#condtiongrid").jqxGrid('getrows');   
            	  for(var i=0;i<rows.length;i++){
            		  var val= $('#condtiongrid').jqxGrid('getcellvalue',i, "ckecked");
            		  if(parseInt(val)==1){
            			   $('#condtiongrid').jqxGrid('selectrow',i);   
            		  }
            	  }
              }); 
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#condtiongrid").jqxGrid(
            {
                width: '100%',
                height: 270,
                source: dataAdapter,
                selectionmode: 'checkbox',
                editable: true,
                       
                columns: [

                          { text: 'SL No', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '15%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Allowance', datafield: 'allowance', width: '76%' ,
                           		cellbeginedit: function (row) {
   									var temp=$('#mode').val();
   									if (temp =="view") {
   									       return false;
   									 }
    								    
    						}},
    						{ text: 'Allowance id', datafield: 'allowanceid', width: '7%' ,hidden:true,
                            		cellbeginedit: function (row) {
    									var temp=$('#mode').val();
    									if (temp =="view") {
    									       return false;
    									 }
    	    								    
    	    				}},
						]
            });
            
        if(disdata=="show") {
    	 	$("#condtiongrid").jqxGrid({ disabled: false});	
    	}
     /*    else if(docnoss>0)
 		   {
            	  $("#condtiongrid").jqxGrid({ disabled: false});	


 		   }
         */
        
        else if(disdata=="hide") {
        	 $("#condtiongrid").jqxGrid({ disabled: true});	
        } else {
        	 $("#condtiongrid").jqxGrid({ disabled: true});	
        }
            
        $("#condtiongrid").on('cellvaluechanged', function (event) {
             var rowindex1 = event.args.rowindex;
		
		 	 var rows = $('#condtiongrid').jqxGrid('getrows');
             var rowlength= rows.length;
             if (rowindex1 == rowlength - 1) {
	             $("#condtiongrid").jqxGrid('addrow', null, {});	
             }	
		  });
          
        });
		
</script>
<div id="condtiongrid"></div>
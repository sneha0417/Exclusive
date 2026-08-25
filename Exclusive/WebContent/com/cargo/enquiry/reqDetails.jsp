 
 
<%@page import="com.cargo.enquiry.ClscargoEnquiryDAO"%>
<% ClscargoEnquiryDAO  cargoenquiryDAO = new ClscargoEnquiryDAO(); %> 

 <%
           	String enqrdocno = request.getParameter("enqrdocno")==null?"0":request.getParameter("enqrdocno").trim();
           	  %> 
<script type="text/javascript">

           	  
           	var temp1='<%=enqrdocno%>';
            var hide;
            if(temp1>0)
          	 {
            	 var reqdata1='<%=cargoenquiryDAO.maingridreload(enqrdocno)%>'; 
          	   hide=2; 
          	 } 
            else
          	 { 
            	var reqdata1;
            	
        
          	 } 
  
  
        $(document).ready(function () { 	
        
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'mode', type: 'string'  },
							{name : 'modeid', type: 'int'   },
     						{name : 'submode', type: 'string'  },
     						{name : 'smodeid', type: 'int'   },
     						{name : 'shipment', type: 'string'  },
     						{name : 'shipmentid', type: 'int'   },
     						{name : 'terms', type: 'string'   },
     						{name : 'termid', type: 'int'   },
     						{name : 'orgin', type: 'string'  },
     						{name : 'pol', type: 'string'   },
     						{name : 'pod', type: 'string'   },
     						
     						{name : 'comodity', type: 'string'   },
     						{name : 'weight', type: 'string'   },
     						
     						{name : 'noofpacks', type: 'number'  },
     						{ name: 'dimension', type: 'string' },
     						{name : 'volume', type: 'string' },
     						{ name: 'remarks', type: 'string' },
     					
     						{name : 'qty', type: 'int'  },
     						{name : 'sr_no', type: 'int'  }
     						
     											
                 ],
                 localdata: reqdata1,
                
                
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

            
            
            $("#jqxEnquiry").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
               
                disabled:true,
                editable: true,
                altRows: true,
                columnsresize: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
               
                handlekeyboardnavigation: function (event) {
               	
                	 var cell1 = $('#jqxEnquiry').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'mode') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex").value = cell1.rowindex;
                       
                        	modeinfoSearchContent('modeSearch.jsp');
                        	 $('#jqxEnquiry').jqxGrid('render');
                        }
                        }
                	 if (cell1 != undefined && cell1.datafield == 'shipment') {  
                     	
                         var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                         if (key == 114) {  
                          	 document.getElementById("rowindex").value = cell1.rowindex;
                        
                         	modeinfoSearchContent('shipmentSearch.jsp');
                         	 $('#jqxEnquiry').jqxGrid('render');
                         }
                         }
               	 if (cell1 != undefined && cell1.datafield == 'terms') { 
                	
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {  
                    	 document.getElementById("rowindex").value = cell1.rowindex;
                    	 terminfoSearchContent('termSearch.jsp');
                    	 $('#jqxEnquiry').jqxGrid('render');
                     }
                  }
           
                 	 if (cell1 != undefined && cell1.datafield == 'submode') {  
                 
             
		                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
		                    if (key == 114) {  
		                    	 document.getElementById("rowindex").value = cell1.rowindex;
		                  	 
		                  	submodeinfoSearchContent('submodeSearch.jsp');
		                  	 $('#jqxEnquiry').jqxGrid('render');
		                    }
                    }
              
              
                  }, 
              
                       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
                            },	
                            { text: 'Mode', datafield: 'mode', width: '9%' , editable: false },	
                            { text: 'Modeid', datafield: 'modeid', width: '2%' ,hidden:true },
							{ text: 'Submode', datafield: 'submode', width: '9%', editable: false , coloumnresizable:true},	
							{ text: 'Submodeid', datafield: 'smodeid', width: '2%',hidden:true },
							{ text: 'Shipment', datafield: 'shipment', width: '9%' , editable: false},
							{ text: 'Shipmentid', datafield: 'shipmentid', width: '2%' ,hidden:true },
							{ text: 'Terms', datafield: 'terms', width: '7%', editable: false },	
							{ text: 'Termid', datafield: 'termid', width: '2%',hidden:true },
							
							{ text: 'Orgin', datafield: 'orgin', width: '6%' },	
							
							{ text: 'Pol', datafield: 'pol', width: '6%'},
													
							{ text: 'PoD', datafield: 'pod', width: '6%'},	
							{ text: 'Commodity', datafield: 'comodity', width: '9%'},
							{ text: 'Weight', datafield: 'weight', width: '6%'},
							{ text: 'No of Packs', datafield: 'noofpacks', width: '6%' },	
							{ text: 'Dimension', datafield: 'dimension', width: '6%' },
							{ text: 'Volume', datafield: 'volume', width: '6%' },	
							{ text: 'Remarks', datafield: 'remarks', width: '6%' },	
							{ text: 'Qty', datafield: 'qty', width: '5%'},
							{ text: 'srno', datafield: 'sr_no', width: '9%',hidden:true}
			              ]
               
            });
           
            $("#jqxEnquiry").jqxGrid('addrow', null, {});
            
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#jqxEnquiry").jqxGrid({ disabled: false}); 
    		}
            
   

            $('#jqxEnquiry').on('celldoubleclick', function (event) {
            	var columnindex1=event.args.columnindex;
            	var datafield = event.args.datafield;

              	  if(datafield == "mode")
              		  { 
            		
              	 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex").value = rowindextemp;  
              	  $('#jqxEnquiry').jqxGrid('clearselection');
              	modeinfoSearchContent('modeSearch.jsp');
              	
              		  } 
              	 if(datafield == "shipment")
         		  { 
       		
         	 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex").value = rowindextemp;  
         	  $('#jqxEnquiry').jqxGrid('clearselection');
         	shipmentinfoSearchContent('shipmentSearch.jsp');
         	
         		  } 
              	 if(datafield == "submode")
         		  { 

         	 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex").value = rowindextemp;  
         		  $('#jqxEnquiry').jqxGrid('clearselection');
         	   
         
         	submodeinfoSearchContent('submodeSearch.jsp?modeval='+$('#jqxEnquiry').jqxGrid('getcellvalue', rowindextemp, "modeid"));
         	
         		  } 
         	  
              	 if(datafield == "terms")
        		  { 

        	     		
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        		  $('#jqxEnquiry').jqxGrid('clearselection');
        	    terminfoSearchContent('termSearch.jsp?modeval='+$('#jqxEnquiry').jqxGrid('getcellvalue', rowindextemp, "modeid"));
        			
        		  }
        	  
              	
              	  
                  }); 
            
            $("#jqxEnquiry").on('cellvaluechanged', function (event) 
         		   {
         		        		  
         		       var rowBoundIndex = event.args.rowindex;
         		       
         		       var datafield = event.args.datafield;
         		       
          		       
         		      if(datafield=="fromdate")
       		           {
         		    	  
         		    	  var fromdate=$('#jqxEnquiry').jqxGrid('getcellvalue', rowBoundIndex, "fromdate");
         		    		 var today = new Date();
         		            today.setHours(0, 0, 0, 0);
         		    	
         		    	if(fromdate<today)
         		    		{
         		    		 document.getElementById("errormsg").innerText="From Date Less Than Current Date";
         		    		document.getElementById("fromdatesval").value=1;
         		    		
         		    		 
         					return 0;
         		    		
         		    		}
         		    	else
         		    		{
         		   	        	
         		    		 document.getElementById("errormsg").innerText="";
         		    		document.getElementById("fromdatesval").value="";
         		    		
         		    		}
         		    	
         		    
         		    	  
         		    	   var text = $('#jqxEnquiry').jqxGrid('getcelltext', rowBoundIndex, "fromdate");
      		        	
      		        	  $('#jqxEnquiry').jqxGrid('setcellvalue',rowBoundIndex, "hidfromdate",text);
      		        	  
      		        	 
      		        	  
      		        	  
       		       }
         		   
         		       
         		  }); 
        });
    </script>
    <div id="jqxEnquiry"></div>
  <input type="hidden" id="rowindex"/> 
  
  
  
  
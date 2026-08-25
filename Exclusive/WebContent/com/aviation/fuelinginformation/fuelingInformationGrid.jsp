 
 
<%@page import="com.aviation.fuelinginformation.ClsfuelingInformationDAO"%>
<% ClsfuelingInformationDAO  fuelinfoDAO = new ClsfuelingInformationDAO(); %> 

 <% String enqrdocno = request.getParameter("enqrdocno")==null?"0":request.getParameter("enqrdocno").trim(); %>
 
<style type="text/css">
    .disableClass{
        color: #999;
    }
</style> 
<script type="text/javascript">

           	  
           	var temp1='<%=enqrdocno%>';
            var hide;
            if(temp1>0)
          	 {
            	 var reqdata1='<%=fuelinfoDAO.maingridreload(enqrdocno)%>'; 
          	   hide=2; 
          	 } 
            else
          	 { 
            	var reqdata1;
            	
        
          	 } 
  
  
        $(document).ready(function () { 	
        
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'date', type: 'date'   },
     						{name : 'port', type: 'string'  },
     						{name : 'portid', type: 'string'  },
     						{name : 'product', type: 'string'  },
     						{name : 'productid', type: 'string'  },
     						
     						{name : 'portname', type: 'string'   },
     						{name : 'ac_type', type: 'string'  },
     						{name : 'aircraftno', type: 'string'   },
     						{name : 'flightno', type: 'string'   },
     						{name : 'unit', type: 'string'   },
     						{name : 'unitid', type: 'string'   },
     						{name : 'qty', type: 'string'  },
     						{name : 'operator', type: 'string'   },
     						{name : 'eta', type: 'string'   },
     						
     						{name : 'etd', type: 'string'   },
     						{name : 'timezone', type: 'string'   },
     						
     						{name : 'remarks', type: 'string'  },
     						{name : 'parking', type: 'string'  },
     						{name : 'invoiced', type: 'int'  },
     						{name : 'delstat', type: 'int'  }
     											
                 ],
                 localdata: reqdata1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
                if (data.invoiced > 0 && data.delstat != 0) {
                    return "disableClass";
                } else if (data.invoiced == 0 && data.delstat != 0) {
                    return "disableClass";
                } else if (data.invoiced > 0 && data.delstat == 0) {
                    return "disableClass";
                };
            }; 
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#jqxFuelInfo").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
               
                disabled:true,
                editable: true,
                columnsresize: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
               handlekeyboardnavigation: function (event) {
               	
                	 var cell1 = $('#jqxFuelInfo').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'product') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {
                        	
                        	if (!($('#jqxFuelInfo').jqxGrid('getcellvalue', cell1.rowindex, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', cell1.rowindex, "delstat")!=0))
					         {
                         	 document.getElementById("rowindex").value = cell1.rowindex;
                       
                        	productinfoSearchContent('productINgridsearch.jsp');
                        	 $('#jqxFuelInfo').jqxGrid('render');
					         }
                        	}
                        }
                	 var cell1 = $('#jqxFuelInfo').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'unit') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {
                        	
                        	if (!($('#jqxFuelInfo').jqxGrid('getcellvalue', cell1.rowindex, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', cell1.rowindex, "delstat")!=0))
					         {
                         	 document.getElementById("rowindex").value = cell1.rowindex;
                       
                        	unitSearchContent('unitINgridsearch.jsp');
                        	 $('#jqxFuelInfo').jqxGrid('render');
                        	}
                         }
                        }
                	 var cell1 = $('#jqxFuelInfo').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'port') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {
                        	
                        	if (!($('#jqxFuelInfo').jqxGrid('getcellvalue', cell1.rowindex, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', cell1.rowindex, "delstat")!=0))
					         {
                         	 document.getElementById("rowindex").value = cell1.rowindex;
                      	portSearchContent('portINgridsearch.jsp');
                        	 $('#jqxFuelInfo').jqxGrid('render');
                        	}
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
                            { text: 'Date', datafield: 'date', width: '8%' , columntype: 'datetimeinput',cellsformat:'dd.MM.yyyy', cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
                            { text: 'Port', datafield: 'port', width: '5%' ,editable:false, cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
                            { text: 'Portid', datafield: 'portid', width: '5%' ,hidden:true },
                            
							{ text: 'Port Name', datafield: 'portname', width: '8%' , coloumnresizable:true,editable:false, cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},		
							
							{ text: 'Product', datafield: 'product', width: '5%'  ,editable:false, cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
                            { text: 'Productid', datafield: 'productid', width: '5%' ,hidden:true },
							{ text: 'A/C Type', datafield: 'ac_type', width: '7%', cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
							{ text: 'Aircraft No', datafield: 'aircraftno', width: '6%', cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
							{ text: 'Flight No', datafield: 'flightno', width: '5%', cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
							{ text: 'Unit', datafield: 'unit', width: '5%'  ,editable:false, cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
							{ text: 'Unitid', datafield: 'unitid', width: '7%',hidden:true },
							{ text: 'Quantity', datafield: 'qty', width: '8%', cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
							
							{ text: 'Operator', datafield: 'operator', width: '6%', cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},		
							
							
							{ text: 'ETA', datafield: 'eta', cellsformat: 'HH:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: true, cellclassname: cellclassname,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								},
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
							
							{ text: 'ETD', datafield: 'etd', cellsformat: 'HH:mm',  width: '7%', cellsalign: 'left', cellclassname: cellclassname,
							columntype: 'datetimeinput',editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								},
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
							{ text: 'Time Zone', datafield: 'timezone', width: '7%', cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
							{ text: 'Remarks', datafield: 'remarks', width: '6%', cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
							{ text: 'Parking', datafield: 'parking', width: '6%', cellclassname: cellclassname,
								cellbeginedit: function (row) {
							        if ($('#jqxFuelInfo').jqxGrid('getcellvalue', row, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', row, "delstat")!=0)
							         {
							              return false;
							         }}
							},	
							{ text: 'Invoiced', datafield: 'invoiced', width: '9%',hidden:true},
							{ text: 'Delstat', datafield: 'delstat', width: '9%',hidden:true}
			              ]
               
            });
           
           // $("#jqxFuelInfo").jqxGrid('addrow', null, {});
            
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#jqxFuelInfo").jqxGrid({ disabled: false}); 
    		}
            
   

            $('#jqxFuelInfo').on('celldoubleclick', function (event) {
            	var columnindex1=event.args.columnindex;
            	var datafield = event.args.datafield;

              	  if(datafield == "product")
              		  { 
            		
              	 var rowindextemp = event.args.rowindex;
              	 
              	if (!($('#jqxFuelInfo').jqxGrid('getcellvalue', rowindextemp, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', rowindextemp, "delstat")!=0))
              		{
              	    document.getElementById("rowindex").value = rowindextemp;  
              	  $('#jqxFuelInfo').jqxGrid('clearselection');
              	productSearchContent('productINgridsearch.jsp');
              		}
              		  } 
              	        
              	if(datafield == "unit")
        		  { 
      		
        	 var rowindextemp = event.args.rowindex;
        	 if (!($('#jqxFuelInfo').jqxGrid('getcellvalue', rowindextemp, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', rowindextemp, "delstat")!=0))
       		{
        	    document.getElementById("rowindex").value = rowindextemp;  
        	  $('#jqxFuelInfo').jqxGrid('clearselection');
        	  unitSearchContent('unitINgridsearch.jsp');
       		}
        		  } 
              	if(datafield == "port")
        		  { 
        	 var rowindextemp = event.args.rowindex;
        	 if (!($('#jqxFuelInfo').jqxGrid('getcellvalue', rowindextemp, "invoiced")>0 || $('#jqxFuelInfo').jqxGrid('getcellvalue', rowindextemp, "delstat")!=0))
       		{
        	    document.getElementById("rowindex").value = rowindextemp;  
        	  $('#jqxFuelInfo').jqxGrid('clearselection');
        	portSearchContent('portINgridsearch.jsp');
       		}
        		  } 
        	            
                  }); 
            
            $("#jqxFuelInfo").on('cellvaluechanged', function (event) 
         		   {
         		        		  
         		       var rowBoundIndex = event.args.rowindex;   
         		       
         		       var datafield = event.args.datafield;
         		       
          		       
         		      if(datafield=="fromdate")
       		           {
         		    	  
         		    	  var fromdate=$('#jqxFuelInfo').jqxGrid('getcellvalue', rowBoundIndex, "fromdate");
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
         		    	
         		    
         		    	  
         		    	   var text = $('#jqxFuelInfo').jqxGrid('getcelltext', rowBoundIndex, "fromdate");
      		        	
      		        	  $('#jqxFuelInfo').jqxGrid('setcellvalue',rowBoundIndex, "hidfromdate",text);
      		        	  
      		        	 
      		        	  
      		        	  
       		       }
         		   
         		       
         		  }); 
        });
    </script>
    <div id="jqxFuelInfo"></div>
  <input type="hidden" id="rowindex"/> 
  
  
  
  
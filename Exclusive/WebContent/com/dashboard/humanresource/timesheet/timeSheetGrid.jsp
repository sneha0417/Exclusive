<%@page import="com.dashboard.humanresource.timesheet.ClsTimeSheetDAO"%>
<% ClsTimeSheetDAO DAO= new ClsTimeSheetDAO(); %>
<% String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();%>

<script type="text/javascript">
        var data;
        var temp1='<%=branchval%>';
        
        if(temp1!='NA'){ }
        
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'date', type: 'date'  },
					{name : 'empid', type: 'String'  },
					{name : 'empname', type: 'String'  },
					{name : 'costtype', type: 'string'    },
					{name : 'costgroup', type: 'string'    },
					{name : 'costcodename', type: 'string'    },
					{name : 'costcode', type: 'number'    },
					{name : 'intime', type: 'date'  }, 
					{name : 'outtime', type: 'date'  }, 
				    {name : 'hrs', type: 'date'  }, 
				    {name : 'othrs', type: 'date'  }, 
				    {name : 'hothrs', type: 'date'  }, 
				    {name : 'empdocno', type: 'String'  },
				    {name : 'costperhour', type: 'String'  }
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
		            });
            
            $("#timeSheetDetailsGridID").jqxGrid(
            {
                width: '98%',
                height: 530,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                columnsresize: true,
                editable: true,
                selectionmode: 'singlecell',
                
				handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#timeSheetDetailsGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'empid') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {   
                        	$('#rowindex').val(cell1.rowindex);$('#txtorgridclick').val('2');
                        	employeeSearchContent("employeeDetailsSearch.jsp");
                        }
                    } 
                    
                    var cell2 = $('#timeSheetDetailsGridID').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    if (key == 114) {  
                    	 $('#rowindex').val(cell2.rowindex);
                    	 $('#txtorgridclick').val('2');
                    	 costTypeSearchContent("costTypeSearchGrid.jsp");
                    	 $('#timeSheetDetailsGridID').jqxGrid('render');
                      }
                	}
                    
                    var cell3 = $('#timeSheetDetailsGridID').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcodename') {
	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
	                   if (key == 114) { 
	                	   var value=  $('#timeSheetDetailsGridID').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
						   if(typeof(value) == "undefined" || typeof(value) == "NaN" || value == ""){
	       	   			 	$.messager.alert('Message','Project Type is Mandatory.','warning');
	       	   			 	return 0;
	       	   		       }
	                	   $('#rowindex').val(cell3.rowindex);
	                	   $('#txtorgridclick').val('2');
	                	   costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+value);
	                	   $('#timeSheetDetailsGridID').jqxGrid('render');
	                   }
	               }
                },
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy',columntype: 'datetimeinput', width: '7%', editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								},
								cellbeginedit: function (row) {
									if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='')
							         {
										  $.messager.alert('Message','Year and Month are Mandatory.','warning');
							              return false;
							         }}	
							},
							{ text: 'Emp. ID', datafield: 'empid', width: '8%', editable: false },
							{ text: 'Employee', datafield: 'empname', editable: false },
							{ text: 'Cost Type', datafield: 'costgroup', width: '9%', editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true },
							{ text: 'Cost Id', datafield: 'costcodename', width: '13%',editable: false },
							{ text: 'Cost ID', datafield: 'costcode', width: '7%',editable: false,hidden: true },
							{ text: 'In Time', datafield: 'intime', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'Out Time', datafield: 'outtime', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'Normal Hours', datafield: 'hrs', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: false,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							}, 
							{ text: 'OT Hours', datafield: 'othrs', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							}, 
							{ text: 'HOT Hours', datafield: 'hothrs', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							}, 
							{ text: 'Emp. Docno', datafield: 'empdocno', hidden: true, width: '8%' },
							{ text: 'Cost Per Hour', datafield: 'costperhour', hidden: true, width: '8%' },
					 		]
            });
            
            if(temp1=='NA'){
                $("#timeSheetDetailsGridID").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
            $("#timeSheetDetailsGridID").on('cellvaluechanged', function (event) {
            	 var datafield = event.args.datafield;
          	     var rowindexestemp = event.args.rowindex;
          	     $('#rowindex').val(rowindexestemp);
          	   
				 if(datafield=="date"){
	         	    	var date = $('#timeSheetDetailsGridID').jqxGrid('getcelltext', rowindexestemp, "date");
	         	    	var day = date.split(".");
	         	    	
	         	    	if($('#cmbmonth').val()!=day[1]) {
							 $.messager.alert('Message','Month should be '+$('#cmbmonth option:selected').text(),'warning');
				             return 0;
				        }
            
	         	    	if($('#cmbyear').val()!=day[2]) {
		   					 $.messager.alert('Message','Year should be '+$('#cmbyear').val(),'warning');
		   		             return 0;
	   			        }
	         	 }
					
	          	 if(datafield=="costtype"){
	      			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "costcodename" ,'');
	      			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
	  			 }
	          	 
	          	if(datafield=="hrs"){
	          		if($('#txtfillbtnclick').val()!='1'){
			          	var rows = $('#timeSheetDetailsGridID').jqxGrid('getrows');
		            	var rowlength= rows.length;
		            	var rowindex1 = rowlength - 1;
		          	    var hours=$("#timeSheetDetailsGridID").jqxGrid('getcellvalue', rowindex1, "hrs");
		          	    if(typeof(hours) != "undefined" && typeof(hours) != "NaN" && hours != ""){
		          	    	$("#timeSheetDetailsGridID").jqxGrid('addrow', null, {"date": ""+$('#date').val()+"","empid": ""+$('#txtemployeeid').val()+"","empname": ""+$('#txtemployeename').val()+"","costtype": ""+$('#txtprojecttypeid').val()+"","costgroup": ""+$('#txtprojecttype').val()+"","costcodename": ""+$('#txtprojectidname').val()+"","costcode": ""+$('#txtprojectid').val()+"","hrs": "","empdocno": ""+$('#txtemployeedocno').val()+""});
		          	    }
	          		}
	          	}
	          	
	          	if(datafield=="intime" || datafield=="outtime"){
	          		
	          		var intime=$("#timeSheetDetailsGridID").jqxGrid('getcelltext', rowindexestemp, "intime");
	          		var outtime=$("#timeSheetDetailsGridID").jqxGrid('getcelltext', rowindexestemp, "outtime");
	          		
	          		if((typeof(intime) != "undefined" && typeof(intime) != "NaN" && intime != "") && typeof(outtime) != "undefined" && typeof(outtime) != "NaN" && outtime != ""){
	             
	                var startDate = new Date($("#timeSheetDetailsGridID").jqxGrid('getcellvalue', rowindexestemp, "intime"));
	                var endDate   = new Date($("#timeSheetDetailsGridID").jqxGrid('getcellvalue', rowindexestemp, "outtime"));
	                
	                
	                
	                if(Date.parse(endDate) < Date.parse(startDate)){
	                	//endDate = new Date(endDate.setDate(endDate.getDate() + 1));
	                	$.messager.alert('Message','Out time should be greater than in time','warning');
	                	$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "outtime" ,"");
						return 0;
	                }
	                
	                var hours1 = (endDate.getTime() - startDate.getTime()) / (1000 * 60);
	                /* var newhours = parseFloat(hours1/60).toFixed(0); //this function rounds to nearest integer ,but we need floor*/
	                var newhours = Math.floor(hours1/60);
	                var newhours1 = ('0' + newhours).slice(-2);
	                var newminutes1 = hours1-(newhours*60);
	                //var newminutes = parseFloat(hours1%60);// reason: one hr extra coming 
	                //var newminutes1 = ('0' + newminutes).slice(-2);
	                var normalHours = new Date("01/01/2017 " + (newhours1+":"+newminutes1+":00"));
	                 
	                $('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "hrs" ,normalHours);
	                	
	          	    }
	          	}
	          	
            });
            
            $('#timeSheetDetailsGridID').on('celldoubleclick', function (event) {
         	     
           	    if(event.args.columnindex == 2)
           	    {
           			var rowindextemp = event.args.rowindex;
           			document.getElementById("rowindex").value = rowindextemp;
           			$('#txtorgridclick').val('2');
           			employeeSearchContent("employeeDetailsSearch.jsp");
                } 
                
           	
  	         	if(event.args.columnindex == 4)
  	            {
  		           var rowindextemp = event.args.rowindex;
  		           document.getElementById("rowindex").value = rowindextemp;
  		           $('#txtorgridclick').val('2');
  		           $('#timeSheetDetailsGridID').jqxGrid('clearselection');
  		           costTypeSearchContent("costTypeSearchGrid.jsp");
  	            }
  	    		  
  	           if(event.args.columnindex == 6)
  	            {
  	        	    var rowindextemp = event.args.rowindex;
  	        	    var value = $('#timeSheetDetailsGridID').jqxGrid('getcellvalue', rowindextemp, "costtype");
  	        	    if(typeof(value) == "undefined" || typeof(value) == "NaN" || value == ""){
 	   			 	$.messager.alert('Message','Project Type is Mandatory.','warning');
 	   			 	return 0;
 	   		       }
  		           document.getElementById("rowindex").value = rowindextemp;
  		           $('#txtorgridclick').val('2');
  		           $('#timeSheetDetailsGridID').jqxGrid('clearselection');
  		           costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+value);
  	            }
  	           
  	           if(event.args.columnindex == 0)
        		  {
        			var rowindexestemp = event.args.rowindex;
        			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "date" ,'');
        			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "empid" ,'');	
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "empname" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "costcodename" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "intime" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "outtime" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "hrs" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "othrs" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "hothrs" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "empdocno" ,'');
                  } 
               });
            
            
            /*Delete Row*/
            $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            
            // create context menu
               var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#timeSheetDetailsGridID").on('contextmenu', function () {
                   return false;
               });
               
            $("#Menu2").on('itemclick', function (event) {
                var rowindex = $("#timeSheetDetailsGridID").jqxGrid('getselectedrowindex');
                    
                var rowid = $("#timeSheetDetailsGridID").jqxGrid('getrowid', rowindex);
                $("#timeSheetDetailsGridID").jqxGrid('deleterow', rowid);
            });
            
            $("#timeSheetDetailsGridID").on('cellclick', function (event) {
                if (event.args.rightclick) {
                    $("#timeSheetDetailsGridID").jqxGrid('selectrow', event.args.rowindex);
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);

                    return false;
                }
            });
            /*Delete Row Ends*/
  });
                       
</script>

<div id='jqxWidget'>
   <div id="timeSheetDetailsGridID"></div>
    <div id="popupWindow2">
 
 <div id='Menu2'>
    <ul>
        <li>Delete Selected Row</li>
    </ul>
</div>       
</div>
</div>
<input type="hidden" id="rowindex"/> 
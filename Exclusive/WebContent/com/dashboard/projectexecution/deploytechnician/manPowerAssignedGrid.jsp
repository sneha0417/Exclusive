<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.projectexecution.deploytechnician.ClsDeployTechnicianDAO"%> 
<% ClsDeployTechnicianDAO DAO=new ClsDeployTechnicianDAO(); %>
<% String branch =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString().trim();
   String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
   String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").toString().trim(); 
   String check =request.getParameter("check")==null?"0":request.getParameter("check").toString().trim();
 %>

<script type="text/javascript">
 		var data2;
    
        $(document).ready(function () { 	
             
        	var rendererstring1=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'date', type: 'date'  },
							{name : 'jobno', type: 'String'  },
							{name : 'empid', type: 'String'  },
							{name : 'empname', type: 'String'  },
							{name : 'consumed', type: 'String' },
     						{name : 'intime', type: 'date'  }, 
     						{name : 'outtime', type: 'date'  }, 
     					    {name : 'hrs', type: 'date'  },
     					    {name : 'stdcost', type: 'number'  },
     					    {name : 'total', type: 'number'  },
     					    {name : 'actualhrs', type: 'String'  },
     					    {name : 'empdocno', type: 'String'  }
     						
                 ],
                 localdata: data2,
                
                
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
            
            $("#manPowerAssignedGridID").jqxGrid(
            {
                width: '99.5%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlecell',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable: true,
                showstatusbar: true,
                showaggregates: true,
                statusbarheight: 25,
             	localization: {thousandsSeparator: ""},
             	
				handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#manPowerAssignedGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'empid') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {   
                        	document.getElementById("rowindex").value = cell1.rowindex;
                   			manPowerSearchContent('employeeDetailsSearch.jsp?id=1');
                        }
                    }
				},
				
                columns: [
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy',columntype: 'datetimeinput', width: '12%', editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								}
							},
							{ text: 'Emp. ID', datafield: 'empid', width: '10%', editable: false },
							{ text: 'Employee', datafield: 'empname', width: '30%', editable: false },
							{ text: 'View',  datafield: 'consumed',columntype: 'button', width: '6%' },
							{ text: 'From', datafield: 'intime', cellsformat: 'HH:mm',  width: '6%', cellsalign: 'left',columntype: 'datetimeinput',editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'To', datafield: 'outtime', cellsformat: 'HH:mm',  width: '6%', cellsalign: 'left',columntype: 'datetimeinput',editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'Hours', datafield: 'hrs', cellsformat: 'HH:mm',  width: '6%', cellsalign: 'left',columntype: 'datetimeinput',editable: false,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							}, 
							{ text: 'Standard Cost', datafield: 'stdcost',cellsformat: 'd2',cellsalign:'right',align:'right', width: '12%',editable: false },
							{ text: 'Total', datafield: 'total',cellsformat: 'd2',cellsalign:'right',align:'right', width: '12%',editable: false, aggregates: ['sum'], aggregatesrenderer:rendererstring1 },
							{ text: 'Actual Hrs', datafield: 'actualhrs',hidden: true, width: '10%' },
							{ text: 'Emp Id', datafield: 'empdocno',hidden: true, width: '10%' },
		
	              ]
            });
             
            $("#overlay, #PleaseWait").hide();
            
            $('#manPowerAssignedGridID').on('celldoubleclick', function (event) {
           	  if(event.args.columnindex == 1)
           		  {
           			var rowindextemp = event.args.rowindex;
           			document.getElementById("rowindex").value = rowindextemp;
           			manPowerSearchContent('employeeDetailsSearch.jsp?id=1');
           		  }
            });
            
            $("#manPowerAssignedGridID").on('cellvaluechanged', function (event) {
           	 	 var datafield = event.args.datafield;
         	     var rowindexestemp = event.args.rowindex;
         	     
				 if(datafield=="intime" || datafield=="outtime"){
	          		
	          		var intime=$("#manPowerAssignedGridID").jqxGrid('getcelltext', rowindexestemp, "intime");
	          		var outtime=$("#manPowerAssignedGridID").jqxGrid('getcelltext', rowindexestemp, "outtime");
	          		var stdcost=$("#manPowerAssignedGridID").jqxGrid('getcelltext', rowindexestemp, "stdcost");
	          		
	          		if((typeof(intime) != "undefined" && typeof(intime) != "NaN" && intime != "") && typeof(outtime) != "undefined" && typeof(outtime) != "NaN" && outtime != ""){
	             
	                var startDate = new Date($("#manPowerAssignedGridID").jqxGrid('getcellvalue', rowindexestemp, "intime"));
	                var endDate   = new Date($("#manPowerAssignedGridID").jqxGrid('getcellvalue', rowindexestemp, "outtime"));
	                
	                if(parseInt(endDate.getHours())<parseInt(startDate.getHours())){
	                	$.messager.alert('Message','To Time Less than From Time.','warning');
	                	$("#manPowerAssignedGridID").jqxGrid('setcellvalue', rowindexestemp, "outtime","");
	                	$("#manPowerAssignedGridID").jqxGrid('setcellvalue', rowindexestemp, "hrs","");
	                	$("#manPowerAssignedGridID").jqxGrid('setcellvalue', rowindexestemp, "actualhrs","");
	       			    return 0;
	                } else if(parseInt(endDate.getHours())==parseInt(startDate.getHours())){
	                	if(parseInt(endDate.getMinutes())<parseInt(startDate.getMinutes())){
	                		$.messager.alert('Message','To Time Less than From Time.','warning');
	                		$("#manPowerAssignedGridID").jqxGrid('setcellvalue', rowindexestemp, "outtime","");
	                		$("#manPowerAssignedGridID").jqxGrid('setcellvalue', rowindexestemp, "hrs","");
		                	$("#manPowerAssignedGridID").jqxGrid('setcellvalue', rowindexestemp, "actualhrs","");
	       			    	return 0;
	                	}
	                }
	                
	                if(Date.parse(endDate) < Date.parse(startDate)){
	                	endDate = new Date(endDate.setDate(endDate.getDate() + 1));
	                }
	                
	                var hours1 = (endDate.getTime() - startDate.getTime()) / (1000 * 60);
	                var newhours = parseFloat(hours1/60).toFixed(0);
	                var newhours1 = ('0' + newhours).slice(-2);
	                var newminutes = parseFloat(hours1%60);
	                var newminutes1 = ('0' + newminutes).slice(-2);
	                var normalHours = new Date("01/01/2017 " + (newhours1+":"+newminutes1+":00"));
	                 
	                $('#manPowerAssignedGridID').jqxGrid('setcellvalue', rowindexestemp, "hrs" ,normalHours);
	                $('#manPowerAssignedGridID').jqxGrid('setcellvalue', rowindexestemp, "actualhrs" ,hours1);
	                	
		                if(typeof(stdcost) != "undefined" && typeof(stdcost) != "NaN" && stdcost != ""){
		                	var total = (parseFloat(hours1)/parseFloat(60))*parseFloat(stdcost);
		                	$('#manPowerAssignedGridID').jqxGrid('setcellvalue', rowindexestemp, "total" ,total);
		                }
	          	    }
	          	}
				 
				 if(datafield=="stdcost"){
					 
					 var stdcost=$("#manPowerAssignedGridID").jqxGrid('getcelltext', rowindexestemp, "stdcost");
					 
					 if(typeof(stdcost) != "undefined" && typeof(stdcost) != "NaN" && stdcost != ""){
						 var actualhrs=$("#manPowerAssignedGridID").jqxGrid('getcelltext', rowindexestemp, "actualhrs");
						 if(typeof(actualhrs) != "undefined" && typeof(actualhrs) != "NaN" && actualhrs != ""){
							 var total = (parseFloat(actualhrs)/parseFloat(60))*parseFloat(stdcost);
			                 $('#manPowerAssignedGridID').jqxGrid('setcellvalue', rowindexestemp, "total" ,total);
						 }
						 
					 } else {
						 $('#manPowerAssignedGridID').jqxGrid('setcellvalue', rowindexestemp, "total" ,stdcost); 
					 }
				 }
            });
            
            $('#manPowerAssignedGridID').on('cellclick', function (event) { 
            	var datafield = event.args.datafield;
            	
            	if(datafield=="consumed"  ) {
            		var rowindex1=event.args.rowindex;
            		var date =$('#manPowerAssignedGridID').jqxGrid('getcelltext', rowindex1, "date");
            		var empdocno =$('#manPowerAssignedGridID').jqxGrid('getcellvalue', rowindex1, "empdocno");
            		var empid =$('#manPowerAssignedGridID').jqxGrid('getcellvalue', rowindex1, "empid");
            		var empname =$('#manPowerAssignedGridID').jqxGrid('getcellvalue', rowindex1, "empname");
            		$("#assignedDetailsWindow").jqxWindow('setTitle', empid+" - "+empname);
            		assignedDetailsContent('manPowerAssignedOnDate.jsp?date='+date+'&empdocno='+empdocno);
      		    }
	            	
	    });
            
        });
    
</script>
<div id="manPowerAssignedGridID"></div>
<input type="hidden" id="rowindex"/> 
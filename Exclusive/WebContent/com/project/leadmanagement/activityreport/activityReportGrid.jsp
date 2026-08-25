<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.project.leadmanagement.activityreport.ClsActivityReportDAO"%> 
<% ClsActivityReportDAO DAO=new ClsActivityReportDAO(); %> 
<% String docNo = request.getParameter("txtactivitydocno2")==null?"0":request.getParameter("txtactivitydocno2");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<script type="text/javascript">
 		var data2;
    
        $(document).ready(function () { 	
             
        	var temp='<%=docNo%>';
            
            if(temp>0){     
           	 data2='<%=DAO.activityGridReloading(session,docNo,check)%>';      
          	 }
            
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
							{name : 'intime', type: 'date'  }, 
							{name : 'outtime', type: 'date'  }, 
 							{name : 'hrs', type: 'date'  },
 							{name : 'clnew', type: 'bool' },
							{name : 'client', type: 'String'  },
							{name : 'jobtype', type: 'String'  },
							{name : 'jobno', type: 'String'  },
							{name : 'notes', type: 'String'  },
							{name : 'followupdate', type: 'date'  }, 
							{name : 'followupnotes', type: 'String'  },
     					    {name : 'actualhrs', type: 'String'  },
     					    {name : 'cldocno', type: 'String'  }
     						
                 ],
                 localdata: data2,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
 
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['AMC', 'SJOB','QOT', 'Other'];
            
            $("#activityReportGridID").jqxGrid(
            {
                width: '99.5%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlecell',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable: true,
             	localization: {thousandsSeparator: ""},
             	
				handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#activityReportGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'client') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {   
                        	if ($('#activityReportGridID').jqxGrid('getcellvalue', cell1.rowindex, "clnew")!=true) {
                        		document.getElementById("rowindex").value = cell1.rowindex;
                        		clientSearchContent('clientDetailsSearch.jsp');
					         }
                        }
                    } 
                    
                    var cell2 = $('#activityReportGridID').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'jobno') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {   
                        	var jobtype=$('#activityReportGridID').jqxGrid('getcellvalue', cell2.rowindex, "jobtype");
                        	var cldocno=$('#activityReportGridID').jqxGrid('getcellvalue', cell2.rowindex, "cldocno");
                  		    if(typeof(jobtype) != "undefined" && typeof(jobtype) != "NaN" && jobtype != "" && jobtype != "0" && jobtype != "Other"){
                  		    	if(typeof(cldocno) != "undefined" && typeof(cldocno) != "NaN" && cldocno != "" && cldocno != "0"){
	                  		    	document.getElementById("errormsg").innerText="";
	                         		document.getElementById("rowindex").value = cell2.rowindex;
	                         		jobSearchContent('jobDetailsSearch.jsp?dtype='+jobtype+'&cldocno='+cldocno);
                  		    	} else {
            				    	document.getElementById("errormsg").innerText="Client is Mandatory.";
            						return 0;
            				    }
        				    } else {
        				    	if(jobtype != "Other"){
        				    		document.getElementById("errormsg").innerText="Job type is Mandatory.";
        							return 0;
        				    	}
        				    }
                        }
                    } 
                    
                    var cell3 = $('#activityReportGridID').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'followupnotes') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {   
                        	var rows = $('#activityReportGridID').jqxGrid('getrows');
                        	var rowlength= rows.length;
                        	var rowindex1 = rowlength - 1;
                      	    var intime=$("#activityReportGridID").jqxGrid('getcellvalue', rowindex1, "intime");
                      	    if(typeof(intime) != "undefined"){
                            	$("#activityReportGridID").jqxGrid('addrow', null, {});
                      	    }
                        }
                    } 
				},
				
                columns: [
							{ text: 'From', datafield: 'intime', cellsformat: 'HH:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'To', datafield: 'outtime', cellsformat: 'HH:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},							
							{ text: 'Hours', datafield: 'hrs', cellsformat: 'HH:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: false,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'New', datafield: 'clnew', columntype: 'checkbox', editable: true, checked: true, width: '3%',cellsalign: 'center', align: 'center',
								cellendedit: function (row) {
							        if ($('#activityReportGridID').jqxGrid('getcellvalue', row, "clnew")==true)
							         {
							        	$('#activityReportGridID').jqxGrid('setcellvalue', row, "cldocno",'');
					       			    $('#activityReportGridID').jqxGrid('setcellvalue', row, "client",'');
							         }}
								
							},
							{ text: 'Client', datafield: 'client', width: '20%',
								cellbeginedit: function (row) {
									var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
							        if ($('#activityReportGridID').jqxGrid('getcellvalue', row, "clnew")!=true)
							         {
							              return false;
							         }
							        else {
							        	$('#activityReportGridID').jqxGrid('setcellvalue', row, "cldocno",'');
					       			    $('#activityReportGridID').jqxGrid('setcellvalue', row, "client",'');
							        }
							        }
								
							},
							{ text: 'Job Type', datafield: 'jobtype', width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                            { text: 'Job No', datafield: 'jobno', width: '10%',
								cellbeginedit: function (row) {
									var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
							        if ($('#activityReportGridID').jqxGrid('getcellvalue', row, "jobtype")!="Other")
							         {
							              return false;
							         }}
                            },
                            { text: 'Notes', datafield: 'notes', width: '15%' },
                            { text: 'Follow Up', datafield: 'followupdate', cellsformat: 'dd.MM.yyyy' ,columntype: 'datetimeinput', width: '9%' },	
                            { text: 'Follow Up Notes', datafield: 'followupnotes', width: '15%' },
							{ text: 'Actual Hrs', datafield: 'actualhrs',hidden: true, width: '10%' },
							{ text: 'Cldocno', datafield: 'cldocno',hidden: true, width: '10%' },
		
	              ]
            });
             
            $("#overlay, #PleaseWait").hide();
            
            if(temp>0){
            	$("#activityReportGridID").jqxGrid('disabled', true);
            }
            
            $('#activityReportGridID').on('celldoubleclick', function (event) {
             	  if(event.args.columnindex == 4) {
             		    var rowindextemp = event.args.rowindex;
             			if ($('#activityReportGridID').jqxGrid('getcellvalue', rowindextemp, "clnew")!=true) {
                    		document.getElementById("rowindex").value = rowindextemp;
                    		clientSearchContent('clientDetailsSearch.jsp');
				         }
             	  }
             	  
             	 if(event.args.columnindex == 6) {
          		    var rowindextemp = event.args.rowindex;
          		    var jobtype=$('#activityReportGridID').jqxGrid('getcellvalue', rowindextemp, "jobtype");
          		    var cldocno=$('#activityReportGridID').jqxGrid('getcellvalue', rowindextemp, "cldocno");
          		    if(typeof(jobtype) != "undefined" && typeof(jobtype) != "NaN" && jobtype != "" && jobtype != "0" && jobtype != "Other"){
          		    	if(typeof(cldocno) != "undefined" && typeof(cldocno) != "NaN" && cldocno != "" && cldocno != "0"){
	          		    	document.getElementById("errormsg").innerText="";
	                 		document.getElementById("rowindex").value = rowindextemp;
	                 		jobSearchContent('jobDetailsSearch.jsp?dtype='+jobtype+'&cldocno='+cldocno);
          		    	} else {
    				    	document.getElementById("errormsg").innerText="Client is Mandatory.";
    						return 0;
    				    }
				    } else {
				    	if(jobtype != "Other"){
				    		document.getElementById("errormsg").innerText="Job type is Mandatory.";
							return 0;
				    	}
				    }
          	      }
            });
            
            $("#activityReportGridID").on("cellclick", function (event) {
            	var datafield = event.args.datafield;
            	var rowindextemp = event.args.rowindex;   
            	
            	if(datafield=="clnew"){
	       	    	 if ($('#activityReportGridID').jqxGrid('getcellvalue', rowindextemp, "clnew")==true) {
	       	    		 $('#activityReportGridID').jqxGrid('setcellvalue', rowindextemp, "cldocno",'');
	       			     $('#activityReportGridID').jqxGrid('setcellvalue', rowindextemp, "client",'');
	       	    	 }
       	        }
            });
            
            $("#activityReportGridID").on('cellvaluechanged', function (event) {
          	 	 var datafield = event.args.datafield;
        	     var rowindexestemp = event.args.rowindex;
        	     
        	     if(datafield=="clnew"){
	       	    	 if ($('#activityReportGridID').jqxGrid('getcellvalue', rowindextemp, "clnew")==true) {
	       	    		 $('#activityReportGridID').jqxGrid('setcellvalue', rowindextemp, "cldocno",'');
	       			     $('#activityReportGridID').jqxGrid('setcellvalue', rowindextemp, "client",'');
	       	    	 }
       	        }
        	     
        	     if(datafield=="intime" || datafield=="outtime"){
 	          		
 	          		var intime=$("#activityReportGridID").jqxGrid('getcelltext', rowindexestemp, "intime");
 	          		var outtime=$("#activityReportGridID").jqxGrid('getcelltext', rowindexestemp, "outtime");
 	          		
 	          		if((typeof(intime) != "undefined" && typeof(intime) != "NaN" && intime != "") && typeof(outtime) != "undefined" && typeof(outtime) != "NaN" && outtime != ""){
 	             
 	                var startDate = new Date($("#activityReportGridID").jqxGrid('getcellvalue', rowindexestemp, "intime"));
 	                var endDate   = new Date($("#activityReportGridID").jqxGrid('getcellvalue', rowindexestemp, "outtime"));
 	                
 	                if(Date.parse(endDate) < Date.parse(startDate)){
 	                	endDate = new Date(endDate.setDate(endDate.getDate() + 1));
 	                }
 	                
 	                var hours1 = (endDate.getTime() - startDate.getTime()) / (1000 * 60);
 	                var newhours = parseFloat(hours1/60).toFixed(0);
 	                var newhours1 = ('0' + newhours).slice(-2);
 	                var newminutes = parseFloat(hours1%60);
 	                var newminutes1 = ('0' + newminutes).slice(-2);
 	                var normalHours = new Date("01/01/2017 " + (newhours1+":"+newminutes1+":00"));
 	                 
 	                $('#activityReportGridID').jqxGrid('setcellvalue', rowindexestemp, "hrs" ,normalHours);
 	                $('#activityReportGridID').jqxGrid('setcellvalue', rowindexestemp, "actualhrs" ,hours1);
 	                	
 		                
 	          	    }
 	          	}
            });
});
    
</script>
<div id="activityReportGridID"></div>
<input type="hidden" id="rowindex"/> 
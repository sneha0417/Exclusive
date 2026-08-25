<%@page import="com.dashboard.humanresource.timesheetreview.ClsTimeSheetReviewDAO"%>
<%ClsTimeSheetReviewDAO DAO= new ClsTimeSheetReviewDAO(); %>
<% String contextPath=request.getContextPath();%>
<%   String year = request.getParameter("year")==null?"0":request.getParameter("year").trim();
     String month = request.getParameter("month")==null?"0":request.getParameter("month").trim();
     String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
     String employee = request.getParameter("employee")==null?"0":request.getParameter("employee").trim();
     String projecttype = request.getParameter("projecttype")==null?"0":request.getParameter("projecttype").trim();
     String projectid = request.getParameter("projectid")==null?"0":request.getParameter("projectid").trim();
     String orderbydate = request.getParameter("orderbydate")==null?"0":request.getParameter("orderbydate").trim();
     String orderbyemployee = request.getParameter("orderbyemployee")==null?"0":request.getParameter("orderbyemployee").trim();
     String orderbycosttype = request.getParameter("orderbycosttype")==null?"0":request.getParameter("orderbycosttype").trim();
     String orderbycostid = request.getParameter("orderbycostid")==null?"0":request.getParameter("orderbycostid").trim();
     String rptType = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype");
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 
<style type="text/css">
        .editClass
        {
            
        }
        .saveClass
        {
            background-color: #F1F1F1;
            color: #000;
            font-weight: bold;
        }
        .deleteClass
        {
           color: #ECECEC; 
        }
        .addClass
        {
            background-color: #FFEBEB;
            font-weight: bold;
        }
        .leaveClass
        {
            background-color: #F1C0C0;
            font-weight: bold;
        }
        .holidayClass
        {
            background-color: #E4D9E6;
            font-weight: bold;
        }
        .whiteClass
        {
           
        }
</style>
<script type="text/javascript">
        var data;
        var tsexceldata;
        var temp1='<%=check%>';
        
        if(temp1=='1'){
        	data='<%=DAO.timeSheetReviewGridLoading(year,month,date,category,employee,projecttype,projectid,orderbydate,orderbyemployee,orderbycosttype,orderbycostid,rptType,check)%>';
        	tsexceldata='<%=DAO.timeSheetReviewExcelData(year,month,date,category,employee,projecttype,projectid,orderbydate,orderbyemployee,orderbycosttype,orderbycostid,rptType,check)%>';
        }
        
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
					{name : 'intime', type: 'date'    },
					{name : 'outtime', type: 'date'    },
					{name : 'costcode', type: 'number'    },
					{name : 'hrs', type: 'string'  },
				    {name : 'actualhrs', type: 'string'  }, 
				    {name : 'othrs', type: 'string'  }, 
				    {name : 'hothrs', type: 'string'  },
				    {name : 'normalhrs', type: 'date'  },
				    {name : 'actualnormalhrs', type: 'string'  },
				    {name : 'overtimehrs', type: 'date'  }, 
				    {name : 'holidayovertimehrs', type: 'date'  },
				    {name : 'confirm', type: 'int'  },
				    {name : 'editbtn', type: 'String'  },
				    {name : 'delete', type: 'image'  },
				    {name : 'rowno', type: 'int'  },
				    {name : 'confirmed', type: 'int'  },
				    {name : 'empdocno', type: 'String'  }
	            ],
                localdata: data,
        	
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	$("#timeSheetReviewGridID").on("bindingcomplete", function (event) {
        		if(document.getElementById("rddetailed").checked==true){
        			$('#timeSheetReviewGridID').jqxGrid({ selectionmode: 'singlecell'}); 
        			$('#timeSheetReviewGridID').jqxGrid({ editable: true}); 
        			$('#timeSheetReviewGridID').jqxGrid('showcolumn', 'actualnormalhrs');
        			$('#timeSheetReviewGridID').jqxGrid('showcolumn', 'normalhrs');
	        		$('#timeSheetReviewGridID').jqxGrid('showcolumn', 'overtimehrs');
	        		$('#timeSheetReviewGridID').jqxGrid('showcolumn', 'intime');
	        		$('#timeSheetReviewGridID').jqxGrid('showcolumn', 'outtime');
	        		
	        		$('#timeSheetReviewGridID').jqxGrid('showcolumn', 'holidayovertimehrs');
	        		$('#timeSheetReviewGridID').jqxGrid('showcolumn', 'editbtn');
	        		$('#timeSheetReviewGridID').jqxGrid('showcolumn', 'delete');
	        		$('#timeSheetReviewGridID').jqxGrid('showcolumn', 'costgroup');
	        		$('#timeSheetReviewGridID').jqxGrid('showcolumn', 'costcodename');
	        		$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'actualhrs');
	        		$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'hrs');
	        		$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'othrs');
	        		$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'hothrs');
        		} else {
        			$('#timeSheetReviewGridID').jqxGrid({ selectionmode: 'singlerow'});
        			$('#timeSheetReviewGridID').jqxGrid({ editable: false}); 
        			$('#timeSheetReviewGridID').jqxGrid('showcolumn', 'actualhrs');
        			$("#timeSheetReviewGridID").jqxGrid('showcolumn', 'hrs');
        			$("#timeSheetReviewGridID").jqxGrid('showcolumn', 'othrs');
        			$("#timeSheetReviewGridID").jqxGrid('showcolumn', 'hothrs');
        			$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'costgroup');
	        		$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'costcodename');
        			$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'normalhrs');
        			$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'actualnormalhrs');
	        		$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'overtimehrs');
	        		$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'holidayovertimehrs');
	        		$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'editbtn');
	        		$('#timeSheetReviewGridID').jqxGrid('hidecolumn', 'delete');
        		}
        	});
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.editbtn == 'EDIT') {
        			if($('#mode').val()=='D'){
                		return "deleteClass";
                	} else {
                    	return "editClass";
                	}
                } else if (data.editbtn == 'SAVE') {
                    return "saveClass";
                } else if (data.confirm == 0) {
                	if(data.empname.includes("Leave")==true){
                		return "leaveClass";
                	} else if(data.empname.includes("Holiday")==true){
                		return "holidayClass";
                	} else {
                    	return "editClass";
                	}
                } else if (data.confirm == 1) {
                    	return "addClass";
                } else if (data.editbtn == 'ADD') {
                	if(data.empname.includes("Leave")==true){
                		return "leaveClass";
                	} else if(data.empname.includes("Holiday")==true){
                		return "holidayClass";
                	} else {
                    	return "addClass";
                	}
                }  
                else{
                	
                		return "whiteClass";
                };
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#timeSheetReviewGridID").jqxGrid(
            {
                width: '98%',
                height: 530,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                columnsresize: true,
                showaggregates: true,
             	
				handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#timeSheetReviewGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'empid') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {
                        	if(document.getElementById("rddetailed").checked==true && $('#mode').val()=='E'){
                        		$('#rowindex').val(cell1.rowindex);$('#txtorgridclick').val('2');
                        		employeeSearchContent("employeeDetailsSearch.jsp");
                        	}
                        }
                    } 
                    
                    var cell2 = $('#timeSheetReviewGridID').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    if (key == 114) {  
                    	if(document.getElementById("rddetailed").checked==true && $('#mode').val()=='E'){
	                    	 $('#rowindex').val(cell2.rowindex);
	                    	 $('#txtorgridclick').val('2');
	                    	 costTypeSearchContent("costTypeSearchGrid.jsp");
	                    	 $('#timeSheetReviewGridID').jqxGrid('render');
                    	}
                      }
                	}
                    
                    var cell3 = $('#timeSheetReviewGridID').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcodename') {
	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
	                   if (key == 114) { 
	                	   if(document.getElementById("rddetailed").checked==true && $('#mode').val()=='E'){
		                	   var value=  $('#timeSheetReviewGridID').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
							   if(typeof(value) == "undefined" || typeof(value) == "NaN" || value == ""){
		       	   			 	$.messager.alert('Message','Project Type is Mandatory.','warning');
		       	   			 	return 0;
		       	   		       }
		                	   $('#rowindex').val(cell3.rowindex);
		                	   $('#txtorgridclick').val('2');
		                	   costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+value);
		                	   $('#timeSheetReviewGridID').jqxGrid('render');
	                	   }
	                   }
	               }
                },
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Date', datafield: 'date', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy',columntype: 'datetimeinput', width: '7%',
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								},
								cellbeginedit: function (row) {
									if(document.getElementById("rddetailed").checked==true && $('#mode').val()=='E'){
									if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='')
							         {
										  $.messager.alert('Message','Year and Month are Mandatory.','warning');
							              return false;
							         }}else {
							        	 return false;
							         }}	 
							},
							{ text: 'Emp. ID', datafield: 'empid', cellclassname: cellclassname, width: '7%', editable: false },
							{ text: 'Employee', datafield: 'empname', cellclassname: cellclassname, editable: false },
							{ text: 'Cost Type', datafield: 'costgroup', cellclassname: cellclassname, width: '7%', editable: false },
							{ text: 'Cost Id', datafield: 'costtype', cellclassname: cellclassname, width: '8%',hidden: true },
							{ text: 'Cost Id', datafield: 'costcodename', cellclassname: cellclassname, width: '13%',editable: false },
							{ text: 'Cost ID', datafield: 'costcode', cellclassname: cellclassname, width: '7%',editable: false,hidden: true },
							{ text: 'In Time', datafield: 'intime', cellclassname: cellclassname, width: '7%',hidden: true,cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput', 
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								},
								cellbeginedit: function (row) {
									if(document.getElementById("rddetailed").checked==true && $('#mode').val()=='E'){
									if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='')
							         {
										  $.messager.alert('Message','Year and Month are Mandatory.','warning');
							              return false;
							         }}else {
							        	 return false;
							         }}	
							},
							{ text: 'Out Time', datafield: 'outtime', cellclassname: cellclassname, width: '7%',hidden: true,cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput', 
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								},
								cellbeginedit: function (row) {
									if(document.getElementById("rddetailed").checked==true && $('#mode').val()=='E'){
									if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='')
							         { 
										  $.messager.alert('Message','Year and Month are Mandatory.','warning');
							              return false;
							         }}else {
							        	 return false;
							         }}	
							},
							{ text: 'Entered Hours', datafield: 'hrs', cellclassname: cellclassname, width: '7%', cellsalign: 'left',editable: false }, 
							{ text: 'Normal Hours', datafield: 'actualhrs', cellclassname: cellclassname,  width: '7%', cellsalign: 'left',editable: false },
							{ text: 'OT Hours', datafield: 'othrs', cellclassname: cellclassname,  width: '7%', cellsalign: 'left',editable: false }, 
							{ text: 'HOT Hours', datafield: 'hothrs', cellclassname: cellclassname,  width: '7%', cellsalign: 'left',editable: false },
							{ text: 'Entered Hours', datafield: 'normalhrs', cellclassname: cellclassname, cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: false
								/* createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								},
								cellbeginedit: function (row) {
									if(document.getElementById("rddetailed").checked==true && $('#mode').val()=='E'){
									if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='')
							         {
										  $.messager.alert('Message','Year and Month are Mandatory.','warning');
							              return false;
							         }}else {
							        	 return false;
							         }} */
							}, 
							{ text: 'Normal Hours', datafield: 'actualnormalhrs', cellclassname: cellclassname,  width: '7%', cellsalign: 'left',editable: false },
							{ text: 'OT Hours', datafield: 'overtimehrs', cellclassname: cellclassname, cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: false
								/* createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								},
								cellbeginedit: function (row) {
									if(document.getElementById("rddetailed").checked==true && $('#mode').val()=='E'){
									if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='')
							         {
										  $.messager.alert('Message','Year and Month are Mandatory.','warning');
							              return false;
							         }}else {
							        	 return false;
							         }}  */
							}, 
							{ text: 'HOT Hours', datafield: 'holidayovertimehrs', cellclassname: cellclassname, cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: false
								/* createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								},
								cellbeginedit: function (row) {
									if(document.getElementById("rddetailed").checked==true && $('#mode').val()=='E'){
									if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='')
							         {
										  $.messager.alert('Message','Year and Month are Mandatory.','warning');
							              return false;
							         }}else {
							        	 return false;
							         }} */ 
							},
							{ text: 'Confirm', datafield: 'confirm', cellclassname: cellclassname, width: '8%',cellsalign:'center',align:'center',aggregates: ['sum'] , hidden: true },
							{ text: ' ', datafield: 'editbtn',  cellclassname: cellclassname, width: '6%', columntype: 'button', editable:false, filterable: false , hidden:true },
			                { text: 'Delete', datafield: 'delete', cellclassname: cellclassname,  editable: false ,width: '4%', columntype: 'text', cellsalign: 'center', align: 'center', hidden:true ,
								cellsrenderer: function () {
			                      return '<div style="width: 100%"><img src="<%=contextPath%>/icons/delete_new.png" style="margin-left: 40%;margin-top: 5px" /></div>';
								}
			                },
			                { text: 'Row No', datafield: 'rowno', cellclassname: cellclassname, hidden: true, width: '6%' },
			                { text: 'Confirmed', datafield: 'confirmed', cellclassname: cellclassname,aggregates: ['sum'], hidden: true, width: '6%' },
							{ text: 'Emp. Docno', datafield: 'empdocno', cellclassname: cellclassname, hidden: true, width: '8%' },
					 		]
            });
            
            if(temp1=='NA'){
                $("#timeSheetReviewGridID").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
            var confirm1="",confirmed1="";
            var confirm=$('#timeSheetReviewGridID').jqxGrid('getcolumnaggregateddata', 'confirm', ['sum'], true);
            confirm1=confirm.sum;
            //alert(confirm1);
            var confirmed=$('#timeSheetReviewGridID').jqxGrid('getcolumnaggregateddata', 'confirmed', ['sum'], true);
            confirmed1=confirmed.sum;
            
            if(!isNaN(confirm1)){
            	$('#txtgridconfirm').val(confirm1);
      		  }
      		else{
		    	 $('#txtgridconfirm').val(0);
		    }
            
            if(!isNaN(confirmed1)){
            	$('#txtgridconfirmed').val(confirmed1);
      		  }
      		else{
		    	 $('#txtgridconfirmed').val(0);
		    }
            
            $("#timeSheetReviewGridID").on('cellvaluechanged', function (event) {
            	
            	if(document.getElementById("rddetailed").checked==true && $('#mode').val()=='E'){
	           	     var datafield = event.args.datafield;
	         	     var rowindexestemp = event.args.rowindex;
	         	     $('#rowindex').val(rowindexestemp);
	         	   
	         	    if(datafield=="date"){
	         	    	var date = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowindexestemp, "date");
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
		      			$('#timeSheetReviewGridID').jqxGrid('setcellvalue', rowindexestemp, "costcodename" ,'');
		      			$('#timeSheetReviewGridID').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
		  			 }
		          	 
		          	if(datafield=="intime" || datafield=="outtime"){
		          		
		          		var intime=$("#timeSheetReviewGridID").jqxGrid('getcelltext', rowindexestemp, "intime");
		          		var outtime=$("#timeSheetReviewGridID").jqxGrid('getcelltext', rowindexestemp, "outtime");
		          		
		          		if((typeof(intime) != "undefined" && typeof(intime) != "NaN" && intime != "") && typeof(outtime) != "undefined" && typeof(outtime) != "NaN" && outtime != ""){
		             
		                var startDate = new Date($("#timeSheetReviewGridID").jqxGrid('getcellvalue', rowindexestemp, "intime"));
		                var endDate   = new Date($("#timeSheetReviewGridID").jqxGrid('getcellvalue', rowindexestemp, "outtime"));
		                
		                
		                
		                if(Date.parse(endDate) < Date.parse(startDate)){
		                	//endDate = new Date(endDate.setDate(endDate.getDate() + 1));
		                	$.messager.alert('Message','Out time should be greater than in time','warning');
		                	$('#timeSheetReviewGridID').jqxGrid('setcellvalue', rowindexestemp, "outtime" ,"");
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
		                 
		                $('#timeSheetReviewGridID').jqxGrid('setcellvalue', rowindexestemp, "normalhrs" ,normalHours);
		                	
		          	    }
		          	}
            	}
            	
				
           });
            
            $('#timeSheetReviewGridID').on('celldoubleclick', function (event) {
        	     
            	/* if(document.getElementById("rddetailed").checked==true && $('#mode').val()=='E'){
            		
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
	  		           $('#timeSheetReviewGridID').jqxGrid('clearselection');
	  		           costTypeSearchContent("costTypeSearchGrid.jsp");
	  	            }
	  	    		  
	  	           if(event.args.columnindex == 6)
	  	            {
	  	        	    var rowindextemp = event.args.rowindex;
	  	        	    var value = $('#timeSheetReviewGridID').jqxGrid('getcellvalue', rowindextemp, "costtype");
	  	        	    if(typeof(value) == "undefined" || typeof(value) == "NaN" || value == ""){
	 	   			 	$.messager.alert('Message','Cost Type is Mandatory.','warning');
	 	   			 	return 0;
	 	   		       }
	  		           document.getElementById("rowindex").value = rowindextemp;
	  		           $('#txtorgridclick').val('2');
	  		           $('#timeSheetReviewGridID').jqxGrid('clearselection');
	  		           costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+value);
	  	            }
            	} */
  	           
            });
            
            $("#timeSheetReviewGridID").on('cellclick', function (event) {
       		 
          	  var datafield = event.args.datafield;
          	  var rowIndex = event.args.rowindex;
        			  
   			  if(datafield=="editbtn"){
   				  if($('#timeSheetReviewGridID').jqxGrid('getcellvalue',rowIndex, "editbtn")=='SAVE'){
   					 
   					 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
   				        
   				     	if(r==false)
   				     	  {
   				     		return false; 
   				     	  }
   				     	else{
   				     		
   				     		 var date = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "date");
   				     		 var empdocno = $('#timeSheetReviewGridID').jqxGrid('getcellvalue', rowIndex, "empdocno");
   				     		 var costtype = $('#timeSheetReviewGridID').jqxGrid('getcellvalue', rowIndex, "costtype");
   				     		 var costcode = $('#timeSheetReviewGridID').jqxGrid('getcellvalue', rowIndex, "costcode");
   				     		 var normalhrs = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "normalhrs");
   				     		 var overtimehrs = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "overtimehrs");
   				     		 var holidayovertimehrs = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "holidayovertimehrs");
   				     		 var intime = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "intime");
   				     		 var outtime = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "outtime");
   				     		 
   				     		 
   				     		 
   				     		 var rowno = $('#timeSheetReviewGridID').jqxGrid('getcellvalue', rowIndex, "rowno");
   				     		 var mode = $('#mode').val();
   				     		 
   				     		 $("#overlay, #PleaseWait").show();
   				     		 
   				     		 saveGridData(date,empdocno,costtype,costcode,normalhrs,overtimehrs,holidayovertimehrs,rowno,intime,outtime,mode);	
   				     	}
   				 	});
   					 
   				  } else {
   					if($('#timeSheetReviewGridID').jqxGrid('getcellvalue',rowIndex, "confirmed")=='1'){
   						$.messager.alert('Message','Already Confirmed,Edit Restricted.','warning');
   					 	return 0;
   					}
   					$('#mode').val('E');$('#timeSheetReviewGridID').jqxGrid('setcellvalue',rowIndex, "editbtn","SAVE");
   					
   				  }
   			  }
   			  
   			  if(datafield=="delete"){
   				if($('#timeSheetReviewGridID').jqxGrid('getcellvalue',rowIndex, "confirmed")=='1'){
					$.messager.alert('Message','Already Confirmed,Delete Restricted.','warning');
					return 0;
				}
   				
   				$.messager.confirm('Confirm', 'Do you want to delete?', function(r){
   					if (r){
   						 $('#mode').val('D');
   						
   						var date = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "date");
				     		 var empdocno = $('#timeSheetReviewGridID').jqxGrid('getcellvalue', rowIndex, "empdocno");
				     		 var costtype = $('#timeSheetReviewGridID').jqxGrid('getcellvalue', rowIndex, "costtype");
				     		 var costcode = $('#timeSheetReviewGridID').jqxGrid('getcellvalue', rowIndex, "costcode");
				     		 var normalhrs = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "normalhrs");
				     		 var overtimehrs = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "overtimehrs");
				     		 var holidayovertimehrs = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "holidayovertimehrs");
				     		 var intime = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "intime");
				     		 var outtime = $('#timeSheetReviewGridID').jqxGrid('getcelltext', rowIndex, "outtime");
				     		 var rowno = $('#timeSheetReviewGridID').jqxGrid('getcellvalue', rowIndex, "rowno");
			     		     var mode = $('#mode').val();
			     		 
			     		 $("#overlay, #PleaseWait").show();
			     		 
			     		saveGridData(date,empdocno,costtype,costcode,normalhrs,overtimehrs,holidayovertimehrs,rowno,intime,outtime,mode);	
   					}
   				});
   			  }
          		   
          }); 
  });
                       
</script>

<div id="timeSheetReviewGridID"></div>
<input type="hidden" id="rowindex"/> 
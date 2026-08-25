<%@page import="com.dashboard.humanresource.timesheet.ClsTimeSheetDAO"%>
<%ClsTimeSheetDAO DAO= new ClsTimeSheetDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String fillfromdate = request.getParameter("fillfromdate")==null?"0":request.getParameter("fillfromdate");
 String filltodate = request.getParameter("filltodate")==null?"0":request.getParameter("filltodate");
 String daysselected = request.getParameter("daysselected")==null?"0":request.getParameter("daysselected");
 String selectedempdocnos = request.getParameter("selectedempdocnos")==null?"0":request.getParameter("selectedempdocnos");
 String selectedcosttypename = request.getParameter("selectedcosttypename")==null?"0":request.getParameter("selectedcosttypename");
 String selectedcosttypeid = request.getParameter("selectedcosttypeid")==null?"0":request.getParameter("selectedcosttypeid");
 String selectedcostid = request.getParameter("selectedcostid")==null?"0":request.getParameter("selectedcostid");
 String selectedcostiddocno = request.getParameter("selectedcostiddocno")==null?"0":request.getParameter("selectedcostiddocno");
 String fillintime = request.getParameter("fillintime")==null?"0":request.getParameter("fillintime");
 String fillouttime = request.getParameter("fillouttime")==null?"0":request.getParameter("fillouttime");
 String fillnormalhrs = request.getParameter("fillnormalhrs")==null?"0":request.getParameter("fillnormalhrs");
 String fillothrs = request.getParameter("fillothrs")==null?"0":request.getParameter("fillothrs");
 String fillhothrs = request.getParameter("fillhothrs")==null?"0":request.getParameter("fillhothrs");
 %>
<script type="text/javascript">
   
        $(document).ready(function () { 
        	
          var fillgriddata;
          var gridload='<%=gridload%>';
        	
          if(gridload=="1"){
        	  fillgriddata = '<%=DAO.timeSheetFillGridLoading(session,fillfromdate,filltodate,daysselected,selectedempdocnos,selectedcosttypename,selectedcosttypeid,selectedcostid,selectedcostiddocno,fillintime,fillouttime,fillnormalhrs,fillothrs,fillhothrs,gridload) %>'; 
          }
        	 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'date', type: 'date'  },
                          	{name : 'days', type: 'String'  },
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
                 			localdata: fillgriddata,
                
                
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
            $("#timeSheetFillSearchGridId").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                columnsresize: true,
                editable: false,
                selectionmode: 'checkbox',
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'Days',datafield:'days',width:'6%' },
							{ text: 'Emp. ID', datafield: 'empid', width: '8%' },
							{ text: 'Employee', datafield: 'empname' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '9%' },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true },
							{ text: 'Cost Id', datafield: 'costcodename', width: '13%' },
							{ text: 'Cost ID', datafield: 'costcode', width: '7%',hidden: true },
							{ text: 'In Time', datafield: 'intime', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'Out Time', datafield: 'outtime', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'Normal Hours', datafield: 'hrs', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',
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
            $("#overlay, #PleaseWait").hide();
           
        });
</script>
<div id="timeSheetFillSearchGridId"></div>
<%@ page import="com.dashboard.leadmanagement.executivediary.ClsExecutiveDiaryDAO" %>
<%  ClsExecutiveDiaryDAO DAO=new ClsExecutiveDiaryDAO();
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
	String activitystatus = request.getParameter("activitystatus")==null?"0":request.getParameter("activitystatus").trim();
	String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
	String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
	String check = request.getParameter("check")==null?"NA":request.getParameter("check").trim();
%>
 <script type="text/javascript">
 
 var data1;
 var leadexceldata;
 var temp='<%=check%>';
 
 	if(temp!='NA'){ 
 		data1='<%=DAO.executiveDiaryGridLoading(session,fromdate,todate,activitystatus,chkfollowup,followupdate,check)%>';
 		leadexceldata='<%=DAO.executiveDiaryExcelExport(session,fromdate,todate,activitystatus,chkfollowup,followupdate,check)%>';
    } else {
 		data1;
 		leadexceldata;
 	}
    
 	$(document).ready(function () { 
 		
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                       
							 {name : 'doc_no', type: 'string'   },	
							 {name : 'highlight', type: 'string'  },
                   			 {name : 'fromstatus', type: 'string'  },
                   			 {name : 'intime', type: 'string'    },
                   			 {name : 'outtime', type: 'string'    },
                   			 {name : 'hrs', type: 'string'    },
                   			 {name : 'clnew', type: 'bool'    },
                   			 {name : 'cldocno', type: 'string'    },
                   			 {name : 'client', type: 'string'    },
                   			 {name : 'jobtype', type: 'string'    },
                   			 {name : 'jobno', type: 'string'    },
                   			 {name : 'notes', type: 'string'    },
                   			 {name : 'followupdate', type: 'date'    },
                   			 {name : 'followupnotes', type: 'string' }
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#executiveGridID").jqxGrid(
            {
                width: '98%',
                height: 500,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
                          	{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
							    }  
							  },
						      { text: 'Doc No', datafield: 'doc_no', width: '6%' }, 
							  { text: 'Highlight', datafield: 'highlight', width: '16%' },  
						      { text: 'Status', datafield: 'fromstatus', width: '10%' },
						      { text: 'From', datafield: 'intime', width: '5%' },
							  { text: 'To', datafield: 'outtime', width: '5%' },
							  { text: 'Hours', datafield: 'hrs', width: '5%' },
							  { text: 'New', datafield: 'clnew', width: '7%', columntype: 'checkbox', checked: true, width: '3%',cellsalign: 'center', align: 'center' },
							  { text: 'Cldocno', datafield: 'cldocno', width: '12%',hidden: true },
							  { text: 'Client', datafield: 'client', width: '12%' },
							  { text: 'Job Type', datafield: 'jobtype', width: '6%' },
							  { text: 'Job No', datafield: 'jobno', width: '8%' },
							  { text: 'Notes', datafield: 'notes', width: '15%' },
							  { text: 'Follow Up Date', datafield: 'followupdate', width: '12%',cellsformat:'dd.MM.yyyy' },
							  { text: 'Follow Up Notes', datafield: 'followupnotes', width: '15%' }					
	              ]
            });
            $("#overlay, #PleaseWait").hide();
            
        });

</script>
<div id="executiveGridID"></div>

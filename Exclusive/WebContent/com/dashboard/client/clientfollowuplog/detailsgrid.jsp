<%@ page import="com.dashboard.client.clientfollowuplog.ClsClientFollowupLogDAO" %>
	
<%
 String userid = request.getParameter("userid")==null?"NN":request.getParameter("userid").trim();
String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
String cldocno = request.getParameter("cldoc")==null?"0":request.getParameter("cldoc").trim();

ClsClientFollowupLogDAO cfld=new ClsClientFollowupLogDAO();
%>
 <script type="text/javascript">
 
 var data1;
 var clientexceldata;
 var temp='<%=userid%>';
 
 	if(temp!='NN'){ 
 		
 		data1='<%=cfld.masterdetails(userid,fromdate,todate,cldocno,check)%>';
 		clientexceldata='<%=cfld.masterdetailsexcel(userid,fromdate,todate,cldocno,check)%>';
 		//alert(clientexceldata);
        }
 	else
 	{
 		
 		data1;
 		clientexceldata;
 		//alert(clientexceldata);
 	}
    
 	$(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                       
										{name : 'date', type: 'date'   },	
										{name : 'acno', type: 'string'  },
                   						{name : 'clientnme', type: 'string'  },
                   						{name : 'mobno', type: 'string'    },
                   						{name : 'comnt', type: 'string'    },
                   						{name : 'folupdate', type: 'date'    },
                   						{name : 'process', type: 'string'    },
                   						{name : 'branchname', type: 'string'    },
                   						
                   						
                   						
                   				//	 t.postdocno
                   						
                   					// rano dtypedesc
                   						
                   						
     						
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
            
            $("#jqxFleetGrid").jqxGrid(
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
							  
							  { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' },
							  { text: 'Acc No', datafield: 'acno', width: '6%' }, 
								{ text: 'Client Name', datafield: 'clientnme', width: '20%' },  
							  { text: 'Mob No', datafield: 'mobno', width: '8%' },
								{ text: 'Comments', datafield: 'comnt', width: '30%' },
								  { text: 'Followup Date', datafield: 'folupdate', width: '8%',cellsformat:'dd.MM.yyyy' },
								  { text: 'Process', datafield: 'process', width: '7%' },
								  { text: 'Branch', datafield: 'branchname', width: '12%' },
														
	              ]
            });
            $("#overlay, #PleaseWait").hide();
        	
            
        });
    </script>
    <div id="jqxFleetGrid"></div>



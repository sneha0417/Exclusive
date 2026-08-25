<%@page import="com.dashboard.analysis.callregisteranalysis.ClscallregisterAnalysisDAO"%>
<%
ClscallregisterAnalysisDAO cab=new ClscallregisterAnalysisDAO();
%>
<% String docno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String brchid =request.getParameter("brhid")==null?"0":request.getParameter("brhid").toString();
%>
<script type="text/javascript">
var data1;
<%-- var docno='<%=docno%>'; --%>
// alert(docno);
<%-- var brchid='<%=brchid%>'; --%>
// alert(brchid);
        $(document).ready(function () { 
        	 data1 ='<%=cab.loadSubGridData(docno,brchid) %>';
         var source = 
            {
                datatype: "json",
                datafields: [   
							{name : 'srno', type: 'number' },
                 			{name : 'empgroupid', type: 'String' },
     						{name : 'empid', type: 'String'},
     						{name : 'assignstatus', type: 'String'},
     						{name : 'entrydate' , type : 'date'},
     						{name : 'description', type: 'String'},
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#assignSubGridDetails").jqxGrid({ 
            	width: '99.5%',
                height: 400,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
               
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
							{ text: 'Assign Group', datafield: 'empgroupid', width: '10%'},
							{ text: 'Group Member', datafield: 'empid', width: '30%' },
							{ text: 'Assign Mode', datafield: 'asgnMode', width: '10%',hidden:true },
							{ text: 'Status', datafield: 'assignstatus', width: '17%'},	
							{ text: 'Entry Date & Time', datafield: 'entrydate', width: '17%',cellsformat:'dd.MM.yyyy HH:mm' },
							{ text: 'Description', datafield: 'description', width: '22%' },
					]
            });
         
           
        });
                       
</script>
<div id="assignSubGridDetails"></div>
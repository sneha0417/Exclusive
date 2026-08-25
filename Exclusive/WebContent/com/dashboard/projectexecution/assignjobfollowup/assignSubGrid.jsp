<%@page import="com.dashboard.projectexecution.assignjobfollowup.AssignJobFollowupDAO"%>
<%AssignJobFollowupDAO sd= new AssignJobFollowupDAO(); %>

<% String docno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String brchid =request.getParameter("brchid")==null?"0":request.getParameter("brchid").toString();
%>
 
 <script type="text/javascript">
 
 var data1 ='<%=sd.loadSubGridData(docno,brchid) %>';
        $(document).ready(function () { 

         var source = 
            {
                datatype: "json",
                datafields: [   
							{name : 'srno', type: 'number' },
                 			{name : 'empgroupid', type: 'String' },
     						{name : 'empid', type: 'String'},
     						{name : 'asgnmode', type: 'String'},
     						{name : 'plannedon' , type : 'date'},
     						{name : 'pltime', type: 'String'},
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
                height: 130,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
               
                columns: [
							{ text: 'Sl No.', datafield: 'srno', width: '4%'},
							{ text: 'Assign Group', datafield: 'empgroupid', width: '10%'},
							{ text: 'Group Member', datafield: 'empid', width: '10%' },
							{ text: 'Assign Method', datafield: 'asgnmode', width: '10%'},	
							{ text: 'Planned Date', datafield: 'plannedon', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Planned Time', datafield: 'pltime', width: '10%' },
							{ text: 'Description', datafield: 'description', width: '46%' },
					]
            });
         
           
        });
                       
</script>
<div id="assignSubGridDetails"></div>
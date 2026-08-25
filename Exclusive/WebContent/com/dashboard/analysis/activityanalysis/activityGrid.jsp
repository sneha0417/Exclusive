<%@page import="com.dashboard.analysis.activityanalysis.ClsActivityAnalysisDAO" %>
<% ClsActivityAnalysisDAO aa=new ClsActivityAnalysisDAO(); %>
<% String id =request.getParameter("test")==null?"0":request.getParameter("test").toString();
 String userid =request.getParameter("user")==null?"0":request.getParameter("user").toString();  %>
 
<script type="text/javascript">
 var data3;
  var check='<%= id%>';
  var userid='<%= userid%>';
 
  if(parseInt(check)==1){
	  data3= '<%= aa.loadGridData(userid,id)%>';
	  activityexcel= '<%= aa.loadGridExcel(userid,id)%>';
 } 
 else{
	 data3;
 }
 $(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'username', type: 'String'  },
     						{name : 'highlight', type: 'String' },
     						{name : 'fromstatus', type: 'String' },
     						{name : 'intime', type: 'String' },
     						{name : 'outtime', type: 'String' },
     						{name : 'hrs', type: 'String' },
     						{name : 'clnew', type: 'bool' },
     						{name : 'cldocno', type: 'String' },
     						{name : 'client',type:'String' },
     						{name : 'jobtype', type: 'String' },
     						{name : 'jobno', type: 'String' },
     						{name : 'notes', type: 'String' },
     						{name : 'followupdate', type: 'date' },
     						{name : 'followupnotes', type: 'String' },
     			],
                 localdata: data3,
                
                
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
            $("#activitygrid").jqxGrid(
            {
                width: '99%',
                height: 514,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '5%' },
					{ text: 'Highlight',  datafield: 'highlight', width: '15%' },
					{ text: 'User Name',  datafield: 'username', width: '10%' },
					{ text: 'Status', datafield: 'fromstatus', width: '10%',hidden: true },
					{ text: 'From', datafield: 'intime', width: '5%' },
					{ text: 'To',datafield:'outtime',width:'5%'},
					{ text: 'Hrs', datafield: 'hrs', width: '5%' },
			 		{ text: 'New', datafield: 'clnew', columntype: 'checkbox', checked: true, width: '3%',cellsalign: 'center', align: 'center' },
					{ text: 'Cldocno', datafield: 'cldocno', width: '6%',hidden: true },
					{ text: 'Client', datafield: 'client', width: '15%' },
					{ text: 'Job Type', datafield: 'jobtype', width: '7%' },
					{ text: 'Job No', datafield: 'jobno', width: '7%' },
					{ text: 'Notes',  datafield: 'notes', width: '9%' },
					{ text: 'Follow Up Date',  datafield: 'followupdate', width: '9%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Follow Up Notes ',  datafield: 'followupnotes', width: '15%' },
				   ]
            });
         if(check!=1){
            $("#activitygrid").jqxGrid('addrow', null, {});
            }
         
         $("#overlay, #PleaseWait").hide();
     });
    </script>
    <div id="activitygrid"></div>

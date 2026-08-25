<%@page import="com.dashboard.projectexecution.legalcontractfollowup.legalContractFollowupDAO"%>
<%legalContractFollowupDAO sd= new legalContractFollowupDAO(); %>

<% String trno =request.getParameter("trno")==null?"0":request.getParameter("trno").toString();%>
 
 <script type="text/javascript">
 
 var data1 ='<%=sd.loadSubGridData(trno) %>';
        $(document).ready(function () { 

         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'detdate', type: 'date' },
     						{name : 'user', type: 'String'},
     						{name : 'remk', type: 'String'},
     						{name : 'fdate' , type : 'date'}
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
         
            $("#followUpDetailsGrid").jqxGrid({ 
            	width: '99%',
                height: 120,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					
                columns: [
							{ text: 'Date', datafield: 'detdate', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'User', datafield: 'user', width: '18%' },
							{ text: 'Follow-Up Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy'},	
							{ text: 'Remarks', datafield: 'remk', width: '62%' },
					]
            });
         
           
        });
                       
</script>
<div id="followUpDetailsGrid"></div>
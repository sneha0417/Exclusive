<%@page import="com.dashboard.client.paymentfollowup.ClsPaymentFollowUpDAO" %>
<% ClsPaymentFollowUpDAO cpfd=new ClsPaymentFollowUpDAO(); %>



<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
 <script type="text/javascript">
 
 var data1 ='<%=cpfd.paymentFollowUpDetailGrid(cldocno,check)%>';
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
            	width: '98%',
                height: 102,
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
         
            $("#followUpDetailsGrid").jqxGrid("addrow", null, {}); 
        });
                       
</script>
<div id="followUpDetailsGrid"></div>
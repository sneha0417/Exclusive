<%@ page import="com.dashboard.client.ClsClientDAO" %>
<% ClsClientDAO cld=new ClsClientDAO();%>


<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
   String srNo = request.getParameter("srno")==null?"0":request.getParameter("srno");
   String process = request.getParameter("document")==null?"0":request.getParameter("document");%>
 <script type="text/javascript">
 var datas  ='<%=cld.documentExpiryFollowUpGrid(cldocno, srNo, process)%>'; 

 $(document).ready(function (){ 
        
         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'detdate', type: 'date' },
     						{name : 'user', type: 'String'},
     						{name : 'fdate' , type : 'date'},
     						{name : 'remk', type: 'String'}
                          	],
                          	localdata: datas,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#documentDetailsGrid").jqxGrid({ 
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
							{ text: 'Remarks', datafield: 'remk', width: '62%' }
					]
            });
         
            $("#documentDetailsGrid").jqxGrid("addrow", null, {}); 
        });
                       
</script>
<div id="documentDetailsGrid"></div>
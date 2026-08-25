<%@ page import="com.dashboard.client.ClsClientDAO" %>
<% ClsClientDAO cld=new ClsClientDAO();%>

<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
   String rType = request.getParameter("rtype")==null?"0":request.getParameter("rtype");
   String aggNo = request.getParameter("aggno")==null?"0":request.getParameter("aggno");
   String cardNo = request.getParameter("cardno")==null?"0":request.getParameter("cardno");%>
 <script type="text/javascript">
 var datas  ='<%=cld.creditCardFollowUpDetailGrid(cldocno, rType, aggNo, cardNo)%>'; 

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
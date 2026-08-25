<%@ page import="com.dashboard.client.customercomplaint.ClsCustomerComplaintDAO" %>
<% ClsCustomerComplaintDAO DAO=new ClsCustomerComplaintDAO();%>


<% String rdocno = request.getParameter("rdocno")==null?"0":request.getParameter("rdocno");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
 
  <script type="text/javascript">
 
var data;

	
 var datas  ='<%=DAO.FollowUpGrid(rdocno,check)%>'; 

 $(document).ready(function (){ 
        
         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'detdate', type: 'date' },
     						{name : 'user', type: 'String'},
     						{name : 'fdate' , type : 'date'},
     						{name : 'remk', type: 'String'},
     					  
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
            	width: '99%',
                height: 225,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					
                columns: [
							{ text: 'Date', datafield: 'detdate', width: '15%',cellsformat:'dd.MM.yyyy'},
							{ text: 'User', datafield: 'user', width: '20%' },
							{ text: 'Follow-Up Date', datafield: 'fdate', width: '15%',cellsformat:'dd.MM.yyyy'},	
							{ text: 'Remarks', datafield: 'remk', width: '50%'  },
							
							]
            });
            
                 
        });
                       
</script>
<div id="documentDetailsGrid"></div>
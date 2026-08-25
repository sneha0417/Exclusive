<%@page import="com.dashboard.humanresource.documentexpiry.ClsDocumentExpiryDAO"%>
<%ClsDocumentExpiryDAO DAO= new ClsDocumentExpiryDAO(); %>
<% String empdocno = request.getParameter("empdocno")==null?"0":request.getParameter("empdocno");
   String document = request.getParameter("document")==null?"0":request.getParameter("document");
   String process = request.getParameter("processes")==null?"0":request.getParameter("processes");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");
   // System.out.println("processes = "+process);
   %>
 <script type="text/javascript">
 var datas  ='<%=DAO.documentExpiryFollowUpGrid(empdocno,document,process,check)%>'; 

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
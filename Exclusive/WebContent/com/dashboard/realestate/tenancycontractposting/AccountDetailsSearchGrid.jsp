   

  <%@page import=" com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO" %>
<%ClsTenancyContractPostingDAO DAO=new ClsTenancyContractPostingDAO();%>
 
 <%
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String mobile = request.getParameter("mobile")==null?"0":request.getParameter("mobile");
 String currency = "0";
 
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 

 
	var clientData='<%=DAO.accountsDetails(session, dtype,  accountno, accountname,  currency,  check)%>';
 	$(document).ready(function () { 
 	 

 		var source = 
         {
             datatype: "json",
             datafields: [
                           {name : 'doc_no', type: 'int'   },
  						   {name : 'account', type: 'string'   },
  						   {name : 'description', type: 'string'  },
  						   {name : 'currency', type: 'string'  },
  						   {name : 'mobile', type: 'string'  },
  						   {name : 'curid', type: 'int'  },
  						   {name : 'rate', type: 'string'  },
  						   {name : 'type', type: 'string'  }
                       	],
                       	localdata: clientData,
             
             pager: function (pagenum, pagesize, oldpagenum) {
                
             }
         };
         
         var dataAdapter = new $.jqx.dataAdapter(source,
         		 {
             		loadError: function (xhr, status, error) {
                  alert(error);    
                  }
           }		
         );
         $("#jqxAccountsTypeSearch").jqxGrid(
         {
             width: '100%',
             height: 303,
             source: dataAdapter,
             selectionmode: 'singlerow',
  			 editable: false,
  			 columnsresize: true,
  			 localization: {thousandsSeparator: ""},
  			
             columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '40%' },
						{ text: 'Account Name', datafield: 'description'  },
						{ text: 'Currency', datafield: 'currency', width: '10%' , hidden: true},
						{ text: 'Mobile', datafield: 'mobile', width: '15%', hidden: true },
						{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%' },
						{ text: 'Rate', hidden: true, datafield: 'rate', width: '5%' },
						{ text: 'Currency Type', hidden: true, datafield: 'type', width: '5%' },
				       ]
               });
        
    	   $('#jqxAccountsTypeSearch').on('rowdoubleclick', function (event) {
               var rowindex1 = event.args.rowindex; 
               var id='<%=dtype%>';
              
              
               if(id=="CA")
            	   {
            	   document.getElementById("cashacno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	               document.getElementById("cashaccid").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "account");
	           	   document.getElementById("caccname").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "description");
	           	   
	        	   document.getElementById("currs1").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "curid");
	        	   document.getElementById("ratess1").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "rate");
	           	   
            	   }
               else
            	   {
            	   document.getElementById("bankacno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	               document.getElementById("bankaccid").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "account");
	           	   document.getElementById("baccname").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "description");
	           	    
	        	   document.getElementById("currs2").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "curid");
	        	   document.getElementById("ratess2").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "rate");
	           	   
            	   
            	   
            	   
            	   }
            	  
	            
               
    	      $('#accountSearchwindow').jqxWindow('close'); 
           });  
				           
}); 
				       
                       
</script>
   
<div id="jqxAccountsTypeSearch"></div>
    
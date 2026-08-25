<%@page import="com.dashboard.realestate.deferredsalesincome.ClsDeferredSalesIncomeDAO" %>
<%
ClsDeferredSalesIncomeDAO DAO=new ClsDeferredSalesIncomeDAO();                                             
%>   
<%@page import="javax.servlet.http.HttpServletRequest" %> 
<%@page import="javax.servlet.http.HttpSession" %>   
 
<style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
	  
}   
</style>
 
  <script type="text/javascript">    
            $(document).ready(function ()   {
            	  var cdata= '<%=DAO.searchaccount()%>';      
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'description', type: 'string'  },
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxAccount").jqxInput({ source: dataAdapter, displayMember: "description", valueMember: "doc_no", items: 20 ,width: '100%', height: 18,placeHolder: "Enter Account Name"});
                $("#jqxAccount").on('select', function (event) {          
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {   
                                	  document.getElementById("hidacno").value=dataAdapter.records[i].doc_no;
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxAccount"  class="form-control"/>
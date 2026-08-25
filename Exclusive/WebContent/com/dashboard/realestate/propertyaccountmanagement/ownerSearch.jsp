<%@page import="com.dashboard.realestate.propertymanagement.ClsPropertyManagementDAO"%>
<% ClsPropertyManagementDAO DAO= new ClsPropertyManagementDAO(); %>                          
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
 
<style>  
#jqxInput{
	background-color:#fff;    
	height: 20px;    
	  
}   
</style>
 
  <script type="text/javascript"> 
            $(document).ready(function () {
            	  var odata= '<%=DAO.searchowner(session)%>';         
                  //alert("sdata"+cdata);  
               	    
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'owner', type: 'string'  },
                    ],
                    localdata: odata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxInputOwner").jqxInput({ source: dataAdapter, displayMember: "owner", valueMember: "doc_no", items: 20 ,width: 200, height: 20});
                $("#jqxInputOwner").on('select', function (event) {      
                	  if (event.args) {
                          var item = event.args.item;                
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {   
                                	  document.getElementById("hidownerid").value=dataAdapter.records[i].doc_no;
                                	  break;          
                                  }  
                              }
                          }
                      }   
                    }); 
            });   
        </script>   
         <input id="jqxInputOwner" />
<%@page import="com.dashboard.realestate.inspectionmanagement.ClsInspectionManagementDAO"%>
<%ClsInspectionManagementDAO DAO= new ClsInspectionManagementDAO();   %>                          
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
            	  var odata= '<%=DAO.searchvendor(session)%>';         
                  //alert("sdata"+cdata);  
               	    
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'accname', type: 'string'  },
                    ],
                    localdata: odata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxInputVendor").jqxInput({ source: dataAdapter, displayMember: "accname", valueMember: "doc_no", items: 20 ,width: 200, height: 20,placeHolder:"Enter Vendor"});
                $("#jqxInputVendor").on('select', function (event) {          
                	  if (event.args) {
                          var item = event.args.item;                
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {   
                                  if (item.value == dataAdapter.records[i].doc_no) {   
                                	  document.getElementById("hidvndid").value=dataAdapter.records[i].doc_no;
                                	  break;          
                                  }  
                              }   
                          }   
                      }   
                    }); 
            });   
        </script>   
         <input id="jqxInputVendor" />
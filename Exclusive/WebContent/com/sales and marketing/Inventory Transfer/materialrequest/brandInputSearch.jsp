<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
 <%@page import="com.sales.InventoryTransfer.materialrequest.*"%>
<%ClsMaterialrequestDAO DAO= new ClsMaterialrequestDAO(); %>
 
<style>
#jqxBrandInput{
	background-color:#fff;
	height: 20px;
	
}
</style>
 
  <script type="text/javascript"> 
  var dataAdapter ="";

         $(document).ready(function () {
             
            
           	     var branddata= '<%=DAO.brandSearch()%>';
 
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'brandname', type: 'string'  }
                                 
                    ],
                    localdata: branddata,
                };
                  dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxBrandInput").jqxInput({ source: dataAdapter, displayMember: "brandname", valueMember: "brandname", width: 130, height: 20});
                
});
        
</script>
<input id="jqxBrandInput" />
     
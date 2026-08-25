<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
 <%@page import="com.procurement.purchase.purchaserequestforquote.ClspurchaserequestforquoteDAO"%>
<%ClspurchaserequestforquoteDAO DAO= new ClspurchaserequestforquoteDAO(); %>
 
<style>
#jqxSubCategoryInput{
	background-color:#fff;
	height: 20px;
	
}
</style>
 
  <script type="text/javascript"> 
  var dataAdapter ="";

         $(document).ready(function () {
             
            
           	     var subcategorySearchdata='<%=DAO.subCategorySearch()%>';
 
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'subcategory', type: 'string'  }
                                 
                    ],
                    localdata: subcategorySearchdata,
                };
                  dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxSubCategoryInput").jqxInput({ source: dataAdapter, displayMember: "subcategory", valueMember: "subcategory", width: 130, height: 20});
                
});
        
</script>
<input id="jqxSubCategoryInput" />
     
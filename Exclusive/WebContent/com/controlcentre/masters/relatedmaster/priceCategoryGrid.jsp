<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.relatedmaster.pricecategory.ClsPriceCategoryDAO"%>
<%
ClsPriceCategoryDAO cd=new ClsPriceCategoryDAO();
%>

<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype");  %>
<script type="text/javascript">
	
	var datas;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 

      	
         	   datas='<%=cd.getPriceCategory()%>'; 
         	
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
   						{name : 'doc_no', type: 'string' },
   						{name : 'category', type: 'string' }
   						               ],
               localdata: datas,
                                      
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
                   alert(error);    
                   }
            });
          
          var list = ['GCC', 'IDP','UAE'];
        
          $("#jqxPriceCategory").jqxGrid(
          {
              
              						
				
                        width: '99%',
                        height: 300,
                        source: dataAdapter,
                        selectionmode: 'singlerow',
             			editable: false,
             			columnsresize: true,
             			localization: {thousandsSeparator: ""},
             			
                        columns: [
        					 { text: 'Doc No', datafield: 'doc_no', width: '30%' },
        					 { text: 'Price Category', datafield: 'category' },
        					 
        					
        					]
                    });
          //Add empty row          
          /* if(temp==0){   
         	   $("#jqxPriceCategory").jqxGrid('addrow', null, {});
          	 }   
            
             if(temp>0){
             	$("#jqxPriceCategory").jqxGrid('disabled', true);
             } */
             $('#jqxPriceCategory').on('rowdoubleclick', function (event) 
               		{ 
     		            	var rowindex1=event.args.rowindex;
     		                document.getElementById("docno").value= $('#jqxPriceCategory').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
     		                document.getElementById("category").value = $("#jqxPriceCategory").jqxGrid('getcellvalue', rowindex1, "category");
     		                 }); 
     		  

    	
   
});
      
</script>
<div id="jqxPriceCategory"></div>
 <input type="hidden" id="gridrowindex" name="gridrowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid"> 
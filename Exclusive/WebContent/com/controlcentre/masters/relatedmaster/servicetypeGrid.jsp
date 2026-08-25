<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.relatedmaster.servicetype.ClsServiceDAO"%>
<%
ClsServiceDAO cd=new ClsServiceDAO();
%>

<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype");  %>
<script type="text/javascript">
	
	var driverdata;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 

      	
         	   driverdata='<%=cd.getServiceGrid()%>'; 
         	
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
   						{name : 'doc_no', type: 'string' },
   						{name : 'name', type: 'string' },
   						{name : 'taxtype', type: 'string' },
   						               ],
               localdata: driverdata,
                                      
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
                   alert(error);    
                   }
            });
          
          var list = ['GCC', 'IDP','UAE'];
        
          $("#jqxService").jqxGrid(
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
        					 { text: 'Name', datafield: 'name', width: '70%' },
        					 { text: 'Tax Type', datafield: 'taxtype',hidden:true },
        					
        					]
                    });
          //Add empty row          
          if(temp==0){   
         	   $("#jqxService").jqxGrid('addrow', null, {});
          	 }   
            
             if(temp>0){
             	$("#jqxService").jqxGrid('disabled', true);
             }
             $('#jqxService').on('rowdoubleclick', function (event) 
               		{ 
     		            	var rowindex1=event.args.rowindex;
     		                document.getElementById("docno").value= $('#jqxService').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
     		                document.getElementById("name").value = $("#jqxService").jqxGrid('getcellvalue', rowindex1, "name");
     		                document.getElementById("txttype").value = $("#jqxService").jqxGrid('getcellvalue', rowindex1, "taxtype");
     		                 }); 
     		  
    
     	
    	
   
});
      
</script>
<div id="jqxService"></div>
 <input type="hidden" id="gridrowindex" name="gridrowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid"> 
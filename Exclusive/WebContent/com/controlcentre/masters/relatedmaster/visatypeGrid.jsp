<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.relatedmaster.visatype.ClsVisaDAO"%>
<%
ClsVisaDAO cd=new ClsVisaDAO();
%>

<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype");  %>
<script type="text/javascript">
	
	var driverdata;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 

      	
         	   driverdata='<%=cd.getVisaGrid()%>'; 
         	
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
   						{name : 'doc_no', type: 'string' },
   						{name : 'name', type: 'string' },
   						{name : 'validity', type: 'string'  }
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
        
          $("#jqxVisa").jqxGrid(
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
        					 { text: 'Name', datafield: 'name', width: '35%' },
        					 { text: 'Validity', datafield: 'validity', width: '35%' },
        					
        					]
                    });
          //Add empty row          
         /*  if(temp==0){   
         	   $("#jqxVisa").jqxGrid('addrow', null, {});
          	 }   
            
             if(temp>0){
             	$("#jqxVisa").jqxGrid('disabled', true);
             } */
             $('#jqxVisa').on('rowdoubleclick', function (event) 
               		{ 
     		            	var rowindex1=event.args.rowindex;
     		                document.getElementById("docno").value= $('#jqxVisa').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
     		                document.getElementById("validity").value = $("#jqxVisa").jqxGrid('getcellvalue', rowindex1, "validity");
     		                document.getElementById("name").value = $("#jqxVisa").jqxGrid('getcellvalue', rowindex1, "name");
     		                 }); 
     		  
     
   
});
      
</script>
<div id="jqxVisa"></div>
 <input type="hidden" id="gridrowindex" name="gridrowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid"> 
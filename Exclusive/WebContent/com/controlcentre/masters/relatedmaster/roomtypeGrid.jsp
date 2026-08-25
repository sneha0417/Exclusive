<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.relatedmaster.roomtype.ClsRoomDAO"%>
<%
ClsRoomDAO cd=new ClsRoomDAO();
%>

<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype");  %>
<script type="text/javascript">
	
	var driverdata;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 

      	
         	   driverdata='<%=cd.getRoomGrid()%>'; 
         	
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
                       	{name : 'date', type: 'date' }, 
   						{name : 'doc_no', type: 'string' },
   						{name : 'name', type: 'string' },
   						{name : 'remarks', type: 'string'  }
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
        
          $("#jqxRoom").jqxGrid(
          {
              
              						
				
                        width: '99%',
                        height: 300,
                        source: dataAdapter,
                        selectionmode: 'singlerow',
             			editable: false,
             			columnsresize: true,
             			localization: {thousandsSeparator: ""},
             			
                        columns: [
        					 { text: 'Doc No', datafield: 'doc_no', width: '5%' },
        					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '20%' },
        					 { text: 'Name', datafield: 'name', width: '35%' },
        					 { text: 'Category', datafield: 'remarks', width: '40%' },
        					
        					]
                    });
          //Add empty row          
         /*  if(temp==0){   
         	   $("#jqxRoom").jqxGrid('addrow', null, {});
          	 }   
            
             if(temp>0){
             	$("#jqxRoom").jqxGrid('disabled', true);
             } */
             $('#jqxRoom').on('rowdoubleclick', function (event) 
               		{ 
     		            	var rowindex1=event.args.rowindex;
     		                document.getElementById("docno").value= $('#jqxRoom').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
     		                document.getElementById("remarks").value = $("#jqxRoom").jqxGrid('getcellvalue', rowindex1, "remarks");
     		                document.getElementById("name").value = $("#jqxRoom").jqxGrid('getcellvalue', rowindex1, "name");
     		               $("#rdate").jqxDateTimeInput('val', $("#jqxRoom").jqxGrid('getcellvalue', rowindex1, "date")); 
     		                 }); 
     		  
     
   
});
      
</script>
<div id="jqxRoom"></div>
 <input type="hidden" id="gridrowindex" name="gridrowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid"> 
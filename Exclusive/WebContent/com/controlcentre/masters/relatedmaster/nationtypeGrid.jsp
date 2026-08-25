<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.relatedmaster.nationtype.ClsNationDAO"%>
<%
ClsNationDAO cd=new ClsNationDAO();
%>

<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype");  %>
<script type="text/javascript">
	
	var datas;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 

      	
         	   datas='<%=cd.getNation()%>'; 
         	
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
   						{name : 'doc_no', type: 'string' },
   						{name : 'nation', type: 'string' },
   						{name : 'catid', type: 'string' },
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
        
          $("#jqxNation").jqxGrid(
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
        					 { text: 'Nation', datafield: 'nation' },
        					 { text: 'Price Category', datafield: 'category' },
        					 { text: 'Category', datafield: 'catid',hidden:true },
        					
        					]
                    });
          //Add empty row          
          /* if(temp==0){   
         	   $("#jqxNation").jqxGrid('addrow', null, {});
          	 }   
            
             if(temp>0){
             	$("#jqxNation").jqxGrid('disabled', true);
             } */
             $('#jqxNation').on('rowdoubleclick', function (event) 
               		{ 
     		            	var rowindex1=event.args.rowindex;
     		                document.getElementById("docno").value= $('#jqxNation').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
     		                document.getElementById("nation").value = $("#jqxNation").jqxGrid('getcellvalue', rowindex1, "nation");
     		                document.getElementById("category").value = $("#jqxNation").jqxGrid('getcellvalue', rowindex1, "catid");
     		                 }); 
     		  

    	
   
});
      
</script>
<div id="jqxNation"></div>
 <input type="hidden" id="gridrowindex" name="gridrowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid"> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.relatedmaster.packagetype.ClsPackageDAO"%>
<%
ClsPackageDAO cd=new ClsPackageDAO();
%>

<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype");  %>
<script type="text/javascript">
	
	var driverdata;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 

      	
         	   driverdata='<%=cd.getPackageGrid()%>'; 
         	
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
   						{name : 'doc_no', type: 'string' },
   						{name : 'name', type: 'string' },
   						{name : 'code', type: 'string'  },
   						{name : 'descr', type: 'string'  }
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
        
          $("#jqxPackage").jqxGrid(
          {
              
              						
				
                        width: '99%',
                        height: 300,
                        source: dataAdapter,
                        selectionmode: 'singlerow',
             			editable: false,
             			columnsresize: true,
             			localization: {thousandsSeparator: ""},
             			
                        columns: [
        					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
        					 { text: 'Name', datafield: 'name', width: '30%' },
        					 { text: 'Code', datafield: 'code', width: '20%' },
        					 { text: 'Description', datafield: 'descr', width: '30%' },
        					
        					]
                    });
          //Add empty row          
          /* if(temp==0){   
         	   $("#jqxPackage").jqxGrid('addrow', null, {});
          	 }   
            
             if(temp>0){
             	$("#jqxPackage").jqxGrid('disabled', true);
             } */
             $('#jqxPackage').on('rowdoubleclick', function (event) 
               		{ 
     		            	var rowindex1=event.args.rowindex;
     		                document.getElementById("docno").value= $('#jqxPackage').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
     		                document.getElementById("code").value = $("#jqxPackage").jqxGrid('getcellvalue', rowindex1, "code");
     		                document.getElementById("name").value = $("#jqxPackage").jqxGrid('getcellvalue', rowindex1, "name");
     		                document.getElementById("descr").value = $("#jqxPackage").jqxGrid('getcellvalue', rowindex1, "descr");
     		                
     		                 }); 
     		  
     
   
});
      
</script>
<div id="jqxPackage"></div>
 <input type="hidden" id="gridrowindex" name="gridrowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid"> 
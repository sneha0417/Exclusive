<%@page import="com.realestate.propertyowner.ClsPropertyOwnerDAO" %>
<%
ClsPropertyOwnerDAO cud=new ClsPropertyOwnerDAO();
%>
<%
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String bdcenter = request.getParameter("bdcenter")==null?"0":request.getParameter("bdcenter");
 
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
 <script type="text/javascript">
 
 var chk="<%=chk%>";

 
 var bdcdata='<%=cud.nationsearch(docno,bdcenter,chk)%>';

  $(document).ready(function () { 	
      
      var num = 0; 
     var source =
     {
    		
    		 
    		 
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },          	
                   	{name : 'nation' , type: 'string' }
                    
                   	
                  	
                 	
						
                   	],
          localdata: bdcdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
     };
     
     var dataAdapter = new $.jqx.dataAdapter(source,
     		 {
         		loadError: function (xhr, status, error) {
                 alert(error);    
                 }
	            }		
     );
     $("#nationSearch").jqxGrid(
     {
         width: '100%',
         height: 356,
         source: dataAdapter,
         columnsresize: true,
         filterable: true,
         showfilterrow:false,
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
			
	
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '35%',hidden:true },		
				{ text: 'Nation', datafield: 'nation', width: '100%' }
				
				
				]
     });
      $('#nationSearch').on('rowdoubleclick', function (event) {
 	  var rowindex1=event.args.rowindex;
       
       
 	
      	
       
              document.getElementById("txtnationality").value= $('#nationSearch').jqxGrid('getcellvalue', rowindex1, "nation");
              document.getElementById("natid").value= $('#nationSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              $('#nationalityWindow').jqxWindow('close');
        
     
     		 });  
     
    
    
 

 });
</script>
<div id="nationSearch"></div>

    
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.templatemaster.ClsTemplateDAO"%>
<%ClsTemplateDAO DAO= new ClsTemplateDAO();%>
 <%
 
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_namess = request.getParameter("Cl_namess")==null?"0":request.getParameter("Cl_namess");
 String dates = request.getParameter("dates")==null?"0":request.getParameter("dates");
 int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
 
%> 

 <script type="text/javascript">
 
 var searchdata;
 
  searchdata='<%=DAO.searchMaster(session,msdocno,Cl_namess,dates,id)%>';
	
  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                      
                    {name : 'doc_no' , type: 'number' },
                  
                   	{name : 'date' , type: 'date' },
                    {name : 'code' , type: 'String' },
                    {name : 'name' , type: 'String' },
                   
                   	],
          localdata: searchdata,
         
         
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
     $("#subsearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
        selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
                   
        
				{ text: 'Doc No', datafield: 'doc_no', width: '15%' },
				
				{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Code', datafield: 'code', width: '30%' },
				{ text: 'Name', datafield: 'name', width: '30%'},
				]
     });
     
     $('#subsearch').on('celldoubleclick', function (event) {
         
    	 var rowindex1=event.args.rowindex;
          var loadid=2;
          
    	/*   $('#doc_no').attr('disabled', false);
 		 $('#masterdoc_no').attr('disabled', false);
 		 $('#mode').attr('disabled', false);
 		 $('#cmbreftype').attr('disabled', false);
    	 $('#date').jqxDateTimeInput({ disabled: false});  */
    	 
    	 
         document.getElementById("docno").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
         document.getElementById("date").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date");
         document.getElementById("txtcodeno").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "code");
         document.getElementById("txtname").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "name");
     
         
         setValues();
         

      
        $('#window').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="subsearch"></div>

    
    </body>
</html>

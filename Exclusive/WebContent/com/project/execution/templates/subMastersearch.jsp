<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.templates.ClsTemplateDAO"%> 
<%ClsTemplateDAO DAO= new ClsTemplateDAO();%>
 <%
 
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_project = request.getParameter("Cl_project")==null?"0":request.getParameter("Cl_project");
 String Cl_section = request.getParameter("Cl_section")==null?"0":request.getParameter("Cl_section");
 String Cl_activity = request.getParameter("Cl_activity")==null?"0":request.getParameter("Cl_activity");
int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
 
%> 

 <script type="text/javascript">
 
 var searchdata;
 
  searchdata='<%=DAO.searchMaster(session,msdocno,Cl_project,Cl_section,Cl_activity,id)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                  	{name : 'doc_no' , type: 'number' },
                  	{name : 'tr_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'project' , type: 'String' },
                   	{name : 'section' , type: 'String' },
                	{name : 'activity' , type: 'String' },
                    {name : 'projectid' , type: 'number'}, 
                    {name : 'sectionid' , type: 'number'}, 
                    {name : 'description' , type: 'String'},
                    {name : 'refno' , type: 'String'},
                    {name : 'total' , type: 'String'},
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
                   
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
				{ text: 'Tr No', datafield: 'tr_no', width: '15%',hidden:true },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Activity', datafield: 'activity', width: '30%' },
				{ text: 'Project', datafield: 'project', width: '25%' },
				{ text: 'projectid', datafield: 'projectid', width: '15%',hidden:true },
				{ text: 'Section', datafield: 'section', width: '20%' },
				{ text: 'sectionid', datafield: 'sectionid', width: '15%',hidden:true },
				{ text: 'description', datafield: 'description', width: '17%',hidden:true  },
				{ text: 'total', datafield: 'total', width: '17%',hidden:true  },
				{ text: 'refno', datafield: 'refno', width: '17%',hidden:true  },
				
				]
     });
     
     $('#subsearch').on('celldoubleclick', function (event) {
         
    	 var rowindex1=event.args.rowindex;
    	 
    	  $('#doc_no').attr('disabled', false);
 		 $('#masterdoc_no').attr('disabled', false);
 		 $('#mode').attr('disabled', false);
 		 
    	 
    	 $('#date').jqxDateTimeInput({ disabled: false}); 
	      
         
         document.getElementById("docno").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
         document.getElementById("masterdoc_no").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
         document.getElementById("txtrefno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "refno");
         $('#date').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
         $('#hiddate').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
         document.getElementById("txtprojectname").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "project");
         document.getElementById("txtprojectid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "projectid");
         document.getElementById("txtactivity").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "activity");
         document.getElementById("txtsectionname").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "section");
         document.getElementById("txtsectionid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "sectionid");
         document.getElementById("txtdescription").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "description");
         document.getElementById("txtnettotal").value=parseFloat($('#subsearch').jqxGrid('getcellvalue', rowindex1, "total"));
         
         var docno=$('#masterdoc_no').val();
         
       
         
         if(docno>0){
			 $("#materialDiv").load("materialDetailsGrid.jsp?docno="+docno);
			 $("#labourDiv").load("labourDetailsGrid.jsp?docno="+docno);
			 $("#equipmentsDiv").load("equipmentDetailsGrid.jsp?docno="+docno);
			 
			 $('#frmTemplates').submit();
		}
     	 
         /* $('#frmservicecontract').submit(); */
         
        $('#window').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="subsearch"></div>

    
    </body>
</html>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.projectInvoicereturn.ClsProjectInvoiceReturnDAO"%>
<%
ClsProjectInvoiceReturnDAO viewDAO=new ClsProjectInvoiceReturnDAO();
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String contno = request.getParameter("contno")==null?"0":request.getParameter("contno");
 String invdate = request.getParameter("invdate")==null?"0":request.getParameter("invdate");
 
 String invtype = request.getParameter("invtype")==null?"0":request.getParameter("invtype").trim();
%> 

 <script type="text/javascript">
 
 var masterdata; 
 

  masterdata='<%=viewDAO.searchMaster(session,msdocno,Cl_names,contno,invdate,invtype)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                  
                   	{name : 'client' , type: 'String' },
                  
                   	{name : 'contype' , type: 'String' },
                 {name : 'contno' , type: 'String' },
                 	{name : 'invtype' , type: 'Int' },
                   
                    {name : 'tr_no' , type: 'number'},
                   /*  {name : 'cldocno' , type: 'string'},
                    {name : 'clacno' , type: 'string'},
                    {name : 'costid' , type: 'string'},
                    {name : 'conttypeval' , type: 'string'} */
						
                   	],
          localdata: masterdata,
         
         
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
     $("#projectInvoiceReturnGridId").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         selectionmode: 'singlerow',
         pagermode: 'default',

         columns: [
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Invoice No', datafield: 'contno', width: '15%' },
				{ text: 'Client', datafield: 'client', width: '45%' },
				{ text: 'Contract Type', datafield: 'contype', width: '15%' },
				{ text: 'invtype', datafield: 'invtype', width: '20%',hidden:true },
				
				{ text: 'trno', datafield: 'tr_no', width: '20%',hidden:true },
				/* { text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Costid', datafield: 'costid', width: '20%',hidden:true },
				{ text: 'Clacno', datafield: 'clacno', width: '20%',hidden:true },
				{ text: 'Conttypeval', datafield: 'conttypeval', width: '20%',hidden:true } */
		
				]
     });
     

     $('#projectInvoiceReturnGridId').on('rowdoubleclick', function (event)  { 
 	  	var rowindex1=event.args.rowindex;
     	
 		$('#date').jqxDateTimeInput({ disabled: false});
        $('#date').val($("#projectInvoiceReturnGridId").jqxGrid('getcellvalue', rowindex1, "date")) ; 
              
        document.getElementById("maintrno").value= $('#projectInvoiceReturnGridId').jqxGrid('getcellvalue', rowindex1, "tr_no");
              
        $('#window').jqxWindow('close');
     	$('#date').jqxDateTimeInput({ disabled: true});
     	$('#mode').attr('disabled',false);
     	$('#maintrno').attr('disabled',false);
     	
    	document.getElementById("frmprojectinvoicereturn").submit();
        
        });	 
   
 });
</script>
<div id="projectInvoiceReturnGridId"></div>
</body>
</html>

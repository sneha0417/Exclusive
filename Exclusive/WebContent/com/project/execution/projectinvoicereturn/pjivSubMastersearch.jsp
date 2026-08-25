<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.projectInvoicereturn.ClsProjectInvoiceReturnDAO"%>
<%
ClsProjectInvoiceReturnDAO viewDAO=new ClsProjectInvoiceReturnDAO();
 String pjivmsdocno = request.getParameter("pjivmsdocno")==null?"0":request.getParameter("pjivmsdocno");
 String pjivCl_names = request.getParameter("pjivCl_names")==null?"0":request.getParameter("pjivCl_names");
 String pjivcontno = request.getParameter("pjivcontno")==null?"0":request.getParameter("pjivcontno");
 String pjivinvdate = request.getParameter("pjivinvdate")==null?"0":request.getParameter("pjivinvdate");
 String pjivinvtype = request.getParameter("pjivinvtype")==null?"0":request.getParameter("pjivinvtype").trim();
%> 

 <script type="text/javascript">
 
 var pjivmasterdata; 
 

  pjivmasterdata='<%=viewDAO.projectInvoiceGridLoading(session,pjivmsdocno,pjivCl_names,pjivcontno,pjivinvdate,pjivinvtype)%>';

  $(document).ready(function () { 	
     
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                   	{name : 'client' , type: 'String' },
                   	{name : 'contype' , type: 'String' },
                 	{name : 'contno' , type: 'String' },
                 	{name : 'invtype' , type: 'int' },
                 	{name : 'refno' , type: 'String' },
                 	{name : 'details' , type: 'String' },
                 	{name : 'cldocno' , type: 'int' },
                 	{name : 'costid' , type: 'int' },
                 	{name : 'clacno' , type: 'int' },
                 	{name : 'conttypeval' , type: 'String' },
                 	{name : 'desp' , type: 'String' },
                 	{name : 'refdocno' , type: 'String' },
                 	{name : 'pdrowno' , type: 'int' },
                 	{name : 'etotal' , type: 'number' },
                 	{name : 'netamount' , type: 'number' },
                 	{name : 'atotal' , type: 'number' },
                 	{name : 'legalchrg' , type: 'number' },
                 	{name : 'notes' , type: 'String' },
                 	{name : 'contypeid' , type: 'int'},
                 	{name : 'ptypeid' , type: 'int'},
                    {name : 'tr_no' , type: 'number'}
						
                   	],
          localdata: pjivmasterdata,
         
         
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
     
     $("#pjivMainSearchGridId").jqxGrid(
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
				{ text: 'Client', datafield: 'client', width: '45%' },
				{ text: 'Contract Type', datafield: 'contype', width: '15%' },
				{ text: 'Contract No', datafield: 'contno', width: '15%' },
				{ text: 'Invtype', datafield: 'invtype', width: '20%',hidden: true },
				{ text: 'Ref No', datafield: 'refno', width: '20%',hidden: true },
				{ text: 'Client Details', datafield: 'details', width: '20%',hidden: true },
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Costid', datafield: 'costid', width: '20%',hidden:true },
				{ text: 'Clacno', datafield: 'clacno', width: '20%',hidden:true },
				{ text: 'Conttypeval', datafield: 'conttypeval', width: '20%',hidden: true },
				{ text: 'Description', datafield: 'desp', width: '20%',hidden: true },
				{ text: 'Ref Doc No', datafield: 'refdocno', width: '20%',hidden: true },
				{ text: 'Row No', datafield: 'pdrowno', width: '20%',hidden: true },
				{ text: 'Etotal', datafield: 'etotal', width: '20%',hidden: true },
				{ text: 'Net Amount', datafield: 'netamount', width: '20%',hidden: true },
				{ text: 'Atotal', datafield: 'atotal', width: '20%',hidden: true },
				{ text: 'Legal Charge', datafield: 'legalchrg', width: '20%',hidden: true },
				{ text: 'Notes', datafield: 'notes', width: '20%',hidden: true },
				{ text: 'Contract Type Id', datafield: 'contypeid', width: '15%',hidden: true },
				{ text: 'PType Id', datafield: 'ptypeid', width: '15%',hidden: true },
				{ text: 'Trno', datafield: 'tr_no', width: '20%',hidden: true },
				
				]
     });
     

     $('#pjivMainSearchGridId').on('rowdoubleclick', function (event) { 
 	  	var rowindex1=event.args.rowindex;
     	
        document.getElementById("rreftrno").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "tr_no");      
        document.getElementById("rrefno").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "doc_no");
        document.getElementById("cmbcontracttype").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "contype");
        document.getElementById("cmbcontracttypeid").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "contypeid");
        document.getElementById("ptype").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "ptypeid");
        document.getElementById("txtrefdetails").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "contno");
        document.getElementById("txtclient").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "client");
        document.getElementById("refno").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "refno");
        document.getElementById("txtclientdet").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "details");
        document.getElementById("clientid").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "cldocno");
        document.getElementById("costid").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "costid");
        document.getElementById("clacno").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "clacno");
        document.getElementById("contypeval").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "contype");
        document.getElementById("desc").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "desp");
        document.getElementById("txtrefdetails").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "refdocno");
        document.getElementById("pdid").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "desp");
        document.getElementById("txtexptotal").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "etotal");
        document.getElementById("txtnettotal").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "netamount");
        document.getElementById("txtseramt").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "atotal");
        document.getElementById("txtlegalamt").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "legalchrg");
        document.getElementById("txtnotes").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "notes");
        document.getElementById("txtcontract").value= $('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "refdocno");        
        
        $("#serdiv").load("serviceGrid.jsp?pjinvtrno="+$('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "tr_no")+"&gridload=1");
        //$("#expdiv").load("expenseGrid.jsp?pjinvtrno="+$('#pjivMainSearchGridId').jqxGrid('getcellvalue', rowindex1, "tr_no")+"&gridload=1");
        
        $('#refnosearchwindow').jqxWindow('close');
     
     });	 
   
 

 });
</script>
<div id="pjivMainSearchGridId"></div>

    
    </body>
</html>

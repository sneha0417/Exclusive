
<%@page import="com.project.execution.projectproInvoice.ClsProjectProInvoiceDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsProjectProInvoiceDAO DAO= new ClsProjectProInvoiceDAO();%>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_mobno = request.getParameter("Cl_mobno")==null?"0":request.getParameter("Cl_mobno");
 String cntrdate = request.getParameter("cntrdate")==null?"0":request.getParameter("cntrdate"); 
 String dtype = request.getParameter("dtype")==null?" ":request.getParameter("dtype"); 

%> 

 <script type="text/javascript">
 
 var cntrmasterdata; 
 

 cntrmasterdata='<%=DAO.contractSrearch(session,msdocno,Cl_names,Cl_mobno,cntrdate,dtype)%>';
  $(document).ready(function () { 	
     
     var source =
     {
    		 
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'clientid' , type: 'String' },
                   	{name : 'name' , type: 'String' },
                   	{name : 'details' , type: 'String' },
                 	{name : 'contmob' , type: 'String' },
                    {name : 'cpersonid' , type: 'String'},
                    {name : 'cperson' , type: 'String'}, 
                    {name : 'tr_no' , type: 'number'} ,
                    {name : 'clacno' , type: 'String'} 	,
                    {name : 'dtype' , type: 'String'} ,
                    {name : 'dueamt' , type: 'String'} ,
                    {name : 'lfee' , type: 'String'} 
						
                   	],
          localdata: cntrmasterdata,
         
         
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
     $("#subContractSearch").jqxGrid(
     {
         width: '100%',
         height: 220,
         source: dataAdapter,
         columnsresize: true,
       
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Cldocno', datafield: 'clientid', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'name', width: '25%' },
				{ text: 'Address', datafield: 'details', width: '35%' },
				{ text: 'MOB', datafield: 'contmob', width: '15%' },
				{ text: 'docno', datafield: 'tr_no', width: '20%',hidden:true },
				{ text: 'cpersonid', datafield: 'cpersonid', width: '20%',hidden:true },
				{ text: 'cperson', datafield: 'cperson', width: '20%',hidden:true },
				{ text: 'Clacno', datafield: 'clacno', width: '20%',hidden:true },
				{ text: 'DType', datafield: 'dtype', width: '10%',hidden:true },
				{ text: 'dueamt', datafield: 'dueamt', width: '20%',hidden:false },
				{ text: 'lfee', datafield: 'lfee', width: '10%',hidden:false }
		
				]
     });
     

     $('#subContractSearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
     	
		      document.getElementById("txtcontract").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              document.getElementById("txtclient").value= $('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "name");
              document.getElementById("txtclientdet").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "details");
              document.getElementById("clientid").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "clientid");
              document.getElementById("costid").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
              document.getElementById("clacno").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "clacno");
              document.getElementById("contypeval").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "dtype");
              
              $('#serviceGrid').jqxGrid('setcellvalue', 0, "amount",$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "dueamt"));
              $('#serviceGrid').jqxGrid('setcellvalue', 0, "lfee",$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "lfee"));
      
 		//	$('#window').jqxWindow('close');
              $('#contractwindow').jqxWindow('close');
     
     		 });	 
     

 });
</script>
<div id="subContractSearch"></div>

    
    </body>
</html>

<%@page import="com.project.execution.projectInvoice.ClsProjectInvoiceDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%
 ClsProjectInvoiceDAO DAO= new ClsProjectInvoiceDAO();
 %>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_mobno = request.getParameter("Cl_mobno")==null?"0":request.getParameter("Cl_mobno");
 String cntrdate = request.getParameter("cntrdate")==null?"0":request.getParameter("cntrdate"); 
 String dtype = request.getParameter("dtype")==null?" ":request.getParameter("dtype"); 
 String ptype = request.getParameter("ptype")==null?" ":request.getParameter("ptype");
 String check = request.getParameter("check")==null?" ":request.getParameter("check");

%> 

 <script type="text/javascript">
 
 var cntrmasterdata; 
 

 cntrmasterdata='<%=DAO.contractSrearch(session,msdocno,Cl_names,Cl_mobno,cntrdate,dtype,ptype,check)%>';
  $(document).ready(function () { 	
     
     var source =
     { 
    		 
         datatype: "json",
         datafields: [
                   /* 	{name : 'doc_no' , type: 'number' },
                   	{name : 'duedate' , type: 'date' },
                    {name : 'clientid' , type: 'String' },
                   	{name : 'name' , type: 'String' },
                   	{name : 'details' , type: 'String' },
                 	{name : 'contmob' , type: 'String' },
                    {name : 'cpersonid' , type: 'String'},
                    {name : 'cperson' , type: 'String'}, 
                    {name : 'tr_no' , type: 'number'} ,
                    {name : 'clacno' , type: 'String'} ,
                    {name : 'pdid' , type: 'String'} ,
                    {name : 'lfee' , type: 'number'} ,
                    {name : 'dueamt' , type: 'number'} , */
                    
                   {name : 'doc_no', type: 'String'  },
					{name : 'dtype', type: 'String'  },
					{name : 'rdtype', type: 'String'  },
					{name : 'client', type: 'String' },
					{name : 'contactno', type: 'String' },
					{name : 'details', type: 'String' },
					{name : 'clientid', type: 'number' },
					{name : 'cperson', type: 'String' },
					{name : 'cpersonid', type: 'number' },
					{name : 'clacno', type: 'number' },
					{name : 'refdtype', type: 'String' },
					{name : 'refno', type: 'String' },
					{name : 'sdate', type: 'date' },
					{name : 'edate', type: 'date' },
					{name : 'cval', type: 'number' },
					{name : 'tobeinvamt', type: 'number' },
					{name : 'duedate', type: 'date' },
					{name : 'dueno', type: 'String' },
					{name : 'dueamt', type: 'number' },
					{name : 'lfee', type: 'number' },
					{name : 'brch', type: 'String' },
					{name : 'tr_no', type: 'String' },
					{name : 'pdid', type: 'String' },
					{name : 'ptype', type: 'String' },
					{name : 'inctax', type: 'String' },
						
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
              
               /*   
				{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
				{ text: 'Due Date', datafield: 'duedate', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Cldocno', datafield: 'clientid', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'name', width: '25%' },
				{ text: 'Address', datafield: 'details', width: '35%' },
				{ text: 'MOB', datafield: 'contmob', width: '15%' },
				{ text: 'Due Amount', datafield: 'dueamt', width: '15%',hidden:true },
				{ text: 'Legal Amount', datafield: 'lfee', width: '15%',hidden:true },
				{ text: 'docno', datafield: 'tr_no', width: '20%',hidden:true },
				{ text: 'cpersonid', datafield: 'cpersonid', width: '20%',hidden:true },
				{ text: 'cperson', datafield: 'cperson', width: '20%',hidden:true },
				{ text: 'Clacno', datafield: 'clacno', width: '20%',hidden:true },
				{ text: 'pdid', datafield: 'pdid', width: '20%',hidden:true }, */
				
				{ text: 'Doc No',  datafield: 'doc_no', width: '10%' },
                { text: 'Name', datafield: 'client', width: '25%' },
                { text: 'Address', datafield: 'details', width: '35%' },
                { text: 'MOB', datafield: 'contactno', width: '15%' },
				{ text: 'Doc Type',  datafield: 'rdtype', width: '6%',hidden:true },
				{ text: 'RefNo', datafield: 'refno', width: '10%',hidden:true },
				{ text: 'Start Date', datafield: 'sdate', width: '7%',cellsformat:'dd.MM.yyyy',hidden:true },
				{ text: 'End Date', datafield: 'edate', width: '7%',cellsformat:'dd.MM.yyyy',hidden:true },
				{ text: 'Due Date', datafield: 'duedate', width: '8%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Contract Amount',  datafield: 'cval', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',hidden:true },
				{ text: 'Legal Amount',  datafield: 'lfee', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',hidden:true },
				{ text: 'Due Amount', datafield: 'dueamt', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
				{ text: 'Other',  datafield: 'tobeinvamt', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',hidden:true },
				{ text: 'clientid', datafield: 'clientid', width: '15%',hidden:true },
				{ text: 'Branch Id',  datafield: 'brch', width: '10%' ,hidden:true },
				{ text: 'Clacno',  datafield: 'clacno', width: '10%' ,hidden:true },
				{ text: 'Tr No',  datafield: 'tr_no', width: '10%',hidden:true },
				{ text: 'pdid',  datafield: 'pdid', width: '10%',hidden:true },
				{ text: 'dtype',  datafield: 'dtype', width: '10%',hidden:true },
				{ text: 'ptype',  datafield: 'ptype', width: '10%',hidden:true },
				{ text: 'inctax',  datafield: 'inctax', width: '10%',hidden:true },
		
				]
     });
     

     $('#subContractSearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
 	 
 	          document.getElementById("txtrefdetails").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
		      document.getElementById("txtcontract").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              document.getElementById("txtclient").value= $('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "client");
              document.getElementById("txtclientdet").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "details");
              document.getElementById("clientid").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "clientid");
              document.getElementById("costid").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
              document.getElementById("clacno").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "clacno");
              document.getElementById("pdid").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "pdid");
              document.getElementById("ptype").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "ptype");
              document.getElementById("contypeval").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "dtype");
              
              $('#serviceGrid').jqxGrid('setcellvalue', 0, "amount",$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "dueamt"));
              $('#serviceGrid').jqxGrid('setcellvalue', 0, "lfee",$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "lfee"));
              
              document.getElementById("inctax").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "inctax");
              
              var txtlegalamt=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "lfee");
      		 var txtseramt=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "dueamt");
      			 document.getElementById("txtlegalamt").value=txtlegalamt;
      			document.getElementById("txtseramt").value=txtseramt;
      		 document.getElementById("txtexptotal").value=0;
      		 var txtexptotal=0;
      		 var grtotal=(parseFloat(txtexptotal)+parseFloat(txtlegalamt)+parseFloat(txtseramt));
      		 document.getElementById("txtnettotal").value=grtotal;
              
              var costid=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
              
              var docType = document.getElementById("cmbcontracttype").value.trim();
              
              if(costid>0){
              	$("#expdiv").load("expenseGrid.jsp?costid="+costid+"&docType="+docType+"&gridload=1");
              }
      
 		//	$('#window').jqxWindow('close');
              $('#contractwindow').jqxWindow('close');
     
     		 });	 
     

 });
</script>
<div id="subContractSearch"></div>

    
    </body>
</html>

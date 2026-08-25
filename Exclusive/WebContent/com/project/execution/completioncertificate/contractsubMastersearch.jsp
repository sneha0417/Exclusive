<%@page import="com.project.execution.completioncertificate.ClsCompletionCertificateDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%
 ClsCompletionCertificateDAO DAO= new ClsCompletionCertificateDAO();
 %>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String contrval = request.getParameter("contrval")==null?"0":request.getParameter("contrval");
 String cntrdate = request.getParameter("cntrdate")==null?"0":request.getParameter("cntrdate"); 
 String dtype = request.getParameter("dtype")==null?" ":request.getParameter("dtype"); 
 String ptype = request.getParameter("ptype")==null?" ":request.getParameter("ptype"); 

%> 

 <script type="text/javascript">
 
 var cntrmasterdata; 
 

 cntrmasterdata='<%=DAO.contractSrearch(session,msdocno,Cl_names,contrval,cntrdate,dtype,ptype)%>';
  $(document).ready(function () { 	
     
     var source =
     {
    		 
         datatype: "json",
         datafields: [
                  
                    
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
					{name : 'reten', type: 'number' },	
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
         height: 240,
         source: dataAdapter,
         columnsresize: true,
       
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
           
				
				{ text: 'Doc No',  datafield: 'doc_no', width: '10%' },
                { text: 'Name', datafield: 'client', width: '33%' },
                { text: 'Address', datafield: 'details', width: '34%' },
                { text: 'Date', datafield: 'duedate', width: '8%',cellsformat:'dd.MM.yyyy' },
                { text: 'Contract Amount',  datafield: 'cval', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
                { text: 'MOB', datafield: 'contactno', width: '15%',hidden:true  },
				{ text: 'Doc Type',  datafield: 'rdtype', width: '6%',hidden:true },
				{ text: 'RefNo', datafield: 'refno', width: '10%',hidden:true },
				{ text: 'Start Date', datafield: 'sdate', width: '7%',cellsformat:'dd.MM.yyyy',hidden:true },
				{ text: 'End Date', datafield: 'edate', width: '7%',cellsformat:'dd.MM.yyyy',hidden:true },
				
				
				{ text: 'Legal Amount',  datafield: 'lfee', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',hidden:true },
				{ text: 'Due Amount', datafield: 'dueamt', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',hidden:true},
				{ text: 'Other',  datafield: 'tobeinvamt', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',hidden:true },
				{ text: 'clientid', datafield: 'clientid', width: '15%',hidden:true },
				{ text: 'Branch Id',  datafield: 'brch', width: '10%' ,hidden:true },
				{ text: 'Clacno',  datafield: 'clacno', width: '10%' ,hidden:true },
				{ text: 'Tr No',  datafield: 'tr_no', width: '10%',hidden:true },
				{ text: 'pdid',  datafield: 'pdid', width: '10%',hidden:true },
				{ text: 'dtype',  datafield: 'dtype', width: '10%',hidden:true },
				{ text: 'ptype',  datafield: 'ptype', width: '10%',hidden:true },
				{ text: 'inctax',  datafield: 'inctax', width: '10%',hidden:true },
				{ text: 'reten',  datafield: 'reten', width: '10%',hidden:true },
				]
     });
     

     $('#subContractSearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
 	  var ctrno=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
 	 document.getElementById("contrretn").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "reten");
 	 
 	  
 	          document.getElementById("txtrefdetails").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
		      document.getElementById("txtcontract").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
              document.getElementById("txtclient").value= $('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "client");
              document.getElementById("txtclientdet").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "details");
              document.getElementById("clientid").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "clientid");
              document.getElementById("costid").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
           
              document.getElementById("contypeval").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "dtype");
              document.getElementById("contrval").value=$('#subContractSearch').jqxGrid('getcellvalue', rowindex1, "cval");
              
              $('#contractwindow').jqxWindow('close');
     
              $("#serdiv").load("serviceGrid.jsp?ctrno="+ctrno);
              
     		 });	 
     

 });
</script>
<div id="subContractSearch"></div>

    
    </body>
</html>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.procurementstatus.ClsProcurementStatusDAO"%>
<%
ClsProcurementStatusDAO viewDAO=new ClsProcurementStatusDAO();

String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String contno = request.getParameter("contno")==null?"0":request.getParameter("contno");
 String invtype = request.getParameter("invtype")==null?"0":request.getParameter("invtype").trim();
%> 

 <script type="text/javascript">
 
 var masterdata; 
 

  masterdata='<%=viewDAO.searchMaster(session,Cl_names,contno,invtype)%>';

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
                    {name : 'site' , type: 'String' },
                   /*  
                   {name : 'cldocno' , type: 'string'},
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
     $("#subEnqirySearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
                
			    { text: 'Contract No', datafield: 'contno', width: '25%' },
				{ text: 'Client', datafield: 'client', width: '50%' },
				{ text: 'Contract Type', datafield: 'contype', width: '25%' },
				{ text: 'invtype', datafield: 'invtype', width: '20%',hidden:true },
				{ text: 'trno', datafield: 'tr_no', width: '20%',hidden:true },
				{ text: 'site', datafield: 'site', width: '20%',hidden:true },
		
				]
     });
     

     $('#subEnqirySearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
     	
              document.getElementById("txtcontractid").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
              document.getElementById("txtcontract").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "contno");
              document.getElementById("txtareadet").value="Type :"+$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "contype")
              +"\n"+"Client :"+$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "client")
              +"\n"+"Site :"+$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "site");
         $('#contractwindow').jqxWindow('close');
     	
     		 });	 
  
 });
</script>
<div id="subEnqirySearch"></div>

    
    </body>
</html>

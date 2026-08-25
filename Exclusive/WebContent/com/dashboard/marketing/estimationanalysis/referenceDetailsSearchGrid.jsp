<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.marketing.estimationanalysis.ClsEstimationAnalysisDAO" %>
<% ClsEstimationAnalysisDAO DAO=new ClsEstimationAnalysisDAO(); %>
<% String contextPath=request.getContextPath();%>
<%
 String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
 String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_mobno = request.getParameter("Cl_mobno")==null?"0":request.getParameter("Cl_mobno");
 String enqdate = request.getParameter("enqdate")==null?"0":request.getParameter("enqdate"); 
 String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid"); 
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
 String reftype = request.getParameter("reftype")==null?"0":request.getParameter("reftype"); 
%> 

 <script type="text/javascript">
 
 var enqmasterdata; 
 
 var reftypes="<%=reftype%>";
if(reftypes=='ENQ' || reftypes=='SRVE')
	{
  enqmasterdata='<%=DAO.referenceDetailsSearchGridLoading(session,msdocno,Cl_names,Cl_mobno,enqdate,clientid,id,reftype)%>';
	}
else{
	enqmasterdata=[];
}
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
                    {name : 'refdocno' , type: 'String'},
                    {name : 'reftrno' , type: 'String'}, 
                    {name : 'voc_no' , type: 'number'}, 
						
                   	],
          localdata: enqmasterdata,
         
         
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
              
                 
				{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Cldocno', datafield: 'clientid', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'name', width: '25%' },
				{ text: 'Address', datafield: 'details', width: '35%' },
				{ text: 'MOB', datafield: 'contmob', width: '15%' },
				{ text: 'docno', datafield: 'doc_no', width: '20%',hidden:true },
				{ text: 'Ref Voc No', datafield: 'refdocno', width: '20%',hidden:true },
				{ text: 'Ref Doc No', datafield: 'reftrno', width: '20%',hidden:true },
		
				]
     });
     

     $('#subEnqirySearch').on('rowdoubleclick', function (event) 
     		{ 
		 	  var rowindex1=event.args.rowindex;
		      document.getElementById("txtreferencevocno").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "refdocno"); 
              document.getElementById("txtreferencedocno").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "reftrno");
              
              
 			$('#referenceDetailsWindow').jqxWindow('close');
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="subEnqirySearch"></div>

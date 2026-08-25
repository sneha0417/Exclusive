<%@page import="com.project.execution.quotationnew.ClsQuotationDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); %>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_mobno = request.getParameter("Cl_mobno")==null?"0":request.getParameter("Cl_mobno");
 String enqdate = request.getParameter("enqdate")==null?"0":request.getParameter("enqdate"); 
 String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid"); 
 String cntype = request.getParameter("cntype")==null?"0":request.getParameter("cntype");
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
String reftype = request.getParameter("reftype")==null?"0":request.getParameter("reftype");
%> 

 <script type="text/javascript">
 
 var enqmasterdata; 
  var reftypejs='<%=reftype %>';

  enqmasterdata='<%=DAO.enquirySrearch(session,msdocno,Cl_names,Cl_mobno,enqdate,clientid,id,cntype,reftype)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
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
                    {name : 'voc_no' , type: 'number'},  	
                    {name : 'esttrno' , type: 'number'},
{name : 'surveyed' , type: 'String'},	
{name : 'surtrno' , type: 'number'},
{name : 'contactdet', type: 'String'  },
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
				{ text: 'cpersonid', datafield: 'cpersonid', width: '20%',hidden:true },
				{ text: 'cperson', datafield: 'cperson', width: '20%',hidden:true },
				{ text: 'esttrno', datafield: 'esttrno', width: '20%',hidden:true },
{ text: 'surveyed', datafield: 'surveyed', width: '20%',hidden:true },
{ text: 'surtrno', datafield: 'surtrno', width: '20%',hidden:true },
		{ text: 'Details', datafield: 'contactdet', width: '50%',hidden:true },
				]
     });
     

     $('#subEnqirySearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
if(reftypejs=='ENQ')
 		  {
 document.getElementById("txtcontact").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "cperson");
	        document.getElementById("cpersonid").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");
	        document.getElementById("txtcontactdetails").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "contactdet");

 	  var esttrno=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "esttrno");
 	  if(esttrno>0){
 	 $('#btnLoad').attr('disabled', false);
 	  }
		      document.getElementById("txtenquiry").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
              document.getElementById("enquiryid").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
      document.getElementById("hidesttrno").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "esttrno");
        	var tr_no=document.getElementById("enquiryid").value;
        	
            var survd=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "surveyed");
            
            var surtrno=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "surtrno");
           // alert(surtrno);
            	$("#siteDetailsDiv").load("siteGrid.jsp?trno="+tr_no+"&surtrno="+surtrno);
    			 $("#serviceDetailsDiv").load("serviceGrid.jsp?trno="+tr_no+"&surtrno="+surtrno);
            }
 	  else{
 		 document.getElementById("txtenquiry").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
         document.getElementById("enquiryid").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
 	  }
 			 
          
              
 			$('#window').jqxWindow('close');
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="subEnqirySearch"></div>

    
    </body>
</html>

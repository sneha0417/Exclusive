<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="com.project.execution.estimationnew.ClsEstimationDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsEstimationDAO DAO= new ClsEstimationDAO(); %>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_mobno = request.getParameter("Cl_mobno")==null?"0":request.getParameter("Cl_mobno");
 String enqdate = request.getParameter("enqdate")==null?"0":request.getParameter("enqdate"); 
 String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid"); 
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
 String reftype = request.getParameter("reftype")==null?"0":request.getParameter("reftype"); 
 //System.out.println("reftype=="+reftype);
%> 

 <script type="text/javascript">
 
 var enqmasterdata; 
 
 var reftypes="<%=reftype%>";
if(reftypes=='ENQ' || reftypes=='SRVE')
	{
  enqmasterdata='<%=DAO.enquirySrearch(session,msdocno,Cl_names,Cl_mobno,enqdate,clientid,id,reftype)%>';
	}
else{
	enqmasterdata=[];
}
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
                    {name : 'surtrno' , type: 'number'}, 
                    {name : 'contrmode' , type: 'String'},
                    
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
				{ text: 'Cldocno', datafield: 'clientid', width: '20%',hidden: true },
				{ text: 'Name', datafield: 'name', width: '25%' },
				{ text: 'Address', datafield: 'details', width: '35%' },
				{ text: 'MOB', datafield: 'contmob', width: '15%' },
				{ text: 'docno', datafield: 'doc_no', width: '20%',hidden: true },
				{ text: 'cpersonid', datafield: 'cpersonid', width: '20%',hidden: true },
				{ text: 'cperson', datafield: 'cperson', width: '20%',hidden: true },
				{ text: 'surtrno', datafield: 'surtrno', width: '20%',hidden: true },
				{ text: 'contrmode', datafield: 'contrmode', width: '20%',hidden: true },
				
				]
     });
     

     $('#subEnqirySearch').on('rowdoubleclick', function (event) 
     		{ 
 	  		  var rowindex1=event.args.rowindex;
 	  		 
 	  		  var doc_no=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
     		  document.getElementById("txtenquiry").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
              document.getElementById("enquiryid").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              document.getElementById("txtcontrmode").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "contrmode");
              getScopeGroup();
              
              var surtrno=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "surtrno");
              if(surtrno>0) {
            	  $("#materialDiv").load("materialDetailsGrid.jsp?surtrno="+surtrno+"&loadid=4"); 
            	  document.getElementById("hidenqtrno").value=0;
            	  document.getElementById("hidsurtrno").value=surtrno;
           	  } else {
            	  $("#materialDiv").load("materialDetailsGrid.jsp?enqtrno="+doc_no+"&loadid=3");
            	  document.getElementById("hidenqtrno").value=doc_no;
            	  document.getElementById("hidsurtrno").value=0;
              }
              
 			$('#window').jqxWindow('close');
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="subEnqirySearch"></div>

    
    </body>
</html>

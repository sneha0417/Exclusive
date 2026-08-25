<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="com.project.execution.surveyDetails.ClsSurveyDetailsDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsSurveyDetailsDAO DAO= new ClsSurveyDetailsDAO(); %>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_mobno = request.getParameter("Cl_mobno")==null?"0":request.getParameter("Cl_mobno");
 String enqdate = request.getParameter("enqdate")==null?"0":request.getParameter("enqdate"); 
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));

%> 

 <script type="text/javascript">
 
 var enqmasterdata; 
 
  enqmasterdata='<%=DAO.enquirySrearch(session,msdocno,Cl_names,Cl_mobno,enqdate,id)%>';

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
			{name : 'empid' , type: 'String'},
                    {name : 'empname' , type: 'String'},	
						
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
				{ text: 'empid', datafield: 'empid', width: '20%',hidden:true },
				{ text: 'empname', datafield: 'empname', width: '20%',hidden:true }
		
				]
     });
     

     $('#subEnqirySearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
     	
				var empid=parseInt($('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "empid"));
 	  		
 	  		if(empid>0)
 	  			{
 	  			document.getElementById("empid").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "empid");
                document.getElementById("surveyedby").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "empname");
 	  			}

		      document.getElementById("txtenquiry").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
              document.getElementById("txtcontact").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "cperson");
              document.getElementById("contactnumber").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "contmob");
              document.getElementById("txtclient").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "name");
              document.getElementById("txtclientdet").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "details");
              
              document.getElementById("cpersonid").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");
              document.getElementById("clientid").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "clientid");
              document.getElementById("enqdoc_no").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
       var tr_no=document.getElementById("enqdoc_no").value;
             
              $("#sitediv").load("siteGrid.jsp?trno="+tr_no+"&gridload=1");
 			$('#window').jqxWindow('close');
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="subEnqirySearch"></div>

    
    </body>
</html>

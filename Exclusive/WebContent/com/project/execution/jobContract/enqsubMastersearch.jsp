<%@page import="com.project.execution.jobContract.ClsJobContractDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsJobContractDAO DAO= new ClsJobContractDAO(); %>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_mobno = request.getParameter("Cl_mobno")==null?"0":request.getParameter("Cl_mobno");
 String enqdate = request.getParameter("enqdate")==null?"0":request.getParameter("enqdate"); 
 String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid"); 
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype"); 
 String formcode = request.getParameter("formcode")==null?"0":request.getParameter("formcode"); 
%> 

 <script type="text/javascript">
 
 var enqmasterdata; 
 var dtype='<%=dtype%>';

  enqmasterdata='<%=DAO.refSearch(session,msdocno,Cl_names,Cl_mobno,enqdate,clientid,dtype,formcode)%>';

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
                    {name : 'legchrg' , type: 'number'}, 
                    {name : 'cntrval' , type: 'number'}, 
                    {name : 'chklegal' , type: 'number'},
						
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
				{ text: 'legchrg', datafield: 'legchrg', width: '20%',hidden: true },
				{ text: 'cntrval', datafield: 'cntrval', width: '20%',hidden: true },
				{ text: 'chklegal', datafield: 'chklegal', width: '20%',hidden: true },
		
		
				]
     });
     

     $('#subEnqirySearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
     	
		      document.getElementById("rrefno").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
              document.getElementById("refmasterdoc_no").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              var tr_no=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              
              if(dtype=='SQOT'){
            	  
            	  var legchrg=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "legchrg");
            	  var chklegal=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "chklegal");
                  if(parseInt(chklegal)>0)
                  	{
                  	 document.getElementById("chklegaldoc").checked=true;
                  	}
                  if(parseFloat(legchrg)>0){
                	
                  document.getElementById("temp1").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "legchrg");
                  legChange();
                  }
				  funRoundAmt($('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "cntrval"),"txtcntrval");
			  
             $("#sitediv").load("siteGrid.jsp?trno="+tr_no+"&gridload=1");
 			 $("#serdiv").load("serviceGrid.jsp?trno="+tr_no+"&gridload=1");
 			 
              }
      
 			$('#window').jqxWindow('close');
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="subEnqirySearch"></div>

    
    </body>
</html>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.surveyDetails.ClsSurveyDetailsDAO"%>
<%ClsSurveyDetailsDAO DAO= new ClsSurveyDetailsDAO();%>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_enqno = request.getParameter("Cl_enqno")==null?"0":request.getParameter("Cl_enqno");
 String surdate = request.getParameter("surdate")==null?"0":request.getParameter("surdate");
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
%> 

 <script type="text/javascript">
 
 var searchdata; 
 

  searchdata='<%=DAO.searchMaster(session,msdocno,Cl_names,Cl_enqno,surdate,id)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                  	{name : 'enqdoc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'clientid' , type: 'String' },
                   	{name : 'name' , type: 'String' },
                   	{name : 'details' , type: 'String' },
                 	{name : 'contmob' , type: 'String' },
                    {name : 'cpersonid' , type: 'String'},
                    {name : 'cperson' , type: 'String'}, 
                    {name : 'enqvoc_no' , type: 'number'}, 
                    {name : 'doc_no' , type: 'number'}, 
                    {name : 'voc_no' , type: 'number'}, 
                    {name : 'remarks' , type: 'string'}, 
                    {name : 'surveyid' , type: 'number'}, 
                    {name : 'survey' , type: 'string'}, 
                    {name : 'excontr' , type: 'string'}, 
                    {name : 'enqstatus' , type: 'number'},
                   	],
          localdata: searchdata,
         
         
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
     $("#subsearch").jqxGrid(
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
				{ text: 'enqdocno', datafield: 'enqdoc_no', width: '20%',hidden:true },
				{ text: 'enqvocno', datafield: 'enqvoc_no', width: '20%',hidden:true },
				{ text: 'survey', datafield: 'survey', width: '20%',hidden:true },
				{ text: 'surveyid', datafield: 'surveyid', width: '20%',hidden:true },
				{ text: 'desc', datafield: 'remarks', width: '20%',hidden:true },
				{ text: 'excontr', datafield: 'excontr', width: '20%',hidden:true },
				{ text: 'enqstatus', datafield: 'enqstatus', width: '20%',hidden:true },
				
				
				]
     });
     
     $('#subsearch').on('celldoubleclick', function (event) {
         
    	 var rowindex1=event.args.rowindex;
    	 $('#date').jqxDateTimeInput({ disabled: false}); 
	      document.getElementById("txtenquiry").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "enqvoc_no"); 
         document.getElementById("txtcontact").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "cperson");
         document.getElementById("contactnumber").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "contmob");
         document.getElementById("txtclient").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "name");
         document.getElementById("txtclientdet").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "details");
         
         document.getElementById("cpersonid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");
         document.getElementById("clientid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "clientid");
         document.getElementById("enqdoc_no").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "enqdoc_no");
         
         $('#date').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
         document.getElementById("hiddate").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date");
         document.getElementById("masterdoc_no").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
         document.getElementById("docno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
         document.getElementById("empid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "surveyid");
         document.getElementById("surveyedby").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "survey");
         document.getElementById("txtdesc").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "remarks");
         document.getElementById("txtcontractr").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "excontr");
         
         var docno=$('#masterdoc_no').val();
         var enqstatus= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "enqstatus");
               
         if(enqstatus>1)
     	   {
       
     	   document.getElementById("hidsuredit").value="1";
   
     	   }
        else
  	   {
      
  	   document.getElementById("hidsuredit").value="0";
  	   }   
 		if(docno>0){
 			$("#servtypeDetailsDiv").load("servtypeDetailsGrid.jsp?trno="+docno);
 			 $("#sitediv").load("siteGrid.jsp?docno="+docno);
 			 $("#servicediv").load("serviceGrid.jsp?docno="+docno);
  			
 		}
 		
 		$('#frmSurveydetails').submit();
        $('#window').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="subsearch"></div>

    
    </body>
</html>

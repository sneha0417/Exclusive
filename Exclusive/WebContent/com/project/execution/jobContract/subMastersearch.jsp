<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.jobContract.ClsJobContractDAO"%>  
<%ClsJobContractDAO DAO= new ClsJobContractDAO();%>
 <%
 String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
 String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String cl_site = request.getParameter("cl_site")==null?"0":request.getParameter("cl_site");
 String cl_area = request.getParameter("cl_area")==null?"0":request.getParameter("cl_area");
 String cl_amount = request.getParameter("Cl_amount")==null?"0":request.getParameter("Cl_amount");
 String sereftype = request.getParameter("sereftype")==null?"0":request.getParameter("sereftype");
 String surdate = request.getParameter("surdate")==null?"0":request.getParameter("surdate");
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
%> 

 <script type="text/javascript">
 
  var searchdata='<%=DAO.searchMaster(session,msdocno,Cl_names,sereftype,surdate,dtype,id,cl_area,cl_site,cl_amount)%>';

  $(document).ready(function () { 	
     
     var source =
     {
     		
         datatype: "json",
         datafields: [
					{name : 'doc_no' , type: 'number' },
					{name : 'date' , type: 'date' },
					{name : 'clientid' , type: 'String' },
					{name : 'name' , type: 'String' },
					{name : 'tr_no' , type: 'number'}, 
					{name : 'reftype' , type: 'String'}, 
					{name : 'area' , type: 'String'}, 
					{name : 'areaid' , type: 'String'}, 
					{name : 'site' , type: 'String'}, 
					{name : 'siteid' , type: 'String'}, 
					{name : 'amount' , type: 'number'}, 
					{name : 'pytno' , type: 'number'}, 
			        {name : 'jbaction' , type: 'number'}, 
			        {name : 'brhid' , type: 'String'},
				    {name : 'appreditdis' , type: 'number'},
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
         height: 300,
         source: dataAdapter,
         columnsresize: true,
         selectionmode: 'singlerow',
         pagermode: 'default',
         editable: false,

         columns: [
              
                 
					{ text: 'Doc No', datafield: 'doc_no', width: '9%' },
					{ text: 'Date', datafield: 'date', width: '9%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Cldocno', datafield: 'clientid', width: '20%',hidden:true },
					{ text: 'Name', datafield: 'name', width: '25%' },
					{ text: 'Ref Type', datafield: 'reftype', width: '8%' },
					{ text: 'trno', datafield: 'tr_no', width: '20%',hidden:true },
					{ text: 'Site', datafield: 'site', width: '20%' },
					{ text: 'siteid', datafield: 'siteid', width: '20%',hidden:true },
					{ text: 'Area', datafield: 'area', width: '17%' },
					{ text: 'areaid', datafield: 'areaid', width: '20%',hidden:true },
					{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '12%', cellsalign: 'right', align: 'right' },
					{ text: 'pytno', datafield: 'pytno', width: '20%',hidden:true },
					{ text: 'jbaction', datafield: 'jbaction', width: '20%',hidden:true },
					{ text: 'brhid', datafield: 'brhid', width: '10%',hidden:true },
					{ text: 'appreditdis', datafield: 'appreditdis', width: '10%',hidden:true },				
				]
     });
     
     $('#subsearch').on('celldoubleclick', function (event) {
         
    	 var rowindex1=event.args.rowindex;
    	 
    	  $('#docno').attr('disabled', false);
 		 $('#masterdoc_no').attr('disabled', false);
 		 $('#mode').attr('disabled', false);
 		 $('#hidbrhid').attr('disabled', false);
    	 
    	 $('#date').jqxDateTimeInput({ disabled: false}); 
	      
         document.getElementById("txtclient").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "name");
         document.getElementById("cmbreftype").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "reftype");
         document.getElementById("clientid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "clientid");
         $('#date').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
         document.getElementById("masterdoc_no").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
         document.getElementById("docno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
         document.getElementById("hidbrhid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "brhid");
         
         var docno=$('#masterdoc_no').val();
         
         var pytno= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "pytno");
         var jbact= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "jbaction");
         var appreditdis= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "appreditdis"); 
         
         if(pytno==1 || jbact==4 || appreditdis==1)
      	   {
      	   $('#hidcontredit').attr('disabled', false);
      	   document.getElementById("hidcontredit").value="1";
      	   }
         else
  	   {
  	   $('#hidcontredit').attr('disabled', false);
  	   document.getElementById("hidcontredit").value="0";
  	   }
         
 		if(docno>0){
 			
 			 $("#schediv").load("serviceScheduleGrid.jsp?docno="+docno);
			 $("#sitediv").load("siteGrid.jsp?docno="+docno);
			 $("#paydiv").load("paymentGrid.jsp?docno="+docno);
			 $("#serdiv").load("serviceGrid.jsp?docno="+docno);
 		}
     	 
         $('#frmjobcontract').submit();
         
        $('#window').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="subsearch"></div>

    
    </body>
</html>

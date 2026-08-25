<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<%@page import="com.cargo.costingforinvoicing.ClsCostingForInvoicingDAO"%>
<% ClsCostingForInvoicingDAO DAO = new ClsCostingForInvoicingDAO(); %> 
<%
String date = request.getParameter("date")==null?"":request.getParameter("date");
String docno = request.getParameter("docno")==null?"":request.getParameter("docno");
String client = request.getParameter("client")==null?"":request.getParameter("client");
String refno = request.getParameter("refno")==null?"":request.getParameter("refno");
String id = request.getParameter("id")==null?"0":request.getParameter("id");
%> 

 <script type="text/javascript">
 var estmasterdata; 
  $(document).ready(function () { 	
      var id = '<%=id%>'; 
      if(id==1){
    	  estmasterdata='<%=DAO.masterSearch(session,date,docno,client,refno,id)%>';
      }
     var source =
     {
         datatype: "json", 
         datafields: [
	                {name : 'voc_no' , type: 'number' },
                 
                   	{name : 'date' , type: 'date' },
                   	{name : 'desc1' , type: 'String' },
                   	{name : 'jobno' , type: 'int' },
                   
		            {name : 'refnos', type: 'string'  }
                   	],
          localdata: estmasterdata,
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
     $("#subEstmSearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
         selectionmode: 'singlerow',
         pagermode: 'default',
         columns: [
				{ text: 'Doc No', datafield: 'voc_no', width: '10%'  },
			 
				{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Job No', datafield: 'jobno', width: '20%'  },
				{ text: 'Ref No', datafield: 'refnos', width: '25%'  },
	 
				{ text: 'Remarks', datafield: 'desc1'  },
				]
     });
     $('#subEstmSearch').on('rowdoubleclick', function (event) 
     { 
    	 var rowindex1=event.args.rowindex;
             
           
              document.getElementById("docno").value= $('#subEstmSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
              $("#frmCFI").submit();
              $('#window').jqxWindow('close');
     });	 
 });
</script>
<div id="subEstmSearch"></div>
</body>
</html>

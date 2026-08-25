<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsEstimationDAO DAO = new ClsEstimationDAO(); %>
<%@page import="com.cargo.estimation.ClsEstimationDAO"%>
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
    	  estmasterdata='<%=DAO.masterSearch(date,docno,client,refno,id,session)%>';
      }
     var source =
     {
         datatype: "json",
         datafields: [
	                {name : 'voc_no' , type: 'number' },
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                   	{name : 'reftype' , type: 'String' },
                   	{name : 'rrefno' , type: 'int' },
                   	{name : 'cldocno' , type: 'String' },
                   	{name : 'refname' , type: 'String' },
                   	{name : 'address', type: 'string'  },
		            {name : 'mob', type: 'string'  },
		            {name : 'email', type: 'string'  },
		            {name : 'remarks', type: 'string'  },
		        	{name : 'enqdocno' , type: 'number' },
		            
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
         height: 355,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
         selectionmode: 'singlerow',
         pagermode: 'default',
         columns: [
				{ text: 'Doc No', datafield: 'doc_no', width: '12%' ,hidden:true},
				{ text: 'Doc No', datafield: 'voc_no', width: '7%' },
				{ text: 'Date', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
				{ text: 'reftype', datafield: 'reftype', width: '5%',hidden:true },
				{ text: 'Ref No', datafield: 'rrefno', width: '8%' },
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true  },
				{ text: 'Client', datafield: 'refname', width: '35%' },
				{ text: 'address', datafield: 'address', width: '10%'  },
				{ text: 'mob', datafield: 'mob', width: '15%'   },
				{ text: 'email', datafield: 'email', width: '13%'   },
				{ text: 'remarks', datafield: 'remarks', width: '2%'  ,hidden:true },
				]
     });
     $('#subEstmSearch').on('rowdoubleclick', function (event) 
     { 
    	 var rowindex1=event.args.rowindex;
           
              $("#estmDate").jqxDateTimeInput('val',$('#subEstmSearch').jqxGrid('getcellvalue', rowindex1, "date"));
              
              document.getElementById("masterdoc_no").value= $('#subEstmSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              document.getElementById("docno").value= $('#subEstmSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
              document.getElementById("cmbreftype").value= $('#subEstmSearch').jqxGrid('getcellvalue', rowindex1, "reftype");
              document.getElementById("refno").value= $('#subEstmSearch').jqxGrid('getcellvalue', rowindex1, "rrefno");
			  $('#txtclient').val($('#subEstmSearch').jqxGrid('getcellvalue',rowindex1,"cldocno"));
			  $('#txtclientname').val($('#subEstmSearch').jqxGrid('getcellvalue',rowindex1,"refname"));
			  $('#txtaddress').val($('#subEstmSearch').jqxGrid('getcellvalue',rowindex1,"address"));
			  $('#txtmobile').val($('#subEstmSearch').jqxGrid('getcellvalue',rowindex1,"mob"));
			  $('#txtemail').val($('#subEstmSearch').jqxGrid('getcellvalue',rowindex1,"email"));
			  $('#txtRemarks').val($('#subEstmSearch').jqxGrid('getcellvalue',rowindex1,"remarks"));
			  $('#hidrefno').val($('#subEstmSearch').jqxGrid('getcellvalue',rowindex1,"enqdocno"));
			  $("#enqdiv").load('reqDetails.jsp?enqrdocno='+$('#subEstmSearch').jqxGrid('getcellvalue', rowindex1, "enqdocno"));
			  funchkforedit();
              $("#subEstmSearch").jqxGrid('clear');
              $('#window').jqxWindow('close');
     });	 
 });
</script>
<div id="subEstmSearch"></div>
</body>
</html>

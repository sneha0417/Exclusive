
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.Sales.deliverynotereturn.ClsDeliverynoteReturnDAO"%>
<%ClsDeliverynoteReturnDAO DAO= new ClsDeliverynoteReturnDAO();%>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_enqno = request.getParameter("Cl_enqno")==null?"0":request.getParameter("Cl_enqno");
 String qotdate = request.getParameter("qotdate")==null?"0":request.getParameter("qotdate");
 String qottype = request.getParameter("qottype")==null?"0":request.getParameter("qottype").trim(); 


 String Cl_clientsale1 = request.getParameter("Cl_clientsale1")==null?"0":request.getParameter("Cl_clientsale1").trim(); 
 String Cl_mobnos = request.getParameter("Cl_mobnos")==null?"0":request.getParameter("Cl_mobnos").trim(); 
 
%> 

 <script type="text/javascript">
 
 var qotmasterdata; 
 

  qotmasterdata='<%=DAO.searchMaster(session,msdocno,Cl_names,Cl_enqno,qotdate,qottype,Cl_clientsale1,Cl_mobnos)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
					{name : 'voc_no' , type: 'number' },
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                	{name : 'dtype' , type: 'String' },
                	{name : 'brhid' , type: 'String' },
                    {name : 'cldocno' , type: 'String' },
                   	{name : 'name' , type: 'String' },
                   	{name : 'cladd' , type: 'String' },
                 	{name : 'ref_type' , type: 'String' },
                 	{name : 'rrefno' , type: 'String' },
                 	

                 	
                 	{name : 'saldocno' , type: 'String' },
                 	
                 	{name : 'sal_name' , type: 'String' },
                 	{name : 'per_mob' , type: 'String' },
                 	
                   	],
          localdata: qotmasterdata,
         
         
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
     $("#subquotationSearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
        selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
				{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Dtype', datafield: 'dtype', width: '10%',hidden:true},
				{ text: 'Brhid', datafield: 'brhid', width: '20%',hidden:true},
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'cladd', datafield: 'cladd', width: '20%',hidden:true },
				{ text: 'Client', datafield: 'name', width: '30%' },
				{ text: 'MOB', datafield: 'per_mob', width: '12%' },
				{ text: 'Sales Person', datafield: 'sal_name', width: '25%' },
				{ text: 'Ref.type', datafield: 'ref_type', width: '8%' },
				{ text: 'Quotation', datafield: 'rrefno', width: '10%',hidden:true },
				
				]
     });
     
     $('#subquotationSearch').on('celldoubleclick', function (event) {
         
     	var columnindex1=event.args.columnindex;
     	 var rowindex1 = event.args.rowindex;
     	 var datafield = event.args.datafield;
     	 var dtype=document.getElementById("formdetailcode").value;
     	
     	document.getElementById("masterdoc_no").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        document.getElementById("docno").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
        document.getElementById("date").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "date");
        document.getElementById("clientid").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
        document.getElementById("txtclientdet").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "cladd");         
        document.getElementById("txtclient").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "name");
        document.getElementById("cmbreftype").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "ref_type");
        document.getElementById("rrefno").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "rrefno");
        funSetlabel();
        document.getElementById("frmdeliveryNoteReturn").submit();
        $('#window').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="subquotationSearch"></div>

    
    </body>
</html>

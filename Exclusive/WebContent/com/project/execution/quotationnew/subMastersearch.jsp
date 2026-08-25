<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.quotationnew.ClsQuotationDAO"%> 
<%ClsQuotationDAO DAO= new ClsQuotationDAO();%>
 <% 
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
 String refno = request.getParameter("refno")==null?"0":request.getParameter("refno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String sereftype = request.getParameter("sereftype")==null?"0":request.getParameter("sereftype");
 String surdate = request.getParameter("surdate")==null?"0":request.getParameter("surdate");
 String cntrtype = request.getParameter("cntrtype")==null?"0":request.getParameter("cntrtype");
 int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
 String Cl_site = request.getParameter("Cl_site")==null?"0":request.getParameter("Cl_site");
 String Cl_area = request.getParameter("Cl_area")==null?"0":request.getParameter("Cl_area");
 String Cl_amount = request.getParameter("Cl_amount")==null?"NA":request.getParameter("Cl_amount");
%> 

 <script type="text/javascript">
 
 var searchdata; 
 
 
   searchdata='<%=DAO.searchMaster(session,msdocno,Cl_names,sereftype,surdate,cntrtype,id,Cl_site,Cl_area,Cl_amount,refno)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                  	{name : 'tr_no' , type: 'String' },
                  	{name : 'refno' , type: 'String' },
                  	{name : 'doc_no' , type: 'String' },
                  	{name : 'netamount' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'refno' , type: 'String' },
                   	{name : 'dtype' , type: 'String' },
                    {name : 'reftype' , type: 'String'}, 
                    {name : 'subject' , type: 'String'}, 
                    {name : 'refdocno' , type: 'String'},
                    {name : 'clrefno' , type: 'String'},
                    {name : 'taxper' , type: 'number'},
                    {name : 'tax' , type: 'number'},
                    {name : 'amount' , type: 'number'},
                    {name : 'discount' , type: 'number'},
                    {name : 'disper' , type: 'number'},
                    {name : 'total' , type: 'number'},
                    {name : 'cntr_type' , type: 'String'},
                    {name : 'name' , type: 'String'},
                    {name : 'clientid' , type: 'String'},
                    {name : 'cperson' , type: 'String'},
                    {name : 'contactdet' , type: 'String'},
                    {name : 'address' , type: 'String'},
                    {name : 'per_mob' , type: 'String'},
                    {name : 'mail1' , type: 'String'},
                    {name : 'desc1' , type: 'String'},
                    {name : 'legalchrg' , type: 'String'},
                    {name : 'remarks' , type: 'String'},
                    {name : 'cpersonid' , type: 'String'},
                    {name : 'salname' , type: 'String'},
                    {name : 'salid' , type: 'String'},
                    {name : 'sjobtype' , type: 'number'}, 
                    {name : 'revision_no' , type: 'number'},
 {name : 'site' , type: 'String'},
                    {name : 'area' , type: 'String'},
                   /*  {name : 'maxrev' , type: 'number'}, */
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
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
        selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
                   
				     
				{ text: 'Doc No', datafield: 'doc_no', width: '8%' },
				{ text: 'Ref. No', datafield: 'refno', width: '8%' },
				{ text: 'Revision No', datafield: 'revision_no', width: '10%',hidden:true  },
				{ text: 'Date', datafield: 'date', width: '9%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Name', datafield: 'name', width: '28%' },
				{ text: 'Contract Type', datafield: 'cntr_type', width: '12%',hidden:false },
				{ text: 'Ref Type', datafield: 'reftype', width: '8%' },
				{ text: 'Site', datafield: 'site', width: '13%' },
				{ text: 'Area', datafield: 'area', width: '12%' },
				{ text: 'Net Total', datafield: 'netamount', width: '10%' },
				{ text: 'trno', datafield: 'tr_no', width: '20%',hidden:true },
				{ text: 'Cldocno', datafield: 'clientid', width: '20%',hidden:true },
				
				{ text: 'subject', datafield: 'subject', width: '20%',hidden:true },
				{ text: 'refDocNo', datafield: 'refdocno', width: '20%',hidden:true },
				{ text: 'clrefNo', datafield: 'clrefno', width: '20%',hidden:true },
				{ text: 'taxPer', datafield: 'taxper', width: '20%',hidden:true },
				{ text: 'tax', datafield: 'tax', width: '20%',hidden:true },
				{ text: 'amount', datafield: 'amount', width: '20%',hidden:true },
				{ text: 'discount', datafield: 'discount', width: '20%',hidden:true },
				{ text: 'disPer', datafield: 'disper', width: '20%',hidden:true },
				{ text: 'total', datafield: 'total', width: '20%',hidden:true },
				/* { text: 'Contract Type', datafield: 'cntr_type', width: '20%',hidden:false }, */
				{ text: 'cperson', datafield: 'cperson', width: '20%',hidden:true },
				{ text: 'cpersonid', datafield: 'cpersonid', width: '20%',hidden:true },
				{ text: 'contactdet', datafield: 'contactdet', width: '20%',hidden:true },
				{ text: 'address', datafield: 'address', width: '20%',hidden:true },
				{ text: 'per_mob', datafield: 'per_mob', width: '20%',hidden:true },
				{ text: 'mail1', datafield: 'mail1', width: '20%',hidden:true },
				{ text: 'legalchrg', datafield: 'legalchrg', width: '20%',hidden:true },
				{ text: 'salname', datafield: 'salname', width: '20%',hidden:true },
				{ text: 'salid', datafield: 'salid', width: '20%',hidden:true },
				{ text: 'sjobtype', datafield: 'sjobtype', width: '20%',hidden:true },
				{ text: 'appreditdis', datafield: 'appreditdis', width: '10%',hidden:true },   
			 ]
     });
     $('#subsearch').on('celldoubleclick', function (event) {
         
    	 var rowindex1=event.args.rowindex;
    	 
    	 $('#doc_no').attr('disabled', false);
 		 $('#masterdoc_no').attr('disabled', false);
 		 $('#mode').attr('disabled', false);
 		 $('#date').jqxDateTimeInput({ disabled: false}); 
	     document.getElementById("txtclient").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "name");
         document.getElementById("cmbreftype").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "reftype");
         document.getElementById("clientid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "clientid");
         $('#date').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
         $('#hiddate').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
         document.getElementById("masterdoc_no").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
         document.getElementById("docno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
         document.getElementById("hidradio").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "cntr_type");
         document.getElementById("txtrevise").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "revision_no");
         var docno=$('#masterdoc_no').val();
         var appreditdis= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "appreditdis"); 
         var revision=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "revision_no");
         if(appreditdis==1 || revision>0)
      	   {
      	   $('#hideditdisable').attr('disabled', false);
      	   document.getElementById("hideditdisable").value="1";
      	   }
         else
  	   {
  	   $('#hidcontredit').attr('disabled', false);
  	   document.getElementById("hideditdisable").value="0";
  	   }
       
         if(docno>0){
        	/*  document.getElementById("revcheck").value="0";
        	 var revno=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "revision_no");
        	 var maxrev=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "maxrev");
        	if(revno==maxrev)
        		{
        		document.getElementById("revcheck").value="1";
   				
   				
        		} */
        	 var rdo=document.getElementById("hidradio").value;
        	 var sjobtype=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "sjobtype");
 			if(rdo=='AMC'){
 				document.getElementById("ramc").checked=true;
 				
 			}
 			if(rdo=='SJOB'){
 				document.getElementById("rsjob").checked=true;
 				if(sjobtype>0){
 	      			 document.getElementById("hidcmbprocess").value=sjobtype;
 	      			}
 				
 			}
         
         var dtype=$('#formdetailcode').val().trim();
         
		 $("#siteDetailsDiv").load("siteGrid.jsp?docno="+docno);
		 $("#serviceDetailsDiv").load("serviceGrid.jsp?docno="+docno);
		 $("#termsDiv").load("termsGrid.jsp?dtype="+dtype+"&qotdoc="+docno);
		 
		 $("#frmQuotation").submit();
		 
         }
         
        $('#window').jqxWindow('close');
        
       
        
     	 });
     
     

 });
</script>
<div id="subsearch"></div>

    
    </body>
</html>

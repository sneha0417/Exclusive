
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.marketing.salesenquiry.ClsSalesEnquiryDAO"%>
<% ClsSalesEnquiryDAO DAO = new ClsSalesEnquiryDAO(); %>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_mobno = request.getParameter("Cl_mobno")==null?"0":request.getParameter("Cl_mobno");
 String enqdate = request.getParameter("enqdate")==null?"0":request.getParameter("enqdate");
 
 String enqtype = request.getParameter("enqtype")==null?"0":request.getParameter("enqtype").trim(); 
 
 String Cl_clientsale1 = request.getParameter("Cl_clientsale1")==null?"0":request.getParameter("Cl_clientsale1").trim(); 
 

%> 

 <script type="text/javascript">
 
 var enqmasterdata; 
 

  enqmasterdata='<%=DAO.searchMaster(session,msdocno,Cl_names,Cl_mobno,enqdate,enqtype,Cl_clientsale1)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
					{name : 'voc_no' , type: 'number' },
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'cldocno' , type: 'String' },
                   	{name : 'name' , type: 'String' },
                   	{name : 'email' , type: 'String' },
                 	{name : 'mob' , type: 'String' },
                 	{name : 'cltype' , type: 'String' },
                 	{name : 'payterms' , type: 'String' },
                 	{name : 'delterms' , type: 'String' },
                 	{name : 'description' , type: 'String' },
                 	{name : 'cladd' , type: 'String' },
                 	
                 	{name : 'shipdetid' , type: 'String' },
                 	{name : 'clname' , type: 'String' },
                 	{name : 'claddress' , type: 'String' },
                 	{name : 'contactperson' , type: 'String' },
                 	{name : 'telno' , type: 'String' },
                 	{name : 'mobno' , type: 'String' },
                 	
                 	{name : 'emailid' , type: 'String' },
                 	{name : 'faxno' , type: 'String' },
                 	
                 	{name : 'sal_id' , type: 'String' },
                 	{name : 'sal_name' , type: 'String' },
                 	
                 	 
                 	
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
				{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'name', width: '35%' },
				{ text: 'Sales Person', datafield: 'sal_name', width: '25%' },
				{ text: 'Email', datafield: 'email', width: '25%' ,hidden:true},
				{ text: 'clname', datafield: 'clname', width: '25%' ,hidden:true},
				{ text: 'MOB', datafield: 'mob', width: '15%' },
				{ text: 'cltype', datafield: 'cltype', width: '15%',hidden:true },
				{ text: 'payterms', datafield: 'payterms', width: '15%',hidden:true },
				{ text: 'delterms', datafield: 'delterms', width: '15%',hidden:true },
				{ text: 'description', datafield: 'description', width: '15%',hidden:true },
				
			
				{ text: 'sal_id', datafield: 'sal_id', width: '25%',hidden:true },
				
				
				]
     });
     
     
     
     $('#subEnqirySearch').on('rowdoubleclick', function (event) 
     		{ 
    	 
    	 document.getElementById("txtclientdet").value="";
         document.getElementById("txtclient").value="";
 	  var rowindex1=event.args.rowindex;
     	
     	
 	  var cldocnval=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "cltype");
 	
       if(cldocnval==1)
     	  {
    	   document.getElementById("txtclientdet").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "name");
     	 
     	  }
       if(cldocnval==0)
 	  {
    	   document.getElementById("txtclient").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "name");
    	   document.getElementById("txtclientdet").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "cladd");
 	  } 
 	  
 	  
   	$('#date').jqxDateTimeInput({ disabled: false});
       $('#date').val($("#subEnqirySearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
       
              document.getElementById("txtmob").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "mob"); 
              document.getElementById("masterdoc_no").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              document.getElementById("docno").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
              document.getElementById("txtemail").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "email");
              document.getElementById("clientid").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "cldocno");         
              document.getElementById("delterms").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "delterms");
              document.getElementById("payterms").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "payterms");
              document.getElementById("txtdesc").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "description");
              //document.getElementById("date").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "date");
              
              
       
              
              
             document.getElementById("shipdocno").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "shipdetid");
          
            document.getElementById("shipto").value=$('#subEnqirySearch').jqxGrid('getcelltext', rowindex1, "clname"); 
                        
            document.getElementById("shipaddress").value=$('#subEnqirySearch').jqxGrid('getcelltext', rowindex1, "claddress");  
            document.getElementById("contactperson").value=$('#subEnqirySearch').jqxGrid('getcelltext', rowindex1, "contactperson"); 
            
            document.getElementById("shipemail").value=$('#subEnqirySearch').jqxGrid('getcelltext', rowindex1, "emailid"); 
            document.getElementById("shiptelephone").value=$('#subEnqirySearch').jqxGrid('getcelltext', rowindex1, "telno"); 
            document.getElementById("shipmob").value=$('#subEnqirySearch').jqxGrid('getcelltext', rowindex1, "mobno"); 
            document.getElementById("shipfax").value=$('#subEnqirySearch').jqxGrid('getcelltext', rowindex1, "faxno"); 
            			     
              
            document.getElementById("txtsalesperson").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
            document.getElementById("salespersonid").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "sal_id");
      
         $('#window').jqxWindow('close');
     	/* $('#date').jqxDateTimeInput({ disabled: false}); */
     	   	 funSetlabel();
         document.getElementById("salesEnquiry").submit();
        
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="subEnqirySearch"></div>

    
    </body>
</html>

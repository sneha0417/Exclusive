
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.completioncertificate.ClsCompletionCertificateDAO"%>
<%
ClsCompletionCertificateDAO viewDAO=new ClsCompletionCertificateDAO();
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String contno = request.getParameter("contno")==null?"0":request.getParameter("contno");
 String invdate = request.getParameter("invsdate")==null?"0":request.getParameter("invsdate");
 
 String invtype = request.getParameter("invtype")==null?"0":request.getParameter("invtype").trim();
 int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").trim());
%> 

 <script type="text/javascript">
 
 var masterdata; 
 

  masterdata='<%=viewDAO.searchMaster(session,msdocno,Cl_names,contno,invdate,invtype,id)%>' ;

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                  
                   	{name : 'client' , type: 'String' },
                  
                   	{name : 'contype' , type: 'String' },
                 {name : 'contno' , type: 'String' },
                 	{name : 'invtype' , type: 'Int' },
                 	{name : 'ctrno' , type: 'String' },
                 	{name : 'reten', type: 'number' },	
                 	{name : 'inv', type: 'number' },	
                   /*  {name : 'cldocno' , type: 'string'},
                    {name : 'clacno' , type: 'string'},
                    {name : 'costid' , type: 'string'},
                    {name : 'conttypeval' , type: 'string'} */
						
                   	],
          localdata: masterdata,
         
         
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
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
			
				{ text: 'Client', datafield: 'client', width: '45%' },
				{ text: 'Contract Type', datafield: 'contype', width: '15%' },
				
				{ text: 'Contract No', datafield: 'contno', width: '15%' },
				{ text: 'invtype', datafield: 'invtype', width: '20%',hidden:true },
				{ text: 'Contract trNo', datafield: 'ctrno', width: '15%',hidden:true },
				{ text: 'reten',  datafield: 'reten', width: '10%',hidden:true },
				{ text: 'inv',  datafield: 'inv', width: '10%',hidden:true },
				/* { text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Costid', datafield: 'costid', width: '20%',hidden:true },
				{ text: 'Clacno', datafield: 'clacno', width: '20%',hidden:true },
				{ text: 'Conttypeval', datafield: 'conttypeval', width: '20%',hidden:true } */
		
				]
     });
     

     $('#subEnqirySearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
     	
 		$('#date').jqxDateTimeInput({ disabled: false});
        $('#date').val($("#subEnqirySearch").jqxGrid('getcellvalue', rowindex1, "date")) ; 
       
        document.getElementById("contrretn").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "reten");
              document.getElementById("maintrno").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              
         $('#window').jqxWindow('close');
     	$('#date').jqxDateTimeInput({ disabled: true});
     	$('#mode').attr('disabled',false);
     	$('#maintrno').attr('disabled',false);
     	$('#contrretn').attr('disabled',false);
     	$('#hidestedit').attr('disabled',false);
     	 var inv= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "inv");
         
         if(parseFloat(inv)>0)
      	   {
       
      	   document.getElementById("hidestedit").value="1";
    
      	   }
         else
  	   {
       
  	   document.getElementById("hidestedit").value="0";
  	   }
     	
     	
    document.getElementById("fromcompletioncertificate").submit();
        
        
     
     		 });	 
   
 

 });
</script>
<div id="subEnqirySearch"></div>

    
    </body>
</html>

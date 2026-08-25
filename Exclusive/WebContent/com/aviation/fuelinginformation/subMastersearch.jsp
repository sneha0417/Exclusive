 
 <%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="com.aviation.fuelinginformation.ClsfuelingInformationDAO"%>
<% ClsfuelingInformationDAO  fuelinfoDAO = new ClsfuelingInformationDAO(); %> 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_mobno = request.getParameter("Cl_mobno")==null?"0":request.getParameter("Cl_mobno");
 String enqdate = request.getParameter("enqdate")==null?"0":request.getParameter("enqdate");
 
 String enqtype = request.getParameter("enqtype")==null?"0":request.getParameter("enqtype").trim(); 
 String dtypes = request.getParameter("dtypes")==null?"0":request.getParameter("dtypes");
 
 
%> 

 <script type="text/javascript">
 
 var enqmasterdata; 
 
   enqmasterdata='<%=fuelinfoDAO.searchMaster(session,msdocno,Cl_names,Cl_mobno,enqdate,enqtype,dtypes)%>'; 

  $(document).ready(function () { 	
     
     var source =
     {
     		
         datatype: "json",
         datafields: [

	                {name : 'voc_no' , type: 'number' },
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'cldocno' , type: 'String' },
                   	{name : 'name' , type: 'String' },
                   	{name : 'com_add1' , type: 'String' },
                 	{name : 'mob' , type: 'String' },
                 	{name : 'reqtype' , type: 'Int' },
                    {name : 'notes' , type: 'String'}                      	
                   	
						
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
     $("#subFuelInfoSearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
       
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%' ,hidden:true},
				{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'name', width: '25%' },
				{ text: 'Address', datafield: 'com_add1', width: '35%' },
				{ text: 'MOB', datafield: 'mob', width: '15%' },
				{ text: 'enqtype', datafield: 'reqtype', width: '20%',hidden:true },
				{ text: 'Notes', datafield: 'notes', width: '20%',hidden:true }
		
				]
     });
     
   
     $('#subFuelInfoSearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
     	
     	 
   	$('#FuelInfoDate').jqxDateTimeInput({ disabled: false});
       $('#FuelInfoDate').val($("#subFuelInfoSearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
              document.getElementById("masterdoc_no").value= $('#subFuelInfoSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              document.getElementById("docno").value= $('#subFuelInfoSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
              document.getElementById("txtnotes").value=$('#subFuelInfoSearch').jqxGrid('getcellvalue', rowindex1, "notes");
                  
              $('#window').jqxWindow('close');
     	$('#FuelInfoDate').jqxDateTimeInput({ disabled: false});
     	
         document.getElementById("frmFuelInfo").submit();
        
        
     
     		 });	 
     
     
    
    
 

 });
</script>
<div id="subFuelInfoSearch"></div>

    
    </body>
</html>

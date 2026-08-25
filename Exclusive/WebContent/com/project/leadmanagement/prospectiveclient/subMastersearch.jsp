
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.leadmanagement.prospectiveclient.ClsProspectiveClientDAO"%>
<%
ClsProspectiveClientDAO viewDAO=new ClsProspectiveClientDAO();
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String salman = request.getParameter("salman")==null?"0":request.getParameter("salman");
 String cpdate = request.getParameter("cpdate")==null?"0":request.getParameter("cpdate");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
%> 

 <script type="text/javascript">
 
 var masterdata; 
 var id='<%=id%>';

 if(id==1){
	 masterdata='<%=viewDAO.searchMaster(session,msdocno,Cl_names,salman,cpdate)%>' ;
 }else{
	 masterdata=[];
 }
  

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                  
                   	{name : 'name' , type: 'String' },
                  
                   	{name : 'salname' , type: 'String' },
                
                    {name : 'tr_no' , type: 'number'},
                    
						
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
     $("#subprosclientSearch").jqxGrid(
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
				{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
			
				{ text: 'Name', datafield: 'name', width: '45%' },
				{ text: 'Salesman', datafield: 'salname', width: '35%' },
				
				{ text: 'trno', datafield: 'tr_no', width: '20%',hidden:true },
				
		
				]
     });
     

     $('#subprosclientSearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
     	
 		$('#date').jqxDateTimeInput({ disabled: false});
        $('#date').val($("#subprosclientSearch").jqxGrid('getcellvalue', rowindex1, "date")) ; 
              
              document.getElementById("maintrno").value= $('#subprosclientSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
              
            
              
         $('#window').jqxWindow('close');
     	$('#date').jqxDateTimeInput({ disabled: true});
     	$('#mode').attr('disabled',false);
     	$('#maintrno').attr('disabled',false);
    document.getElementById("frmprospectiveclient").submit();
        
       
     		 });	 
   
 

 });
</script>
<div id="subprosclientSearch"></div>

    
    </body>
</html>

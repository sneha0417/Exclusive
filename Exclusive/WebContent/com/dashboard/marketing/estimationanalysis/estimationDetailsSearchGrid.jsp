<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.marketing.estimationanalysis.ClsEstimationAnalysisDAO" %>
<% ClsEstimationAnalysisDAO DAO=new ClsEstimationAnalysisDAO(); %>
 <%
 
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_namess = request.getParameter("Cl_namess")==null?"0":request.getParameter("Cl_namess");
 String dates = request.getParameter("dates")==null?"0":request.getParameter("dates");
 String reftype = request.getParameter("reftype")==null?"0":request.getParameter("reftype");
 String refno = request.getParameter("refno")==null?"0":request.getParameter("refno");
 int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
 
%> 

 <script type="text/javascript">
 
 var searchdata='<%=DAO.estimationDetailsSearchGridLoading(session,msdocno,Cl_namess,dates,reftype,id,refno)%>';
	
  $(document).ready(function () { 	
     
     var source =
     {
     		
         datatype: "json",
         datafields: [
                      
                    {name : 'doc_no' , type: 'number' },
                  	{name : 'tr_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'client' , type: 'String' },
                    {name : 'reftrno' , type: 'String' },
                   	{name : 'cldocno' , type: 'String' },
                	{name : 'reviseno' , type: 'String' },
                    {name : 'ref_type' , type: 'String'}, 
                    {name : 'refdocno' , type: 'String'}, 
                    {name : 'material' , type: 'String'},
                    {name : 'labour' , type: 'String'},
                    {name : 'machine' , type: 'String'},
                    {name : 'nettotal' , type: 'String'},
                    {name : 'address' , type: 'String'},
                    {name : 'esttrno' , type: 'String'},
                    {name : 'qottrno' , type: 'String'},
                    {name : 'surtrno' , type: 'String'},
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
     $("#estimationDetailsSearchGridId").jqxGrid(
     {
    	 width: '100%',
         height: 303,
         source: dataAdapter,
         selectionmode: 'singlerow',
      
         columns: [
                   
				{ text: 'Doc No', datafield: 'doc_no', width: '15%' },
				{ text: 'Tr No', datafield: 'tr_no', width: '15%',hidden:true },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'RefType', datafield: 'ref_type', width: '15%' },
				{ text: 'RefDocNo', datafield: 'refdocno', width: '20%'},
				{ text: 'Client', datafield: 'client', width: '35%' },
				{ text: 'cldocno', datafield: 'cldocno', width: '15%',hidden:true },
				{ text: 'reviseno', datafield: 'reviseno', width: '20%',hidden:true },
				{ text: 'refdocno', datafield: 'reftrno', width: '17%',hidden:true  },
				{ text: 'material', datafield: 'material', width: '17%',hidden:true  },
				{ text: 'labour', datafield: 'labour', width: '17%',hidden:true },
				{ text: 'machine', datafield: 'machine', width: '17%',hidden:true },
				{ text: 'netTotal', datafield: 'nettotal', width: '17%',hidden:true },
				{ text: 'address', datafield: 'address', width: '17%',hidden:true },
				{ text: 'esttrno', datafield: 'esttrno', width: '17%',hidden:true },
				{ text: 'qottrno', datafield: 'qottrno', width: '17%',hidden:true },
				{ text: 'surtrno', datafield: 'surtrno', width: '17%',hidden:true },
				
				]
     });
     
     $('#estimationDetailsSearchGridId').on('rowdoubleclick', function (event) {
         var rowindex1 = event.args.rowindex;
         document.getElementById("txtestimationno").value = $('#estimationDetailsSearchGridId').jqxGrid('getcellvalue', rowindex1, "doc_no");
         document.getElementById("txtestimationtrno").value = $('#estimationDetailsSearchGridId').jqxGrid('getcellvalue', rowindex1, "tr_no");
     	
     	$('#estimationDetailsWindow').jqxWindow('close'); 
     });  
     
     

 });
</script>
<div id="estimationDetailsSearchGridId"></div>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.estimationnew.ClsEstimationDAO"%> 
<%ClsEstimationDAO DAO= new ClsEstimationDAO();%>
 <%
 
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_namess = request.getParameter("Cl_namess")==null?"0":request.getParameter("Cl_namess");
 String dates = request.getParameter("dates")==null?"0":request.getParameter("dates");
 String reftype = request.getParameter("reftype")==null?"0":request.getParameter("reftype");
 String refno = request.getParameter("refno")==null?"0":request.getParameter("refno");
 int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
 
%> 

 <script type="text/javascript">
 
 var searchdata;
 
  searchdata='<%=DAO.searchMaster(session,msdocno,Cl_namess,dates,reftype,id,refno)%>';
	
  $(document).ready(function () { 	
     
      var num = 0; 
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
                    {name : 'contrmode' , type: 'String'},
                    {name : 'scopegrpid' , type: 'int'},
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
				{ text: 'contrmode', datafield: 'contrmode', width: '17%',hidden:true },
				{ text: 'Scope Group', datafield: 'scopegrpid', width: '20%',hidden:true },
				
				]
     });
     
     $('#subsearch').on('celldoubleclick', function (event) {
         
    	 var rowindex1=event.args.rowindex;
          var loadid=2;
          
    	  $('#doc_no').attr('disabled', false);
 		 $('#masterdoc_no').attr('disabled', false);
 		 $('#mode').attr('disabled', false);
 		 $('#cmbreftype').attr('disabled', false);
 		 $('#cmbscopegroup').attr('disabled', false);
    	 $('#date').jqxDateTimeInput({ disabled: false}); 
    	 
         document.getElementById("docno").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
         document.getElementById("masterdoc_no").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
         document.getElementById("txtreviseno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "reviseno");
         $('#date').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
         $('#hiddate').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
         document.getElementById("txtclient").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "client");
         document.getElementById("clientid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
         document.getElementById("cmbreftype").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "ref_type");
         document.getElementById("hidcmbreftype").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "ref_type");
         document.getElementById("txtenquiry").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "refdocno");
         document.getElementById("enquiryid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "reftrno");
         document.getElementById("txtcontrmode").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "contrmode");
         document.getElementById("hidcmbscopegroup").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "scopegrpid");
         //getScopeGroup();
         
        /*  document.getElementById("txtmatotal").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "material");
         document.getElementById("txtlabtotal").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "labour");
         document.getElementById("txteqptotal").value=parseFloat($('#subsearch').jqxGrid('getcellvalue', rowindex1, "machine"));
         document.getElementById("txtnetotal").value=parseFloat($('#subsearch').jqxGrid('getcellvalue', rowindex1, "nettotal")); */
         document.getElementById("txtnettotal").value=parseFloat($('#subsearch').jqxGrid('getcellvalue', rowindex1, "nettotal"));
         document.getElementById("txtclientdet").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "address");
         
         
         document.getElementById("hidsurtrno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "surtrno");
   	  document.getElementById("hidenqtrno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "reftrno");
         
         var docno=$('#masterdoc_no').val();
         var cmbreftype=$('#cmbreftype').val();
         if(cmbreftype!='DIR'){
        	 $('#cmbreftype').attr('disabled', false);
         }
         
         var esttrno= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "esttrno");
         var qottrno= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "qottrno");
        
         if(esttrno>0 && qottrno>0)
      	   {
        
      	   document.getElementById("hidestedit").value="1";
    
      	   }
         else
  	   {
       
  	   document.getElementById("hidestedit").value="0";
  	   }
         
         if(docno>0){
        	 refChange();
			 $("#materialDiv").load("materialDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
			
			
			 
         }
         
         $('#frmEstimation select').attr('disabled', false);
         $('#date').jqxDateTimeInput({disabled: false});
         funSetlabel();
         document.getElementById("frmEstimation").submit();
         $('#frmEstimation select').attr('disabled', true);
         $('#date').jqxDateTimeInput({disabled: true});
         
        $('#window').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="subsearch"></div>

    
    </body>
</html>

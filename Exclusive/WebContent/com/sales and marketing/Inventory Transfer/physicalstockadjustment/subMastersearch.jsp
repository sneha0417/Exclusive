
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.InventoryTransfer.physicalstockadjustment.ClsphysicalStockadjustmentDAO"%>
<%ClsphysicalStockadjustmentDAO DAO= new ClsphysicalStockadjustmentDAO();
 
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String desc = request.getParameter("descs")==null?"0":request.getParameter("descs");
 
 String qotdate = request.getParameter("qotdate")==null?"0":request.getParameter("qotdate");
 
%> 

 <script type="text/javascript">
 
 var qotmasterdata; 
 

  qotmasterdata='<%=DAO.searchMaster(session,msdocno,desc,qotdate)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
					{name : 'voc_no' , type: 'number' },
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                 
                	{name : 'brhid' , type: 'String' },
                    {name : 'locid' , type: 'String' },
                   	{name : 'locname', type: 'String' },
                   	{name : 'descs' , type: 'String' },
                  
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
     $("#subSearch").jqxGrid(
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
			 
				{ text: 'Brhid', datafield: 'brhid', width: '20%',hidden:true},
				{ text: 'Description', datafield: 'descs', width: '75%'  },
				{ text: 'locid', datafield: 'locid', width: '20%',hidden:true },
				{ text: 'locname', datafield: 'locname', width: '30%' ,hidden:true  },
			 
				
				]
     });
     
     $('#subSearch').on('celldoubleclick', function (event) {
         
      
     	 var rowindex1 = event.args.rowindex;
 
        	$('#date').jqxDateTimeInput({ disabled: false});
            $('#date').val($("#subSearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
            
     	document.getElementById("masterdoc_no").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        document.getElementById("docno").value= $('#subSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
      
        document.getElementById("hidbrchids").value= $('#subSearch').jqxGrid('getcellvalue', rowindex1, "brhid");
        document.getElementById("locationid").value= $('#subSearch').jqxGrid('getcellvalue', rowindex1, "locid");         
        document.getElementById("txtlocation").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "locname");
        document.getElementById("txtdescription").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "descs");
      
        funSetlabel();
        document.getElementById("frmstkadjust").submit();
        $('#window').jqxWindow('close');
        
     	 });
  
     

 });
</script>
<div id="subSearch"></div>

    
    </body>
</html>

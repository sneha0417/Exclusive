
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.InventoryTransfer.InventoryTransferRecept.ClsTransferReceptDAO"%>
<%ClsTransferReceptDAO DAO= new ClsTransferReceptDAO();%>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String tobranch = request.getParameter("tobranch")==null?"0":request.getParameter("tobranch");
 String tolocation = request.getParameter("tolocation")==null?"0":request.getParameter("tolocation");
 String sdate = request.getParameter("sdate")==null?"0":request.getParameter("sdate"); 
 String reftype = request.getParameter("reftype")==null?"0":request.getParameter("reftype");

%> 

 <script type="text/javascript">
 
 var masterdata; 
 

  masterdata='<%=DAO.searchMaster(session,msdocno,tobranch,tolocation,sdate,reftype)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
					{name : 'voc_no' , type: 'number' },
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                	{name : 'tobrhid' , type: 'String' },
                    {name : 'tolocid' , type: 'String' },
                   	{name : 'tobranch' , type: 'String' },
                   	{name : 'toloc' , type: 'String' },
                   	{name : 'frmbrhid' , type: 'String' },
                    {name : 'frmlocid' , type: 'String' },
                   	{name : 'frmbranch' , type: 'String' },
                   	{name : 'frmloc' , type: 'String' },
                 	{name : 'refno' , type: 'String' },
                 	{name : 'amount' , type: 'String' },
                 	{name : 'netamount' , type: 'String' },
                 	{name : 'servamt' , type: 'String' },
                 	{name : 'grantamt' , type: 'String' },
                 	{name : 'reftype' , type: 'String' },
                 	{name : 'remarks' , type: 'String' },
                 	{name : 'rrefno' , type: 'String' },
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
     $("#submasterSearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
        selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '5%',hidden:true },
				{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
				{ text: 'tolocid', datafield: 'tolocid', width: '10%' ,hidden:true},
				{ text: 'tobrchid', datafield: 'tobrhid', width: '20%' ,hidden:true},
				{ text: 'frmlocid', datafield: 'frmlocid', width: '20%',hidden:true },
				{ text: 'frmbrchid', datafield: 'frmbrhid', width: '20%',hidden:true },
				{ text: 'RefNo', datafield: 'refno', width: '12%' },
				{ text: 'From Location', datafield: 'frmloc', width: '22%'   },
				{ text: 'To Branch', datafield: 'tobranch', width: '22%' },
				{ text: 'To Location', datafield: 'toloc', width: '22%' },
				{ text: 'Frm Branch', datafield: 'frmbranch', width: '25%',hidden:true  },
				
				{ text: 'amount', datafield: 'amount', width: '25%',hidden:true  },
				{ text: 'netamount', datafield: 'netamount', width: '25%',hidden:true  },
				{ text: 'servamt', datafield: 'servamt', width: '25%',hidden:true  },
				{ text: 'grantamt', datafield: 'grantamt', width: '25%',hidden:true  },
				{ text: 'Remarks', datafield: 'remarks', width: '25%',hidden:true },
				{ text: 'Reftype', datafield: 'reftype', width: '15%',hidden:true  }
				
				]
     });
     
     $('#submasterSearch').on('celldoubleclick', function (event) {
    	 $('#date').jqxDateTimeInput({disabled: false});
     	var columnindex1=event.args.columnindex;
     	 var rowindex1 = event.args.rowindex;
     	 var datafield = event.args.datafield;
     	 var dtype=document.getElementById("formdetailcode").value;
     	 
     	$('#frminventoryrecept select').attr('disabled', false );
     	getfrmBranch(1);
     	document.getElementById("masterdoc_no").value=$('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        document.getElementById("docno").value= $('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
        $("#date").jqxDateTimeInput('val', $("#submasterSearch").jqxGrid('getcellvalue', rowindex1, "date"));
        $("#hiddate").jqxDateTimeInput('val', $("#submasterSearch").jqxGrid('getcellvalue', rowindex1, "date"));
      //  document.getElementById("rrefno").value= $('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "rrefno");
        document.getElementById("txttolocation").value= $('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "toloc");         
        document.getElementById("txtfrmbranch").value=$('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "frmbranch");
        document.getElementById("txtfrmlocation").value=$('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "frmloc");
        
        document.getElementById("branchfrmid").value= $('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "frmbrhid");
        document.getElementById("locationfrmid").value= $('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "frmlocid");         
        document.getElementById("refmasterdocno").value=$('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "rrefno");
        document.getElementById("locationtoid").value=$('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "tolocid");
        
        document.getElementById("txtremark").value=$('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "remarks");
        document.getElementById("txtrefno").value=$('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "refno");
     	 
        document.getElementById("txtproductamt").value= $('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "amount");
        document.getElementById("txtnettotal").value= $('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "netamount");         
        document.getElementById("nettotal").value=$('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "servamt");
        document.getElementById("orderValue").value=$('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "grantamt");
        
        document.getElementById("cmbreftype").value=$('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "reftype");
        document.getElementById("hidcmbreftype").value=$('#submasterSearch').jqxGrid('getcellvalue', rowindex1, "reftype");
        $('#date').jqxDateTimeInput({disabled: false});
        document.getElementById("frminventoryrecept").submit();
      
        $('#window').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="submasterSearch"></div>

    
    </body>
</html>

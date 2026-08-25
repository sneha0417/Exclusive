<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.marketing.quotationdetail.ClsQuotationDetailDAO"%> 
<%ClsQuotationDetailDAO DAO= new ClsQuotationDetailDAO();%>
 <%
 String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
 String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
  String sereftype = request.getParameter("sereftype")==null?"0":request.getParameter("sereftype");
  String surdate = request.getParameter("surdate")==null?"0":request.getParameter("surdate");
  String cntrtype = request.getParameter("cntrtype")==null?"0":request.getParameter("cntrtype");
  int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
 
 String fromdate=request.getParameter("fromdate");
 	String todate=request.getParameter("todate"); %>

 <script type="text/javascript">
 
 var searchdata; 
 
 
  searchdata='<%=DAO.searchMaster(session,fromdate,todate,msdocno,Cl_names,sereftype,surdate,cntrtype,id)%>';

  $(document).ready(function () { 	
     
     var source =
     {
     		
         datatype: "json",
         datafields: [
					{name : 'tr_no' , type: 'String' }, 
                  	{name : 'doc_no' , type: 'String' },
                   	{name : 'date' , type: 'date' },
                    {name : 'reftype' , type: 'String'}, 
                    {name : 'cntr_type' , type: 'String'},
                    {name : 'name' , type: 'String'},
                    {name : 'est_trno' , type: 'String'},
                    {name : 'cldocno' , type: 'String'},
                	{name : 'estdate' , type: 'String' },
                	{name : 'brhid' , type: 'String' },
                	{name : 'revision_no' , type: 'String' },
                	{name : 'netamount' , type: 'number' },
                	{name : 'discount' , type: 'number' },
                	{name : 'enqno' , type: 'number' },
                	{name : 'surtrno' , type: 'number' },
                	{name : 'contrmode' , type: 'String'},
                    {name : 'scopegrpid' , type: 'int'},
                   	],
          localdata: searchdata,
         pager: function (pagenum, pagesize, oldpagenum) {
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
         filterable:true,
         showfilterrow:true,
        selectionmode: 'singlerow',
         pagermode: 'default',
         columns: [
				{ text: 'Doc No', datafield: 'doc_no', width: '10%'},
				{ text: 'Date', datafield: 'date', width: '13%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Name', datafield: 'name' },
				{ text: 'Contract Type', datafield: 'cntr_type', width: '16%',hidden:false },
				{ text: 'Ref Type', datafield: 'reftype', width: '12%' },
				{ text: 'Net Amount', datafield: 'netamount', width: '15%' , cellsalign: 'right', align: 'right'},
				{ text: 'Tran no', datafield: 'tr_no', width: '20%',hidden:true },
				{ text: 'EST Tran no', datafield: 'est_trno', width: '20%',hidden:true },
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true},
				{ text: 'EstDate', datafield: 'estdate', width: '20%',hidden:true },
				{ text: 'Brnchid', datafield: 'brhid', width: '20%',hidden:true },
				{ text: 'revision_no', datafield: 'revision_no', width: '20%',hidden:true },
				{ text: 'discount', datafield: 'discount', width: '20%',hidden:true }, 
				{ text: 'enqno', datafield: 'enqno', width: '20%',hidden:true }, 
				{ text: 'surtrno', datafield: 'surtrno', width: '20%',hidden:true },
				{ text: 'contrmode', datafield: 'contrmode', width: '17%',hidden:true },
				{ text: 'Scope Group', datafield: 'scopegrpid', width: '20%',hidden:true }, 
			 ]
     });
     $('#subsearch').on('celldoubleclick', function (event) {
         
    	 var rowindex1=event.args.rowindex;
    	
		 $('#quotdate').jqxDateTimeInput({disabled: false});
    	 $('#quotdate').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
	     document.getElementById("qutname").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "name");
	     document.getElementById("quttrno").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
         
	     document.getElementById("enqno").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "enqno");
	     document.getElementById("surtrno").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "surtrno");
	      var reftype=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "reftype");
	      $('#reftype').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "reftype"));
	      $('#revision').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "revision_no"));
	      $('#txtdiscount').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "discount"));
    	  $('#txtnettotal').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "netamount"));
    	  document.getElementById("txtcontrmode").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "contrmode");
          document.getElementById("cmbscopegroup").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "scopegrpid");
          
	      $('#qutDetSubGrid').jqxGrid('clear');
	      $('#qutDetGrid').jqxGrid('clear');
	      $('#txtclient').attr('disabled',false);
	  	  $('#txtremarks').attr('disabled',false);
	  	 $('#btnsaveqot').attr('disabled',false);
	  	/* || reftype=="SRVE" */
	      if(reftype=="DIR" ){
	    	  $('#qutDetSubGrid').jqxGrid('disabled',true);
	    	  $('#btnsaveest').attr('disabled',true);
	    	 $('#btnsavereqot').attr('disabled',true);
	      }
	      else{
	    	  $('#qutDetSubGrid').jqxGrid('disabled',false);
	    	  $('#btnsaveest').attr('disabled',false);
	    	  $('#btnsavereqot').attr('disabled',false);
	    	 
	    	
	    	  $('#hidtrno').val("");
	    	  $('#cldocno').val("");
	    	  $('#date').val("");
	    	  $('#brhid').val("");
	    	  $('#hidtrno').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "est_trno"));
	    	  $('#cldocno').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "cldocno"));
	    	  $('#date').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "estdate"));
	    	  $('#brhid').val($('#subsearch').jqxGrid('getcellvalue', rowindex1, "brhid"));
	      }
	      
        $('#quotwindow').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="subsearch"></div>

    
    </body>
</html>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.servicesalereturn.ClsServiceSaleReturnDAO" %>
 
<%

ClsServiceSaleReturnDAO viewDAO=new ClsServiceSaleReturnDAO();
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
 String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 
 String reftypess = request.getParameter("reftypess")==null?"NA":request.getParameter("reftypess"); 
 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
String mobileno=request.getParameter("mobileno")==null?"NA":request.getParameter("mobileno");
%> 
 
<script type="text/javascript">


var ddd1= '<%=viewDAO.srsmainsearch(session,docnoss,accountss,accnamess,datess,reftypess,aa,mobileno) %>'; 


$(document).ready(function () { 
             
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    {name : 'doc_no', type: 'int'   },
                    {name : 'date', type: 'date'   },
						{name : 'netamount', type: 'number'   },
						{name : 'type', type: 'string'   },
						
						{name : 'atype', type: 'string'   },
						{name : 'account', type: 'string'   },
						{name : 'description', type: 'string'   },
						{name : 'refno', type: 'string'   },
						{name : 'rate', type: 'string'   },
						{name : 'delterm', type: 'string'   },
						{name : 'payterm', type: 'string'   },
                		{name : 'deldate', type: 'date'   },
						{name : 'desc1', type: 'string'   },
						{name : 'acno', type: 'string'   },
						{name : 'curid', type: 'string'   },
						{name : 'reftype', type: 'string'   },
						{name : 'tr_no', type: 'int'   },
						{name : 'voc_no', type: 'int'   },
						{name : 'refvocno', type: 'int'   },
						{name :'mobno',type:'String'},
						 {name : 'invdate', type: 'date'   },
						{name : 'invno', type: 'String'   },
						
						{name : 'tax', type: 'number'   },
						
						
						
						
                ],
        		localdata: ddd1, 
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
                                
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source);
    
    $("#submainsearshgrid").jqxGrid(
    {
        width: '100%',
        height: 280,
        source: dataAdapter,
/*          showfilterrow: true, 
        filterable: true,  */
        selectionmode: 'singlerow',
        
        columns: [
                  
                  


                    { text: 'Doc No', datafield: 'voc_no', width: '6%' },
					{ text: 'Date', datafield: 'date', width: '9%',cellsformat:'dd.MM.yyyy' },
					
					{ text: 'atype', datafield: 'atype', width: '0%', hidden: true },
					{ text: 'Account', datafield: 'account', width: '8%' },
						{ text: 'Account Name', datafield: 'description', width: '22%' },
						 { text: 'Ref Type', datafield: 'reftype', width: '7%'},
						 { text: 'Mob No', datafield: 'mobno', width: '11%'},
						{ text: 'Amount', datafield: 'netamount', width: '12%' ,cellsformat: 'd2', cellsalign: 'right', align:'right'},
						 { text: 'type', datafield: 'type', width: '5%',hidden:true },
						 { text: 'refno', datafield: 'refno', width: '5%',hidden:true },
							{ text: 'rate', datafield: 'rate', width: '2%' ,hidden:true},
							{ text: 'delterm', datafield: 'delterm', width: '8%',hidden:true },
							 { text: 'payterm',  datafield: 'payterm', width: '5%' ,hidden:true},
								{ text: 'deldate', datafield: 'deldate', width: '5%' ,cellsformat:'dd.MM.yyyy',hidden:true},
								{ text: 'Description', datafield: 'desc1', width: '25%' },
								 { text: 'acno', datafield: 'acno', width: '2%' ,hidden:true},
								 { text: 'curid', datafield: 'curid', width: '2%',hidden:true },
								 
								 { text: 'invdate', datafield: 'invdate', width: '10%',cellsformat:'dd.MM.yyyy' ,hidden:true}, 
								 { text: 'invno', datafield: 'invno', width: '2%',hidden:true},
								 { text: 'tr_no', datafield: 'tr_no', width: '2%',hidden:true},
								 { text: 'voc_no', datafield: 'doc_no', width: '2%',hidden:true},
								 { text: 'refvocno', datafield: 'refvocno', width: '2%',hidden:true},
								 
								 { text: 'tax', datafield: 'tax', width: '10%',hidden:true},
								 
								 
								 
				]
    });
 $('#submainsearshgrid').on('rowdoubleclick', function (event) {
var rowindex1 = event.args.rowindex;
   	 $('#nipurchasedate').jqxDateTimeInput({ disabled: false});
	 $('#deliverydate').jqxDateTimeInput({ disabled: false});
	 $('#invDate').jqxDateTimeInput({ disabled: false});
	  $('#cmbcurr').attr('disabled', false);
	  $('#acctype').attr('disabled', false);
	 document.getElementById("rrefno").value = $('#submainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
     document.getElementById("ordermasterdoc_no").value = $('#submainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
     $('#nipurchasedate').val($("#submainsearshgrid").jqxGrid('getcellvalue', rowindex1, "date")) ;
     $('#deliverydate').val($("#submainsearshgrid").jqxGrid('getcellvalue', rowindex1, "deldate")) ;
        
        
        $('#invDate').val($("#submainsearshgrid").jqxGrid('getcellvalue', rowindex1, "invdate")) ;
        
        document.getElementById("invno").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "invno");
        document.getElementById("refno").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "refvocno");
  
        
        $('#acctypeval').val($('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "type"));
        
        $('#cmbcurr').val($('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "curid"));
        $('#cmbtype').val($('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "atype"));
        
        document.getElementById("reftypeval").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "reftype");
    	  document.getElementById("currate").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "rate");
          
          document.getElementById("delterms").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "delterm");
      	document.getElementById("payterms").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "payterm");
        document.getElementById("purdesc").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "desc1");
        
        document.getElementById("nipuraccid").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "account");
    	document.getElementById("puraccname").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "description");
        
       document.getElementById("nettotal").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "netamount");
       
        document.getElementById("accdocno").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "acno");
        
        
        document.getElementById("tarannumber").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
    

        
        
        document.getElementById("taxpers").value = $('#submainsearshgrid').jqxGrid('getcellvalue', rowindex1, "tax");
        
        
     
          
        
         
        

	  $("#nipurdetails").load("descgridDetails.jsp?nipurdoc="+$("#submainsearshgrid").jqxGrid('getcellvalue',rowindex1,"doc_no"));
	  $('#refnosearchwindow').jqxWindow('close');
    });    
     
});
</script>
    <div id="submainsearshgrid"></div>
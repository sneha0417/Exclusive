<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.nipurchase.nipurchasereturn.*" %>
 
<%

ClsnipurchaseReturnDAO viewDAO=new ClsnipurchaseReturnDAO();
String description = request.getParameter("description")==null?"NA":request.getParameter("description");
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
 String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 
 String reftypess = request.getParameter("reftypess")==null?"NA":request.getParameter("reftypess"); 
 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
%> 
 
<script type="text/javascript">


var niordermain= '<%=viewDAO.refnosearch(session,docnoss,accountss,accnamess,datess,reftypess,aa,description) %>'; 
 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            {name : 'date', type: 'date'   },
                            {name : 'invdate', type: 'date'   },
                       
                            {name : 'invno', type: 'string'   },
                            
     						{name : 'netamount', type: 'number'   },
     						{name : 'type', type: 'string'   },
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
     						{name : 'voc_no', type: 'string'   },
     						{name : 'typeid', type: 'string'   },
     						{name : 'ptype', type: 'string'   },
     						{name : 'per', type: 'string'   },
     						
     						
     						
                        ],
                		localdata: niordermain, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#refnosearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
              
                selectionmode: 'singlerow',
                
                columns: [
	
                            { text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Account', datafield: 'account' },
							{ text: 'Account Name', datafield: 'description', width: '44%' },
							{ text: 'Amount', datafield: 'netamount', width: '16%',cellsalign: 'right', align:'right',cellsformat:'d2' ,hidden:true },
							{ text: 'type', datafield: 'type', width: '5%',hidden:true },
							{ text: 'refno', datafield: 'refno', width: '5%',hidden:true },
							{ text: 'rate', datafield: 'rate', width: '2%' ,hidden:true},
							{ text: 'delterm', datafield: 'delterm', width: '8%',hidden:true },
							{ text: 'payterm',  datafield: 'payterm', width: '5%' ,hidden:true},
							{ text: 'deldate', datafield: 'deldate', width: '5%' ,cellsformat:'dd.MM.yyyy',hidden:true},
							{ text: 'Description', datafield: 'desc1', width: '32%' ,hidden:true},
							{ text: 'acno', datafield: 'acno', width: '2%' ,hidden:true},
							{ text: 'curid', datafield: 'curid', width: '2%',hidden:true },
							{ text: 'docno', datafield: 'doc_no', width: '2%' ,hidden:true },
							 
										
						]
            });
            
             $('#refnosearch').on('rowdoubleclick', function (event) {
       
            	 var  rowindex1=event.args.rowindex;
            	 
        		 $("#nidescdetailsGrid").jqxGrid('clear');
				 $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
            	 
            	 document.getElementById("refno").value=$('#refnosearch').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
            	 document.getElementById("ordermasterdoc_no").value=$('#refnosearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                 
                 document.getElementById("accdocno").value = $('#refnosearch').jqxGrid('getcellvalue', rowindex1, "acno");
                 document.getElementById("nipuraccid").value = $('#refnosearch').jqxGrid('getcellvalue', rowindex1, "account");
             	 document.getElementById("puraccname").value = $('#refnosearch').jqxGrid('getcellvalue', rowindex1, "description");
            	  
             	
             	 $('#deliverydate').val($("#refnosearch").jqxGrid('getcellvalue', rowindex1, "deldate")) ;
                 document.getElementById("invno").value=$('#refnosearch').jqxGrid('getcellvalue', rowindex1, "invno"); 
             	 $('#invDate').val($("#refnosearch").jqxGrid('getcellvalue', rowindex1, "invdate")) ;
             	  
             	 
             	 
             	 
             	 
             	  
                 document.getElementById("delterms").value = $('#refnosearch').jqxGrid('getcellvalue', rowindex1, "delterm");
                 document.getElementById("payterms").value = $('#refnosearch').jqxGrid('getcellvalue', rowindex1, "payterm");
           	     document.getElementById("purdesc").value = $('#refnosearch').jqxGrid('getcellvalue', rowindex1, "desc1");
           	
    		
			
                 document.getElementById("hideproducttype").value = $('#refnosearch').jqxGrid('getcellvalue', rowindex1, "typeid");
                 document.getElementById("txtproducttype").value = $('#refnosearch').jqxGrid('getcellvalue', rowindex1, "ptype");
       	         document.getElementById("taxpers").value = $('#refnosearch').jqxGrid('getcellvalue', rowindex1, "per");
       	         
       	         
       	         
       	      var indexval1 =$('#refnosearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				
	     	  	 
	     	  	
  	  		 $("#nipurdetails").load("descgridDetails.jsp?nipurdoc="+indexval1);
       
            	 $('#refnosearchwindow').jqxWindow('close');
                
            	 
            }); 
             
        });
    </script>
    <div id="refnosearch"></div>
<%@page import="com.finance.transactions.termloanmaster.ClstermloanmasterDAO" %>
<%
ClstermloanmasterDAO cvp=new ClstermloanmasterDAO();
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 

 
 var findata='<%=cvp.rcpancesearch(session,accountno,accountname,check)%>';
	
 	$(document).ready(function () { 

 		//acc_no,fname,doc_no
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'int'   }, 
 						{name : 'acc_no', type: 'string'   },
 						{name : 'fname', type: 'string'  },
 						
                    ],
            		localdata: findata, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#finsearch").jqxGrid(
        {
        	width: '100%',
            height: 350,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'acc_no', width: '20%' },
						{ text: 'Account Name', datafield: 'fname', width: '80%' },
				/* 		{ text: 'Currency', datafield: 'currency', width: '10%' },
						{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%' },
						{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%' }, */
					]
        });
        
         $('#finsearch').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
           // finaccdocno,financeaccid,financeaccname
	            document.getElementById("finaccdocno").value = $('#finsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	            document.getElementById("financeaccid").value = $('#finsearch').jqxGrid('getcellvalue', rowindex1, "acc_no");
	        	document.getElementById("financeaccname").value = $('#finsearch').jqxGrid('getcellvalue', rowindex1, "fname");
	        //	document.getElementById("hidcmbcurrency").value = $('#finsearch').jqxGrid('getcellvalue', rowindex1, "curid");
	        	//funRoundRate($('#finsearch').jqxGrid('getcellvalue', rowindex1, "rate"),"txtrate");
         
        	
          $('#accountSearchwindow').jqxWindow('close');  
        });  
    });
</script>

<div id="finsearch"></div>
    
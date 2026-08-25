<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.accountssetup.trfsetup.ClsTrfSetUpDAO"%>
<%ClsTrfSetUpDAO DAO= new ClsTrfSetUpDAO(); %>
 <%
 String atype = request.getParameter("atype")==null?"0":request.getParameter("atype");
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String date = request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var accountData='<%=DAO.accountsDetails(session, atype, accountno, accountname, currency, date, check)%>';
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'int'   },
 						{name : 'account', type: 'string'   },
 						{name : 'description', type: 'string'  },
 						{name : 'currency', type: 'string'  },
 						{name : 'curid', type: 'int'  },
 						{name : 'rate', type: 'number'  },
 						{name : 'type', type: 'string'  }
                    ],
            		localdata: accountData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#accountsSearchGridID").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '30%' },
						{ text: 'Account Name', datafield: 'description', width: '50%' },
						{ text: 'Currency', datafield: 'currency', width: '10%' },
						{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%' },
						{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%' },
						{ text: 'Currency Type', hidden: true, datafield: 'type', width: '5%' },
					]
        });
         
         $('#accountsSearchGridID').on('rowdoubleclick', function (event) {
             var rowindex1 =$('#rowindex').val();
             var rowindex2 = event.args.rowindex;
             
             if(parseInt($('#txtcheckmainorgrid').val())==1) {
            	 
            	 document.getElementById("txtmainaccountdocno").value =$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "doc_no");
            	 document.getElementById("txtmainaccountno").value =$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "account");
            	 document.getElementById("txtmainaccountname").value =$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "description");
            		 
             } else {
	             $('#clusterGridID').jqxGrid('setcellvalue', rowindex1, "doc_no" ,$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	             $('#clusterGridID').jqxGrid('setcellvalue', rowindex1, "account" ,$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "account"));
	             $('#clusterGridID').jqxGrid('setcellvalue', rowindex1, "accountname" ,$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "description"));
	             
				 var rows = $('#clusterGridID').jqxGrid('getrows');
	             var rowlength= rows.length;
	             var rowindex2 = rowlength - 1;
	         	 var docno=$("#clusterGridID").jqxGrid('getcellvalue', rowindex2, "doc_no");
	         	 if(typeof(docno) != "undefined" && docno != ""){
	         		$("#clusterGridID").jqxGrid('addrow', null, {"account": "","accountname": "","doc_no": ""});
	         	 }
             }
			  $('#accountDetailsWindow').jqxWindow('close'); 
       }); 
    });
</script>

<div id="accountsSearchGridID"></div>
    
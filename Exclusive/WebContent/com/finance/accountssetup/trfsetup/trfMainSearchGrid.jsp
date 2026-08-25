<%@page import="com.finance.accountssetup.trfsetup.ClsTrfSetUpDAO"%>
<%ClsTrfSetUpDAO DAO= new ClsTrfSetUpDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String trfSetupName = request.getParameter("trfsetupname")==null?"0":request.getParameter("trfsetupname");
 String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var accountData='<%=DAO.interCompanyMainSearch(session,docNo,date,trfSetupName,check)%>';
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'int'   },
                        {name : 'date', type: 'string'  },
                        {name : 'name', type: 'string'   },
                        {name : 'acno', type: 'string'   },
                        {name : 'account', type: 'string'   },
                        {name : 'accountname', type: 'string'   },
 						{name : 'description', type: 'string'  }
                    ],
            		localdata: accountData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#trfMainSearchGridID").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', width: '10%' },
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '10%' },
						{ text: 'Transfer Name', datafield: 'name', width: '30%' },
						{ text: 'Description', datafield: 'description', width: '50%' },
						{ text: 'Account', datafield: 'acno', hidden : true, width: '10%' },
						{ text: 'Account No', datafield: 'account', hidden : true, width: '10%' },
						{ text: 'Account Name', datafield: 'accountname', hidden : true, width: '10%' },
					]
        });
         
         $('#trfMainSearchGridID').on('rowdoubleclick', function (event) {
             var rowindex1 =event.args.rowindex;
             document.getElementById("docno").value= $('#trfMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
             $('#trfSetUpDate').jqxDateTimeInput({disabled: false});
             $("#trfSetUpDate").jqxDateTimeInput('val', $("#trfMainSearchGridID").jqxGrid('getcellvalue', rowindex1, "date"));
             $('#trfSetUpDate').jqxDateTimeInput({disabled: true});
             document.getElementById("txttrfsetupname").value= $('#trfMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "name");
             document.getElementById("txtmainaccountdocno").value= $('#trfMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "acno");
             document.getElementById("txtmainaccountno").value= $('#trfMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "account");
             document.getElementById("txtmainaccountname").value= $('#trfMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "accountname");
             document.getElementById("txtdescription").value= $('#trfMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "description");
             
             var indexVal = document.getElementById("docno").value;
			 if(indexVal> 0){
	         	 $("#trfSetUpDiv").load("trfSetUpGrid.jsp?docno="+indexVal+"&mode="+$('#mode').val());
			 }  
			 
			 /* $('#trfSetUpDate').jqxDateTimeInput({disabled: false});
             funSetlabel();
             document.getElementById("frmTrfSetUp").submit();
             $('#trfSetUpDate').jqxDateTimeInput({disabled: true}); */
			 
			 $('#window').jqxWindow('close'); 
       }); 
    });
</script>

<div id="trfMainSearchGridID"></div>
    
<%@page import="com.fixedassets.assets.assetmaster.ClsAssetmasterDAO" %>
<%ClsAssetmasterDAO amd=new ClsAssetmasterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String date = request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 String valuess=request.getParameter("values")==null?"0":request.getParameter("values");
// System.out.println("-----valuess--"+valuess);
%>   
 <script type="text/javascript">
 var valuess='<%=valuess%>';
 var accountData1;
	 accountData1='<%=amd.accountsDetails(session, accountno, accountname,date, check)%>'; -
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
						 {name : 'type', type: 'string'  },
						 {name : 'atype', type: 'string'  }
                    ],
            		localdata: accountData1, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#jqxAccountsSearch1").jqxGrid(
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
						{ text: 'Account Type', hidden: true, datafield: 'atype', width: '5%' },
					]
        });
        
         $('#jqxAccountsSearch1').on('rowdoubleclick', function (event) { 
            var rowindex1 = event.args.rowindex;
         
        // fixedassetaccId  fixedassetaccName  fixaccDocno  fixaccCurrid  fixaccRate fixaccType
         if(parseInt(valuess)==1)
        	 {

            document.getElementById("fixedassetaccId").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "account");
        	document.getElementById("fixedassetaccName").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "description");
        	document.getElementById("fixaccDocno").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
        	document.getElementById("fixaccCurrid").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "curid");
        	document.getElementById("fixaccRate").value = $('#jqxAccountsSearch1').jqxGrid('getcelltext', rowindex1, "rate");
        	document.getElementById("fixaccType").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "type");
        	 }
         else if(parseInt(valuess)==2)
        	 {
       
        	// accdepraccId accdepraccName accdepraccDocno accdepraccCurrid accdepraccRate accdepraccType
        	
            document.getElementById("accdepraccId").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "account");
        	document.getElementById("accdepraccName").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "description");
        	document.getElementById("accdepraccDocno").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
        	document.getElementById("accdepraccCurrid").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "curid");
        	document.getElementById("accdepraccRate").value = $('#jqxAccountsSearch1').jqxGrid('getcelltext', rowindex1, "rate");
        	document.getElementById("accdepraccType").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "type");
        	 }
        //	depraccId depraccName  depracDocno depracCurrid  depracRate  depracType
        	else if(parseInt(valuess)==3)
        		{
        	
            document.getElementById("depraccId").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "account");
        	document.getElementById("depraccName").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "description");
        	document.getElementById("depracDocno").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
        	document.getElementById("depracCurrid").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "curid");
        	document.getElementById("depracRate").value = $('#jqxAccountsSearch1').jqxGrid('getcelltext', rowindex1, "rate");
        	document.getElementById("depracType").value = $('#jqxAccountsSearch1').jqxGrid('getcellvalue', rowindex1, "type");
      
        		}
        	document.getElementById("errormsg").innerText="";
        	// txttypeatype txttypetype
            $('#fixaccountDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="jqxAccountsSearch1"></div>
    
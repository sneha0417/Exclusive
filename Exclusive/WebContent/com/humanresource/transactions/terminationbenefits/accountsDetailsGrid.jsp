<%@page import="com.humanresource.transactions.terminationbenefits.ClsTerminationBenefitsDAO"%>
<% ClsTerminationBenefitsDAO DAO= new ClsTerminationBenefitsDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");
String trNo = request.getParameter("trno")==null?"0":request.getParameter("trno");%>
<script type="text/javascript">
		var data1;
		
        $(document).ready(function () { 
            
        	var temp='<%=check%>';
        	var temp1='<%=trNo%>';
        	
        	if(temp=='2'){
        		data1='<%=DAO.accountDetailsGridLoading()%>';     
        	}else if(temp1>0){
          	    data1='<%=DAO.accountDetailsGridReloading(trNo)%>';
            } 
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'acno', type: 'int' },
							{name : 'account', type: 'int' },
     						{name : 'codeno', type: 'string' }, 
     						{name : 'debit', type: 'number'   },
     						{name : 'credit', type: 'number'   }
                        ],
                           localdata: data1,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#terminationBenefitsAccounts").jqxGrid(
            {
                width: '99%',
                height: 150,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                       
                columns: [
							{ text: 'Account Doc No', datafield: 'acno', hidden: true, width: '10%' },
							{ text: 'Account No', datafield: 'account',  width: '15%' },
							{ text: 'Account Head',   datafield: 'codeno',  width: '55%' },
							{ text: 'Debit', datafield: 'debit', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'Credit', datafield: 'credit', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
						]
            });
            
            if(temp1>0){
            	$("#terminationBenefitsAccounts").jqxGrid('disabled', true);
            }
            
        });
    </script>
    <div id="terminationBenefitsAccounts"></div>
    <input type="hidden" id="rowindex"/> 
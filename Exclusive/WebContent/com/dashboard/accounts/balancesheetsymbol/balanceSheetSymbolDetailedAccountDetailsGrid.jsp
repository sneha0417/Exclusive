<%@page import="com.dashboard.accounts.balancesheetsymbol.ClsBalanceSheetSymbol" %>
<%ClsBalanceSheetSymbol DAO=new ClsBalanceSheetSymbol(); %>
<%  String trno = request.getParameter("trno")==null?"0":request.getParameter("trno").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%>
     
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }
        
    .icon {
		width: 2.5em;
		height: 3em;
		border: none;
		background-color: #E0ECF8;
    }
        
</style>

<script type="text/javascript">
      var data4;
      
      var temp='<%=check%>';
      
	  	if(temp=='1'){ 
	  		data4='<%=DAO.accountStatementDetailGrid(trno,check)%>';
	  	}
	  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'account', type: 'string'   },
     						{name : 'currency', type: 'string' },
     						{name : 'rate', type: 'number'   },
     						{name : 'dr', type: 'number' },
     		     		    {name : 'cr', type: 'number'   },
     						{name : 'drcur', type: 'number'   },
     						{name : 'crcur', type: 'number'   },
     						{name : 'tr_no', type: 'string'   }
	            ],
                localdata: data4,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#accountDetailsDetailedGridID").jqxGrid(
            {
                width: '98%',
                height: 250,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
							{ text: 'Account', datafield: 'account', width: '30%' },	
							{ text: 'Currency', datafield: 'currency', width: '9%' },	
							{ text: 'Rate', datafield: 'rate', width: '9%', cellsformat: 'd2' },
							{ text: 'Dr', datafield: 'dr', width: '13%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Cr', datafield: 'cr', width: '13%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Dr. base currency', datafield: 'drcur',  width: '13%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Cr. base currency' , datafield: 'crcur',  width: '13%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Tr No', hidden: true, datafield: 'tr_no',  width: '10%' },
						]
            });
            
            $("#overlay, #PleaseWait").hide();
        });

</script>
        
<div id="accountDetailsDetailedGridID"></div>
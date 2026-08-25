<%@page import="com.humanresource.transactions.leavetraveldisbursement.ClsLeaveTravelDisbursementDAO"%>
<% ClsLeaveTravelDisbursementDAO DAO= new ClsLeaveTravelDisbursementDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");
   String trNo = request.getParameter("trno")==null?"0":request.getParameter("trno");%>
<script type="text/javascript">
		var data;
		
        $(document).ready(function () { 
        	
        	var temp1='<%=trNo%>';
        	
        	if(temp1>0){
          	    data='<%=DAO.accountDetailsGridReloading(trNo)%>';
            }  
             
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
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
                           localdata: data,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#leaveTravelDisbursementGridID").jqxGrid(
            {
                width: '99%',
                height: 250,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',
                showaggregates:true,
                localization: {thousandsSeparator: ""},
                       
                columns: [
							{ text: 'Account Doc No', datafield: 'acno', hidden: true, width: '10%' },
							{ text: 'Account No', datafield: 'account',  width: '15%' },
							{ text: 'Account Head',   datafield: 'codeno',  width: '55%' },
							{ text: 'Debit', datafield: 'debit', width: '15%', cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer: rendererstring, cellsalign: 'right', align: 'right'},
							{ text: 'Credit', datafield: 'credit', width: '15%', cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer: rendererstring, cellsalign: 'right', align: 'right'},
						]
            });
            
            if(temp1>0){
            	$("#leaveTravelDisbursementGridID").jqxGrid('disabled', true);
            }
            
            
        });

</script>
<div id="leaveTravelDisbursementGridID"></div>
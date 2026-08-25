<%@page import="com.dashboard.realestate.tenancymanagement.*"%>
<%ClsTenancyManagementDAO DAO= new ClsTenancyManagementDAO();  %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String check = request.getParameter("id")==null?"0":request.getParameter("id").trim();%> 
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
</style>
<script type="text/javascript">
      var mrfacdata;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		mrfacdata='<%=DAO.accountsStatement(branchval, fromDate, toDate, accdocno,check)%>';
	  	}    
	  	
  	
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'trdate' , type: 'date' },
							{name : 'transtype' , type:'string'},
							{name : 'transno' , type:'int'},
							{name : 'branchname' , type:'string'},
							{name : 'description' , type:'string'},
							{name : 'currency',type:'string'},
							{name : 'rate' , type:'number'},
							{name : 'dr' , type:'number'},
							{name : 'cr' , type:'number'},
							{name : 'debit' , type:'number'},
							{name : 'credit' , type:'number'},
							{name : 'balance' , type:'number'}
	                      ],
                          localdata: mrfacdata,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.debit != '') {
                    return "redClass";
                } else if (data.credit != '') {
                    return "yellowClass";
                }
                else{
                	return "greyClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#mrfAccountsGrid").jqxGrid(
            {
                width: '98%',
                height: 300,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	enabletooltips: true,
             	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25,
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Date', datafield: 'trdate', cellclassname: cellclassname, width: '6%', cellsformat: 'dd.MM.yyyy' ,columngroup:'cashcontrolaccount'},
							{ text: 'Type',  datafield: 'transtype',  cellclassname: cellclassname, width: '4%',columngroup:'cashcontrolaccount' },
							{ text: 'Doc No',  datafield: 'transno',  cellclassname: cellclassname, width: '6%'  ,columngroup:'cashcontrolaccount' },
							{ text: 'Branch',  datafield: 'branchname',  cellclassname: cellclassname, width: '9%'  ,columngroup:'cashcontrolaccount' },
							{ text: 'Description', datafield:'description', cellclassname: cellclassname, width:'26%',columngroup:'cashcontrolaccount'},
							{ text: 'Currency',  datafield: 'currency',  cellclassname: cellclassname, width: '5%'  ,columngroup:'transactedin'},
							{ text: 'Rate',  datafield: 'rate',  cellclassname: cellclassname, width: '4%',cellsformat: 'd2',columngroup:'transactedin'},
							{ text: 'Dr',  datafield: 'dr',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin'},
							{ text: 'Cr',  datafield: 'cr',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Debit',  datafield: 'debit',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Credit',  datafield: 'credit',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Balance',  datafield: 'balance',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right' },
						 ], columngroups: 
					                     [
					                       { text: 'Account Informations', align: 'center', name: 'cashcontrolaccount',width: '20%' },
					                       { text: 'Transacted In', align: 'center', name: 'transactedin',width: '10%' },
					                       { text: 'Value In Base Currency', align: 'center', name: 'valueinbasecurrency',width: '10%' }
					                     ]
            });
            
			$("#overlay, #PleaseWait").hide();
			
        });

</script>
<div id="mrfAccountsGrid"></div>

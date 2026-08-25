<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.accountssetup.accountsMaster.ClsAccMasterDAO" %>
<%ClsAccMasterDAO DAO=new ClsAccMasterDAO(); %>

 
 

 <script type="text/javascript">
 
	var accountData='<%=DAO.getcurr()%>';
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",  
            datafields: [
                        {name : 'doc_no', type: 'int'   },
 						{name : 'code', type: 'string'   },
 						{name : 'rate', type: 'number'  },
 					 
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
            height: 300,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
			 
						{ text: 'Currency', datafield: 'code', width: '50%' },
						 
						{ text: 'Rate', datafield: 'rate', width: '50%' , cellsformat: 'd3', cellsalign: 'right', align: 'right' },
						 
					]
        });
         
         $('#accountsSearchGridID').on('rowdoubleclick', function (event) {
            
             var rowindex2 = event.args.rowindex; 
             
             document.getElementById("currs").value=$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "code")
             document.getElementById("currsid").value=$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "doc_no");
             var rates=$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "rate");
         	funRoundRate(rates,"ratess");
             
         	document.getElementById("errormsg").innerText="";
           
			  $('#accountSearchwindow').jqxWindow('close'); 
       }); 
    });
</script>

<div id="accountsSearchGridID"></div>
    
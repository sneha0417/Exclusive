<%@page import="com.humanresource.setup.hrsetup.allowances.ClsAllowancesDAO"%>
<% ClsAllowancesDAO accDAO = new ClsAllowancesDAO(); %> 
<% String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
   String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");
   String rowindex = request.getParameter("rowindex")==null?"0":request.getParameter("rowindex");
%> 

<script type="text/javascript">

        var data2= '<%=accDAO.accountsDetailsFrom(accountno,accountname,check) %>'; 

        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'grtype', type: 'int'  }
                        ],
                		localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsSearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
                            { text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '30%' },
							{ text: 'Account Name', datafield: 'description', width: '70%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, width: '10%' },
						]
            });
            
             $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
                 var rowindex1 = event.args.rowindex;
                 var rowindex2='<%=rowindex%>';
 
             	  $('#accountsetup').jqxGrid('setcellvalue', rowindex2, "account" ,$('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account"));
                  $('#accountsetup').jqxGrid('setcellvalue', rowindex2, "acno" ,$('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                  $('#accountsetup').jqxGrid('setcellvalue', rowindex2, "grtype" ,$('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "grtype"));
                  
              $('#accountSearchwindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="jqxAccountsSearch"></div>
 
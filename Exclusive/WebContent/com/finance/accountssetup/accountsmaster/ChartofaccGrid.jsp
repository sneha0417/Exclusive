<%@page import="com.finance.accountssetup.accountsMaster.ClsAccMasterDAO" %>
<%ClsAccMasterDAO amd=new ClsAccMasterDAO(); %>
 <%
 
String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");
//System.out.println("-------chk---"+chk);
%> 


 <script type="text/javascript">
<!--

//-->

 $(document).ready(function () {
	   var theme = getDemoTheme();
	/*    $("#excelExport").click(function() {
			$("#ChartOfAccounts").jqxGrid('exportdata', 'xls', 'ChartOfAccounts');
		}); */
		//alert("hgcjju");
            // prepare the data
         <%--    var chk='<%=chk%>'; --%>
   
      /*       if(chk=="load")
            	{ */
           exceldata= '<%=amd.getChartOfACExcel(chk)%>';
           var data = '<%=amd.getChartOfAC(chk)%>'; 
            	/* }
            else
            	{
              data;
            	}
             */
            
            var source = 
            {
                datatype: "json",
                datafields: [

                             
						{ name: 'gp_desc', type: 'string' },
						{ name: 'head', type: 'string' },
						{ name: 'account', type: 'string' },
						{ name: 'description', type: 'string' },
						{ name: 'md', type: 'string' },
						{ name: 'group_name', type: 'string' }
                          	],
                          	localdata: data,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            
            
            
    /*         var source =
            {
            	       datatype: "json",
                datafields:
                [
                    { name: 'gp_desc', type: 'string' },
                    { name: 'head', type: 'string' },
                    { name: 'account', type: 'string' },
                    { name: 'description', type: 'string' },
                    { name: 'md', type: 'string' },
                    { name: 'group_name', type: 'string' }
                    
                    
                ],
         
                localdata: data,
              //  getChartOfACExcel
                updaterow: function (rowid, rowdata) {
                    // synchronize with the server - send update command   
                }
            }; */
            var redRow;
            var yellowRow;
            var cellclassname = function (row, column, value, data) {
                if (data.md == 'D') {
                    return "redClass";
                } else if (data.md == 'M') {
                	  return "yellowClass";
                }; 
                
            }; 
            var dataAdapter = new $.jqx.dataAdapter(source);
            // initialize jqxGrid 
            $("#ChartOfAccounts").jqxGrid(
            {
                width: '99.5%',
				height: 500,
                source: dataAdapter,
                groupable: true,
                //groupsrenderer: false,
                selectionmode: 'singlecell',
                groups: ['gp_desc','head','group_name'],
                columns: [
          
                  { text: 'Group Name', groupable: true, datafield: 'gp_desc', width: '20%' ,cellclassname: cellclassname },
                  { text: 'Group Head', groupable: true, datafield: 'head', width: '20%',cellclassname: cellclassname  },
                  { text: 'Main Head', groupable: true, datafield: 'group_name', width: '20%' ,cellclassname: cellclassname },
                  { text: 'Account', groupable: false, datafield: 'account', width: '9%',cellclassname: cellclassname  },
                  { text: 'Description', groupable: false, datafield: 'description', width: '30%',cellclassname: cellclassname  }
                ],
				 groupsrenderer: function (defaultText, group, state, params) {
						return false;
					}
				
            });
     	   $("#overlay, #PleaseWait").hide();
        });
        

 
        </script>
    <div id="ChartOfAccounts"></div>    
        
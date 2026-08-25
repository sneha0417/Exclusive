<%@page import="com.humanresource.transactions.additionanddeduction.ClsAdditionandDeductionDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% ClsAdditionandDeductionDAO DAO=new ClsAdditionandDeductionDAO();
   String employeename = request.getParameter("employeename")==null?"0":request.getParameter("employeename");
   String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
   String contactno = request.getParameter("contactno")==null?"0":request.getParameter("contactno"); %>
   
<script type="text/javascript">
 
         var data1= '<%=DAO.employeeDetailsSearch(empid, employeename, contactno)%>';  
         $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dtjoin', type: 'date'   },
     						{name : 'name', type: 'string'   },
     						{name : 'desc_id', type: 'string'  }, 
     						{name : 'desig', type: 'string'  },
     						{name : 'pay_catid', type: 'string'  },
     						{name : 'category', type: 'string'  },
     						{name : 'dept_id', type: 'string'  },
     						{name : 'dept', type: 'string'  },
     						{name : 'doc_no', type: 'int'   },
     						{name : 'codeno', type: 'string'   },
     						{name : 'pmmob', type: 'string'   },
     						{name : 'acno', type: 'int'   },
     						{name : 'atype', type: 'string'   },
     						{name : 'account', type: 'string'   },
     						{name : 'accountname', type: 'string'   },
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#employeeDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow', 
                
                columns: [
							{ text: 'Employee Id', datafield: 'codeno', width: '20%'  },
							{ text: 'Employee Name', datafield: 'name', width: '60%' },
							{ text: 'Contact', datafield: 'pmmob', width: '20%' },
							{ text: 'desc_id', datafield: 'desc_id', width: '20%', hidden: true },
							{ text: 'desig', datafield: 'desig', width: '20%', hidden: true },
							{ text: 'pay_catid', datafield: 'pay_catid', width: '20%', hidden: true },
							{ text: 'category', datafield: 'category', width: '20%', hidden: true },
							{ text: 'dept_id', datafield: 'dept_id', width: '20%' , hidden: true },
							{ text: 'dept', datafield: 'dept', width: '20%', hidden: true },
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '5%' },
							{ text: 'Account No',  datafield: 'acno', hidden: true, width: '5%' },
							{ text: 'Account',  datafield: 'account', hidden: true, width: '5%' },
							{ text: 'Account name',  datafield: 'accountname', hidden: true, width: '5%' },
							{ text: 'Account Type',  datafield: 'atype', hidden: true, width: '5%' },
						]
            });  
            
             $('#employeeDetailsSearch').on('rowdoubleclick', function (event) {
            	 var rowindex3 =$('#rowindex').val();
                 var rowindex2 = event.args.rowindex;

                 $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex3, "empid" ,$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex2, "codeno"));
                 $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex3, "empname" ,$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex2, "name"));
                 $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex3, "empdoc" ,$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                 $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex3, "atype" ,$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex2, "atype"));
                 $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex3, "acno" ,$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex2, "acno"));
                 $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex3, "account" ,$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex2, "account"));
                 $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex3, "accountname" ,$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex2, "accountname"));
                 
                 var rows = $('#descdetailsGrid').jqxGrid('getrows');
                 var rowlength= rows.length;
                 if (rowindex3 == rowlength - 1) {
                     $("#descdetailsGrid").jqxGrid('addrow', null, {});	
                 }	
                
            	$('#empsearchwndow').jqxWindow('close'); 
            });  
});

</script>
<div id="employeeDetailsSearch"></div>
 
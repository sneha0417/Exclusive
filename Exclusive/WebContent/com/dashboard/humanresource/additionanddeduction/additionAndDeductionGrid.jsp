<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.humanresource.additionanddeduction.ClsAdditionAndDeductionDAO"%>
<%ClsAdditionAndDeductionDAO DAO= new ClsAdditionAndDeductionDAO(); %>
<%  
   String year = request.getParameter("year")==null?"2016":request.getParameter("year");
   String month = request.getParameter("month")==null?"01":request.getParameter("month");
   String empId = request.getParameter("empId")==null?"0":request.getParameter("empId");
   String acno = request.getParameter("acno")==null?"0":request.getParameter("acno");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 

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
	var temp='<%=check%>';
	var data;
        
	$(document).ready(function () { 	
               
		if(temp!='NA'){
    		 data='<%=DAO.additionAndDeductionGridLoading(year,month,acno,empId,check)%>'; 
    		 dataExcelExport='<%=DAO.additionAndDeductionExcelExport(year,month,acno,empId,check)%>'; 
    	 }
		
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						
     						{name : 'empname', type: 'string' },
     						{name : 'empid', type: 'string' },
     						{name : 'atype', type: 'string' }, 
     						{name : 'account', type: 'string' },
     						{name : 'accountname', type: 'string' },
							{name : 'addition', type: 'number' },
     						{name : 'deduction', type: 'number' },
     						{name : 'remarks', type: 'string' }
                 ],
                 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#additionAndDeductionGridID").jqxGrid(
            {
            	width: '98%',
                height: 520,
                source: dataAdapter,
                editable: false,
                columnsresize: true,
                filtermode:'excel',
                filterable: true,
                sortable :true,
                selectionmode: 'singlerow',
                
                columns: [
                
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) { 
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
                              }   
                            }, 
							{ text: 'Emp. ID', datafield: 'empid', width: '7%',editable: false },
							{ text: 'Emp. Name', datafield: 'empname',cellsalign: 'left', align:'left',editable: false},
							{ text: 'Type', datafield: 'atype', width: '4%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                            { text: 'Account', datafield: 'account',  editable: false,  width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname', editable: false, width: '22%' },	
							{ text: 'Addition', datafield: 'addition', width: '8%' ,  cellclassname: 'yellowClass',cellsalign: 'right', align:'right', align:'right',cellsformat:'d2'},
							{ text: 'Deduction', datafield: 'deduction', width: '8%' ,  cellclassname: 'redClass',cellsalign: 'right', align:'right',cellsformat:'d2'},
		    				{ text: 'Remarks', datafield: 'remarks', width: '22%'  },
							
	              ]
            });
            
            $("#overlay, #PleaseWait").hide();
           
}); 
 
</script>
<div id="additionAndDeductionGridID"></div>

<%@page import="com.dashboard.humanresource.openingbalance.ClsOpeningBalanceDAO"%>
<%ClsOpeningBalanceDAO DAO= new ClsOpeningBalanceDAO(); %>
<%   String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
	 String department = request.getParameter("department")==null?"0":request.getParameter("department").trim();
	 String employee = request.getParameter("employee")==null?"0":request.getParameter("employee").trim();
	 String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%>

<style>     
.terminationBenefitsClass { background-color: #CEECF5; }
.leaveClass { background-color: #F1F8E0; }
.travelsClass { background-color: #FFEBC2; }       
</style>
        
<script type="text/javascript">
      var data;
      var temp='<%=check%>';
      
	  	if(temp=='1'){ 
	  		    data='<%=DAO.openingBalanceGridLoading(category, department, employee, check)%>';   
	  	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'empid', type: 'String'  },
					{name : 'empname', type: 'String'  },
					{ name: 'category', type: 'string' },
	                { name: 'department', type: 'string' },
				    {name : 'terminationbenefits' , type: 'number' },
				    {name : 'leavesalary' , type: 'number' },
				    {name : 'travels', type: 'number'  },
				    {name : 'empdocno', type: 'int'  },
				    {name : 'empacno', type: 'int'  },
				    {name : 'tobesaved', type: 'String'  }
	            ],
                localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#openingDetailsGridID").jqxGrid(
            {
                width: '98%',
                height: 530,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                editable: true,
                
                columns: [
						{ text: 'Emp. ID', datafield: 'empid',editable: false, columngroup:'employeeinfo', width: '8%' },
						{ text: 'Employee', datafield: 'empname',editable: false, columngroup:'employeeinfo', width: '40%' },
						{ text: 'Category', datafield: 'category',editable: false, columngroup:'employeeinfo', width: '12%' },
						{ text: 'Department', datafield: 'department',editable: false, columngroup:'employeeinfo', width: '10%' },
						{ text: 'Terminal Benefits', datafield: 'terminationbenefits', columngroup:'openingbalance', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'terminationBenefitsClass', width: '10%' },
						{ text: 'Leave Salary', datafield: 'leavesalary', columngroup:'openingbalance', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'leaveClass',  width: '10%' },
						{ text: 'Travels', datafield: 'travels', columngroup:'openingbalance', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'travelsClass', width: '10%' },
						{ text: 'Emp. Docno', datafield: 'empdocno',hidden: true, width: '10%' },
						{ text: 'Emp. Acno', datafield: 'empacno',hidden: true, width: '10%' },
						{ text: 'To be Saved', datafield: 'tobesaved',hidden: true, width: '5%' },
					 ], columngroups: 
	                     [
	                       { text: 'Employee Informations', align: 'center', name: 'employeeinfo',width: '20%' },
	                       { text: 'Opening Balance', align: 'center', name: 'openingbalance',width: '20%' },
	                     ]
            });
            
            if(temp!='1'){
                $("#openingDetailsGridID").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
            $("#openingDetailsGridID").on('cellvaluechanged', function (event){
            	var empid = $('#txtemployeeids').val();
            	var rowindex1 = event.args.rowindex;
            	if(empid.trim()==''){
                    document.getElementById("txtemployeeids").value = $('#openingDetailsGridID').jqxGrid('getcellvalue', rowindex1, "empdocno");
            	} else {
            		document.getElementById("txtemployeeids").value = empid+"::"+$('#openingDetailsGridID').jqxGrid('getcellvalue', rowindex1, "empdocno");
            	}      
            	$('#openingDetailsGridID').jqxGrid('setcellvalue', rowindex1, "tobesaved" ,"1");
            	
            });
  });
                       
</script>
<div id="openingDetailsGridID"></div>
<%@page import="com.dashboard.humanresource.severancepay.ClsSeverancePay" %>
<% ClsSeverancePay DAO=new ClsSeverancePay(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String empDocno = request.getParameter("employeedocno")==null?"0":request.getParameter("employeedocno").trim();
     String rptType = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype");
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 

<style type="text/css">
  .opnClass
  {
      color: #298A08;
  }
  .additionClass
  {
      color: #0101DF;
  }
  .deletionClass
  {
     color: #FF0000;
  }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
	  var temp1='<%=upToDate%>';
	  
	  	if(temp!='NA'){ 
	  		data='<%=DAO.severancePayGridLoading(branchval, upToDate, empDocno, rptType, check)%>';
	  		var dataExcelExport='<%=DAO.severancePayExcelExport(branchval, upToDate, empDocno, rptType, check)%>'; 
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
							{name : 'employeedocno', type: 'int' },
							{name : 'employeeid' , type: 'String' },
     						{name : 'employeename', type: 'String'  },
     						{name : 'dateofjoin',type:'date'},
     						{name : 'terminalbenefitstotal',type:'number'},
     						{name : 'terminalbenefitsgiven',type:'number'},
     						{name : 'terminalbenefitsbalance',type:'number'},
     						{name : 'leavesalarytotal',type:'number'},
     						{name : 'leavesalarygiven',type:'number'},
     						{name : 'leavesalarybalance',type:'number'},
     						{name : 'travelstotal',type:'number'},
     						{name : 'travelsgiven',type:'number'},
     						{name : 'travelsbalance',type:'number'},
     						{name : 'nettotal',type:'number'}
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
		            }		
            );
            $("#severancePayGridID").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                rowsheight:25,
                statusbarheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                showaggregates: true,
             	showstatusbar:true,
                editable: false,
                columnsresize: true,
                
                columns: [
							{ text: 'No.', sortable: false, filterable: false, editable: false,
						    	groupable: false, draggable: false, resizable: false,datafield: '',
						    	columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						    	cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						      }    
							},
							{ text: 'Emp. Doc No', datafield: 'employeedocno',hidden: true,editable:false, width: '6%' },
							{ text: 'Emp. ID', datafield: 'employeeid',editable:false, width: '5%',columngroup:'employeeinfo'},
							{ text: 'Emp. Name', datafield: 'employeename',editable:false, width: '14%',columngroup:'employeeinfo'},
							{ text: 'Date of Join', datafield: 'dateofjoin', width: '6%',editable:false ,cellsformat:'dd.MM.yyyy',columngroup:'employeeinfo',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Total', datafield: 'terminalbenefitstotal', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'terminalbenefits',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Paid', datafield: 'terminalbenefitsgiven', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'terminalbenefits',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'Balance',datafield:'terminalbenefitsbalance', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'terminalbenefits',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: 'deletionClass' },
							{ text: 'Total',  datafield:'leavesalarytotal',width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'leavesalary',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Paid', datafield: 'leavesalarygiven', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'leavesalary',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'Balance', datafield: 'leavesalarybalance', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'leavesalary',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'deletionClass' },
							{ text: 'Total',datafield:'travelstotal', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'travels',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Paid',  datafield:'travelsgiven',width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'travels',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'Balance',  datafield:'travelsbalance',width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'travels',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'deletionClass' },
							{ text: 'Net Total',  datafield:'nettotal',width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }
							],
							columngroups: 
							  [
							    { text: 'Employee Informations', align: 'center', name: 'employeeinfo',width: '18%' },
		                        { text: 'Terminal Benefits', align: 'center', name: 'terminalbenefits',width: '10%' },
		                        { text: 'Leave Salary', align: 'center', name: 'leavesalary',width: '10%' },
		                        { text: 'Travels', align: 'center', name: 'travels',width: '8%' }
							 
							  ]
            });
            
            if(temp=='NA'){
                $("#severancePayGridID").jqxGrid("addrow", null, {});
            }

			$("#overlay, #PleaseWait").hide();
			
			
			 $('#severancePayGridID').on('rowdoubleclick', function (event) {
				    var rowindex=event.args.rowindex;
	                var desc= "Severance Pay"; 
	                var empdocno=$('#severancePayGridID').jqxGrid('getcellvalue', rowindex, "employeedocno");
          	        var url=document.URL;
					var reurl=url.split("com/");
					
					var detName=$('#severancePayGridID').jqxGrid('getcellvalue', rowindex, "employeename");
					var path="com/dashboard/humanresource/severancepay/severanceDetailedPayGrid.jsp";
					top.addTab( detName,reurl[0]+""+path+"?name="+detName+"&main="+desc+"&branchval="+temp+'&empdocno='+empdocno+'&uptodate='+temp1);
	          	    
	              });
            
        });

</script>
<div id="severancePayGridID"></div>

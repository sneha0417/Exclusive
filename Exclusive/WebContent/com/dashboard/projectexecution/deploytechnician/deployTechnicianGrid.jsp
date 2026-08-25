<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.projectexecution.deploytechnician.ClsDeployTechnicianDAO"%> 
<% ClsDeployTechnicianDAO DAO=new ClsDeployTechnicianDAO(); %>
<% String branch =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString().trim();
   String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
   String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").toString().trim(); 
   String check =request.getParameter("check")==null?"0":request.getParameter("check").toString().trim();
 %>
<style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.yellowClass {
	background-color: #FFFF00;
}

.orangeClass {
	background-color: #FFEBC2;
}
</style>
<script type="text/javascript">
 		var data;
 
 		data= '<%= DAO.deployTechnicianGridLoading(session,branch,fromdate,todate,check) %>';
    
        $(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dtype', type: 'String'  },
     						{name : 'refdocno', type: 'String'  },
     						{name : 'tr_no', type: 'String' },
     						{name : 'sr_no', type: 'String' },
     						{name : 'consumed', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'siteaddress', type: 'String' },
     						{name : 'refname', type: 'String' },
     						{name : 'contactperson', type: 'String' },
     						{name : 'mobileno', type: 'String' },
     						{name : 'groupname', type: 'String' },
     						{name : 'pldate', type: 'String' },
     						{name : 'validupto', type: 'String' },
     						{name : 'apprdate', type: 'String' },
     						{name : 'contractdetails', type: 'String' },
     						{name : 'sertype', type: 'String' },
     						{name : 'asgngrp', type: 'String' },
     						{name : 'emp', type: 'String' },
     						{name : 'complaint', type: 'String' },
     						{name : 'contracttrno', type: 'String' },
     						{name : 'empid', type: 'String' },
     						{name : 'serdocno', type: 'String' },
     						{name : 'siteid', type: 'String' },
     						{name : 'areaid', type: 'String' },
     						{name : 'teampid', type: 'String' },
     						{name : 'grpid', type: 'String' },
     						{name : 'asignid', type: 'String' },
     						{name : 'branch', type: 'String' },
     						{name : 'budget', type: 'String' }
     						
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
 
            var cellclassname = function (row, column, value, data) {
            	
       		 if (data.gridrow==1) {
                   return "orangeClass";
               };
               
               if(typeof(data.pldate) != "undefined" && typeof(data.pldate) != "NaN" && data.pldate != ""){
	               var currentdate= new Date(new Date());
	               var planneddate=(data.pldate).split("-");
	               
	               if (parseInt(planneddate[2])==parseInt(currentdate.getFullYear())){
		                if (parseInt(planneddate[1])==parseInt(currentdate.getMonth()+1)) { 
		                   return "yellowClass";
		                };
	           	   };
               }
           	   
            };
					
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#deployTechnicianGridID").jqxGrid(
            {
                width: '99.5%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                showfilterrow:true,
                filterable: true,
                sortable: true,

                columns: [
                    { text: 'SL#', sortable: false, filterable: false, editable: false,
                        groupable: false, draggable: false, resizable: false,
                        datafield: 'sl', columntype: 'number', width: '4%',
                        cellsrenderer: function (row, column, value) {
                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        }  
                    },	
					{ text: 'Dtype',columntype: 'textbox', datafield: 'dtype', width: '4%',cellclassname:cellclassname },
					{ text: 'Doc No',columntype: 'textbox',  datafield: 'refdocno', width: '5%',cellclassname:cellclassname },
					{ text: 'Sch.No',columntype: 'textbox', datafield: 'tr_no', width: '4%',cellclassname:cellclassname },
					{ text: 'Sr No',columntype: 'textbox', datafield: 'sr_no', width: '5%', hidden: true, cellclassname:cellclassname },
					{ text: 'Consumed',  datafield: 'consumed',columntype: 'button', width: '5%' },
					{ text: 'Site Name',columntype: 'textbox', width: '8%', datafield: 'site',cellclassname:cellclassname },
					{ text: 'Site Address',columntype: 'textbox', width: '8%', datafield: 'siteaddress',cellclassname:cellclassname },
					{ text: 'Client Name',columntype: 'textbox',  datafield: 'refname', width: '15%',cellclassname:cellclassname },
					{ text: 'Contact Person',columntype: 'textbox',  datafield: 'contactperson', width: '15%',cellclassname:cellclassname },
					{ text: 'Mobile',columntype: 'textbox',  datafield: 'mobileno', width: '10%',cellclassname:cellclassname },
					{ text: 'Area',columntype: 'textbox', datafield: 'groupname', width: '8%',cellclassname:cellclassname },
					{ text: 'Planned Date',columntype: 'textbox',  datafield: 'pldate', width: '6%',cellclassname:cellclassname },
					{ text: 'End Date',columntype: 'textbox',  datafield: 'validupto', width: '6%',cellclassname:cellclassname },
					{ text: 'Appr. Date',columntype: 'textbox',  datafield: 'apprdate', width: '6%',cellclassname:cellclassname,hidden: true },
					{ text: 'Contract Details',  datafield: 'contractdetails', width: '5%',hidden: true },
					{ text: 'Service Type',columntype: 'textbox', width: '8%', datafield: 'sertype',cellclassname:cellclassname },
					{ text: 'Assign Group',columntype: 'textbox', datafield: 'asgngrp', width: '8%',cellclassname:cellclassname },
					{ text: 'Employee',columntype: 'textbox', datafield: 'emp', width: '8%',cellclassname:cellclassname },
					{ text: 'Complaint',columntype: 'textbox',  datafield: 'complaint',cellclassname:cellclassname },
					{ text: 'Contracttrno',  datafield: 'contracttrno', hidden: true, width: '5%' },
					{ text: 'Emp Id',columntype: 'textbox', datafield: 'empid',cellclassname:cellclassname, hidden: true },
					{ text: 'Ser Docno',  datafield: 'serdocno', hidden: true, width: '5%' },
					{ text: 'Site Id',  datafield: 'siteid', hidden: true, width: '5%' },
					{ text: 'Area Id',  datafield: 'areaid', hidden: true, width: '5%' },
					{ text: 'Teampid',columntype: 'textbox', datafield: 'teampid',cellclassname:cellclassname, hidden: true },
					{ text: 'Group Id',columntype: 'textbox', datafield: 'grpid',cellclassname:cellclassname, hidden: true },
					{ text: 'Assign Id',columntype: 'textbox', datafield: 'asignid',cellclassname:cellclassname, hidden: true },
					{ text: 'branch',  datafield:'branch', hidden: true, width: '5%' },
					{ text: 'Budget',  datafield:'budget', hidden: true, width: '10%' },
		
	              ]
            });
             
            $("#overlay, #PleaseWait").hide();
            
            $('#deployTechnicianGridID').on('rowdoubleclick', function (event) { 
            	  var rowindex1=event.args.rowindex;
            	  
            	  $("#deployTechnicianDetailsGridId").jqxGrid({ disabled: false});
          		
          		  $("#manPowerAssignedGridID").jqxGrid('clear');
          		  $("#manPowerAssignedGridID").jqxGrid("addrow", null, {"consumed":"View"}); 
          		  $("#manPowerAssignedGridID").jqxGrid({ disabled: false});

          		  var costtype =$('#deployTechnicianGridID').jqxGrid('getcellvalue', rowindex1, "dtype");
          		  var costcode =$('#deployTechnicianGridID').jqxGrid('getcellvalue', rowindex1, "refdocno");
          		  var budget =$('#deployTechnicianGridID').jqxGrid('getcellvalue', rowindex1, "budget");
          		 
          		  document.getElementById("txtcosttype").value = costtype;
          		  document.getElementById("txtcostcode").value = costcode;
          		  document.getElementById("txtsite").value = $('#deployTechnicianGridID').jqxGrid('getcellvalue', rowindex1, "site");
          		  $('#btnSaving').attr('disabled', false);
          		  $("#deployTechnicianDetailsGridDiv").load("deployTechnicianDetailsGrid.jsp?costtype="+costtype+'&costcode='+costcode+'&check=1');
          		  
          		  funRoundAmt(budget,"txtbudget");
          		  getManPowerConsumed(costtype,costcode);
            });
            
            $('#deployTechnicianGridID').on('cellclick', function (event) { 
	            	var datafield = event.args.datafield;
	            	
	            	if(datafield=="consumed"  ) {
	            		var rowindex1=event.args.rowindex;
	            		var costtype =$('#deployTechnicianGridID').jqxGrid('getcellvalue', rowindex1, "dtype");
	            		var costcode =$('#deployTechnicianGridID').jqxGrid('getcellvalue', rowindex1, "refdocno");
	            		$("#consumedDetailsWindow").jqxWindow('setTitle', costtype+" - "+costcode);
	            		consumedDetailsContent('manPowerConsumed.jsp?costtype='+costtype+'&costcode='+costcode);
	      		    }
		            	
		    });
            
            
        });
    
</script>
<div id="deployTechnicianGridID"></div>

<%@page import="com.dashboard.audit.contractservicescheduleupdate.ClsContractServiceScheduleUpdateDAO" %>
<% ClsContractServiceScheduleUpdateDAO DAO=new ClsContractServiceScheduleUpdateDAO(); %>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 String date = request.getParameter("startdate")==null?"0":request.getParameter("startdate"); 
 String enddate = request.getParameter("enddate")==null?"0":request.getParameter("enddate");
 String amount1 = request.getParameter("amount")==null?"0":request.getParameter("amount");
 String instno1 = request.getParameter("instno")==null?"0":request.getParameter("instno");
 String payfre = request.getParameter("cmbpaytype")==null?"0":request.getParameter("cmbpaytype");
 String serdueafter = request.getParameter("serdueafter")==null?"0":request.getParameter("serdueafter"); 
%>

<style type="text/css">
  
    .yellowClass
    {
        background-color: #F8E489;  
    }
    
    .orangeClass
    {
        background-color: #FAD7A0;
    }
  .greenClass
    {
        background-color: #7AFA90;
    }
     .whiteClass
    {
        background-color: #FFFFFF;
    }
</style>

<script type="text/javascript">
    var servsecdata;
    var gridload='<%=gridload%>';
    var docno='<%=docno%>';
    
        $(document).ready(function () { 	
            
        	if(gridload=="1"){
        		
        		servsecdata = '<%=DAO.serviceScheduleGridFillLoading(session,date,enddate,instno1,amount1,gridload,payfre,serdueafter) %>';
          	}
	       	if(docno>0){
	        		
	        		servsecdata = '<%=DAO.serviceScheudleGridLoading(session,docno,dtype) %>';
	        		
	          }
        	
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'pldate' , type: 'date' },
     						{name : 'pltime', type: 'String'  },
                          	{name : 'asgngrp', type: 'String'  },
                          	{name : 'assigngrpid', type: 'String'  },
     						{name : 'emp', type: 'String'  },
     						{name : 'assigntoid', type: 'String'  },
     						{name : 'asgnmode', type: 'String'  },
     						{name : 'desc1', type: 'String'  },
     						{name : 'site', type: 'String'  },
     						{name : 'value', type: 'number'  },
     						{name : 'days', type: 'String'  },
     						{name : 'service', type: 'String'  },
     						{name : 'serviceid', type: 'String'  },
     						{name : 'siteid', type: 'String'  },
     						{name : 'priority', type: 'bool'   },
     						{name : 'trno', type: 'String'   },
     						{name : 'workper', type: 'int'   }
                          	],
                 			localdata: servsecdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            $("#serviceScheduleGridID").on("bindingcomplete", function (event) {
				 
            	var rows = $("#serviceScheduleGridID").jqxGrid('getrows');
  			    for(var i=0 ; i < rows.length ; i++){
  				    var chk=rows[i].trno;
  				    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
  				    	var chks=rows[i].workper;
  				    	if(chks>0) {
  				    		
  				    		$('#srvcinterval').val('');$('#serdueafter').val('');$('#cmbsrvctype').val('1');$('#txteditrval').val('1');
  				  			$('#cmbsrvctype').attr('readonly', true);
  				  			$('#serdueafter').attr('readonly', true);
  				  			$('#cmbsrvctype').attr('disabled', true);
  				  			$('#btnAdd').attr('disabled', true);
  				  			$('#serdate').jqxDateTimeInput({disabled: true});
  				  			$('#stdate').jqxDateTimeInput({disabled: true});
  				  			$('#enddate').jqxDateTimeInput({disabled: true});
  				    		
  				  			return false;
  				    	}
  	  					
  	  			    }
  			    }
				 
       		});
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            
            var cellclassname = function (row, column, value, data) {
                
            	if(data.workper>0){
                	return "orangeClass";
                }
            
              };
              
            $("#serviceScheduleGridID").jqxGrid(
            {
                width: '98%',
                height: 190,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlecell',
                editable:true,
                sortable: true,
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%', cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Pl.Date', datafield: 'pldate', width: '10%' , editable: true,columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy',enableBrowserBoundsDetection:true, cellclassname: cellclassname,
 						cellbeginedit: function (row) {
					        if ($('#serviceScheduleGridID').jqxGrid('getcellvalue', row, "workper")>0)
					         {
					              return false;
					         }}
					},
					{ text: 'Pl.Time', datafield: 'pltime', width: '5%' ,cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", cellclassname: cellclassname, createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
	                      editor.jqxDateTimeInput({ showCalendarButton: false });
	                  },
 						cellbeginedit: function (row) {
					        if ($('#serviceScheduleGridID').jqxGrid('getcellvalue', row, "workper")>0)
					         {
					              return false;
					         }}
					},
	                { text: 'Days',datafield:'days',width:'6%',editable: false,hidden: true, cellclassname: cellclassname },
	           	    { text: 'Site',datafield:'site',width:'10%',editable: false, cellclassname: cellclassname },
	           	    { text: 'Service',datafield:'service',width:'8%',editable: false,hidden: true, cellclassname: cellclassname },
	           	    { text: 'serviceid',datafield:'serviceid',width:'10%',editable: false,hidden: true },
	           	    { text: 'siteid',datafield:'siteid',width:'10%',editable: false,hidden: true },
	             	{ text: 'Value',datafield:'value',width:'8%',editable: false,hidden: true, cellclassname: cellclassname },
					{ text: 'Assign Group', datafield: 'asgngrp', width: '15%',editable: false,editable:false, cellclassname: cellclassname },
					{ text: 'Assign Group ID', datafield: 'assigngrpid', width: '10%',hidden: true,editable: false },
					{ text: 'Assign To',datafield:'emp',width:'15%',editable: false, cellclassname: cellclassname },
					{ text: 'Assign To ID', datafield: 'assigntoid', width: '9%',hidden: true,editable: false },
					{ text: 'AssigEmpid', datafield:'assignempid', width: '9%',hidden: true,editable: false },
					{ text: 'Assign Method',datafield:'asgnmode',width:'12%',editable: false, cellclassname: cellclassname },
					{ text: 'Description',datafield:'desc1',editable: false,width:'22%', cellclassname: cellclassname },
					{ text: 'Priority',datafield:'priority',width:'7%', columntype:'checkbox', checked: false, cellclassname: cellclassname},
					{ text: 'Trno', datafield:'trno', width: '9%',hidden: true },
					{ text: 'Work Per', datafield:'workper', width: '9%',hidden: true }
					]
            });
            
            $("#serviceScheduleGridID").jqxGrid('addrow', null, {});
            $("#overlay, #PleaseWait").hide();
            
            $('#serviceScheduleGridID').on('cellValueChanged', function (event) { 
            	
              	 var rowBoundIndex=event.args.rowindex;
              	 $('#serviceScheduleGridID').jqxGrid('setcellvalue', rowBoundIndex, "pltime" ,new Date());
              	 
           });
            
            $("#serviceScheduleGridID").on("cellclick", function (event) {
	            		    
           		    var rows = $('#serviceScheduleGridID').jqxGrid('getrows');
   	            	var rowlength= rows.length;
   	            	var rowindex1 = rowlength - 1;
   	          	    var pldatecheck=$("#serviceScheduleGridID").jqxGrid('getcellvalue', rowindex1, "pldate");
   	          	    if(typeof(pldatecheck) != "undefined" && typeof(pldatecheck) != "NaN" && pldatecheck != ""){
   	                	$("#serviceScheduleGridID").jqxGrid('addrow', null, {});
   	          	    }
	            	
            });   
            
});
</script>
<div id="serviceScheduleGridID"></div>

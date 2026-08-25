<%@page import="com.project.execution.jobContract.ClsJobContractDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsJobContractDAO DAO= new ClsJobContractDAO(); %>
 <%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String date = request.getParameter("startdate")==null?"0":request.getParameter("startdate"); 
 String enddate = request.getParameter("enddate")==null?"0":request.getParameter("enddate");
 String amount1 = request.getParameter("amount")==null?"0":request.getParameter("amount");
 String instno1 = request.getParameter("instno")==null?"0":request.getParameter("instno");
 String payfre = request.getParameter("cmbpaytype")==null?"0":request.getParameter("cmbpaytype");
 String serdueafter = request.getParameter("serdueafter")==null?"0":request.getParameter("serdueafter");
 
 %>
    <script type="text/javascript">
    var servsecdata;
    var gridload='<%=gridload%>';
    var docno='<%=docno%>';
    
        $(document).ready(function () { 	
            
        	if(gridload=="1"){
        		
        		servsecdata = '<%=DAO.serviceScheduleGrid(session,date,enddate,instno1,amount1,gridload,payfre,serdueafter) %>';
          }
       if(docno>0){
        		
        		servsecdata = '<%=DAO.serviceScheudleGridLoad(session,docno) %>';
        		
          }
        	
             var num = 0; 
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
     						{name : 'trno', type: 'String'   }
                          	],
                 localdata: servsecdata,
                
                
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
            $("#servscGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable:true,
                sortable: true,
                //Add row method--mm:ss
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Pl.Date', datafield: 'pldate', width: '5%',editable:true, columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Pl.Time', datafield: 'pltime', width: '5%' ,cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
	                      editor.jqxDateTimeInput({ showCalendarButton: false });
	                  }
	         
					 },
	                {text: 'Days',datafield:'days',width:'6%',editable:false},
	           	    {text: 'Site',datafield:'site',width:'8%',editable:false,hidden:true},
	           	    {text: 'Service',datafield:'service',width:'8%',editable:false},
	           	    {text: 'serviceid',datafield:'serviceid',width:'10%',editable:false,hidden:true},
	           	    {text: 'siteid',datafield:'siteid',width:'10%',editable:false,hidden:true},
	             	{text: 'Value',datafield:'value',width:'8%',editable:false},
					{ text: 'Assign Group', datafield: 'asgngrp', width: '10%',editable:false,editable:false },
					{ text: 'Assign Group ID', datafield: 'assigngrpid', width: '10%',hidden:true,editable:false },
					{text: 'Assign To',datafield:'emp',width:'10%',editable:false},
					{ text: 'Assign To ID', datafield: 'assigntoid', width: '9%',hidden:true,editable:false },
					{ text: 'AssigEmpid', datafield:'assignempid', width: '9%',hidden:true,editable:false },
					{text: 'Assign Method',datafield:'asgnmode',width:'12%',editable:false},
					{text: 'Description',datafield:'desc1',editable:false},
					{text: 'priority',datafield:'priority',width:'10%', columntype:'checkbox', checked:false},
					{ text: 'trno', datafield:'trno', width: '9%',hidden:true }
					]
            });
            
            
            
            if($('#mode').val()=='view'){
       		 $("#servscGrid").jqxGrid({ disabled: true});
       		
           }
		if(docno>0){
        		
			$('#servscGrid').jqxGrid('showcolumn','site');
        		
          } 
            
            $('#servscGrid').on('cellValueChanged', function (event) 
            		{ 
            	
              	 var rowBoundIndex=event.args.rowindex;
              	 $('#servscGrid').jqxGrid('setcellvalue', rowBoundIndex, "pltime" ,new Date());
            
           });
            
            $('#servscGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      /* if((datafield=="assigngrp"))
	    	   {
 		    	 getgrpcode(rowBoundIndex);
	    	   }
 		     if((datafield=="assignto"))
	    	   {
 		    	 var assgnid=$('#servscGrid').jqxGrid('getcellvalue', rowBoundIndex, "assigngrpid");
 		    	
 		    	getteam(rowBoundIndex,assgnid);
	    	   } */
 		     
            			
            		});
            
            funsercheck();
            $("#servscGrid").jqxGrid('addrow', null, {});
            
            $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#jqxTerms").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu2").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#servscGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#servscGrid").offset();
                       $("#popupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#servscGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow2").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#servscGrid").jqxGrid('getrowid', rowindex);
                       $("#servscGrid").jqxGrid('deleterow', rowid);
                   }
               });
               
               $("#servscGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#servscGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               });
            
               $("#servscGrid").jqxGrid('addrow', null, {});
        });
</script>
<div id='jqxWidget'>
   <div id="servscGrid"></div>
    <div id="popupWindow2">
 
 <div id='Menu2'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
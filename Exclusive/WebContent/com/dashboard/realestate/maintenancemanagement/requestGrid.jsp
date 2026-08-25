<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.realestate.maintenancemanagement.ClsMaintenanceManagementDAO"%>
<% ClsMaintenanceManagementDAO DAO= new ClsMaintenanceManagementDAO();   %>
<% 
String status=request.getParameter("status")==null || request.getParameter("status")==""?"0":request.getParameter("status").toString();
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").toString();
String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno").toString();
String id=request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").toString();
%>
<script type="text/javascript">              
	var mdata;	  	 
	mdata='<%=DAO.loadRequestGrid(vocno,brhid,id,status)%>';                  
 
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
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [
						{name : 'voc_no', type: 'string'  },
						{name : 'brhid', type: 'string'  },
						{name : 'doc_no', type: 'int'  }, 
						{name : 'job', type: 'string'  }, 
						{name : 'job_docno', type: 'int'  }, 
						{name : 'vendor_acno', type: 'string'  },
						{name : 'vendor_name', type: 'string'  },
						{name : 'vendor_docno', type: 'int'  },
						{name : 'priority', type: 'string'  },
						{name : 'est_cost', type: 'number'  },
						{name : 'notify_owner', type: 'bool'  },
						{name : 'comments', type: 'string'  },
	                    {name : 'total', type: 'number'  }, 
	                    {name : 'pay', type: 'string'  }, 
	                    {name : 'margin', type: 'number'  },  
	                    {name : 'rowno', type: 'string'  },       
	                    {name : 'chk', type: 'bool'},       
	                    {name : 'status', type: 'string'  },  
	                    {name : 'description', type: 'string'  }, 
	                    {name : 'workscope', type: 'string'  },
                      ],
                       localdata: mdata,  
              
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source);
          $("#jqxRequestGrid").jqxGrid(
          {
              width: '100%',  
              height: 325,
              source: dataAdapter,
              ready: function () {
                    // callback function which is called by jqxGrid when the widget is initialized and the binding is completed.
                    if($('#hidmodtype').val()=="W"){
                    	 $('#jqxRequestGrid').jqxGrid('showcolumn', 'description');  
					}else{
						$('#jqxRequestGrid').jqxGrid('hidecolumn', 'description');
					}
                },
              editable: true,
              altRows:true,
              showaggregates: true,   
              showstatusbar:true,
              statusbarheight:25,
              columnsresize:true,
              enabletooltips:true,
              selectionmode: 'singlecell',       
              columns: [  
                    { text: '',datafield: 'chk',columntype:'checkbox'},
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
					}  
					},
					{ text: 'rowno', datafield: 'rowno', width: '10%',hidden:true },
					{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true },
					{ text: 'voc_no', datafield: 'voc_no', width: '10%',hidden:true },
					{ text: 'brhid', datafield: 'brhid', width: '10%',hidden:true },             
					{ text: 'job', datafield: 'job', editable: false},	
					{ text: 'Work Scope', datafield: 'workscope', width: '10%' }, 
					{ text: 'job_docno', datafield: 'job_docno', width: '10%',hidden:true },        
					{ text: 'Provider Acc.No',datafield:'vendor_acno',width:'8%', editable: false,hidden:true},
					{ text: 'Provider Name', datafield: 'vendor_name', width: '15%', editable: false },
					{ text: 'vendor_docno', datafield: 'vendor_docno', width: '10%',hidden:true }, 
					{ text: 'Priority', datafield: 'priority', width:'5%',editable: true,columntype:'dropdownlist',hidden:true,
						createeditor: function (row, column, editor) {									
	                        billlist = ["H","M","L"];   		                      
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billlist });								
							},
					 	 initeditor: function (row, cellvalue, editor) {		                       
							var terms = $('#jqxRequestGrid').jqxGrid('getcellvalue', row, "priority");								
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billlist });								
	                     },  
	                 },		
					{ text: 'Notify Owner', datafield: 'notify_owner', width:'5%',columntype:'checkbox',hidden:true},  
					{ text: 'Comments', datafield: 'comments', editable: true ,hidden:true},
					{ text: 'Pay', datafield: 'pay', width:'7%',editable: true,columntype:'dropdownlist',
						createeditor: function (row, column, editor) {									
	                        billlists = ["Owner","Tenant","Expenses","MRF"];          		                      
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billlists });                   	 							
							},
					 	 initeditor: function (row, cellvalue, editor) {		                       
							var terms = $('#jqxRequestGrid').jqxGrid('getcellvalue', row, "pay");								
							editor.jqxDropDownList({ autoDropDownHeight: true, source: billlists });								
	                     },        
	                 },      
					{ text: 'Estimated Value', datafield: 'est_cost', width: '7%', editable: true,cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },  
					{ text: 'Margin', datafield: 'margin', width: '7%', editable: true,cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
					{ text: 'Total', datafield: 'total', width: '7%', editable: false,cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring }, 
					{ text: 'Description', datafield: 'description', width: '18.7%', editable: true },            
					{ text: 'Status', datafield: 'status', width: '8%', editable: false },    
				]  
          });
          // $('#jqxRequestGrid').jqxGrid('hidecolumn', 'description');
          $('#jqxRequestGrid').on('celldoubleclick', function(event){    
              	var rowBoundIndex = event.args.rowindex;  
              	var datafield = event.args.datafield; 
              	if((datafield=="vendor_name")){
	   		    	getvendorac(rowBoundIndex);
	  	    	} 
             /*	if(datafield=="job"){
    		    	getjob(rowBoundIndex);   
   	    	    } */  
            });     
       $('#jqxRequestGrid').on('cellvaluechanged', function (event) {                                                                  
	         var datafield = event.args.datafield;
	         var rowindextemp = event.args.rowindex;
	   	     var estcost=$('#jqxRequestGrid').jqxGrid('getcellvalue', rowindextemp, "est_cost");  
	       	 var marginval=$('#jqxRequestGrid').jqxGrid('getcellvalue', rowindextemp, "margin");  
	       	 var nettotal=0.0;
	       	 if(datafield=="est_cost"){     
	       	   if(typeof(estcost) != "undefined" && typeof(estcost) != "NaN" && estcost != "" && estcost != null){  
					if(typeof(marginval) != "undefined" && typeof(marginval) != "NaN" && marginval != ""  && marginval != null){  
					   nettotal=parseFloat(estcost)+parseFloat(marginval);
			        }else{
			        	nettotal=parseFloat(estcost);
			        }
			    }else{
			    	if(typeof(marginval) != "undefined" && typeof(marginval) != "NaN" && marginval != ""  && marginval != null){  
						   nettotal=parseFloat(marginval);
				        }       
			    }
	         	$('#jqxRequestGrid').jqxGrid('setcellvalue', rowindextemp, "total",nettotal);  
	         	
	       	 } 
	       	  if(datafield=="margin"){    
	       	   if(typeof(marginval) != "undefined" && typeof(marginval) != "NaN" && marginval != "" && marginval != null){
					if(typeof(estcost) != "undefined" && typeof(estcost) != "NaN" && estcost != "" && estcost != null){  
					   nettotal=parseFloat(estcost)+parseFloat(marginval);
			        }else{
			        	nettotal=parseFloat(marginval);
			        }
			    }else{
			    	if(typeof(estcost) != "undefined" && typeof(estcost) != "NaN" && estcost != "" && estcost != null){  
					   nettotal=parseFloat(estcost);
			        }
			    }   
	         	$('#jqxRequestGrid').jqxGrid('setcellvalue', rowindextemp, "total",nettotal);     
	       	 }
	      });  
       $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
       // create context menu
          var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
          $("#jqxRequestGrid").on('contextmenu', function () {
              return false;
          });
              
          $("#Menu2").on('itemclick', function (event) {
       	   var args = event.args;
              var rowindex = $("#jqxRequestGrid").jqxGrid('getselectedrowindex');
              if ($.trim($(args).text()) == "Edit Selected Row") {
                  editrow = rowindex;
                  var offset = $("#jqxRequestGrid").offset();
                  $("#popupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                  // get the clicked row's data and initialize the input fields.
                  var dataRecord = $("#jqxRequestGrid").jqxGrid('getrowdata', editrow);
                  // show the popup window.
                  $("#popupWindow2").jqxWindow('show');
              }
              else {
                  var rowid = $("#jqxRequestGrid").jqxGrid('getrowid', rowindex);
                  var rowno=$('#jqxRequestGrid').jqxGrid('getcellvalue', rowid, "rowno");
                  if(typeof(rowno) != "undefined" && typeof(rowno) != "NaN" && rowno != ""){ 
                	  funDelete(rowno);    
                  }
                  $("#jqxRequestGrid").jqxGrid('deleterow', rowid);
              }
          });
          
          $("#jqxRequestGrid").on('rowclick', function (event) {
              if (event.args.rightclick) {
   		   
                  $("#jqxRequestGrid").jqxGrid('selectrow', event.args.rowindex);
                  var scrollTop = $(window).scrollTop();
                  var scrollLeft = $(window).scrollLeft();
                  contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                  return false;
              
   		   }
          });
      });
</script>      
 <div id='jqxWidget'>
   <div id="jqxRequestGrid"></div> 
    <div id="popupWindow2">
        <div id='Menu2'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
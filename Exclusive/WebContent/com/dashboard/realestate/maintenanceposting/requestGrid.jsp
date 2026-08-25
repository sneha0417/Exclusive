<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.realestate.maintenanceposting.ClsMaintenancePostingDAO"%>
<% ClsMaintenancePostingDAO DAO= new ClsMaintenancePostingDAO();   %>  
<% 
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").toString();
String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno").toString();
String id=request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").toString();
%>
<script type="text/javascript">              
	var mdata;	  	 
	mdata='<%=DAO.loadRequestGrid(vocno,brhid,id)%>';                    
 
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
		                    {name : 'status', type: 'string'  },  
		                    {name : 'cpudoc', type: 'string'  }, 
		                    {name : 'cpuvoc', type: 'string'  },  
		                    {name : 'invdoc', type: 'string'  },
		                    {name : 'invvoc', type: 'string'  },
		                    {name : 'chk', type: 'bool'},      
		                    {name : 'taxacno', type: 'string'  },
		                    {name : 'description', type: 'string'  },
		                    {name : 'reimbursement', type: 'string'  },
		                    {name : 'rmbjvtrno', type: 'string'  },
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
              height: 250,  
              showaggregates: true,   
              showstatusbar:true,
              statusbarheight:25,
              source: dataAdapter,
              editable: true,
              altRows:true,
              showaggregates: true,
              columnsresize:true,
              enabletooltips:true,
              selectionmode: 'singlecell',       
              columns: [  
                    { text: '',datafield: 'chk',columntype:'checkbox', width: '3%'},
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
					{ text: 'rmbjvtrno', datafield: 'rmbjvtrno', width: '10%',hidden:true },             
					{ text: 'reimbursement', datafield: 'reimbursement', width: '10%',hidden:true },  
					{ text: 'job', datafield: 'job', editable: false},		
					{ text: 'job_docno', datafield: 'job_docno', width: '10%',hidden:true },        
					{ text: 'Provider Acc.No',datafield:'vendor_acno',width:'8%', editable: false,hidden:true},
					{ text: 'Provider Name', datafield: 'vendor_name', width: '20%', editable: false },
					{ text: 'vendor_docno', datafield: 'vendor_docno', width: '10%',hidden:true },
					{ text: 'taxacno', datafield: 'taxacno', width: '10%',hidden:true }, 
					{ text: 'Priority', datafield: 'priority', width:'5%',editable: false,columntype:'dropdownlist',hidden:true,
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
					{ text: 'Pay', datafield: 'pay', width:'10%',editable: true,columntype:'dropdownlist',
						createeditor: function (row, column, editor) {									
	                        billlists = ["Owner","Tenant","Expenses","MRF"];         		                      
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billlists });                   	 							
							},
					 	 initeditor: function (row, cellvalue, editor) {		                       
							var terms = $('#jqxRequestGrid').jqxGrid('getcellvalue', row, "pay");								
							editor.jqxDropDownList({ autoDropDownHeight: true, source: billlists });								
	                     },        
	                 },      
					{ text: 'Estimated Value', datafield: 'est_cost', width: '6%', editable: true ,cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },                   
					{ text: 'Margin', datafield: 'margin', width: '6%', editable: true ,cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
					{ text: 'Total', datafield: 'total', width: '6%', editable: true ,cellsalign:'right',cellsformat:'d2',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring }, 
					{ text: 'Status', datafield: 'status', width: '9%', editable: false },     
					{ text: 'Description', datafield: 'description', width: '18.7%', editable: true },
					{ text: 'CPU Doc No', datafield: 'cpudoc', width: '6%', editable: false,hidden:true  },
					{ text: 'PRIV Doc No', datafield: 'invdoc', width: '6%', editable: false,hidden:true  },
					{ text: 'CPU Doc No', datafield: 'cpuvoc', width: '6%', editable: false },
					{ text: 'PRIV Doc No', datafield: 'invvoc', width: '6%', editable: false },       
				]    
          });
          $('#jqxRequestGrid').on('cellvaluechanged', function (event) {                                                                  
 	         var datafield = event.args.datafield;
 	         var rowindextemp = event.args.rowindex;
 	   	     var est_cost=$('#jqxRequestGrid').jqxGrid('getcellvalue', rowindextemp, "est_cost");  
 	       	 var margin=$('#jqxRequestGrid').jqxGrid('getcellvalue', rowindextemp, "margin");  
 	       	 var nettotal=0.0;
 	       	 if(datafield=="est_cost"){  
 	       	   if(typeof(est_cost) != "undefined" && typeof(est_cost) != "NaN" && est_cost != "" && est_cost != null){  
 					if(typeof(margin) != "undefined" && typeof(margin) != "NaN" && margin != ""  && margin != null){  
 					   nettotal=parseFloat(est_cost)+parseFloat(margin);
 			        }else{
 			        	nettotal=parseFloat(est_cost);
 			        }
 			    }
 	         	$('#jqxRequestGrid').jqxGrid('setcellvalue', rowindextemp, "total",nettotal);  
 	         	
 	       	 } 
 	       	  if(datafield=="margin"){  
 	       	   if(typeof(margin) != "undefined" && typeof(margin) != "NaN" && margin != "" && margin != null){  
 					if(typeof(est_cost) != "undefined" && typeof(est_cost) != "NaN" && est_cost != "" && est_cost != null){  
 					   nettotal=parseFloat(est_cost)+parseFloat(margin);
 			        }else{
 			        	nettotal=parseFloat(margin);
 			        }
 			    }
 	         	$('#jqxRequestGrid').jqxGrid('setcellvalue', rowindextemp, "total",nettotal);           
 	       	 }
 	      });
      });
</script>
<div id="jqxRequestGrid"></div>
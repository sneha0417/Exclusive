<%@page import="com.project.execution.quotation.ClsQuotationDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); %>
 <%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString();
 String reviseno=request.getParameter("reviseno")==null?"0":request.getParameter("reviseno").trim().toString();
 %>
    <script type="text/javascript">
    var servdata;
    var gridload='<%=gridload%>';
    var docno='<%=docno%>';
    var trno='<%=trno%>';
    
    if(gridload=="1" && trno>0){
    	servdata = '<%=DAO.serviceRefGridLoad(session,trno) %>';
    
    }
    
    if(docno>0){
		
    	servdata = '<%=DAO.serviceGridLoad(session,docno,reviseno) %>';
    	
  }
   
    	  var rendererstring1=function (aggregates){
        	var value=aggregates['sum1'];
        	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
        }
    	  
    	  var cellclassname = function (row, column, value, data) {
        		/* if (data.qty==0) {
        			document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
                    return "redClass";
                }
        		else{
        			//document.getElementById("errormsg").innetText="";
        		} */
        		};
     
    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
    }
    
        $(document).ready(function () { 	
         var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'site' , type: 'String' },
							{name : 'siteid' , type: 'String' }, 
                          	{name : 'stype' , type: 'String' },
                          	{name : 'stypeid' , type: 'String' },
                          	{name : 'unit' , type: 'String' },
                          	{name : 'unitid' , type: 'String' },
     						{name : 'item', type: 'String'  },
                          	{name : 'qty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'desc1', type: 'String'  },
     						{name : 'revision_no', type: 'String'  },
                          	],
                 localdata: servdata,
                
                
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
            $("#serviceGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:20,
             	 selectionmode: 'singlecell',
                 localization: {thousandsSeparator: ""},
                editable:true,
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Site', datafield: 'site', width: '16%',editable:false },
					{ text: 'siteid', datafield: 'siteid', width: '10%',hidden:true},
					{ text: 'Service.Type', datafield: 'stype', width: '16%',editable:false },
					{ text: 'stypeid', datafield: 'stypeid', width: '10%',hidden:true},
					{ text: 'Item', datafield: 'item', width: '10%'},
					{ text: 'Unit', datafield: 'unit', width: '5%',editable:false  },
					{ text: 'Qty', datafield: 'qty', width: '5%' },
					{ text: 'Unitid', datafield: 'unitid', width: '10%',hidden:true},
					{text: 'Amount',datafield:'amount',width:'10%',cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
					{text: 'Total',datafield:'total',cellsformat: 'd2',editable:false, width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{text: 'Description',datafield:'desc1'}, 
					{ text: 'revision_no', datafield: 'revision_no', width: '10%',hidden:true},
					]
            });
            if($('#mode').val()=='view'){
       		 $("#serviceGrid").jqxGrid({ disabled: true});
       		
           }
            $('#serviceGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="stype"))
	    	   {
 		    	 getserType(rowBoundIndex);
	    	   }
 		     if((datafield=="site"))
	    	   {
 		    	getsite(rowBoundIndex);
	    	   }
 		    if(datafield=="unit")
	    	   {
	    	  unitSearchContent('unitSearchGrid.jsp?rowno='+rowBoundIndex);
	    	   }
 		    			
            		});
            
            $("#serviceGrid").on('cellvaluechanged', function (event) 
                    {
            	
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    
    		            	   
    		    if(datafield=="qty" || datafield=="amount" )
    		  {
    		    	
    		    	var qty= $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
               	    var amount= $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
               		var total;
               		
               		if(qty==""||typeof(qty)=="undefined"|| qty=="NaN"){
               			qty=0;
               		}
               		
               		if(amount=="" || typeof(amount)=="undefined" || amount=="NaN"){
               			amount=0;
               		}		
               			
    		    		total=parseFloat(qty)*parseFloat(amount);
             			$('#serviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
             			
    		    	 var summaryData3= $("#serviceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    	         	document.getElementById("txtgrtotal").value=summaryData3.sum.replace(/,/g,''); 
    	         	document.getElementById('txttotalamt').value=summaryData3.sum.replace(/,/g,''); 
    	         	document.getElementById('txtnettotal').value=summaryData3.sum.replace(/,/g,''); 
    		  }
    		   
            	
                    });
            
            
            
            $("#popupWindow1").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu1").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#serviceGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu1").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#serviceGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#serviceGrid").offset();
                       $("#popupWindow1").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#serviceGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow1").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#serviceGrid").jqxGrid('getrowid', rowindex);
                       $("#serviceGrid").jqxGrid('deleterow', rowid);
                   }
               });
               
               $("#serviceGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#serviceGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               });
            
            
            $("#serviceGrid").jqxGrid('addrow', null, {});
      
        });
    </script>
    
    <div id='jqxWidget'>
   <div id="serviceGrid"></div>
    <div id="popupWindow1">

 <div id='Menu1'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>

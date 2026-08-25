<%@page import="com.project.execution.estimation.ClsEstimationDAO"%>
<%ClsEstimationDAO DAO= new ClsEstimationDAO();%>
<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); 
String trno = request.getParameter("trno")==null?"0":request.getParameter("trno");
String aid = request.getParameter("aid")==null?"0":request.getParameter("aid");
int loadid =request.getParameter("loadid")==null?0:Integer.parseInt(request.getParameter("loadid").trim());
%>  

<script type="text/javascript">

		var eqpdata;
		var docno='<%=docno%>';
		var trno='<%=trno%>';
		var loadid=parseInt('<%=loadid%>');
		
		if(loadid==1){
		eqpdata='<%=DAO.equipmentGridLoad(session,docno)%>'; 
		}
		else if(loadid==2){
			eqpdata='<%=DAO.equipmentGridReLoad(session,trno,aid)%>';
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
        	
        	
        	// prepare the equipdata
            var source =
            {
            		datatype: "json",
                    datafields: [
							
     						{name : 'codeno', type: 'string' },
     						{name : 'desc2', type: 'string'   },
     						{name : 'hrs2', type: 'string'  },
     						{name : 'min2', type: 'string'  },
     						{name : 'rate2', type: 'number'  },
     						{name : 'total2', type: 'number'  },
     						{name : 'margin2', type: 'number'  },
     						{name : 'netotal2', type: 'number'  },
     						{name : 'docno', type: 'string'  },
     						{name : 'activity', type: 'string'  },
     						{name : 'activityid', type: 'string'  }
                 ],
                 localdata: eqpdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
        	
            $("#equipmentDetailsGridID").on("bindingcomplete", function (event) {
             	
           	 var rowlength=$("#equipmentDetailsGridID").jqxGrid('rows').records.length;
           	 
           	if(rowlength>0){
           		var summaryData3= $("#equipmentDetailsGridID").jqxGrid('getcolumnaggregateddata', 'netotal2', ['sum'],true);
         		  document.getElementById("txteqptotal").value=summaryData3.sum.replace(/,/g,''); 
         		 var txtmatotal=document.getElementById("txtmatotal").value;
           		 var txtlabtotal=document.getElementById("txtlabtotal").value;
           		 var txteqptotal=document.getElementById("txteqptotal").value;
           		 var grtotal=(parseFloat(txtmatotal)+parseFloat(txtlabtotal)+parseFloat(txteqptotal));
           		document.getElementById("txtnettotal").value=grtotal.toFixed(2);
           		document.getElementById("txtnetotal").value=grtotal.toFixed(2);
           	}
           	 
              });
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );

            
            
            $("#equipmentDetailsGridID").jqxGrid(
            {
            	width: '99%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                editable: true,
                sortable: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:20,
                rowsheight:25,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                columns: [
						  { text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Activity', datafield: 'activity', width: '10%',editable:false },
							{ text: 'Machine', datafield: 'desc2', width: '30%',editable:false },
							{ text: 'Hrs', datafield: 'hrs2', width: '8%' },	
							{ text: 'Mins', datafield: 'min2', width: '8%' },	
							{ text: 'docno', datafield: 'docno', width: '10%',hidden:true },
							{ text: 'activityid', datafield: 'activityid', width: '5%',hidden:true },
							{ text: 'Rate/Hr', datafield: 'rate2', cellsformat: 'd2', cellsalign: 'right', width: '10%',editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Total', datafield: 'total2', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							{ text: 'Margin %', datafield: 'margin2', width: '10%', cellsalign: 'right', cellsformat: 'd2'},
							{ text: 'NetTotal', datafield: 'netotal2', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable:false },
						 ]
            });
            //9349711600
            $('#equipmentDetailsGridID').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		       if( (datafield=="desc2"))
	    	   {
 		    	 getecharge(rowBoundIndex);
	    	   } 
 		     	
            });
            
            $("#equipmentDetailsGridID").on('cellvaluechanged', function (event) 
                    {
            	
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    
    		    var hrs=0;
    		    var mins=0;
    		    var rate=0;
    		    var ratemin=0.0;
          	    var totmin=0.0;
          	    var total=0.0;
          	    var margin=0;
          	    var discount=0;
          	    var netotal=0;
    		            	   
    		    if(datafield=="hrs2" || datafield=="min2" || datafield=='margin2' )
    		  {
    		    	
    		    	 hrs= $('#equipmentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "hrs2");
               	     mins= $('#equipmentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "min2");
               	     rate= $('#equipmentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "rate2");
               	    total=$('#equipmentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "total2");
        			 margin=$('#equipmentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "margin2");
               	
               	 if((hrs==""||typeof(hrs)=="undefined"|| typeof(hrs)=="NaN" ))
      		   {
               		hrs=0;
               		
             	    
      		   }
               	if(( mins=="" || typeof(mins)=="undefined" || typeof(mins)=="NaN"))
       		   {
                		
                		mins=0;
              	    
       		   }
               	
             	  ratemin=rate/60;
             	  totmin=parseInt((hrs*60))+parseInt(mins);
             	  total=totmin*ratemin;
             	 netotal=total;
             	 discount=(parseFloat(total)*parseFloat(margin))/100;
       			 netotal=parseFloat(total)+parseFloat(discount);
       			
      			$('#equipmentDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "total2",total);
      			$('#equipmentDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "netotal2",netotal);
		    	
   		   }
   		    
   		 /*    if(datafield=='margin2' ){
   		    	total=$('#equipmentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "total2");
       			 margin=$('#equipmentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "margin2");
       			
       			 if(( margin=="" || typeof(margin)=="undefined" || typeof(margin)=="NaN" ))
	       		   {
	                		
		    		 margin=0;
	              	    
	       		   }
       			 
       			 
       			 discount=(parseFloat(total)*parseFloat(margin))/100;
       			 netotal=parseFloat(total)+parseFloat(discount);
       			
       			$('#equipmentDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "netotal2",netotal);
       		} */
   		 
   		 
   		     var summaryData3= $("#equipmentDetailsGridID").jqxGrid('getcolumnaggregateddata', 'netotal2', ['sum'],true);
       		  document.getElementById("txteqptotal").value=summaryData3.sum.replace(/,/g,'');  
       		  
       		 var txtmatotal=document.getElementById("txtmatotal").value;
       		 var txtlabtotal=document.getElementById("txtlabtotal").value;
       		 var txteqptotal=document.getElementById("txteqptotal").value;
       		 var grtotal=(parseFloat(txtmatotal)+parseFloat(txtlabtotal)+parseFloat(txteqptotal));
       		document.getElementById("txtnettotal").value=grtotal.toFixed(2);
       		document.getElementById("txtnetotal").value=grtotal.toFixed(2);
   		    
            	
                    });
            
            if($('#mode').val()=="view"){
           
            	$("#equipmentDetailsGridID").jqxGrid('disabled', true);
            }
            
            $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#equipmentDetailsGridID").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu2").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#equipmentDetailsGridID").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#equipmentDetailsGridID").offset();
                       $("#popupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#equipmentDetailsGridID").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow2").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#equipmentDetailsGridID").jqxGrid('getrowid', rowindex);
                       $("#equipmentDetailsGridID").jqxGrid('deleterow', rowid);
                   }
               });
               
               $("#equipmentDetailsGridID").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#equipmentDetailsGridID").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               });
      
        });

</script>
<div id='jqxWidget'>
   <div id="equipmentDetailsGridID"></div>
    <div id="popupWindow2">
 
 <div id='Menu2'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
<!-- <div id="equipmentDetailsGridID"></div> -->
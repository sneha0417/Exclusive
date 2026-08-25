<%@page import="com.project.execution.templates.ClsTemplateDAO"%>
<%ClsTemplateDAO DAO= new ClsTemplateDAO();%>
<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>  

<script type="text/javascript">

		var eqpdata;
		eqpdata='<%=DAO.equipmentGridLoad(session,docno)%>'; 
	  
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
     						{name : 'docno', type: 'string'  }
                 ],
                 localdata: eqpdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
        	
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
							
							{ text: 'Machine', datafield: 'desc2', width: '30%',editable:false },
							{ text: 'Hrs', datafield: 'hrs2', width: '15%' },	
							{ text: 'Mins', datafield: 'min2', width: '10%' },	
							{ text: 'docno', datafield: 'docno', width: '10%',hidden:true },	
							{ text: 'Rate/Hr', datafield: 'rate2', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%',editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Total', datafield: 'total2', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							{ text: 'Margin %', datafield: 'margin2', width: '10%', cellsalign: 'right'},
							{ text: 'NetTotal', datafield: 'netotal2', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable:false },
						 ]
            });
            
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
               	  margin=$('#equipmentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "margin2");
               	total=$('#equipmentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "total2");
               	  
               	
               	 if((hrs==""||typeof(hrs)=="undefined"|| typeof(hrs)=="NaN" ))
      		   {
               		hrs=0;
               		
             	    
      		   }
               	if((mins=="" || typeof(mins)=="undefined" || typeof(mins)=="NaN"))
       		   {
                		
                		mins=0;
              	    
       		   }
               	if(( margin=="" || typeof(margin)=="undefined" || typeof(margin)=="NaN" ))
	       		   {
	                		
		    		 margin=0;
	              	    
	       		   }
               	
             	  ratemin=rate/60;
             	  totmin=parseInt((hrs*60))+parseInt(mins);
             	  total=totmin*ratemin;
             	 netotal=total;
             	 discount=(parseFloat(total)*parseFloat(margin))/100;
      			 netotal=parseFloat(total)+parseFloat(discount);
      			
      			$('#equipmentDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "netotal2",netotal);
      			$('#equipmentDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "total2",total);
      			$('#equipmentDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "netotal2",netotal);
		    	
   		   }
   		    
   		  /*   if(datafield=='margin2' ){
   		    	
       			 margin=$('#equipmentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "margin2");
       			 
       			if(( margin=="" || typeof(margin)=="undefined" || typeof(margin)=="NaN" ))
	       		   {
	                		
		    		 margin=0;
	              	    
	       		   }
       			
       			total=$('#equipmentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "total2");
       			
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
       		 document.getElementById("txtnettotal").value=grtotal;
   		    
            	
                    });
            
            if($('#mode').val()=="view"){
           
            	$("#equipmentDetailsGridID").jqxGrid('disabled', true);
            }
            
            
        });

</script>

<div id="equipmentDetailsGridID"></div>
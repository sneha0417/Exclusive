 <%@page import="com.project.execution.templates.ClsTemplateDAO"%>
<%ClsTemplateDAO DAO= new ClsTemplateDAO();%>
<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>  

<script type="text/javascript">

		var labdata;
		labdata='<%=DAO.labourGridLoad(session,docno)%>'; 
	  
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
							
     						{name : 'codeno', type: 'string' },
     						{name : 'desc1', type: 'string'   },
     						{name : 'hrs', type: 'string'  },
     						{name : 'min', type: 'string'  },
     						{name : 'rate', type: 'number'  },
     						{name : 'total1', type: 'number'  },
     						{name : 'margin1', type: 'number'  },
     						{name : 'netotal1', type: 'number'  },
     						{name : 'docno', type: 'string'  }
                 ],
                 localdata: labdata, 
                
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

            
            
            $("#labourDetailsGridID").jqxGrid(
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
							{ text: 'Code No', datafield: 'codeno', width: '5%',editable:false },	
							{ text: 'docno', datafield: 'docno', width: '5%',hidden:true },
							{ text: 'Description', datafield: 'desc1', width: '20%',editable:false },
							{ text: 'Hrs', datafield: 'hrs', width: '20%' },	
							{ text: 'Mins', datafield: 'min', width: '10%' },	
							{ text: 'Rate/Hr', datafield: 'rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%',editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Total', datafield: 'total1', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							{ text: 'Margin %', datafield: 'margin1', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'NetTotal', datafield: 'netotal1', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable:false },
						 ]
            });
            
            $('#labourDetailsGridID').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="codeno") || (datafield=="desc2"))
	    	   {
 		    	 getlcharge(rowBoundIndex);
	    	   }
 		     	
            });
            
            $("#labourDetailsGridID").on('cellvaluechanged', function (event) 
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
    		    if(datafield=="hrs" || datafield=="min" || datafield=='margin1'  )
    		  {
    		    	
    		    	 hrs= $('#labourDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "hrs");
               	     mins= $('#labourDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "min");
               	     rate= $('#labourDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "rate");
               	    total=$('#labourDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "total1");
               	    margin=$('#labourDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "margin1");
               	
               	 if((hrs==""||typeof(hrs)=="undefined"|| typeof(hrs)=="NaN"  ))
      		   {
               		hrs=0;
               		
             	    
      		   }
               	
               	 
               	if(( mins=="" || typeof(mins)=="undefined" || typeof(mins)=="NaN"  || typeof(mins)=="NaN"))
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
             	 
      			$('#labourDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "total1",total);
      			$('#labourDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "netotal1",netotal);
      			
    		    	
    		   }
    		    
    		     /* if(datafield=='margin1' ){
    		    	 
    		    	 margin=$('#labourDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "margin1");
    		   
    		    	 if(( margin=="" || typeof(margin)=="undefined" || typeof(margin)=="NaN" ))
    	       		   {
    	                		
    		    		 margin=0;
    	              	    
    	       		   }
    		    	
    		    	 
    		    	 if(margin!=0){
    		    		 
    		    		 total=$('#labourDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "total1");
            			 discount=(parseFloat(total)*parseFloat(margin))/100;
            			 netotal=parseFloat(total)+parseFloat(discount);
            			 $('#labourDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "netotal1",netotal);
            			 
    		    	 }
    		    	 
        			
        		}  */
    		    
    		     
    		     var summaryData2= $("#labourDetailsGridID").jqxGrid('getcolumnaggregateddata', 'netotal1', ['sum'],true);
    		     
        		document.getElementById("txtlabtotal").value=summaryData2.sum.replace(/,/g,''); 
        		
        		 var txtmatotal=document.getElementById("txtmatotal").value;
           		 var txtlabtotal=document.getElementById("txtlabtotal").value;
           		 var txteqptotal=document.getElementById("txteqptotal").value;
           		 var grtotal=(parseFloat(txtmatotal)+parseFloat(txtlabtotal)+parseFloat(txteqptotal));
           		 document.getElementById("txtnettotal").value=grtotal;
    		    
            	
                    });
            
            if($('#mode').val()=="view"){
            	
            	$("#labourDetailsGridID").jqxGrid('disabled', true);
            }
            
            
            
            
            
        });

</script>

<div id="labourDetailsGridID"></div>
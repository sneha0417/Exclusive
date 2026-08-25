<%@page import="com.aviation.aviationinvoice.ClsaviationInvoiceDAO"%>
<% ClsaviationInvoiceDAO DAO = new ClsaviationInvoiceDAO(); 
 

String masterdocno = request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno");
	
	 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
	 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
	 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate");
	 String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno");
 
	 


%> 
<script type="text/javascript">

var masterdocno='<%=masterdocno%>';

var cldocno='<%=cldocno%>';

var reqdata1;

if(masterdocno>0)
	{
	  reqdata1='<%=DAO.maingridreload(masterdocno)%>';  
	}
else if(cldocno>0)
	{
	  reqdata1='<%=DAO.maingridreload(cldocno,fromdate,todate,psrno)%>';  
	}
else
	{
	  reqdata1;
	}





        $(document).ready(function () { 	
        
    
      
           var rendererstring=function (aggregates){
           	var value=aggregates['sum'];
           	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
           }
               
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dateoff', type: 'date'  },
							{name : 'docno', type: 'int'   },
     						{name : 'dono', type: 'string'  },
     					 
     						{name : 'ddocno', type: 'int'   },
     						{name : 'unitid', type: 'int'   },
     						
     						{name : 'operator', type: 'string'  },
     						{name : 'port', type: 'string'  },
     						{name : 'flno', type: 'string'  },
     						
     						{name : 'qpl', type: 'number'  },
     						{name : 'qpg', type: 'number'  },
     						{name : 'tax', type: 'number'   },
     						{name : 'itax', type: 'number'   },
     						{name : 'portid', type: 'number'   },
     						{name : 'sprice', type: 'number'   },
     						{name : 'pprice', type: 'number'   },
     						{name : 'amountusd', type: 'number'   },
     						{name : 'amountaed', type: 'number'   },
     						{name : 'amountusdp', type: 'number'   },
     						{name : 'amountaedp', type: 'number'   },
     						
     						{name : 'vndid', type: 'number'   },
     						
     						{name : 'fdocno', type: 'number'   },
     						
     						
     						
     						
     						
                 ],
                 localdata: reqdata1,
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

            
            
            $("#jqxdetgrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                disabled:true,
                editable: true,
                altRows: true,
                columnsresize: true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,cellsalign: 'center',
                              datafield: 'sl', columntype: 'number', width: '2%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
                            },	
                            
                            { text: 'Date of Fuelling', datafield: 'dateoff', width: '6%',cellsformat:'dd.MM.yyyy' , editable: false},
                            { text: 'Doc No', datafield: 'docno', width: '5%' , editable: false},
                            { text: 'ddocno', datafield: 'ddocno', width: '5%' , editable: false,hidden:true},
                            { text: 'unitid', datafield: 'unitid', width: '5%' , editable: false,hidden:true},
                            { text: 'Do No', datafield: 'dono', width: '8%' , editable: false},	
                            { text: 'Operator', datafield: 'operator', width: '10%' , editable: false},	
                            { text: 'Port', datafield: 'port', width: '10%' , editable: false},	
                            { text: 'Portid', datafield: 'portid', width: '10%' , editable: false,hidden:true},	
                            { text: 'Flight No', datafield: 'flno', width: '7%' , editable: false},	
                            { text: 'Qty/LTR', datafield: 'qpl', width: '5%' , editable: false,cellsformat: 'd4', align: 'right', cellsalign: 'right'},	
                            { text: 'Qty/USG', datafield: 'qpg', width: '5%' , editable: false, cellsformat: 'd4', align: 'right', cellsalign: 'right'},	
                            { text: 'Tax(Per Rate)', datafield: 'tax', width: '7%' , editable: false,cellsformat: 'd4', align: 'right', cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
                            { text: 'Tax(Per Invoice)', datafield: 'itax', width: '7%' , editable: false,cellsformat: 'd4', align: 'right', cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
                            { text: 'vndid', datafield: 'vndid', width: '8%' , editable: false,hidden:true },
                            { text: 'fdocno', datafield: 'fdocno', width: '8%' , editable: false ,hidden:true},
                            { text: 'S.Price/Unit', datafield: 'sprice', width: '7%' , editable: true,cellsformat: 'd4', align: 'right', cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
                            { text: 'P.Price/Unit', datafield: 'pprice', width: '7%' , editable: false,cellsformat: 'd4', align: 'right', cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
                            { text: 'Amount-USD', datafield: 'amountusd', width: '7%' , editable: false,cellsformat: 'd4', align: 'right', cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
                            { text: 'Amount-AED', datafield: 'amountaed', width: '7%' , editable: false,cellsformat: 'd4', align: 'right', cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
                            { text: 'Amount-USDP', datafield: 'amountusdp', width: '8%' , editable: false,cellsformat: 'd4', align: 'right', cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
                            { text: 'Amount-AEDP', datafield: 'amountaedp', width: '8%' , editable: false,cellsformat: 'd4', align: 'right', cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
                            
     		 
                         
			              ]
               
            });
            
            
            
            
            $("#jqxdetgrid").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
            		    var rowBoundIndex = event.args.rowindex;    
            		    if(datafield=="sprice" && (document.getElementById("mode").value=="A" ||document.getElementById("mode").value=="E"))
            		    	{
            		    	var qpg= $('#jqxdetgrid').jqxGrid('getcellvalue', rowBoundIndex, "qpg"); 
            		    	var sprice= $('#jqxdetgrid').jqxGrid('getcellvalue', rowBoundIndex, "sprice");	
            		    	var c_rate=document.getElementById("usdrate").value;
            		    	var amountusd=(parseFloat(qpg)*(parseFloat(sprice)* parseFloat(0.01)));
            		    	var amountaed=(parseFloat(amountusd)*parseFloat(c_rate));
            		    	$('#jqxdetgrid').jqxGrid('setcellvalue', rowBoundIndex, "amountusd",amountusd);	
            		    	$('#jqxdetgrid').jqxGrid('setcellvalue', rowBoundIndex, "amountaed",amountaed);	
            		    	}
                    });
            
            $("#jqxdetgrid").jqxGrid('addrow', null, {});
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
		       {
		  $("#jqxdetgrid").jqxGrid({ disabled: false}); 
		    
		       
		       
		       
		       }
        
 
        });
        
       
 
    </script>
    <div id="jqxdetgrid"></div>
  <input type="hidden" id="rowindex"/> 

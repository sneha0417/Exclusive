 <%@page import="com.dashboard.vehiclepurchase.purchaselist.ClsPurchaseListDAO" %>
 <%ClsPurchaseListDAO cpd=new ClsPurchaseListDAO(); %>
 
 <%
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 
  	
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var enqdata;

 if(temp4!='NA')
{ 
	
	 enqdata='<%=cpd.reqclosesearch(barchval,fromdate,todate)%>'; 
		 
} 
else
{ 
	
	enqdata;
	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
//doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                        {name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'type', type: 'String'  },
						{name : 'expdeldt', type: 'date'  },
						{name : 'qty', type: 'String'  },
						{name : 'brand', type: 'String'},
						{name : 'model', type: 'String'},
						{name : 'color', type: 'String'  },
						{name : 'spec', type: 'String'  },
						{name : 'btnsave', type: 'String'  },
						{name : 'brhid', type: 'String'  },
						{name : 'doc_no', type: 'String'  },
						
						{name : 'srno', type: 'String'  },
						
						],
				    localdata: enqdata,
        
        
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
    
    
   
   
    
    $("#reqlistgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                    
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                      { text: 'Doc No',datafield: 'voc_no', width: '5%' },
         			 { text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
           	         { text: 'Type', datafield: 'type',  width: '5%' }, 
		
			
				     { text: 'Exp.Delivery', datafield: 'expdeldt', width: '9%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Qty', datafield: 'qty', width: '5%' },
				
					 { text: 'Brand', datafield: 'brand', width: '15%'},
					 { text: 'Model', datafield: 'model', width: '15%'},
					 { text: 'Color', datafield: 'color', width: '8%'},
					 { text: 'Specification', datafield: 'specification', width: '20%' },	
					 { text: ' ', datafield: 'btnsave', width: '6%',columntype: 'button',editable:false, filterable: false},
					 { text: 'brhid', datafield: 'brhid', width: '20%' ,hidden:true},	
					 { text: 'doc_no', datafield: 'doc_no', width: '20%' ,hidden:true},
					 { text: 'srno', datafield: 'srno', width: '20%' ,hidden:true},
					]
   
    
    
    
    
    
    
    });
    $("#overlay, #PleaseWait").hide();
    
    $("#reqlistgrid").on('cellclick', function (event) 
    		{
    		 
    		    var datafield = event.args.datafield;
    		    var rowBoundIndex=event.args.rowindex;
    		    
    		    
     			
     			  		    
    if(datafield=="btnsave"){
   	 if($('#reqlistgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){
   		
   		
   		 
   		 //for 
   		  var radocno= $('#reqlistgrid').jqxGrid('getcellvalue',rowBoundIndex, "doc_no");
    		 var branchval= $('#reqlistgrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
   		 
    		 var srno= $('#reqlistgrid').jqxGrid('getcellvalue',rowBoundIndex, "srno");
       		 
   		
		    		          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		    		        	  
		    	     		       
							       		        	if(r==false)
							       		        	  {
							       		        		return false; 
							       		        	  }
							       		        	else{
							        				 savegriddata(radocno,branchval,srno);
							       		        	   }
		    		                      });
   	                      }
						           	 else {
						           		 
						           	
						           	  $('#reqlistgrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
						           	         }
						             }
    });
	          
    function savegriddata(radocno,branchval,srno)
    {
    	
    	var x=new XMLHttpRequest();
    	x.onreadystatechange=function(){
    	if (x.readyState==4 && x.status==200)
    		{
    		
         			
    			var items=x.responseText;
    			
    			
    			 $.messager.alert('Message', '  Record successfully Updated ', function(r){
				     
			     });
    			 funreload(event); 
    			 
    			 
    			
    			}
    		
    	}
    		
    x.open("GET","savereclosedata.jsp?radocno="+radocno+"&branchval="+branchval+"&srno="+srno,true);
    
    x.send();
    		
    }
    
    
});


</script>
<div id="reqlistgrid"></div>
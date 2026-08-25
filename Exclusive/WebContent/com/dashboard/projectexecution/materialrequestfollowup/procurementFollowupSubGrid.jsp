<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
    
  <%@page import="com.dashboard.projectexecution.materialrequestfollowup.ClsMaterialRequestFollowupDAO"%>
<%
ClsMaterialRequestFollowupDAO sd=new ClsMaterialRequestFollowupDAO();
%>
    
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim();
String aid = request.getParameter("aid")==null?"0":request.getParameter("aid");
int loadid =request.getParameter("loadid")==null?0:Integer.parseInt(request.getParameter("loadid").trim());

%>

<style type="text/css">
    .orangeClass
    {
        background-color: #FDEBD0;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greenClass
    {
        background-color: #D1F2EB;
    }
     .greyClass
    {
        background-color: #EAEDED;
    }         
       .blueClass
    {
        background-color: #E8DAEF;
    }           
</style>

<script type="text/javascript">
var matdata;
$(document).ready(function () {
	chklastpurchase();
   var docno='<%=docno%>';
   var trno='<%=trno%>';
   var loadid=parseInt('<%=loadid%>');
 if(loadid==2){
	  
	   matdata='<%=sd.materialGridLoad(session,trno)%>';
   }
	 
 
 var rendererstring2=function (aggregates){
  	var value=aggregates['sum2'];
  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
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

$('#gridtext').keyup(function(){
 	

     $("#prosearchGrid").jqxGrid('clearfilters');
	  

   $('#part_no').val($(this).val());
   var dataField = "part_no";
applyFilter(dataField,$(this).val());  
   
   
   
});


$('#gridtext1').keyup(function(){
	

     $("#prosearchGrid").jqxGrid('clearfilters');
 

 $('#brandname').val($(this).val());
 var dataField = "brandname";
 applyFilter(dataField,$(this).val());  
 
 
 
});            

            	 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'desc1', type: 'string'  },
							{name : 'product', type: 'string' },
     						{name : 'productid', type: 'string' },
     						{name : 'activity', type: 'string' },
     						{name : 'activityid', type: 'string' },
     						{name : 'productname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'qty', type: 'number'  },
     						{name : 'stkqty', type: 'number'  },
     						{name : 'resqty', type: 'number'  },
     						{name : 'purqty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'netotal', type: 'number'  },
     						{name : 'margin', type: 'number'  },
     						{name : 'invoiced', type: 'bool'  },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'proid', type: 'number'    },
     						{name : 'specid', type: 'number'    },
     						{name : 'rowno', type: 'number'    },
     						{name : 'brhid', type: 'number'    },
     						{name : 'locid', type: 'number'    },
     						{name : 'brandname', type: 'string'    },
     						{name : 'remqty', type: 'number'    },
     						{name : 'stypeid', type: 'number'    },
     						{name : 'site', type: 'string'    },
     						{name : 'sertype', type: 'string'    },
     						{name : 'brandid', type: 'number'    },
     						{name : 'purorder', type: 'number'    },
     						{name : 'oldbalqty', type: 'number'    },
     						
     						
     						{name : 'mrqty', type: 'number'    },
     						{name : 'purchaseqty', type: 'number'    },
     						{name : 'proqty', type: 'number'    },
     						
     						{name : 'costdocno', type: 'number'    },
     						
     						{name : 'issueqty', type: 'number'    },
     						
     						
     						
     						
     						
     						
     						
     						
							  
     						
                        ],
                        
                        
                       
                         localdata: matdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            		
            };
            	
            		
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#procurementSubGrid").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                columnsresize: true,
                statusbarheight: 20,
                selectionmode: 'checkbox',
                pagermode: 'default',
                handlekeyboardnavigation: function (event) {
                	


                	
                	
                	
                	

              	  var cell2 = $('#procurementSubGrid').jqxGrid('getselectedcell');
                  	if (cell2 != undefined && cell2.datafield == 'unitprice' &&   document.getElementById("puchasechk").value == 1) {
                     	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     	if (key == 114) { 
                         	var psrno= $('#procurementSubGrid').jqxGrid('getcellvalue',  cell2.rowindex, "psrno");
                         	if(parseInt(psrno)>0)
                         		{
                         	      document.getElementById("rowindex").value =  cell2.rowindex;  
                          	  $('#procurementSubGrid').jqxGrid('clearselection');
                          	  priceSearchContent('purchasepriceSearch.jsp?rowindex='+document.getElementById("rowindex").value+"&psrno="+psrno);
                     	
                                	}
                           }
                     	}
                  
                },
                  
                columns: [
							{ text: 'SrNo', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Activty', datafield: 'activity', width: '10%',editable:false ,hidden:true},
							{text: 'activityid', datafield: 'activityid', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'Site', datafield: 'site', width: '8%',editable:true,hidden:true },
							{text: 'Service Type', datafield: 'sertype', width: '7%',editable:false ,hidden:true},
							{ text: 'Description', datafield: 'desc1', width: '10%',editable:false ,hidden:true},
							
							{ text: 'costdocno', datafield: 'costdocno', width: '15%',editable:false,hidden:true  },
							
							
							
							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '10%',cellclassname: cellclassname,editable:false},  
							{text: 'Brand', datafield: 'brandname', width: '10%',cellclassname: cellclassname,editable:false},
							{ text: 'Product Name', datafield: 'productname'  ,cellclassname: cellclassname ,editable:false,hidden:false},
							
							{ text: 'Unit', datafield: 'unit', width: '4%',editable:false,cellclassname: cellclassname },	
							
						/* 	{ text: 'Amount', datafield: 'amount', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname }, */
							
							{ text: 'Qty', datafield: 'qty', width: '6%',editable:false,cellclassname: cellclassname, cellsformat: 'd2',cellclassname: 'greyClass',editable:false, cellsalign: 'right', align: 'right' },
							
							{ text: 'MR_Qty', datafield: 'mrqty', width: '6%',editable:false,cellclassname: cellclassname, cellsformat: 'd2',cellclassname: 'greyClass',editable:false, cellsalign: 'right', align: 'right' },
							
							{ text: 'Issue Qty', datafield: 'issueqty', width: '6%',editable:false,cellclassname: cellclassname, cellsformat: 'd2',cellclassname: 'orangeClass',editable:false , cellsalign: 'right', align: 'right'},
							
							
							
				/* 			
							{ text: 'Stock Qty', datafield: 'stkqty', width: '5%',editable:false,cellclassname: cellclassname, cellsformat: 'd2',cellclassname: 'orangeClass',editable:false , cellsalign: 'right', align: 'right'},
							
							{ text: 'RES Qty', datafield: 'resqty', width: '5%',cellclassname: cellclassname, cellsformat: 'd2',cellclassname: 'yellowClass', cellsalign: 'right', align: 'right',editable:false },
							{ text: 'PR Qty', datafield: 'purqty', width: '5%',cellclassname: cellclassname, cellsformat: 'd2',cellclassname: 'greenClass' , cellsalign: 'right', align: 'right',editable:false},
							{ text: 'PO Qty', datafield: 'purorder', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false},
							
							{ text: 'Purchase Qty', datafield: 'purchaseqty', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false},
							 */
							{ text: 'Bal Qty', datafield: 'remqty',editable:false, width: '6%',cellclassname: cellclassname, cellsformat: 'd2',cellclassname: 'blueClass' , cellsalign: 'right', align: 'right',editable:false},
						
							
							{ text: 'Proc Qty', datafield: 'proqty',editable:true, width: '8%',cellclassname: cellclassname, cellsformat: 'd2'  , cellsalign: 'right', align: 'right'},
							
							
							
				
						
							
						/* 	{ text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname  },
							{ text: 'Margin', datafield: 'margin', width: '4%',editable:false,cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',hidden:true },
							{ text: 'Net Total', datafield: 'netotal', width: '8%', cellsformat: 'd2', cellsalign: 'right',hidden:true, align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
							
							 */
							
							
							
							
							
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname ,hidden:true  },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname ,hidden:true },
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'rowno', datafield: 'rowno', width: '10%',cellclassname: cellclassname ,hidden:true},
							{text: 'brhid', datafield: 'brhid', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'locid', datafield: 'locid', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'Old Bal Qty', datafield: 'oldbalqty',editable:false, width: '5%',hidden:true},
							/* { text: 'Invoiced', datafield: 'invoiced', columntype: 'checkbox', editable: true, checked: true, width: '5%',cellsalign: 'center', align: 'center' }, */
						]
            });
            
/*             $('#procurementSubGrid').on('cellbeginedit', function (event) {
                
            	var columnindex1=event.args.columnindex;
            	 var datafield=event.args.datafield;
            	 $('#datas').val("0");
            	  if(datafield == "productid")
            		  { 
            		 
                	 productSearchContent('productSearch.jsp?cldocno='+cldocno+'&estdate='+estdate);
                	 var rowindextemp = event.args.rowindex;
            	    document.getElementById("rowindex").value = rowindextemp;  
            	    
           var temp= $('#procurementSubGrid').jqxGrid('getcellvalue', rowindextemp, "productid"); 
           


           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
           { 
          	 $('#gridtext').val("");  
          	 $('#part_no').val("");  
           }
           else
          	 {
          	 
          	 $('#part_no').val($('#procurementSubGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
               $('#gridtext').val($('#procurementSubGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
              $('#procurementSubGrid').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#procurementSubGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));

               
          	 }
            
               
            		  } 
            	  
            	  
            	  if(datafield == "brandname")
        		  { 
            		 
            		  productSearchContent('productSearch.jsp?cldocno='+cldocno+'&estdate='+estdate);
            	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        	    
        	      var temp= $('#procurementSubGrid').jqxGrid('getcellvalue', rowindextemp, "brandname"); 
                
        	      
                // alert(temp);
                 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
        		   { 
              	   $('#gridtext1').val(""); 
              	   $('#brandname').val("");  
        		   }
                 else
                	 {
        	    

              	   $('#brandname').val($('#procurementSubGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
              	   $('#gridtext1').val($('#procurementSubGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
                     
                     $('#procurementSubGrid').jqxGrid('setcellvalue', rowindextemp, "brandname" ,$('#procurementSubGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));

                     
                	 }
                  

         
        		  
            }	 
                   
                   }); */
            $("#procurementSubGrid").on('cellvaluechanged', function (event) 
                    {
            	
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    /* var discount=0;
    		    var margin=0;  
    		    var total=0;
    		    var qty=0;
    		    var amount=0;
    		    var nettotal=0; */
/*       		 
     var resqty= parseFloat($('#procurementSubGrid').jqxGrid('getcelltext', rowBoundIndex, "resqty")); 
     var stkqty= parseFloat($('#procurementSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "stkqty"));
     var opnqty= parseFloat($('#procurementSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty"));
     var remqty= parseFloat($('#procurementSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "oldbalqty"));
     var purqty= parseFloat($('#procurementSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "purqty"));
     var purorder= parseFloat($('#procurementSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "purorder"));
     var amount= parseFloat($('#procurementSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount"));
     var margin= parseFloat($('#procurementSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "margin"));
    var resq=0;
    var purq=0;
    if(datafield == "resqty")
	  { 
    if(stkqty>remqty)
	{
	resq=remqty;
	}
else if(remqty>stkqty)
	{
	resq=stkqty;
	}
     if(resqty>stkqty || resqty>remqty)
	{
    	 purq=remqty-resq;
    	 $.messager.alert('Message', 'Reserve Quantity Should Be Less Than Or Equal To Remaining Quantity');
  	 //  alert("Reserve Quantity Should Be Less Than Stock Quantity");
  	 $("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "resqty", resq);
  //	 $("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "purqty", purq);
	}
     else
    	 {
    	 $("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "resqty", resqty);
      //	 $("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "purqty", remqty-resqty);
      	 var bal=opnqty-(parseFloat($('#procurementSubGrid').jqxGrid('getcelltext', rowBoundIndex, "resqty"))+parseFloat($('#procurementSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "purqty"))+parseFloat($('#procurementSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "purorder")));
     	 var total=bal*amount;
     	 var net=total+margin;
     	$("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "remqty", bal);
     	$("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "total", total);
     	$("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "netotal", net);
      	
    	 }
      
         
      		  }  */
/*     if(datafield == "purqty")
	  { 
    	
    	if(purqty>remqty)
    		{
    		 purq=remqty-resqty;
    	  	 $.messager.alert('Message', 'Purchase Quantity Should Be Less Than Or Equal To Remaining Quantity');
    		 $("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "purqty", purq);
    		}
    	 var bal=opnqty-(parseFloat($('#procurementSubGrid').jqxGrid('getcelltext', rowBoundIndex, "resqty"))+parseFloat($('#procurementSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "purqty"))+parseFloat($('#procurementSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "purorder")));
     	 var total=bal*amount;
     	 var net=total+margin;
     	$("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "remqty", bal);
     	$("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "total", total);
     	$("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "netotal", net);
 
    		  }  */
    
    if(datafield == "proqty")
	  { 
  	
    	 
    	
    	 var remqty=$('#procurementSubGrid').jqxGrid('getcelltext', rowBoundIndex, "remqty");
    	 var proqty=$('#procurementSubGrid').jqxGrid('getcelltext', rowBoundIndex, "proqty");
    	
    	
   
  	  if(parseFloat(proqty.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1"))>parseFloat(remqty.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1")))
  		{
  		 
  	  	 $.messager.alert('Message', 'Procurement Quantity Should Be Less Than Or Equal To Balance Quantity');
  		 $("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "proqty", remqty);
  		//proqty=remqty;
  		}  
/*   	 var bal=proqty;
  		var amount=$('#procurementSubGrid').jqxGrid('getcelltext', rowBoundIndex, "amount");
  		
  		 
  		
   	 var total=parseFloat(bal.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1"))*parseFloat(amount.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1"));
   	  */
 
    
/*      	$("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "remqty", bal); */
   	//  $("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "total", total);
   //	$("#procurementSubGrid").jqxGrid('setcellvalue', rowBoundIndex, "netotal", net);

  		  } 
   
    
                    });
            
/* 
            $('#procurementSubGrid').on('celldoubleclick', function (event) {
           	 
           	
            	var columnindex1=event.args.datafield;
            	
                	  if(columnindex1 == "amount" && document.getElementById("puchasechk").value == 1)
                		  { 
                		 
                	 var rowindextemp = event.args.rowindex;
                	 
                	var psrno= $('#procurementSubGrid').jqxGrid('getcellvalue', rowindextemp, "psrno");
                	
                	if(parseInt(psrno)>0)
                		{
                	   document.getElementById("rowindex").value = rowindextemp;  
                 	  $('#procurementSubGrid').jqxGrid('clearselection');
                 	 priceSearchContent('purchasepriceSearch.jsp?rowindex='+document.getElementById("rowindex").value+"&psrno="+psrno);
                		}
                	 
                	 
                	
                		   } 
                	 
                	 
                	
                	  
                    }); */
               
            

        });
function chklastpurchase()
{
	
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200)
    {
      var items= x.responseText.trim();
     
      if(parseInt(items)>0)
       {
    	
    	   document.getElementById("puchasechk").value=1;
    	  
    	  
        }
          else
      {
        	   document.getElementById("puchasechk").value=0; 
      }
      
       }}
   x.open("GET","checklastpurchase.jsp?",true);
	x.send();
 
      
        
	
} 
</script>

<div id="procurementSubGrid"></div>
<input type="hidden" id="rowindex">
  <!-- 
 <div id='jqxWidget'>
 
    <div id="popupWindow">
 
 <div id='Menu1'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
 -->
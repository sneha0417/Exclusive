  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%@page import="com.finance.nipurchase.nipurchasereturn.*" %>
 
<%

ClsnipurchaseReturnDAO viewDAO=new ClsnipurchaseReturnDAO();

%>
<%
String nipurdoc=request.getParameter("nipurdoc")==null?"0":request.getParameter("nipurdoc").trim();
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();


System.out.println("====sqlsss==docno=="+docno);

%>


<script type="text/javascript">
var descdatas;

var temp='<%=nipurdoc%>';
var temp1='<%=docno%>';
 
if(temp>0)
{
 
	descdatas='<%=viewDAO.reloadnipurchasemaster(session,nipurdoc)%>';  

}

else if(temp1>0)
{
 
	descdatas='<%=viewDAO.reloadnipurchase(session,docno)%>';  

}
else
 
{   
 
  
     descdatas;
   
}
        $(document).ready(function () { 	
       
            
        	  var rendererstring1=function (aggregates){
               	var value=aggregates['sum1'];
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
               }
         var rendererstring=function (aggregates){
         	var value=aggregates['sum'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">'  + value + '</div>';
         }
               
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [//srno, description, unitprice, qty, total, discount, nettotal, nuprice, acno, costtype, costcode, remarks, account, description, atype, CostGroup
     						
							    {name : 'type', type: 'string'  },
								{name : 'account', type: 'number'    },
								{name : 'accname', type: 'string'    },
								{name : 'description', type: 'string'    },
								{name : 'qty', type: 'number'    },
								{name : 'unitprice', type: 'number'    },
								{name : 'total', type: 'number'    },
								{name : 'discount', type: 'number'    },
								{name : 'nettotal', type: 'number'    },
								{name : 'costtype', type: 'string'    },
								{name : 'costgroup', type: 'string'    },
								
								{name : 'costcode', type: 'nember'    },
								{name : 'nuprice', type: 'number'    },
								{name : 'remarks', type: 'string'    },
								
								
								{name : 'headdoc', type: 'number'    },
								{name : 'qutval', type: 'number'    },
								{name : 'grtype', type: 'number'    },
								
								{name : 'refrow', type: 'number'    },
								
								
	        					 {name : 'taxper', type: 'number'  },  
	        					 {name : 'taxamount', type: 'number'  },
	        					{name : 'taxperamt', type: 'number'  },
								
								
                 ],              
              
                 localdata: descdatas,
                
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

            
            
            $("#nidescdetailsGrid").jqxGrid(
            {
            	 width: '100%',
                 height: 302,
                 source: dataAdapter,
                 showaggregates:true,
                 showstatusbar:true,
                 editable: true,
                 disabled:true,
                 statusbarheight: 25,
                 selectionmode: 'singlecell',
           
                
                 
                 handlekeyboardnavigation: function (event) {
                	
                	
/*                   var rows = $('#nidescdetailsGrid').jqxGrid('getrows');
                     var rowlength= rows.length;
                       var cell1 = $('#nidescdetailsGrid').jqxGrid('getselectedcell');
                       
                     
                       if (cell1 != undefined && cell1.datafield == 'unitprice' && cell1.rowindex == rowlength - 1) {
                           var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                           if (key ==9) {   
                        	   
                                $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
                               rowlength++;                           
                           }
                       }
                       
                       
                  
                       
                       
                       var cell2 = $('#nidescdetailsGrid').jqxGrid('getselectedcell');
                       if (cell2 != undefined && cell2.datafield == 'costgroup') {
                       	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        document.getElementById("rowindex").value =cell2.rowindex;
                       	var value = $('#nidescdetailsGrid').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
            	            if(value==4 || value==5){
                       	if (key == 114) { 
                       		costSearchContent('costtypegridsearch.jsp');
                           	 $('#nidescdetailsGrid').jqxGrid('render');
                	           }
                             }
                       	}
                       
                       
                        */
                       
                       /* 
                                          if(args.datafield=="costgroup")
                        	{
                        	
                        	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                            if (key == 114) {  
                            	
                            	 costSearchContent('costtypegridsearch.jsp');
                            	 $('#nidescdetailsGrid').jqxGrid('render');
                            }
                        	} */
                        	
                        	
                        	
         /*                	 var cell3 = $('#nidescdetailsGrid').jqxGrid('getselectedcell');
                            if (cell3 != undefined && cell3.datafield == 'costcode') {
                            	 document.getElementById("rowindex").value =cell3.rowindex;
            	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
            	                   var value1 = $('#nidescdetailsGrid').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
        	        	           if(value1==4 || value1==5){
            	                   if (key == 114) {   
            	                	   var value=  $('#nidescdetailsGrid').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
            	              
                                	     var aa="nidescdetailsGrid";
            	                       costcodeSearchContent('../../../../com/costcenter/costCodeSearchGrid.jsp?costtype='+value+'&formname='+aa);
            	                	   $('#nidescdetailsGrid').jqxGrid('render');
            	        	           }
            	                   }
            	               }
                        	
                        	 */
                        	
                        	
                 /*        if(args.datafield=="costcode")
                    	{
               
                     
                           var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                           if (key == 114) {   
                        	   var value=  document.getElementById("costgropename").value;
                        	   costcodeSearchContent('costcodegridsearch.jsp?costtype='+value);
                        	   $('#nidescdetailsGrid').jqxGrid('render');
                           }
                       }
                      */
/*                       var cell4 = $('#nidescdetailsGrid').jqxGrid('getselectedcell');
                      if (cell4 != undefined && cell4.datafield == 'account') {
      	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
      	                 
      	                   if (key == 114) {   
      	                	
      	                	 document.getElementById("rowindex1").value =cell4.rowindex;
      	                	   var valuess=  $('#nidescdetailsGrid').jqxGrid('getcellvalue', cell4.rowindex, "type");
      	              
      	                     CashSearchContent('accountGridSearch.jsp?atype='+valuess);
      	                	   $('#nidescdetailsGrid').jqxGrid('render');
      	        	           }
      	                   }
                      var cell5 = $('#nidescdetailsGrid').jqxGrid('getselectedcell');
                      if (cell5 != undefined && cell5.datafield == 'description') {
      	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
      	                 
      	                   if (key == 114) {   
      	                	
      	                	 document.getElementById("rowindex1").value =cell5.rowindex;
      	                   var value = document.getElementById("ordermasterdoc_no").value;
      	                // alert(""+value);
      	                  if(parseInt(value)>0)
      	      			     {	
      	                 nipurhsaeslnocontent('nislnosearch.jsp?niorder='+value);
      	      			       }
      	                	   $('#nidescdetailsGrid').jqxGrid('render');
      	        	           }
      	                   }
      	             
                   	 */
               
                       },
                    
           
                
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '2%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
                           
				
							{ text: 'Description', datafield: 'description', width: '13%' ,editable: true},
							{ text: 'Qty', datafield: 'qty', cellsformat: 'd2', width: '3%', cellsalign: 'left', align:'left',editable: true},
							{ text: 'Unit Price', datafield: 'unitprice', width: '6%',cellsalign: 'right', align:'right',cellsformat:'d2',editable: true },
							{ text: 'Total', datafield: 'total', width: '6%',cellsformat:'d2',cellsalign: 'right', align:'right', editable:false},
							{ text: 'Discount', datafield: 'discount', width: '6%',cellsalign: 'right', align:'right',cellsformat:'d2',editable: true ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							{ text: 'Net Total', datafield: 'nettotal', width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable:false},
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,editable:true},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right'  ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Net Total', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							{ text: 'Type', datafield: 'type', width: '4%', cellsalign: 'left',align: 'left' ,editable: false
	     					    },
							{ text: 'Account', datafield: 'account', width: '4%' ,editable: false,cellsalign: 'center', align:'center'},
							{ text: 'Account Name', datafield: 'accname', width: '12%' ,editable: false},
							{ text: 'Cost Type', datafield: 'costgroup', width: '8%',editable: false },
							{ text: 'Cost Code', datafield: 'costcode', width: '6%',editable: false },
							{ text: 'Remarks', datafield: 'remarks', width: '20%' ,editable: true},
							{ text: 'Qutval', datafield: 'qutval', width: '20%',editable: true,hidden:true},
							{ text: 'nuprice', datafield: 'nuprice', width: '9%',cellsformat:'d2',hidden:true,editable: true},
							{ text: 'Head doc', datafield: 'headdoc', width: '20%',hidden:true,editable: true},     /* for account name, acccount from my head then save this number in table */
							{ text: 'Cost id', datafield: 'costtype', width: '8%',hidden:true ,editable: true},
							{ text: 'grtype', datafield: 'grtype', width: '20%',editable: true,hidden:true},  /* this for grrtype=4 and 5 then take cost code and costtype  */
							
							{ text: 'refrow', datafield: 'refrow', width: '20%',editable: true,hidden:true },
	              ]
            });
            
            
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#nidescdetailsGrid").jqxGrid({ disabled: false}); 
    		}
            
           
            $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
            
            
           
            if(temp>0)
            {  
  		  
		    
 			     document.getElementById("roundof").value="";
	 
 		    var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
             document.getElementById("nettotal").value=summaryData.sum.replace(/,/g,'');
             
 		    var summaryData1= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
             var aa=summaryData1.sum.replace(/,/g,'');;
             funRoundAmt(aa,"nettotalval");
          
            }
            
        
            $("#compopupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#comMenu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#nidescdetailsGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#comMenu2").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#nidescdetailsGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#nidescdetailsGrid").offset();
                       $("#compopupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#nidescdetailsGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#compopupWindow2").jqxWindow('show');
                   }
                   else {
                	    var val=1;   
                        var rowid = $("#nidescdetailsGrid").jqxGrid('getrowid', rowindex);     
    					if($('#mode').val()=="A"){   
    						var commit = $("#nidescdetailsGrid").jqxGrid('deleterow', rowid);
    						valchange(0);      
    					}                   
                   }
               });  $("#nidescdetailsGrid").on('rowclick', function (event) {
                    if (event.args.rightclick) {
        		
                       $("#nidescdetailsGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                  
        		   } 
               });   
          $("#nidescdetailsGrid").on('cellclick', function (event) 
            		{
        
        	   var rowindextemp2 = event.args.rowindex;
               document.getElementById("rowindex").value = rowindextemp2;
               document.getElementById("rowindex1").value = rowindextemp2;
        /*        alert(event.args.datafield); */
               
               if(event.args.datafield=="account")
            	   {
            	
               $("#nidescdetailsGrid").jqxGrid('clearselection');
            	   }
               if(event.args.datafield=="costgroup")
        	   {
        	
               $("#nidescdetailsGrid").jqxGrid('clearselection');
        	   } 
               if(event.args.datafield=="costcode")
        	   {
        	
               $("#nidescdetailsGrid").jqxGrid('clearselection');
        	   } 
               
           
               
                    }); 
        
          
            $('#nidescdetailsGrid').on('celldoubleclick', function (event) {
            	
            	  var refno=document.getElementById("ordermasterdoc_no").value;

 			/* if(event.args.datafield=="description"&&(refno==""||parseInt(refno)<=0))
          	   {
          		 var rowindextemp = event.args.rowindex;
                 document.getElementById("prdsetrowno").value = rowindextemp;
          		getproductdetails();
          	   } */
            	 // alert(""+refno);
               /*    if(parseInt(refno)>0)
      			     {	
            	  if(event.args.datafield=="description")
            	   {
          
                   var rowindextemp = event.args.rowindex;
                   document.getElementById("rowindex1").value = rowindextemp;
                  
                $('#nidescdetailsGrid').jqxGrid('clearselection'); 
                 
                      var values = document.getElementById("ordermasterdoc_no").value;
             
                      nipurhsaeslnocontent('nislnosearch.jsp?niorder='+values);
                          } 
            	  
            	  
      			     } */
            	
          /*       if(event.args.datafield=="account")
         	   {
         	
                var rowindextemp = event.args.rowindex;
                document.getElementById("rowindex1").value = rowindextemp;
               
                $('#nidescdetailsGrid').jqxGrid('clearselection');
                   var value = $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowindextemp, "type");
                         CashSearchContent('accountGridSearch.jsp?atype='+value);
                       } 
                if(event.args.datafield=="costgroup")
         	   {
               var rowindextemp1 = event.args.rowindex;
               document.getElementById("rowindex").value = rowindextemp1;
               $('#nidescdetailsGrid').jqxGrid('clearselection');
               var value = $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowindextemp1, "grtype"); 
               if(value==4 || value==5){
                        costSearchContent('costtypegridsearch.jsp?');
                    }
                        
                      } 
                if(event.args.datafield=="costcode")
         	   {
         	
               var rowindextemp2 = event.args.rowindex;
               document.getElementById("rowindex").value = rowindextemp2;
               $('#nidescdetailsGrid').jqxGrid('clearselection');
               
               var value = $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowindextemp2, "grtype"); 
               if(value==4 || value==5){
               
                  var values = $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowindextemp2, "costtype");
                  var aa="nidescdetailsGrid";
                  costcodeSearchContent('../../../../com/costcenter/costCodeSearchGrid.jsp?costtype='+values+'&formname='+aa);
                  
                           }
                      } 
                 
                 */
                
                 });
            	
            function valchange(rowBoundIndex)
            {
                var qutval=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qutval");	
   	            var qty;
               	 
               var quty=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
               var refno=document.getElementById("refno").value;
               
               if(parseInt(refno)>0)
   			     {
            	if(quty>qutval)
            		{
            
            		document.getElementById("errormsg").innerText=" Qty value not more than Actual Qty  ";
            		qty=qutval;
            	 $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",qutval);
            	 
            	    }
		            	else
		        		{
		        		//document.getElementById("errormsg").innerText="";
		        		 qty= $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
		        		}
            	 
            		}
               
		               else
		       		{
		       		//document.getElementById("errormsg").innerText="";
		       		 qty= $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
		       		}
            	
            	var unitprice=	$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");	
            	var total=parseFloat(qty)*parseFloat(unitprice);
           
    		    $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
    		    
    		   var gtotal= $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
				  
    	   		var discount=	$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");	
    	        		    
    	        		
    	   		var nettotal=parseFloat(gtotal)-parseFloat(discount);
    	   		if(discount==""||discount==null||discount=="undefiend")
    	   			{
    	   		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
    	   			}
    	   		else{
    	   			$('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
    	   		}
    	        		    
    	   	 			document.getElementById("roundof").value="";
    	   		 
    	        		    var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
    	                    //alert("ssssss"+summaryData.sum);
    	                    document.getElementById("nettotal").value=summaryData.sum;
    	                    
    	        		    var summaryData1= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
    	                    //alert("ssssss"+summaryData.sum);
    	                    var aa=summaryData1.sum.replace(/,/g,'');
    	                    funRoundAmt(aa,"nettotalval");
    	                 
    	                    
    	                     	 $('#nettotalval').attr('readonly', true);
    	                    
    	                    var nettotalval=  $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal");
    	                    var nuprice=parseFloat(nettotalval)/parseFloat(qty);
    	                   // alert("nuprice"+nuprice);
    	                       $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nuprice",nuprice);
            }

            $("#nidescdetailsGrid").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;    
    		    
    		    if(datafield=="type")
    		    {
    		        		    	document.getElementById("acctypegrid").value=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "type");
    		    	
    		    }
    		    if(datafield=="costtype")
    		    {
    		    	//alert("");
    		    	document.getElementById("costgropename").value=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "costtype");
    		    	
    		    }
    		    
    		    
    		     
            		if(datafield=="qty")
            		    {
            
            			valchange(rowBoundIndex);
            		    }
            		if(datafield=="unitprice")
        		    {
            			
            			valchange(rowBoundIndex);
        		    }
            		if(datafield=="discount")
        		    {
            			//$('#nidescdetailsGrid').jqxGrid('selectcell', rowBoundIndex, 'costgroup');
            			valchange(rowBoundIndex);
   				
        		    }
            		
            		if(datafield=="type")
        		    {
            			
            			
            	         $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "account","");
            	         $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "accname","");
            			
            			
            			
        		    }	
            		
            		  if(datafield=="taxper")
            		  {
            				var netotal=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
                    		
                    		
                  
                    		  var taxper= $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper"); 
                    		  if(parseFloat(taxper)>0)
                  			{ 
                    			  
                    			  
                    		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
                    		  
                    		  
                    		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
                    		  
                    		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
                    		  
                    		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
                  			}
                    		  
                    		  else
                    			  {
                    			  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
                    			  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",netotal);
                    			  }
                    		  
                    		  
                    		  
                    		    
          	   	 			     document.getElementById("roundof").value="";
          	   		 
          	        		    var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
          	                    //alert("ssssss"+summaryData.sum);
          	                    document.getElementById("nettotal").value=summaryData.sum;
          	                    
          	        		    var summaryData1= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
          	                    //alert("ssssss"+summaryData.sum);
          	                    var aa=summaryData1.sum.replace(/,/g,'');;
          	                    funRoundAmt(aa,"nettotalval");
          	                 
                    		  
            		  }
            		
            		
            		
            		
            	   	  if(datafield=="nettotal")
            		  {
            		var netotal=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
            		
            		 
            		var taxpers=document.getElementById("taxpers").value; 
            		if(parseFloat(taxpers)>0)
            			{
            			$('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxper",taxpers); 
        		 		 var taxper= taxpers; 
            		  
            		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
            		  
            		  
            		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
            		  
            		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
            		  
            		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
            			
            			}
            		else
            			{
            			 $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
              		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",netotal);
            			}
            		
    
            		  
            	    
	   	 				document.getElementById("roundof").value="";
	        		    var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
	                    document.getElementById("nettotal").value=summaryData.sum;
	        		    var summaryData1= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
	                    var aa=summaryData1.sum.replace(/,/g,'');;
	                    funRoundAmt(aa,"nettotalval");
	                 
            		 
            		  }
            		
            		 
            		});

            $("#nidescdetailsGrid").on('cellclick', function (event) 
            {
        		document.getElementById("errormsg").innerText="";
            		 
            		});
        });
        

        function funinterstate()
		{
			
		   var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
			       var items= x.responseText.trim();
			       
			       var item = items.split('::');
					var itemval1  = item[0];
					var itemval2 = item[1];
			    
			       if(parseInt(itemval1)>0){
			    	   
			    	   $('#txtproducttype').show();
			    	   $('#billtype').show();
			    	      $('#nidescdetailsGrid').jqxGrid('showcolumn', 'taxper');
		            	  $('#nidescdetailsGrid').jqxGrid('showcolumn', 'taxamount');
		            	  $('#nidescdetailsGrid').jqxGrid('showcolumn', 'taxperamt');
		            	//  $('#nidescdetailsGrid').jqxGrid('hidecolumn', 'nettotal');
		            	  if($('#mode').val()=='E' || ($('#mode').val()=='A' && $('#nireftype').val()=="NPO"))
		            		  {
		            		  
		                  	if(parseInt(itemval2)>0)
		            		{
		                  		
		                  		
		                  		document.getElementById("validates").value=1;
		                  		
		   				 $('#txtproducttype').attr('readonly', true);
		   				 
		   				 
		   				 $('#txtproducttype').attr('disabled', false);
		            		
		            		}
		            	
		            	else
		            		{
		            		document.getElementById("validates").value=0;
		            		 $('#txtproducttype').attr('readonly', true);
			   				 
			   				 
			   				 $('#txtproducttype').attr('disabled', true);
		            		}
		            		  
		            		  }
		            	  
		            						
						
			       }
					else{
						   
						 $('#txtproducttype').hide();
				    	   $('#billtype').hide();
				    	   
				    	   
				    	   $('#nidescdetailsGrid').jqxGrid('hidecolumn', 'taxper');
			            	  $('#nidescdetailsGrid').jqxGrid('hidecolumn', 'taxamount');
			            	  $('#nidescdetailsGrid').jqxGrid('hidecolumn', 'taxperamt');
			            	  
			           //	  $('#nidescdetailsGrid').jqxGrid('showcolumn', 'nettotal');
				    	   
						
					}
					}
				else{
					
				}
				}
		x.open("GET","interstate.jsp?docnos="+document.getElementById("accdocno").value,true);
		x.send();
		}
    </script>
     <div id='jqxWidget'> 
	  <div id="nidescdetailsGrid"></div> 
	    <div id="compopupWindow2">
	      <div id='comMenu2'>      
	        <ul>
	            <li>Delete Selected Row</li>
	        </ul>
	       </div>
	    </div>
      </div>
   <input type="hidden" id="rowindex"/> 
   <input type="hidden" id="rowindex1"/> 
   <input type="hidden" id="prdsetrowno"/>   
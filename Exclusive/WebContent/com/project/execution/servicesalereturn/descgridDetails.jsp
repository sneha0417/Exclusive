  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%@page import="com.project.execution.servicesalereturn.*" %>



	
<%

ClsServiceSaleReturnDAO viewDAO=new ClsServiceSaleReturnDAO();
%>

<%
 
String docno=request.getParameter("nipurdoc")==null?"0":request.getParameter("nipurdoc").trim();
String maindoc=request.getParameter("maindoc")==null?"0":request.getParameter("maindoc").trim();
String rdocno=request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").trim();

%>
<script type="text/javascript">
var descdatas;

 
var tempdocno='<%=docno%>';
var maindoc='<%=maindoc%>';
if(maindoc>0){
	descdatas='<%=viewDAO.reloaddata(maindoc,rdocno)%>';  
}
else if(tempdocno>0){
	descdatas='<%=viewDAO.reloddata(session,docno)%>';  
}
else
 
{   
 
  
     descdatas=[];
    var list =['GL','HR'];
}
//alert(descdatas);

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
								{name : 'account', type: 'string'    },
								{name : 'accname', type: 'string'    },
								{name : 'description', type: 'string'    },
								{name : 'qty', type: 'int'    },
								{name : 'unitprice', type: 'number'    },
								{name : 'total', type: 'number'    },
								{name : 'discount', type: 'number'    },
								{name : 'nettotal', type: 'number'    },
								{name : 'costtype', type: 'string'    },
								{name : 'costgroup', type: 'string'    },
								
								{name : 'costcode', type: 'number'    },
								{name : 'nuprice', type: 'number'    },
								{name : 'remarks', type: 'string'    },
								
								
								{name : 'headdoc', type: 'number'    },
								{name : 'qutval', type: 'number'    },
								{name : 'grtype', type: 'number'    },
								 {name : 'taxper', type: 'number'  },  
	        					 {name : 'taxamount', type: 'number'  },
	        					{name : 'taxperamt', type: 'number'  },
	        					{name : 'rdocno', type: 'number'  },
	        					
	        					
	        					{name : 'valamount', type: 'number'  },
	        					
	        					
	        					
	        					
	        					
	        					
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
           
                
                 
            /*      handlekeyboardnavigation: function (event) {
                	
                	
                  var rows = $('#nidescdetailsGrid').jqxGrid('getrows');
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
                       
                       
                       
                       
            
                        	
                        	
                        	 var cell3 = $('#nidescdetailsGrid').jqxGrid('getselectedcell');
                            if (cell3 != undefined && cell3.datafield == 'costcode') {
                            	 document.getElementById("rowindex").value =cell3.rowindex;
            	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
            	                   var value1 = $('#nidescdetailsGrid').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
        	        	           if(value1==4 || value1==5){
            	                   if (key == 114) {   
            	                	   var value=  $('#nidescdetailsGrid').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
            	              
                                	   costcodeSearchContent('costcodegridsearch.jsp?costtype='+value);
            	                	   $('#nidescdetailsGrid').jqxGrid('render');
            	        	           }
            	                   }
            	               }
                        	
                        	
                        	
      
                      var cell4 = $('#nidescdetailsGrid').jqxGrid('getselectedcell');
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
      	             
                   	
               
                       },
                     */
           
                
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '2%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
                           
				
							{ text: 'Description', datafield: 'description', width: '13%' ,editable: true},
							{ text: 'Qty', datafield: 'qty', width: '3%', cellsalign: 'left', align:'left',editable: true},
							{ text: 'Unit Price', datafield: 'unitprice', width: '5%',cellsalign: 'right', align:'right',cellsformat:'d2',editable: true },
							{ text: 'Total', datafield: 'total', width: '5%',cellsformat:'d2',cellsalign: 'right', align:'right', editable:false},
							{ text: 'Discount', datafield: 'discount', width: '4%',cellsalign: 'right', align:'right',cellsformat:'d2',editable: true ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							{ text: 'Net Total', datafield: 'nettotal', width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable:false},
							
							
							{ text: 'Tax %', datafield: 'taxper', width: '3%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,editable: true},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '6%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right'  ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Total Amount', datafield: 'taxamount', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							
							{ text: 'Type', datafield: 'type', width: '4%', cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
	                                editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
	                            }
	     					    },
	     					   
	     						{ text: 'rdocno', datafield: 'rdocno', width: '4%' ,editable: false,cellsalign: 'center', align:'center',hidden:true},
	     						
	     						
	     						{ text: 'valamount', datafield: 'valamount', width: '4%' ,editable: false, cellsformat: 'd2', cellsalign: 'right', align: 'right',hidden:true},
	     						
	     						
	     						
	     					    
							{ text: 'Account', datafield: 'account', width: '4%' ,editable: false,cellsalign: 'center', align:'center'},
							{ text: 'Account Name', datafield: 'accname', width: '12%' ,editable: false},
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false },
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false },
							{ text: 'Remarks', datafield: 'remarks', width: '19%' ,editable: true},
							{ text: 'Qutval', datafield: 'qutval', width: '20%',editable: true,hidden:true},
							{ text: 'nuprice', datafield: 'nuprice', width: '9%',cellsformat:'d2',hidden:true,editable: true},
							{ text: 'Head doc', datafield: 'headdoc', width: '20%',hidden:true,editable: true},     /* for account name, acccount from my head then save this number in table */
							{ text: 'Cost id', datafield: 'costtype', width: '8%',hidden:true ,editable: true},
							{ text: 'grtype', datafield: 'grtype', width: '20%',editable: true,hidden:true},  /* this for grrtype=4 and 5 then take cost code and costtype  */
							
							
	              ]
            });
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#nidescdetailsGrid").jqxGrid({ disabled: false}); 
    		}
            
           
     
           
        
            
/*           $("#nidescdetailsGrid").on('cellclick', function (event) 
            		{
        
        	   var rowindextemp2 = event.args.rowindex;
               document.getElementById("rowindex").value = rowindextemp2;
               document.getElementById("rowindex1").value = rowindextemp2;
   
               
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
               
           
               
                    });   */
        
          
/*             $('#nidescdetailsGrid').on('celldoubleclick', function (event) {
            	
            	//   var refno=document.getElementById("ordermasterdoc_no").value;
            	 // alert(""+refno);
                if(parseInt(refno)>0)
      			     {	
            	  if(event.args.datafield=="description")
            	   {
          
                   var rowindextemp = event.args.rowindex;
                   document.getElementById("rowindex1").value = rowindextemp;
                  
                $('#nidescdetailsGrid').jqxGrid('clearselection'); 
                 
                      var values = document.getElementById("ordermasterdoc_no").value;
             
                      nipurhsaeslnocontent('nislnosearch.jsp?niorder='+values);
                          } 
            	  
            	  
      			     }  
            	
                if(event.args.datafield=="account")
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
                  
                  costcodeSearchContent('costcodegridsearch.jsp?costtype='+values);
                  
                           }
                      } 
                 
                
                
                 }); */
            	
            function valchange(rowBoundIndex)
            {
                var qutval=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qutval");	
   	          
               	 
               var qty=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
               

               
               
               
               
               
               
 /*               var refno=document.getElementById("refno").value;
               
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
            	 */
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
    	        		    
    	        		    var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
    	                    //alert("ssssss"+summaryData.sum);
    	                    document.getElementById("nettotal").value=summaryData.sum;
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
            	/* 		var tper=$('#taxperc').val();
          	   		  	$('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxper",tper); */
        		    }
            		
           			if(datafield=="discount")
        		    {
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
		   				var tper=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper");
		           		if(parseFloat(tper)>0){
		            		  var taxempamount=parseFloat(netotal)*(parseFloat(tper)/100);
		            		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
		            		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
		            		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
		         		}else{
		           			  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
		           			  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",netotal);
		           		} 
		    		 }
					 if(datafield=="nettotal")
            		 {
						 
	            		var netotal=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
	            		var taxpers=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper");
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
    	        		
    	        		
    	                
    	                var valamount=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "valamount");
    	                
    	                var taxamount=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxamount");
    	                
    	                
    	                
    	              if(parseFloat(taxamount)>parseFloat(valamount))
    	             	 
    	             	 
    	             	 {
    	             	 
    	             	 document.getElementById("errormsg").innerText=" Total Amount value not more than Actual Amount  ";
    	             	 return 0;
    	             	 
    	             	 }
            		  }
            });

            $("#nidescdetailsGrid").on('cellclick', function (event) 
            {
        		document.getElementById("errormsg").innerText="";
            		 
            		});
            
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#nidescdetailsGrid").on('contextmenu', function () {
                   return false;
               });
               
            $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#nidescdetailsGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#nidescdetailsGrid").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#nidescdetailsGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#nidescdetailsGrid").jqxGrid('getrowid', rowindex);
                       $("#nidescdetailsGrid").jqxGrid('deleterow', rowid);
                       
                       
                   }
               });
               
               $("#nidescdetailsGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#nidescdetailsGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               });
        });
        
    </script>
    <div id="nidescdetailsGrid"></div>
    
    
    <div id='jqxWidget'>
 
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
    
   <input type="hidden" id="rowindex"/> 
      <input type="hidden" id="rowindex1"/> 

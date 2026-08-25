<%@page import="com.project.execution.quotationnew.ClsQuotationDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); %>
 <%
// String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 int surtrno =request.getParameter("surtrno")==null?0:Integer.parseInt(request.getParameter("surtrno").trim());
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString();
 String reviseno=request.getParameter("reviseno")==null?"0":request.getParameter("reviseno").trim().toString();
 String enqno=request.getParameter("enqno")==null?"0":request.getParameter("enqno").trim().toString();
 String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim().toString();
 %>      
    <script type="text/javascript">
    var servdata;
    var surtrno='<%=surtrno%>';   
    var docno='<%=docno%>';
    var trno='<%=trno%>';
    var enqno='<%=enqno%>';
     if(trno>0){
      	servdata = '<%=DAO.serviceRefGridLoad(session,trno,surtrno) %>';      
    }
    
    if(docno>0){
		
    	servdata = '<%=DAO.serviceGridLoad(session,docno,reviseno) %>';
    	     
  }
    if(surtrno==2 && enqno>0){
    	servdata = '<%=DAO.serviceEstLoad(session,enqno,dtype) %>';   
    
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
        	//chkproductconfig();
        	  $('#gridtext').keyup(function(){
     	

	     $("#newprosearchGrid").jqxGrid('clearfilters');
	
       $('#item').val($(this).val());
       var dataField = "item";
applyFilter(dataField,$(this).val());  
       
       
       
   }); 
          
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'site' , type: 'String' },
							{name : 'siteid' , type: 'String' }, 
                          	{name : 'stype' , type: 'String' },
                          	{name : 'stypeid' , type: 'String' },
                          	{name : 'scope', type: 'string'},
							{name : 'scopeid', type: 'string'},
                          	{name : 'unit' , type: 'String' },
                          	{name : 'unitid' , type: 'String' },
     						{name : 'item', type: 'String'  },
                          	{name : 'qty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'scopeamount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'desc1', type: 'String'  },
     						{name : 'revision_no', type: 'String'  },
     						{name : 'psrno', type: 'String'  },
     						{name : 'prdname', type: 'String'  },
     						{name : 'stdprice', type: 'number'    },
     						{name : 'lbrchg', type: 'number'},
							{name : 'scopestdcost', type: 'number'},
                          	],
                 localdata: servdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            $("#serviceGrid").on("bindingcomplete", function (event) {
    			
           	 var rowlength=$("#serviceGrid").jqxGrid('rows').records.length;
           	 if(surtrno==2 && enqno>0){
           	 if(rowlength>0){
           	    var summaryData3= $("#serviceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
	         	document.getElementById("txtgrtotal").value=summaryData3.sum.replace(/,/g,''); 
	         	
				var rows = $("#serviceGrid").jqxGrid('getrows');
		  		var qty=0,amount=0.00;
		  		for(var i=0 ; i < rows.length ; i++){
		  			var chkqty=rows[i].qty;
		  			var chkamount=rows[i].amount;
					if((typeof(chkqty) != "undefined" && typeof(chkqty) != "NaN" && chkqty != "") && (typeof(chkamount) != "undefined" && typeof(chkamount) != "NaN" && chkamount != "")){
						qty=parseFloat(qty)+parseFloat(chkqty);
						amount=parseFloat(amount)+parseFloat(chkamount);
					}
		  		}
		  		
		  		if(parseFloat(qty)>0 && parseFloat(amount)>0) {
					getNetTotalValue();
	  			}
    	     }
           	}
			
			if(parseInt($('#presalesscopeallowed').val())==1){
				$('#serviceGrid').jqxGrid('showcolumn', 'scope');
				$('#serviceGrid').jqxGrid('showcolumn', 'scopeamount');
			} else {
				$('#serviceGrid').jqxGrid('hidecolumn', 'scope');
				$('#serviceGrid').jqxGrid('hidecolumn', 'scopeamount');
			}
						
              }); 
            
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
                sortable: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:20,
             	editmode: 'selectedcell',
             	 selectionmode: 'singlecell',
                editable:true,
                sortable: false,
 
                handlekeyboardnavigation: function (event) {

                	var cell1 = $('#serviceGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'scope') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) { 
                        		document.getElementById("rowindex").value = cell1.rowindex;
                        		$('#serviceGrid').jqxGrid('render');
                        		scopeSearchContent('scopeSearchGrid.jsp?rowno='+cell1.rowindex);
                        }
                    }
                    
                    var cell4 = $('#serviceGrid').jqxGrid('getselectedcell');
                   
                    
                    if (cell4 != undefined && (cell4.datafield == 'item'   )) 
                    
                   {	 
                   
  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  	               
  	                  if (key == 9) { 
  	                	  
   	                	 if(cell4.datafield == 'item')
 	                		  {
 	                		var aa= $('#item').val();
 	                		  }
 	                	
 	                 
                    if(typeof(aa)=="undefined")
                    
                    	{
                    	 
                    	return 0;
                    	}
                    
  	               	 var rows = $("#newprosearchGrid").jqxGrid('getrows');
  	  		     	
  	                	   $('#serviceGrid').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	              	
  	              	  $('#datas1').val(0);
  	         
               
					$('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "prdname" ,rows[0].productname);
					$('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
					$('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "unitid" ,rows[0].unitdocno);
					$('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno);
					$('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "item" ,rows[0].productname);
					$('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "amount" ,rows[0].amount);
					$('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "stdprice" ,rows[0].stdprice);
					$('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "lbrchg" ,rows[0].lbrchg);
					$('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "scopeamount" ,rows[0].scopefprice);
					$('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "scopestdcost" ,rows[0].scopestdcost);
					$('#datas1').val(1);
  	        
  	       
					$('#sidesearchwndow').jqxWindow('close'); 
  	                	   
					var rows = $('#serviceGrid').jqxGrid('getrows');
					var rowlength= rows.length;
           
               if(rowindex1 == rowlength -1)
               	{  
            	
               $("#serviceGrid").jqxGrid('addrow', null, {});
               	} 
               $("#serviceGrid").jqxGrid('ensurerowvisible', rowlength);
  	        	            } 
  	                   
  	                if (key != 13) {   
            if (cell4 != undefined && cell4.datafield == 'item') {
       
       		 
       		   document.getElementById("gridtext").focus();
       		 
            }
           
              
  	                }
                   } 
       		 
            
                    },
	
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
					{ text: 'Scope', datafield: 'scope', width: '3%',editable: false },
					{ text: 'Item', datafield: 'item', width: '8%',cellclassname: cellclassname,columntype: 'custom',
                      	  
						    createeditor: function (row, cellvalue, editor, cellText, width, height) {
						     
						         editor.html('<input type="text" id="item" name="item" style="width:100%;height:99%;"   />' ); 
						   
						        
						    }, 
						 
						 
					},
					{ text: 'Unit', datafield: 'unit', width: '5%',editable:false  },
					{ text: 'Qty', datafield: 'qty', width: '5%' },
					{ text: 'Unitid', datafield: 'unitid', width: '10%',hidden:true},
					{ text: 'Amount',datafield:'amount',width:'10%',cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
					{ text: 'Scope Amount', datafield: 'scopeamount', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname },
					{ text: 'Total',datafield:'total',cellsformat: 'd2',editable:false, width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Description',datafield:'desc1'}, 
					{ text: 'revision_no', datafield: 'revision_no', width: '10%',hidden: true},
					{ text: 'psrno', datafield: 'psrno', width: '10%',hidden: true},
					{ text: 'prdname', datafield: 'prdname', width: '10%',hidden: true},
					{ text: 'Scope Id', datafield: 'scopeid', width: '10%',cellclassname: cellclassname, hidden: true}, 
					{ text: 'stdprice', datafield: 'stdprice', width: '10%',cellclassname: cellclassname,hidden: true},
					{ text: 'Labour Charge', datafield: 'lbrchg', width: '10%',cellclassname: cellclassname,hidden: true},
					{ text: 'Scope Standard Cost', datafield: 'scopestdcost', width: '10%',cellclassname: cellclassname,hidden: true},
					]
            });
            if($('#mode').val()=='view'){
       		 $("#serviceGrid").jqxGrid({ disabled: true});
       		
           }
            

            $('#serviceGrid').on('cellbeginedit', function (event) {
      
         $('#datas').val(0);
     	var columnindex1=event.args.datafield;

     	// alert("in "+columnindex1);
     	 
     	 
     	if(columnindex1 == "item")
 		  { 
     		  if(document.getElementById("errormsg").innerText!="")
        		 {
           		   
        		 return 0;
        		 }	
     		 					var rowindextemp = event.args.rowindex;
	  			 				var scopeid=$('#serviceGrid').jqxGrid('getcellvalue', rowindextemp, "scopeid");
  			 					var stypeid=$('#serviceGrid').jqxGrid('getcellvalue', rowindextemp, "stypeid");
             					productSearchContent('productSearch.jsp?id=1&scopeid='+scopeid+'&stypeid='+stypeid);
             					document.getElementById("rowindex").value = rowindextemp; 
 							    
 							      var temp= $('#serviceGrid').jqxGrid('getcellvalue', rowindextemp, "item"); 
 						        
 							      
 						       //  alert(temp);
 						         if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
 								   { 
 						      	   $('#gridtext').val(""); 
 						      	   $('#item').val("");  
 								   }
 						         else
 						        	 {
 							    
 						
 						      	   $('#item').val($('#serviceGrid').jqxGrid('getcellvalue', rowindextemp, "prdname"));
 						      	   
 						      	   $('#gridtext').val($('#serviceGrid').jqxGrid('getcellvalue', rowindextemp, "prdname"));
 						      	   
 						             
 						             $('#serviceGrid').jqxGrid('setcellvalue', rowindextemp, "item" ,$('#serviceGrid').jqxGrid('getcellvalue', rowindextemp, "prdname"));
 						
 						             
 						        	 }
 						         
 						        
 				               
 	    		}
  

            
            });

          
            
            
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
 		   if(datafield=="scope")
    	   {
    		   
    			scopeSearchContent('scopeSearchGrid.jsp?rowno='+rowBoundIndex);
     	    	document.getElementById("rowindex").value = rowBoundIndex;  
    	
    	   }
 		   	  if(datafield == "item")
    		  { 
 		   		  if(document.getElementById("productchk").value==1)
    					{
 		   			      var rowindextemp = event.args.rowindex;
     			   	      var scopeid=$('#serviceGrid').jqxGrid('getcellvalue', rowindextemp, "scopeid");
     			          var stypeid=$('#serviceGrid').jqxGrid('getcellvalue', rowindextemp, "stypeid");
     			          $('#txtgridservicetypeid').val(stypeid);$('#txtgridscopeid').val(scopeid);
				   	      productSearchContent('productMasterSearch.jsp?scopeid='+scopeid+'&stypeid='+stypeid);
     				   	 //productSearchContent('productMasterSearch.jsp');
  				  		}
 		   		  else{
        				
 		   			  }
    	 var rowindextemp = event.args.rowindex;
    	    document.getElementById("rowindex").value = rowindextemp;  
    	  
    		  } 
 		    			
            		});
            
            $("#serviceGrid").on('cellvaluechanged', function (event) 
                    {
            	
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    
    		    
    		    if(parseInt($('#datas').val())!=1) {
    	            
  	              if(datafield=="item") {
  	            $('#serviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "item" ,$('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "prdname"));
  	               $('#sidesearchwndow').jqxWindow('close');
  	             }
  	          
  	            
  	            }
    		  
    		    
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
               		
               		if(parseInt($('#presalesscopeallowed').val())==1){
		    			
		    			scopeamount=$('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "scopeamount");
		    			
		    		   if(!(scopeamount=="" || typeof(scopeamount)=="undefined" || typeof(scopeamount)=="NaN")) {
		    				total=(parseFloat(qty)*parseFloat(amount))+(parseFloat(qty)*parseFloat(scopeamount));
		           	   } else {
		    		    	total=parseFloat(qty)*parseFloat(amount);
				       }
            			
		    		} else {
               			
    		    		total=parseFloat(qty)*parseFloat(amount);
		    		}
             			$('#serviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
             			
             			if(parseFloat(qty)>0 && parseFloat(amount)>0) {
							getNetTotalValue();
    		  			}
    		  }
    		    
    		    if(datafield=="stypeid") {
    		    	var rows = $('#serviceGrid').jqxGrid('getrows');
	            	var rowlength= rows.length;
	            	var rowindex1 = rowlength - 1;
	          	    var typeId=$("#serviceGrid").jqxGrid('getcellvalue', rowindex1, "stypeid");
	          	    if(typeof(typeId) != "undefined"){
	                	$("#serviceGrid").jqxGrid('addrow', null, {});
	          	    }
    		    }
    			
		    	 var summaryData3= $("#serviceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
	         	document.getElementById("txtgrtotal").value=summaryData3.sum.replace(/,/g,''); 
		  		
            	
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
                       var summaryData3= $("#serviceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
       	         	document.getElementById("txtgrtotal").value=summaryData3.sum.replace(/,/g,''); 
       	         	var  disprc=parseFloat(document.getElementById('txtdisper').value);
       		  		var  disamt=parseFloat(document.getElementById('txtdisamt').value);
       		  		if(disprc!=0 && disamt!=0)
       		  			{
       		  			//fundisper();
       		  			getNetTotalValue();
       		  			}
       		  		else if(disprc!=0 && disamt==0)
       	  			{
       	  			//fundisper();
       	  			getNetTotalValue();
       	  			}
       		  		else if(disprc==0 && disamt!=0)
       	  			{
       	  			
       	  			//fundisamt();
					getNetTotalValue();
       	  			}
       		  		else{
       		  			//fundisper();
						getNetTotalValue();
       		  		} 
                   	

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




        var applyFilter = function (datafield,value) {
        	    if(parseInt($('#datas').val())!=1)
        		  {   
            var filtertype = 'stringfilter';
          
        		//  alert(datafield+"="+value);
          
            if (datafield == 'item') filtertype = 'stringfilter';
            var filtergroup = new $.jqx.filter();

                var filter_or_operator = 1;

                var filtervalue = value;
                var filtercondition = 'contains';
                
                var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
                filtergroup.addfilter(filter_or_operator, filter);
           
            
            if (datafield == 'item') 
            	{
           
            $("#newprosearchGrid").jqxGrid('addfilter', 'productname' , filtergroup);
         //   document.getElementById("part_no").focus();
            	}
           
            

            $("#newprosearchGrid").jqxGrid('applyfilters');
            
        		  }
            

        }

         
                
                
        function chkproductconfig()
        {
        	
           var x=new XMLHttpRequest();
           x.onreadystatechange=function(){
           if (x.readyState==4 && x.status==200)
            {
              var items= x.responseText.trim();
             
              if(parseInt(items)>0)
               {
            	
            	   document.getElementById("productchk").value=1;
            	 
            	     $('#serviceGrid').jqxGrid('setcolumnproperty','item','editable',false);
            	   
            	   		
            	   } 
                
                  else
              {
                	   document.getElementById("productchk").value=0; 
                	   $('#serviceGrid').jqxGrid('setcolumnproperty','item','editable',true);
               	  
              }
              
               }}
           x.open("GET","checkproductconfig.jsp?",true);
        	x.send();

        	
        } 


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
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
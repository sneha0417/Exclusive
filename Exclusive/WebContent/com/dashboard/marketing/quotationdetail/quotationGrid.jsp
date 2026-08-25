<%@page import="com.dashboard.marketing.quotationdetail.ClsQuotationDetailDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%ClsQuotationDetailDAO DAO= new ClsQuotationDetailDAO(); %>
<%
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String revision=request.getParameter("revision")==null?"0":request.getParameter("revision").trim().toString();
 int load =request.getParameter("load")==null?0:Integer.parseInt(request.getParameter("load").trim());
 int enqno=request.getParameter("enqno")==null?0:Integer.parseInt(request.getParameter("enqno").trim());
 String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim().toString();
%>
    <script type="text/javascript">
    var servdata;
    var doc_no='<%=docno%>';
    var load='<%=load%>';
    var enqno='<%=enqno%>';
    var value2=2;
    
    if(parseInt(doc_no)>0){
		servdata = '<%=DAO.quotGridLoad(session,docno,revision) %>';
    }
    
    if(load==2 && parseInt(enqno)>0){
     	servdata = '<%=DAO.serviceEstLoad(session,enqno,reftype)%>';
    }
    
    	  var rendererstring1=function (aggregates){
        	var value=aggregates['sum1'];
        	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Total" + '</div>';
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
     value2=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value2 + '</div>';
    }
    
        $(document).ready(function () { 	
        	chkproductconfig();
         var num = 0; 
         
         $('#gridtext3').keyup(function(){
        	 	

             $("#prosearchGridqot").jqxGrid('clearfilters');
        	  
        // alert("gridtext="+$(this).val());
           $('#proname').val($(this).val());
           var dataField = "proname";
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
     						{name : 'proname', type: 'String'  },
                          	{name : 'qty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'scopeamount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'desc1', type: 'String'  },
     						{name : 'psrno', type: 'String'  },
     						{name : 'product', type: 'String'  },
     						{name : 'stdprice', type: 'number'    },
     						{name : 'lbrchg', type: 'number'},
							{name : 'scopestdcost', type: 'number'}
     						
                          	],
                 localdata: servdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            $("#qutDetGrid").on("bindingcomplete", function (event) {
            	  
            	 if(parseInt($('#presalesscopeallowed').val())==1){
          			$('#qutDetGrid').jqxGrid('showcolumn', 'scope');
					$('#qutDetGrid').jqxGrid('showcolumn', 'scopeamount');
					$('#qutDetGrid').jqxGrid('setcolumnproperty', 'desc1', 'width', '14%');
					$('#qutDetGrid').jqxGrid('setcolumnproperty', 'proname', 'width', '11%');
  			     } else {
  			    	$('#qutDetGrid').jqxGrid('hidecolumn', 'scope');
					$('#qutDetGrid').jqxGrid('hidecolumn', 'scopeamount');
					$('#qutDetGrid').jqxGrid('setcolumnproperty', 'desc1', 'width', '23%');
					$('#qutDetGrid').jqxGrid('setcolumnproperty', 'proname', 'width', '16%');
  			     }
            	
                  document.getElementById("qutnettotal").value=value2; 
                  fundisamt();
    		   
            }); 
          
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#qutDetGrid").jqxGrid(
            {
                width: '100%',
                height:210,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:20,
             	selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                editable: true,

                handlekeyboardnavigation: function (event) {

                	
                    var cell4 = $('#qutDetGrid').jqxGrid('getselectedcell');
                   
                    
                    if (cell4 != undefined && (cell4.datafield == 'proname'  )) 
                    
                   {	 
                   
  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  	               
  	                  if (key == 9) { 
  	                	  
   	                	 if(cell4.datafield == 'proname')
 	                		  {
 	                		var aa= $('#proname').val();
 	                		  }
 	                	 
 	                 
                    if(typeof(aa)=="undefined")
                    
                    	{
                    	 
                    	return 0;
                    	}
                    
  	               	 var rows = $("#prosearchGridqot").jqxGrid('getrows');
  	  		     	
  	                  $('#qutDetGrid').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	              	
  	              	  $('#datas1').val(0);
  	              
  	              	  $('#qutDetGrid').jqxGrid('setcellvalue', rowindex1, "product" ,rows[0].prdname);
  	              	  $('#qutDetGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].prdname);       
  	              	  $('#qutDetGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	              	  $('#qutDetGrid').jqxGrid('setcellvalue', rowindex1, "unitid" ,rows[0].unitdocno);
  	              	  $('#qutDetGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno);
  	              	  $('#qutDetGrid').jqxGrid('setcellvalue', rowindex1, "amount" ,rows[0].amount);
  	              	  $('#qutDetGrid').jqxGrid('setcellvalue', rowindex1, "stdprice" ,rows[0].stdprice);
					  $('#qutDetGrid').jqxGrid('setcellvalue', rowindex1, "lbrchg" ,rows[0].lbrchg);
					  $('#qutDetGrid').jqxGrid('setcellvalue', rowindex1, "scopeamount" ,rows[0].scopefprice);
					  $('#qutDetGrid').jqxGrid('setcellvalue', rowindex1, "scopestdcost" ,rows[0].scopestdcost);
					
					  $('#datas1').val(1);
  	
					  $('#sidesearchwndowqot').jqxWindow('close'); 
  	                	   

					  var rows = $('#qutDetGrid').jqxGrid('getrows');
					  var rowlength= rows.length;
           
               
					  if(rowindex1 == rowlength -1) {  
						  $("#qutDetGrid").jqxGrid('addrow', null, {});
					  } 
               
					  $("#qutDetGrid").jqxGrid('ensurerowvisible', rowlength);
  	        	            
  	                  } 
  	                
  	                  if (key != 13) { 
  	                	if(parseInt(document.getElementById("productchk").value)==0) {
  	                		  if (cell4 != undefined && cell4.datafield == 'proname') {
  	                			  document.getElementById("gridtext3").focus();
  	                		  }
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
							{ text: 'Site', datafield: 'site', width: '15%',editable: false },
							{ text: 'Siteid', datafield: 'siteid', width: '10%',hidden: true},
							{ text: 'Service.Type', datafield: 'stype', width: '14%',editable: false },
							{ text: 'stypeid', datafield: 'stypeid', width: '10%',hidden:true},
							{ text: 'Scope', datafield: 'scope', width: '5%',editable: false },
							{ text: 'Item', datafield: 'proname',cellclassname: cellclassname,columntype: 'custom',
		                    	  
								    createeditor: function (row, cellvalue, editor, cellText, width, height) {
								     
								         editor.html('<input type="text" id="proname" name="proname" style="width:100%;height:99%;"   />' ); 
								   
								        
								    }, 
								 
								 
							},
							{ text: 'Unit', datafield: 'unit', width: '4%',editable: false  },
							{ text: 'Qty', datafield: 'qty', width: '4%' },
							{ text: 'Unitid', datafield: 'unitid', width: '10%',hidden:true},
							{ text: 'Scope Amount', datafield: 'scopeamount', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Amount',datafield:'amount',width:'10%',cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							{ text: 'Total',datafield:'total',cellsformat: 'd2',editable:false, width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Description',datafield:'desc1'},
							{ text: 'psrno', datafield: 'psrno', width: '10%',hidden: true},
							{ text: 'product', datafield: 'product', width: '10%',hidden:true},
							{ text: 'Scope Id', datafield: 'scopeid', width: '10%', hidden: true}, 
							{ text: 'stdprice', datafield: 'stdprice', width: '10%',hidden: true},
							{ text: 'Labour Charge', datafield: 'lbrchg', width: '10%',hidden: true},
							{ text: 'Scope Standard Cost', datafield: 'scopestdcost', width: '10%',hidden: true},
					]
            });
            
            $('#qutDetGrid').on('cellbeginedit', function (event) {
                
            	 var datafield=event.args.datafield;
            	 $('#datas').val("0");

            	 if(parseInt(document.getElementById("productchk").value)==0){
            		 
            		 $('#qutDetGrid').jqxGrid('setcolumnproperty', 'proname', 'editable', true);
            		 
            		 if(datafield == "proname") { 
            			 
            			 var rowindextemp = event.args.rowindex;
                		 var scopeid=$('#qutDetGrid').jqxGrid('getcellvalue', rowindextemp, "scopeid");
		 				 var stypeid=$('#qutDetGrid').jqxGrid('getcellvalue', rowindextemp, "stypeid");
                		 productSearchContentqot('productSearchqot.jsp?id=1&scopeid='+scopeid+'&stypeid='+stypeid);
                		 document.getElementById("rowindex").value = rowindextemp;  
            							      
                		 var temp= $('#qutDetGrid').jqxGrid('getcellvalue', rowindextemp, "proname"); 
            						         
                		 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN") { 
                			 $('#gridtext3').val(""); 
                			 $('#proname').val("");  
                		 } else {
                			 $('#proname').val($('#qutDetGrid').jqxGrid('getcellvalue', rowindextemp, "product"));
                			 $('#gridtext3').val($('#qutDetGrid').jqxGrid('getcellvalue', rowindextemp, "product"));
                			 $('#qutDetGrid').jqxGrid('setcellvalue', rowindextemp, "proname" ,$('#qutDetGrid').jqxGrid('getcellvalue', rowindextemp, "product"));
                		 }
            		 }
            	 }
            });
            
            $('#qutDetGrid').on('celldoubleclick', function(event)  {
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

            	if(datafield == "proname")
 		  		{ 
            		if(parseInt(document.getElementById("productchk").value)==1) {
            			 var rowindextemp = event.args.rowindex;
            			 var scopeid=$('#qutDetGrid').jqxGrid('getcellvalue', rowindextemp, "scopeid");
   			             var stypeid=$('#qutDetGrid').jqxGrid('getcellvalue', rowindextemp, "stypeid");
   			             $('#txtgridqotservicetypeid').val(stypeid);$('#txtgridqotscopeid').val(scopeid);
    				   	 productSearchContentqot('productMasterSearchqot.jsp?scopeid='+scopeid+'&stypeid='+stypeid);

            		} else{
       				//productSearchContent('productSearch.jsp?id=1');
		   			}
 	 
            		var rowindextemp = event.args.rowindex;
            		document.getElementById("rowindex").value = rowindextemp;  
 		  		} 

            });
            
            $("#qutDetGrid").on('cellvaluechanged', function (event)  {
            	var datafield = event.args.datafield;
    		    var rowBoundIndex = event.args.rowindex;    
    		    
    		    if(parseInt($('#datas').val())!=1) {
    		    	if(datafield=="proname") {
    		    		$('#qutDetGrid').jqxGrid('setcellvalue', rowBoundIndex, "proname" ,$('#qutDetGrid').jqxGrid('getcellvalue', rowBoundIndex, "product"));
    		    		$('#sidesearchwndowqot').jqxWindow('close');
    		    	}
    		    }
    		    
    		    if(datafield=="qty" || datafield=="amount" ) {
    		    	var qty= $('#qutDetGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
               	    var amount= $('#qutDetGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
               		var total;
               		
               		if(qty==""||typeof(qty)=="undefined"|| qty=="NaN"){
               			qty=0;
               		}
               		
               		if(amount=="" || typeof(amount)=="undefined" || amount=="NaN"){
               			amount=0;
               		}		
               			
               		if(parseInt($('#presalesscopeallowed').val())==1){
               		   scopeamount=$('#qutDetGrid').jqxGrid('getcellvalue', rowBoundIndex, "scopeamount");
		    			
 		    		   if(!(scopeamount=="" || typeof(scopeamount)=="undefined" || typeof(scopeamount)=="NaN")) {
 		    				total=(parseFloat(qty)*parseFloat(amount))+(parseFloat(qty)*parseFloat(scopeamount));
 		           	   } else {
 		    		    	total=parseFloat(qty)*parseFloat(amount);
 				       }
             			
 		    		} else {
               			total=parseFloat(qty)*parseFloat(amount);
 		    		}
               		
               		$('#qutDetGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
             			
    		    	 var summaryData3= $("#qutDetGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    	         	document.getElementById("qutnettotal").value=summaryData3.sum.replace(/,/g,''); 
    	         	fundisamt();
    		  }
    		   
            	
                    });
            
         $("#popupWindow1").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu1").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#qutDetGrid").on('contextmenu', function () {
                   return false;
               });
               
         $("#Menu1").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#qutDetGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#qutDetGrid").offset();
                       $("#popupWindow1").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#qutDetGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow1").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#qutDetGrid").jqxGrid('getrowid', rowindex);
                      
                       $("#qutDetGrid").jqxGrid('deleterow', rowid);
                       var summaryData3= $("#qutDetGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
       	         	document.getElementById("qutnettotal").value=summaryData3.sum.replace(/,/g,''); 
       	         fundisamt();
               		
                   }
               }); 
                
           $("#qutDetGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		  // if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#qutDetGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                 // }
        		   }
               });
                 
            
            $("#qutDetGrid").jqxGrid('addrow', null, {}); 
             
        });
        


        var applyFilter = function (datafield,value) {
        	if(document.getElementById("productchk").value==0){
        	    if(parseInt($('#datas').val())!=1)
        		  {   
            var filtertype = 'stringfilter';
          
        		//  alert(datafield+"="+value);
          
            if (datafield == 'proname' ) filtertype = 'stringfilter';
            var filtergroup = new $.jqx.filter();

                var filter_or_operator = 1;

                var filtervalue = value;
                var filtercondition = 'contains';
                
                var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
                filtergroup.addfilter(filter_or_operator, filter);
           
            
            if (datafield == 'proname') 
            	{
           
            $("#prosearchGridqot").jqxGrid('addfilter', 'prdname' , filtergroup);
         //   document.getElementById("part_no").focus();
            	}
          

            $("#prosearchGridqot").jqxGrid('applyfilters');
            
        		  }
            
        	}
        }

         
                
                
        function chkproductconfig()
        {
        	
           var x=new XMLHttpRequest();
           x.onreadystatechange=function(){
           if (x.readyState==4 && x.status==200)
            {
              var items= x.responseText.trim();
            // alert(parseInt(items));
              if(parseInt(items)>0)
               {
            	
            	   document.getElementById("productchk").value=1;
            	 
            	     $('#qutDetGrid').jqxGrid('setcolumnproperty','proname','editable',false);
            	   		
            	   } 
                
                  else
              {
                	   document.getElementById("productchk").value=0; 
                	   $('#qutDetGrid').jqxGrid('setcolumnproperty','proname','editable',true);
               	  
              }
              
               }}
           x.open("GET","checkproductconfig.jsp?",true);
        	x.send();

        	
        } 
    </script>
    

 <div id='jqxWidget1'>
   <div id="qutDetGrid"></div>
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
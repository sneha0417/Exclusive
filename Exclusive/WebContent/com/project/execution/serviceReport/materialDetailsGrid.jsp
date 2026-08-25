<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<% ClsServiceReportDAO DAO = new ClsServiceReportDAO(); %> 
<% String docNo = request.getParameter("trno")==null?"0":request.getParameter("trno");%>  

<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }
              
</style>

<script type="text/javascript">

		var data1;
		
		$(document).ready(function () {
			var temp2='<%=docNo%>';
			
			if(temp2>0){  
				data1 =  '<%=DAO.toBeInvoicedGridReloading(docNo) %>'; 
			}
			
			var rendererstring=function (aggregates){
				var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
				return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
			}
	 
			var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Net Total : " + '</div>';
            }
			
	        $('#gridtext').keyup(function(){
	
			       $("#prosearch").jqxGrid('clearfilters');
	               $('#part_no').val($(this).val());
	               var dataField = "part_no";
	               applyFilter(dataField,$(this).val());  
	        });
	         
	        $('#gridtext1').keyup(function(){
	
	 			   $("#prosearch").jqxGrid('clearfilters');
	               $('#productname').val($(this).val());
	               var dataField = "productname";
	    		   applyFilter(dataField,$(this).val());  
	               
	        });   
           	 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'desc1', type: 'string'  },
							{name : 'product', type: 'string' },
     						{name : 'productid', type: 'string' }, 
     						{name : 'productname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'qty', type: 'string'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'invoiced', type: 'bool'  },
     						{name : 'proid', type: 'string' },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'specid', type: 'number'    }
     						
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#materialDetailsGridID").jqxGrid(
            {
                width: '99%',
                height: 160,
                source: dataAdapter,
                columnsresize: true,
                showaggregates:true,
                showstatusbar:true,
             	statusbarheight:25,
                editable: true,
                disabled:true,
                editmode: 'selectedcell',
                selectionmode: 'singlecell',
                pagermode: 'default',
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {

                    var cell4 = $('#materialDetailsGridID').jqxGrid('getselectedcell');
                    if (cell4 != undefined && (cell4.datafield == 'productid' || cell4.datafield == 'productname'  )) {	 
  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  	                   if (key == 9) { 
  	                      $('#sidesearchwndow').jqxWindow('close');
	   	               	  var rows = $("#prosearch").jqxGrid('getrows');  
	   	               	  var prodocs=rows[0].doc_no;
  	                
  	                	  if(parseInt(rows[0].method)==0) {
  	              	  
  	            		      var rows1 = $("#materialDetailsGridID").jqxGrid('getrows');
  	          	              var aa=0;
  	          	              for(var i=0;i<rows1.length;i++){
  	          	    	 
	  	          		       if(parseInt(rows1[i].prodoc)==parseInt(prodocs)) {
	  	          			   		aa=1;
	  	          			        break;
	  	          			   } else{
	  	          			   		aa=0;
	  	          		       } 
  	          	          }
  	          	   
  	          	   		 if(parseInt(aa)==1) {
  	          			      document.getElementById("errormsg").innerText="You have already select this product";
	   	          		      return 0;
  	          		     } else {
  	          		   		  document.getElementById("errormsg").innerText="";
  	          		     }
  	            	  }
  	                	   
  	               	 	   var rows = $("#prosearch").jqxGrid('getrows');
  	                	   $('#materialDetailsGridID').jqxGrid('render');
  	              	       var rowindex1 =$('#rowindex').val();
  	              	       $('#datas1').val(0);
  	              	
  	                       $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	                       $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
		  	               $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
		  	               $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
		  	               $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
		  	               $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
		  	               $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
		  	               $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno ); 
		  	               $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid ); 
  	              
  	       		           $('#datas1').val(1);
  	                       $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          			   var rows = $('#materialDetailsGridID').jqxGrid('getrows');
                           var rowlength= rows.length;
                           if(rowindex1 == rowlength - 1) {  
               					$("#materialDetailsGridID").jqxGrid('addrow', null, {});
               				} 
  	        	           } 
  	                   
                    
            			   /*if (cell4 != undefined && cell4.datafield == 'productid') {
				       		   document.getElementById("gridtext").focus();
            				}
				            if (cell4 != undefined && cell4.datafield == 'productname') {
				       		   document.getElementById("gridtext1").focus();
          					}*/
                   		  } 
                    	},
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Description', datafield: 'desc1', width: '28%',editable:true },
							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '8%'},
							{ text: 'Product Name', datafield: 'productname',columntype: 'custom'},
							{ text: 'Unit', datafield: 'unit', width: '5%',editable:false },	
							{ text: 'Quantity', datafield: 'qty', width: '5%' },
							{ text: 'Amount', datafield: 'amount', width: '8%', cellsformat: 'd3', cellsalign: 'right', align: 'right', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Total', datafield: 'total', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right', editable: false,aggregates: ['sum'],aggregatesrenderer:rendererstring },
							/* { text: 'Margin%', datafield: 'margin', width: '5%', hidden: true }, */
							{ text: 'pid', datafield: 'proid', width: '10%', hidden: true }, 
  							{ text: 'pname', datafield: 'proname', width: '10%', hidden: true },
  							{ text: 'prodoc', datafield: 'prodoc', width: '10%', hidden: true },
							{ text: 'unitdocno', datafield: 'unitdocno', width: '10%', hidden: true },
							{ text: 'psrno', datafield: 'psrno', width: '10%', hidden: true },
							{ text: 'specid', datafield: 'specid', width: '10%', hidden: true },
						    { text: 'To Be Invoiced', datafield: 'invoiced', columntype: 'checkbox', editable: true, checked: true, width: '8%',cellsalign: 'center', align: 'center' }, 
						]
            });
            
             
            
           $('#materialDetailsGridID').on('cellbeginedit', function (event) {
	   var rowindex2 = event.args.rowindex;
	  
	   $('#datas').val(0);
	   var columnindex1=event.args.datafield;
	
	
	 /* if(columnindex1 == "productid") 
	  { 
	    	
	   			$('#materialDetailsGridID').jqxGrid('setcolumnproperty', 'productid', 'editable', true);
  			  $('#materialDetailsGridID').jqxGrid('setcolumnproperty', 'productname', 'editable', true);
	   			 productSearchContent('productSearch.jsp');
			
	   		 	        	 
        	var rowindextemp = event.args.rowindex;
    	    document.getElementById("rowindex").value = rowindextemp;  
		    	    
		    var temp= $('#materialDetailsGridID').jqxGrid('getcellvalue', rowindextemp, "productid"); 
		    if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN"){ 
		  	   $('#gridtext').val("");  
		  	   $('#part_no').val("");  
		    }
		    else{
		       $('#part_no').val($('#materialDetailsGridID').jqxGrid('getcellvalue', rowindextemp, "proid"));
		       $('#gridtext').val($('#materialDetailsGridID').jqxGrid('getcellvalue', rowindextemp, "proid"));
		       $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#materialDetailsGridID').jqxGrid('getcellvalue', rowindextemp, "proid"));
		  	}
	    }	    
    	if(columnindex1 == "productname")
    	{ 
    	  	if(document.getElementById("errormsg").innerText!="")
      		{
         		return 0;
      		}	
			
	   			$('#materialDetailsGridID').jqxGrid('setcolumnproperty', 'productid', 'editable', true);
			  $('#materialDetailsGridID').jqxGrid('setcolumnproperty', 'productname', 'editable', true);
	   			 productSearchContent('productSearch.jsp');
			
	   		 
	    	var rowindextemp = event.args.rowindex;
			document.getElementById("rowindex").value = rowindextemp;  
			var temp= $('#materialDetailsGridID').jqxGrid('getcellvalue', rowindextemp, "productname"); 
	        if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
			{ 
	      	   $('#gridtext1').val(""); 
	      	   $('#productname').val("");  
			   }
	         else
	        	{
	      	   $('#productname').val($('#materialDetailsGridID').jqxGrid('getcellvalue', rowindextemp, "proname"));
	      	   $('#gridtext1').val($('#materialDetailsGridID').jqxGrid('getcellvalue', rowindextemp, "proname"));
	             $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#materialDetailsGridID').jqxGrid('getcellvalue', rowindextemp, "proname"));
	        	 }
	     }*/
           });


  
  $('#materialDetailsGridID').on('celldoubleclick', function (event) {
             	var columnindex1=event.args.datafield;

          	  if(columnindex1 == "productid")
        	  { 
        	    	
        	   	 
        	   			$('#materialDetailsGridID').jqxGrid('setcolumnproperty', 'productid', 'editable', false);
        	  			  $('#materialDetailsGridID').jqxGrid('setcolumnproperty', 'productname', 'editable', false);
        		         productSearchContent('productMasterSearch.jsp');
        		    	        	 
                	var rowindextemp = event.args.rowindex;
            	    document.getElementById("rowindex").value = rowindextemp;  
        	  }
          	if(columnindex1 == "productname")
        	{ 
        	  	if(document.getElementById("errormsg").innerText!="")
          		{
             		return 0;
          		}	
    		
       		 	
       		 
    	   			 
    	   			$('#materialDetailsGridID').jqxGrid('setcolumnproperty', 'productid', 'editable', false);
    	  			  $('#materialDetailsGridID').jqxGrid('setcolumnproperty', 'productname', 'editable', false);
    		         productSearchContent('productMasterSearch.jsp');
    		    
    	    	var rowindextemp = event.args.rowindex;
    			document.getElementById("rowindex").value = rowindextemp;  
        	}
             	
                 	  
                     });
            
            $("#materialDetailsGridID").on('cellvaluechanged', function (event)  {
            	
            	var datafield = event.args.datafield;
    		    var rowBoundIndex = event.args.rowindex;

    		    var total=0;var qty=0;var amount=0;
    		    
    		    /*if(parseInt($('#datas').val())!=1) {
    	   	   if(datafield=="productid") {
    	   				$('#materialDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#materialDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
    	       			$('#sidesearchwndow').jqxWindow('close');
    	   		   }
    	   	   
    	   	   		if(datafield=="productname") {
    	   		   		$('#materialDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#materialDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
    	               	$('#sidesearchwndow').jqxWindow('close');
    	   		   }
    	   	   		
    	   	   
    	   		  }*/
    		    
    		    	if(datafield=="qty" || datafield=="amount" ) {
    		    	
    		    	 qty= $('#materialDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
               	     amount= $('#materialDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "amount");
               		
    		    	 if(!(qty==""||typeof(qty)=="undefined"|| typeof(qty)=="NaN" || typeof(amount)=="" || typeof(amount)=="undefined" || typeof(amount)=="NaN")) {
    		    		total=parseFloat(qty)*parseFloat(amount);
             			$('#materialDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
           		     }
    		  
    		      }
    		     
    		      	var netamount=$('#materialDetailsGridID').jqxGrid('getcolumnaggregateddata', 'total', ['sum'], true);
    		      	var netamount1=netamount.sum;
    	            if(!isNaN(netamount1)){
    	      		    funRoundAmt(netamount1,"txttobeinvoicednettotal");
    	      		  }
    	      		else{
    			    	 funRoundAmt(0.00,"txttobeinvoicednettotal");
    			    }
            });
            
            
            var applyFilter = function (datafield,value) {
                
            	if(parseInt($('#datas').val())!=1) {
                	var filtertype = 'stringfilter';
              
       		        if (datafield == 'part_no' || datafield == 'productname') filtertype = 'stringfilter';
                	var filtergroup = new $.jqx.filter();
                    var filter_or_operator = 1;
                    var filtervalue = value;
    	            var filtercondition = 'starts_with';
                    
                    var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
                    filtergroup.addfilter(filter_or_operator, filter);
                
                	if (datafield == 'part_no')  {
                		$("#prosearch").jqxGrid('addfilter', 'part_no' , filtergroup);
		                //document.getElementById("part_no").focus();
                	} else  if (datafield == 'productname')  {
	                    $("#prosearch").jqxGrid('addfilter', 'productname' , filtergroup);
    	                //document.getElementById("productname").focus();
                    }
	                $("#prosearch").jqxGrid('applyfilters');
            	}
            }
            
            if(temp2>0){
            	$("#materialDetailsGridID").jqxGrid('disabled', true);
            }
            
            if($('#mode').val()!="view"){
            	$("#materialDetailsGridID").jqxGrid('disabled', false);
            }
         
		});

</script>
<div id="materialDetailsGridID"></div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">

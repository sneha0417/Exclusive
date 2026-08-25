<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.marketing.quotationdetail.ClsQuotationDetailDAO"%> 
<%ClsQuotationDetailDAO DAO= new ClsQuotationDetailDAO();%>
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String scopegroupid=request.getParameter("scopegroupid")==null?"0":request.getParameter("scopegroupid").trim();
String scopegroupchanged=request.getParameter("scopegroupchanged")==null?"0":request.getParameter("scopegroupchanged").trim();
%>

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
var matdata;
var value;

var docno='<%=docno%>';
var scopegroupchanged='<%=scopegroupchanged%>';

if(parseInt(docno)>0 && parseInt(scopegroupchanged)>0){
	   matdata = '<%=DAO.quotSubScopeGroupChangeGridLoad(session,docno,scopegroupid) %>';
} else if(parseInt(docno)>0){
	   matdata = '<%=DAO.quotSubGridLoad(session,docno) %>';
	
}
$(document).ready(function () {
  
	chkproductconfig();
 var rendererstring3=function (aggregates){
  value=aggregates['sum'];
  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
  }    



	  var rendererstring1=function (aggregates){
    	
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
    }
	  var rendererstring4=function (aggregates){
	    	
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
	var valuetot=aggregates['sum'];
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + valuetot + '</div>';
}
 
$('#gridtext').keyup(function(){
 	

     $("#prosearchGrid").jqxGrid('clearfilters');
	  
// alert("gridtext="+$(this).val());
   $('#proname').val($(this).val());
   var dataField = "proname";
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
							{name : 'scope', type: 'string'},
							{name : 'scopeid', type: 'string'},
							{name : 'product', type: 'string' },
     						{name : 'productid', type: 'string' },
     						{name : 'activity', type: 'string' },
     						{name : 'activityid', type: 'string' },
     						{name : 'brand', type: 'string'},
     						{name : 'brandname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'qty', type: 'number'  },
     						{name : 'scopeamount', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'nettotal', type: 'number'  },
     						{name : 'margin', type: 'number'  },
     						{name : 'invoiced', type: 'bool'  },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'proid', type: 'number'    },
     						{name : 'specid', type: 'number'    },  
     						{name : 'stypeid', type: 'number'    },
     						{name : 'site', type: 'string'    },
     						{name : 'sertype', type: 'string'    },
     						{name : 'brandid', type: 'number'    }, 
     						{name : 'tr_no', type: 'number'    },
     						{name : 'sitesrno', type: 'number'    },
     						{name : 'productname', type: 'string'  },
     						{name : 'stdprice', type: 'number'    },
     						{name : 'marginper', type: 'number'    },
     						{name : 'lbrchg', type: 'number'},
							{name : 'scopestdcost', type: 'number'},
							{name : 'scopeproduct', type: 'int'},
                        ],
                       
                         localdata: matdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            		
            };
            	
           
            $("#qutDetSubGrid").on("bindingcomplete", function (event) {
            	
            	if(parseInt($('#presalesscopeallowed').val())==1){
          			$('#qutDetSubGrid').jqxGrid('showcolumn', 'scope');
					$('#qutDetSubGrid').jqxGrid('showcolumn', 'scopeamount');
					$('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'desc1', 'width', '14%');
					$('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'proname', 'width', '10%');
  			    } else {
  			    	$('#qutDetSubGrid').jqxGrid('hidecolumn', 'scope');
					$('#qutDetSubGrid').jqxGrid('hidecolumn', 'scopeamount');
					$('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'desc1', 'width', '23%');
					$('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'proname', 'width', '15%');
  			    }
            	
                document.getElementById("estimationtotal").value=value; 
          }); 
            
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#qutDetSubGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                statusbarheight: 21,
                editmode: 'selectedcell',
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                pagermode: 'default',
                columnsresize:true,
                
                handlekeyboardnavigation: function (event) {

                	var cell1 = $('#qutDetSubGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'scope') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) { 
	                        	if($('#cmbscopegroup').val().trim()=='') {
	                		    	$.messager.alert('Message','Select a Scope Group.','warning');
	                		     	return 0;
	                		    }
	                        	$('#rowindex').val(cell1.rowindex);
                        		$('#qutDetSubGrid').jqxGrid('render');
                        		scopeSearchContent('scopeSearchGrid.jsp?rowno='+cell1.rowindex+'&scopegroup='+$('#hidcmbscopegroup').val());
                        }
                    }
                    
                    var cell4 = $('#qutDetSubGrid').jqxGrid('getselectedcell');
                    
                    if (cell4 != undefined && (cell4.datafield == 'proname' || cell4.datafield == 'brandname'  )) 
                   {	 
                   
  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  	               
  	                  if (key == 9) { 
  	                	  
   	                	 if(cell4.datafield == 'proname')
 	                		  {
 	                		var aa= $('#proname').val();
 	                		  }
 	                	  else if(cell4.datafield == 'brandname')
 	                		  {
 	                		var aa= $('#brandname').val();  
 	                		  }
 	                		
 	                 
                    if(typeof(aa)=="undefined")
                    
                    	{
                    	 
                    	return 0;
                    	}
                    
  	               	 var rows = $("#prosearchGrid").jqxGrid('getrows');
  	  		     	
  	                	   $('#qutDetSubGrid').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	              	
  	              	  $('#datas1').val(0);
  	              
  	            $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "product" ,rows[0].productname);
  	            $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "brand" ,rows[0].brandname);
  	            $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	            $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);       
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,rows[0].doc_no);
               
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno);
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid);
                if(parseInt($('#qutDetSubGrid').jqxGrid('getcellvalue', rowindex1, "scopeproduct"))==1){
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "amount" ,rows[0].amount);
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "stdprice" ,rows[0].stdprice); 
                } else {
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "amount" ,0);
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "stdprice" ,0); 
                }
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "brandid" ,rows[0].brandid);
                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "lbrchg" ,rows[0].lbrchg);
  		        $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "scopeamount" ,rows[0].scopefprice);
  		        $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "scopestdcost" ,rows[0].scopestdcost);
  	              
  
  	            $('#datas1').val(1);
  	        
  	       
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#qutDetSubGrid').jqxGrid('getrows');
               var rowlength= rows.length;
           
               if(rowindex1 == rowlength -1)
               	{  
            	
               $("#qutDetSubGrid").jqxGrid('addrow', null, {"scopeproduct": "1"});
               	} 
               $("#qutDetSubGrid").jqxGrid('ensurerowvisible', rowlength);
  	        	            } 
  	                   
  	           if (key != 13) {   
  	                		
  	        	   if(parseInt(document.getElementById("productchk").value)==0) {
            
  	        		   if (cell4 != undefined && cell4.datafield == 'proname') {
  	        			   document.getElementById("gridtext").focus();
  	        		   }

  	        		   if (cell4 != undefined && cell4.datafield == 'brandname') {
  	        			   document.getElementById("gridtext1").focus();
  	        		   }
  	        	   }
  	             }
                } 
                    
                },
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Site', datafield: 'site', width: '9%',editable:false },
							{ text: 'Scope', datafield: 'scope', width: '5%',editable: false },
							{ text: 'Service Type', datafield: 'sertype', width: '9%',editable:false },
							{ text: 'Description', datafield: 'desc1',width: '15%',editable:true },
    						{ text: 'prdid', datafield: 'productid', width: '10%',cellclassname: cellclassname,hidden:true },
							{ text: 'Product', datafield: 'proname',cellclassname: cellclassname,columntype: 'custom',
	                          	  
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="proname" name="proname" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    }, 
  							 
  							 
							},
  							 
							{ text: 'Brand', datafield: 'brandname', width: '8%'  ,cellclassname: cellclassname ,columntype: 'custom',
								

  								
	  							 createeditor: function (row, cellvalue, editor, cellText, width, height) {
	  							       
	  							         editor.html('<input type="text" id="brandname" name="brandname" style="width:100%;height:99%;"   />' ); 
	  							     
	  							        
	  							    },  
								
								},
							
							{ text: 'Unit', datafield: 'unit', width: '3%',editable:false,cellclassname: cellclassname },	
							{ text: 'QTY', datafield: 'qty', width: '4%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Scope Amt', datafield: 'scopeamount', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname },
							{ text: 'Amount', datafield: 'amount', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,aggregatesrenderer: rendererstring4},
							{ text: 'Total', datafield: 'total', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer: rendererstring3 },
							{ text: 'Margin', datafield: 'margin', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Margin %', datafield: 'marginper', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right' , align: 'right',aggregatesrenderer: rendererstring1},
							{ text: 'Net Total', datafield: 'nettotal', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer: rendererstring ,editable: false,cellclassname: cellclassname},
							{ text: 'Scope Id', datafield: 'scopeid', width: '10%',cellclassname: cellclassname,hidden: true},
							{ text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{ text: 'pname', datafield: 'productname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{ text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{ text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true}, 
							{ text: 'brandid', datafield: 'brandid', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'stypeid', datafield: 'stypeid', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'Tr No', datafield: 'tr_no',  width: '5%',hidden:true }, 
							{ text: 'sitesrno', datafield: 'sitesrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'stdprice', datafield: 'stdprice', width: '10%',cellclassname: cellclassname,hidden: true},
							{ text: 'Labour Charge', datafield: 'lbrchg', width: '10%',cellclassname: cellclassname,hidden: true},
							{ text: 'Scope Standard Cost', datafield: 'scopestdcost', width: '10%',cellclassname: cellclassname,hidden: true},
							{ text: 'product', datafield: 'product', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'brand', datafield: 'brand', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'Scope Product', datafield: 'scopeproduct', width: '10%',cellclassname: cellclassname,hidden: true},
							]
            });
            
            $('#qutDetSubGrid').on('cellbeginedit', function (event) {
                
            	var columnindex1=event.args.columnindex;
            	 var datafield=event.args.datafield;
            	 $('#datas').val("0");
            	 
            	 if(parseInt(document.getElementById("productchk").value)==0){
            		 
            		 $('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'proname', 'editable', true);
	            	 $('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'brandname', 'editable', true);
	            	 
            		 if(datafield == "proname") {   
                	
       						 //productSearchContent('productSearch.jsp?id=1');
       						 var rowindextemp = event.args.rowindex;
						     document.getElementById("rowindex").value = rowindextemp;
						    
       						 var scopeid=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "scopeid");
   			   	  			 var scopeproduct=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "scopeproduct");
   			      			 var stypeid=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "stypeid");
   			      			 productSearchContent('productSearch.jsp?id=1&scopeid='+scopeid+'&scopeproduct='+scopeproduct+'&stypeid='+stypeid);
   							    
   							  var temp= $('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "proname"); 

   							  if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN") { 
   						      	   $('#gridtext').val(""); 
   						      	   $('#proname').val("");  
   							  } else {
   						      	   $('#proname').val($('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "product"));
   						      	   $('#gridtext').val($('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "product"));
   						           $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindextemp, "proname" ,$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "product"));
   						      }
            		 }
                	
                	if(datafield == "brandname") { 
       						//productSearchContent('productSearch.jsp?id=1');
   							 var rowindextemp = event.args.rowindex;
   							 document.getElementById("rowindex").value = rowindextemp;  
   							    
   							 var scopeid=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "scopeid");
  			   	  			 var scopeproduct=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "scopeproduct");
  			      			 var stypeid=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "stypeid");
  			      			 productSearchContent('productSearch.jsp?id=1&scopeid='+scopeid+'&scopeproduct='+scopeproduct+'&stypeid='+stypeid);
  			      			 
   							 var temp= $('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "brandname"); 
   							 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN") { 
   						      	   $('#gridtext1').val(""); 
   						      	   $('#brandname').val("");  
   							 } else {
   						      	   $('#brandname').val($('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "brand"));
   						      	   $('#gridtext1').val($('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "brand"));
   						      	   $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindextemp, "brandname" ,$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "brand"));
   							 }
                	}
            	 } else {
            		    $('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'proname', 'editable', false);
						$('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'brandname', 'editable', false);
            	 }
                   
            });
            
                      
            $("#qutDetSubGrid").on('cellvaluechanged', function (event) {
            	
            	var datafield = event.args.datafield;
    		    var rowBoundIndex = event.args.rowindex;
    		    var discount=0;
    		    var margin=0;  
    		    var total=0;
    		    var qty=0;
    		    var scopeamount=0;
    		    var amount=0;
    		    var nettotal=0;
    		    
    		    if(parseInt($('#datas').val())!=1) {
    	            
  	              if(datafield=="proname") {
  	            		$('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "proname" ,$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "product"));
  	               		$('#sidesearchwndow').jqxWindow('close');
  	             }
  	            
  	              if(datafield=="brandname") {
  	               		$('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "brandname" ,$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "brand"));
  	                    $('#sidesearchwndow').jqxWindow('close');
  	             }
  	            
  	            }
  		    
    		    
    		    
    		   if(datafield=="qty" || datafield=="amount" || datafield=="scopeamount" || datafield=='margin' || datafield=="marginper" ) {
    		    	
    		     qty= $('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
               	 amount= $('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
               	 total=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
     			 margin=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "margin");
               		
     			 if(( margin=="" || typeof(margin)=="undefined" || typeof(margin)=="NaN" )) {
		    		 margin=0;
	       		 }
     			 
     			var marginper=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "marginper");
     			if(marginper==""||marginper==null||marginper=="undefiend" || marginper==0)
				{
					 $('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "margin",0);
					 marginper=0;
				}
     			 
    		    	
     			if(!(qty==""||typeof(qty)=="undefined"|| typeof(qty)=="NaN")) {
     				
     				if(parseInt($('#presalesscopeallowed').val())==1){
		    			
		    		   scopeamount=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "scopeamount");
		    			
		    		   if(!(scopeamount=="" || typeof(scopeamount)=="undefined" || typeof(scopeamount)=="NaN")) {
		    			   
	    			    if((amount=="" || typeof(amount)=="undefined" || typeof(amount)=="NaN")) {
	    				   amount="0";
	    			    }
		    			   
		    			total=(parseFloat(qty)*parseFloat(amount))+(parseFloat(qty)*parseFloat(scopeamount));
    		    		nettotal=total;
    		    		margin=(parseFloat(nettotal)*parseFloat(marginper))/100;
    		    		discount=parseFloat(margin);
            			nettotal=parseFloat(total)+parseFloat(discount);
		           		   
		    		} else {
		    			
		    			if((amount=="" || typeof(amount)=="undefined" || typeof(amount)=="NaN")) {
		    				   amount="0";
		    			 }
		    			
		    			total=parseFloat(qty)*parseFloat(amount);
    		    		nettotal=total;
    		    		margin=(parseFloat(nettotal)*parseFloat(marginper))/100;
    		    		discount=parseFloat(margin);
            			nettotal=parseFloat(total)+parseFloat(discount);
		    		}
            			
		    		} else {
		    			
		    			if((amount=="" || typeof(amount)=="undefined" || typeof(amount)=="NaN")) {
		    				   amount="0";
		    			}
		    			
		    			total=parseFloat(qty)*parseFloat(amount);
    		    		nettotal=total;
    		    		margin=(parseFloat(nettotal)*parseFloat(marginper))/100;
    		    		discount=parseFloat(margin);
            			nettotal=parseFloat(total)+parseFloat(discount);
             			
           		   }
     				
     				$('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
     				$('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "margin",margin);
         			$('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
    		  
    		     }
    		   }
    		   
    		   if(datafield=="margin"){
       			
    			   var marginper=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "marginper");
    			   var margin=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "margin");
    			   var totals=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
       			
    			   if(margin==""||margin==null||margin=="undefiend" || margin==0) {
		        				
    				   if(marginper==""||marginper==null||marginper=="undefiend" || marginper==0) {
		        			 $('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "margin",0);
		        			 $('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "marginper",0);
    				   } else {
    					      var marginval=(parseFloat(totals)*parseFloat(marginper))/100;
		        		   	  $('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "margin",marginval);
    				   }	
       				} else {
       					 var	marginp=(parseFloat(margin)*100)/parseFloat(total);
          		   		 $('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "marginper",marginp);
       				}
       
    		   }
    		      
    		   var summaryData1= $("#qutDetSubGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true); 
    		   document.getElementById("estimationtotal").value=summaryData1.sum.replace(/,/g,''); 
                    
            });
            
            
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#qutDetSubGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#qutDetSubGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#qutDetSubGrid").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#qutDetSubGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#qutDetSubGrid").jqxGrid('getrowid', rowindex);
                      
                       $("#qutDetSubGrid").jqxGrid('deleterow', rowid);
                       var summaryData1= $("#qutDetSubGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true); 
               		document.getElementById("estimationtotal").value=summaryData1.sum.replace(/,/g,''); 
               		
                   }
               });
               
               $("#qutDetSubGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		  // if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#qutDetSubGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                 // }
        		   }
               });
                
              
               $('#qutDetSubGrid').on('celldoubleclick', function(event) {
               	
            	   var rowBoundIndex = event.args.rowindex;
            	   var datafield = event.args.datafield;
            	  
            	   if(datafield == "proname") { 
            		   if(parseInt(document.getElementById("productchk").value)==1) {
            			   
            			   $('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'proname', 'editable', false);
             			   $('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'brandname', 'editable', false);
             			   var rowindextemp = event.args.rowindex;
            			   var scopeid=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "scopeid");
            			   var scopeproduct=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "scopeproduct");
            			   var stypeid=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "stypeid");
            			   $('#txtgridservicetypeid').val(stypeid);$('#txtgridscopeid').val(scopeid);$('#txtgridscopeproduct').val(scopeproduct);
    				   	   productSearchContent('productMasterSearch.jsp?scopeid='+scopeid+'&scopeproduct='+scopeproduct+'&stypeid='+stypeid);
            		   }
       		   		  else{
              				//productSearchContent('productSearch.jsp?id=1');
       		   			   $('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'proname', 'editable', true);
		   		           $('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'brandname', 'editable', true);
       		   		  }
        	 
            		   var rowindextemp = event.args.rowindex;
            		   document.getElementById("rowindex").value = rowindextemp;  
            	   } 
        	  
        	  
        	   
            	   if(datafield == "brandname") {
            		   if(parseInt(document.getElementById("productchk").value)==1) {
            			   var rowindextemp = event.args.rowindex;
            		   	   var scopeid=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "scopeid");
            		   	   var scopeproduct=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "scopeproduct");
            		   	   var stypeid=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "stypeid");
            		   	   $('#txtgridservicetypeid').val(stypeid);$('#txtgridscopeid').val(scopeid);$('#txtgridscopeproduct').val(scopeproduct);
            		   	   productSearchContent('productMasterSearch.jsp?scopeid='+scopeid+'&scopeproduct='+scopeproduct+'&stypeid='+stypeid);
            		   } else{
   						   //productSearchContent('productSearch.jsp?id=1');
            			   $('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'proname', 'editable', true);
		   		           $('#qutDetSubGrid').jqxGrid('setcolumnproperty', 'brandname', 'editable', true);
            		   }
    	 
            		   var rowindextemp = event.args.rowindex;
            		   document.getElementById("rowindex").value = rowindextemp;  
            	   }
            	   
    		      
            	   if((datafield=="sertype")) {
    		    		getservicetype(rowBoundIndex);
            	   } 
   		     
    		      if((datafield=="site")) {
    		    	  var surtrno=document.getElementById("surtrno").value;
    		    	  var enqtrno=document.getElementById("enqno").value;
    		    	  var id=0;

    		    	  if(surtrno>0){
    		    		  id=4;
    		    		  getsiteEst(rowBoundIndex,surtrno,id);

    		    	  } else {
    		    		  id=3;
    		    		  getsiteEst(rowBoundIndex,enqtrno,id);
    		    	  }
    		      } 
    		      
    		      if(datafield=="scope") {
           		   
           		    if($('#cmbscopegroup').val()=='') {      
           		    	$.messager.alert('Message','Select a Scope Group.','warning');
           		     	return 0;
           		    }
           		    
           		    var rowindextemp = event.args.rowindex;
           			scopeSearchContent('scopeSearchGrid.jsp?rowno='+rowindextemp+'&scopegroup='+$('#hidcmbscopegroup').val());
           			document.getElementById("rowindex").value = rowindextemp;  
   	    	
   	    	   }
               });
               
               $("#qutDetSubGrid").jqxGrid('addrow', null, {"scopeproduct": "1"});
        });


	var applyFilter = function (datafield,value) {
	    
		if(parseInt($('#datas').val())!=1)
		  {   
    var filtertype = 'stringfilter';
  
		//  alert(datafield+"="+value);
  
    if (datafield == 'proname' || datafield == 'brandname') filtertype = 'stringfilter';
    
    	var filtergroup = new $.jqx.filter();

        var filter_or_operator = 1;

        var filtervalue = value;
        var filtercondition = 'contains';
        
        var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
        filtergroup.addfilter(filter_or_operator, filter);
   
    
    if (datafield == 'proname') 
    	{
   
    $("#prosearchGrid").jqxGrid('addfilter', 'productname' , filtergroup);
 //   document.getElementById("part_no").focus();
    	}
    else  if (datafield == 'brandname') 
	         {
        
        $("#prosearchGrid").jqxGrid('addfilter', 'brandname' , filtergroup);
      //  document.getElementById("productname").focus();
        	}
    
    

    $("#prosearchGrid").jqxGrid('applyfilters');
    
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
    	 
    	   $('#qutDetSubGrid').jqxGrid('setcolumnproperty','proname','editable',false);
    	   $('#qutDetSubGrid').jqxGrid('setcolumnproperty','brandname','editable',false);
    	   		
    	   } 
        
          else
      {
        	   document.getElementById("productchk").value=0; 
        	   $('#qutDetSubGrid').jqxGrid('setcolumnproperty','proname','editable',true);
       	       $('#qutDetSubGrid').jqxGrid('setcolumnproperty','brandname','editable',true);
      }
      
       }}
   x.open("GET","checkproductconfig.jsp?",true);
	x.send();

	
} 
 
</script>

<div id='jqxWidget'>
   <div id="qutDetSubGrid"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">



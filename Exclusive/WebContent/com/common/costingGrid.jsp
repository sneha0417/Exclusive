<%@page import="com.common.ClsCommonCosting"%>
<% ClsCommonCosting DAO= new ClsCommonCosting(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String tranid = request.getParameter("tranid")==null?"0":request.getParameter("tranid");
   String check = request.getParameter("checks")==null?"0":request.getParameter("checks").trim();%>  
<script type="text/javascript">
        
       	var costingdata1; 
        $(document).ready(function () { 
            
            var temp1='<%=check%>';
             
             if(temp1=='1'){     
            	 costingdata1='<%=DAO.costGridLoading(tranid,check)%>';      
           	 }
                
             var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	if(typeof(value) == "undefined"){
                		value=0.00;
                	}
                	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
                }
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'costtype', type: 'string'    },
							{name : 'costgroup', type: 'string'    },
							{name : 'costcodes', type: 'number'    },
							{name : 'costcode', type: 'number'    },
     						{name : 'amount', type: 'number'  }
                        ],
                		   localdata: costingdata1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#costingGridID").on("bindingcomplete", function (event) {
            	$("#costingGridID").jqxGrid("addrow", null, {});
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costingGridID").jqxGrid(
            {
            	width: '99.5%',
                height: 260,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                	 var cell1 = $('#costingGridID').jqxGrid('getselectedcell');
                     if (cell1 != undefined && cell1.datafield == 'costgroup') {
                     	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0;
                         if (key == 114) {
                         	 costTypeSearchContent(<%=contextPath+"/"%>+"com/common/costTypeSearchGrid.jsp?formname=costingGridID");
                         	 $('#costingGridID').jqxGrid('render');
                         	 
                         	 var rows = $('#costingGridID').jqxGrid('getrows');
         	                 var rowlength= rows.length;
         	                 var rowindex1 = rowlength - 1;
         	          	     var costtypeId=$("#costingGridID").jqxGrid('getcellvalue', rowindex1, "costtype");
         	          	     if(typeof(costtypeId) != "undefined" && typeof(costtypeId) != "NaN" && costtypeId.trim() != ""){
         	                	$("#costingGridID").jqxGrid('addrow', null, {});
         	          	     }
              	            }
                     	}
                         
                     var cell2 = $('#costingGridID').jqxGrid('getselectedcell');
                     if (cell2 != undefined && cell2.datafield == 'costcodes') {
     	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
     	                   if (key == 114) {   
     	                	   var value=  $('#costingGridID').jqxGrid('getcellvalue', cell2.rowindex, "costtype");
     	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/common/costCodeSearchGrid.jsp?formname=costingGridID&costtype="+value);
     	                	   $('#costingGridID').jqxGrid('render');
     	                   }
     	               }
                },
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '7%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Cost Type', datafield: 'costgroup', width: '33%', editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%', hidden: true ,editable: true},
							{ text: 'Cost Code', datafield: 'costcodes', width: '30%',editable: false },
							{ text: 'Cost Code', datafield: 'costcode', width: '10%', hidden: true, editable: false },
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '30%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						]
            });
            
            $("#costingGridID").on('cellvaluechanged', function (event) {
           	    var rowindexestemp = event.args.rowindex;
           	    var datafield = event.args.datafield;
           	    $('#rowindex').val(rowindexestemp);    
           	   
	           	if(datafield=="costtype"){
	       			$('#costingGridID').jqxGrid('setcellvalue', rowindexestemp, "costcodes" ,'');
	       			$('#costingGridID').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
	   			}
              });
            
            $('#costingGridID').on('cellclick', function (event) {
            	   var rowBoundIndex = event.args.rowindex;  
            	   $('#rowindex').val(rowBoundIndex); 
            	   
            	   var rows = $('#costingGridID').jqxGrid('getrows');
	               var rowlength= rows.length;
	               var rowindex1 = rowlength - 1;
	          	   var costtypeId=$("#costingGridID").jqxGrid('getcellvalue', rowindex1, "costtype");
	          	   if(typeof(costtypeId) != "undefined" && typeof(costtypeId) != "NaN" && costtypeId.trim() != ""){
	                $("#costingGridID").jqxGrid('addrow', null, {});
	          	   }
            });
            
            $('#costingGridID').on('celldoubleclick', function (event) {
           	  
	           	 if(event.args.columnindex == 1){
		   	           var rowindextemp = event.args.rowindex;
		   	           document.getElementById("rowindex").value = rowindextemp;
		   	           $('#costingGridID').jqxGrid('clearselection');
		   	           costTypeSearchContent(<%=contextPath+"/"%>+"com/common/costTypeSearchGrid.jsp?formname=costingGridID");
		   	           
		   	           var rows = $('#costingGridID').jqxGrid('getrows');
		               var rowlength= rows.length;
		               var rowindex1 = rowlength - 1;
		          	   var costtypeId=$("#costingGridID").jqxGrid('getcellvalue', rowindex1, "costtype");
		          	   if(typeof(costtypeId) != "undefined" && typeof(costtypeId) != "NaN" && costtypeId.trim() != ""){
		                $("#costingGridID").jqxGrid('addrow', null, {});
		          	   }
	               } 
	       		  
	              if(event.args.columnindex == 3){
		   	           var rowindextemp = event.args.rowindex;
		   	           document.getElementById("rowindex").value = rowindextemp;
		   	           $('#costingGridID').jqxGrid('clearselection');
		   	           var value = $('#costingGridID').jqxGrid('getcellvalue', rowindextemp, "costtype");
		   	           costCodeSearchContent(<%=contextPath+"/"%>+"com/common/costCodeSearchGrid.jsp?formname=costingGridID&costtype="+value);
	               } 
	              
	              if(event.args.columnindex == 0) {
	      			var rowindexestemp = event.args.rowindex;
	  	   			$('#costingGridID').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
	  	   			$('#costingGridID').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
	  	   			$('#costingGridID').jqxGrid('setcellvalue', rowindexestemp, "costcodes" ,'');
	  	   			$('#costingGridID').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
	  	   			$('#costingGridID').jqxGrid('setcellvalue', rowindexestemp, "amount" ,'0.00');
	              }
              
             });
            
            $("#costingGridID").on('cellvaluechanged', function (event)  {
              	    var datafield = event.args.datafield;
           		    if(datafield=="amount"){
           		
  	               	    var value=0.0,value1=0.0;
  	               	    var rows = $('#costingGridID').jqxGrid('getrows');
  	           	        var rowlength= rows.length;
  	               		for(i=0;i<=rowlength-1;i++)
  	               		{
  	                       var value= $("#costingGridID").jqxGrid('getcellvalue', i, "amount"); 
  	               	      
  	                       if(!isNaN(value)){
  	                    	 	value1=value1+value;
                   	   	   }else if(isNaN(value)){
                   	   			value=0.00;
                   	   			value1=value1+value;
                     	   }
  	                     
  	               		}
  	               		funCostingRoundAmt(value1,"txtcostingtotal");
  	               	
  	               		if(!isNaN(value1)){
  	               			var balance=(parseFloat($('#txtaccounttotal').val())-parseFloat($('#txtcostingtotal').val()));
  	               			if(parseFloat(balance)>0.00) {
  	               	    		document.getElementById("costingmsg").innerText="Unallocated Amount is "+balance;
  	               	    	    $('#btnCostingSave').attr('disabled', true);
  	               			} else if(parseFloat(balance)==0.00) {
  	               	    		document.getElementById("costingmsg").innerText="Amount is Allocated,Please Save Changes.";
  	               	    	    $('#btnCostingSave').attr('disabled', false);
  	               			} else {
  	               				document.getElementById("costingmsg").innerText="Invalid Allocation "+balance;
  	               			    $('#btnCostingSave').attr('disabled', true);
  	               			}
  	               		}
           		    }
                 		
                });
            
            var costingtotal1="";
            var costingtotal=$('#costingGridID').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
            costingtotal1=costingtotal.sum;
            
            if(!isNaN(costingtotal1)){
            	funCostingRoundAmt(costingtotal1,"txtcostingtotal"); 
      		    document.getElementById("costingmsg").innerText="Unallocated Amount is "+(parseFloat($('#txtaccounttotal').val())-parseFloat($('#txtcostingtotal').val()));
      		} else {
      			funCostingRoundAmt(0.00,"txtcostingtotal");
		    }
           
});
        
</script>
<div id="costingGridID"></div>
    
<input type="hidden" id="rowindex"/> 
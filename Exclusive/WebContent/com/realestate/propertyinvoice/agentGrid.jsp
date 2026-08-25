<%@page import="com.realestate.propertyinvoice.*" %>
<%ClsPropertyInvoiceDAO DAO=new ClsPropertyInvoiceDAO(); %>
<%
String rdocno = request.getParameter("rdocno")==null?"0":request.getParameter("rdocno");
String id = request.getParameter("id")==null?"0":request.getParameter("id");
System.out.println("agentdata"+rdocno+"::"+id);
%> 
<script type="text/javascript">
var agentdata;  
var id='<%=id%>';
if(id=="1"){   
	agentdata='<%=DAO.getAgent(rdocno,id)%>';
}
$(document).ready(function () { 
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'agent', type: 'string'   },
     						{name : 'commperc', type: 'number' },
     						{name : 'commamount', type: 'number'   },
     						{name : 'salid', type: 'number'   }
                        ],
                         localdata: agentdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#agentGridId").jqxGrid(
            {
                width: '100%',
                height: 100,
                source: dataAdapter,
                disabled:true,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                handlekeyboardnavigation: function (event) {
                    var rows = $('#agentGridId').jqxGrid('getrows');
                     var rowlength= rows.length;
                       var cell = $('#agentGridId').jqxGrid('getselectedcell');
                       if (cell != undefined && cell.datafield == 'agent' && cell.rowindex == rowlength - 1) {
                           var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                           if (key == 114) {  
                        	   salespersonSearchContent('SearchSalesman.jsp?rowno='+cell.rowindex);
                           $('#agentGridId').jqxGrid('render');
                           }
                           if (key ==9) {                                                        
                               var commit = $("#agentGridId").jqxGrid('addrow', null, {});
                               rowlength++;                           
                           }
                       }
                       },
                    
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Agent', datafield: 'agent',  editable: false },	
							{ text: 'Agent', datafield: 'salid',  editable: false,width:'10%',hidden:true },	
							{ text: 'Commission %', datafield: 'commperc', cellsformat: 'd2', width: '25%', cellsalign: 'right', align: 'right'},
							{ text: 'Commission Value', datafield: 'commamount', cellsformat: 'd2', width: '20%', cellsalign: 'right', align: 'right'}
						]
            });
			
			 $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    		// create context menu
       		var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
       		$("#agentGridId").on('contextmenu', function () {
           		return false;
       		});
            $("#Menu2").on('itemclick', function (event) {
    	   		var args = event.args;
           		var rowindex = $("#agentGridId").jqxGrid('getselectedrowindex');
           		if ($.trim($(args).text()) == "Delete Selected Row") {
               		var rowid = $("#agentGridId").jqxGrid('getrowid', rowindex);
               		$("#agentGridId").jqxGrid('deleterow', rowid);
           		}
       		});
            $("#agentGridId").on('rowclick', function (event) {
           		if (event.args.rightclick) {
		   			if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
               			$("#agentGridId").jqxGrid('selectrow', event.args.rowindex);
               			var scrollTop = $(window).scrollTop();
               			var scrollLeft = $(window).scrollLeft();
               			contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               			return false;
           			}
		   		}
       		});
            
            if ($("#mode").val() == "A" || $("#mode").val() == "E") {
            	
            	  $("#agentGridId").jqxGrid({ disabled: false});
            	
            }
            
            $('#agentGridId').on('celldoubleclick', function (event) {

            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	 
             
            	if(datafield=="agent")
         	   { 
            		  $("#agentGridId").jqxGrid('clearselection');
            		  salespersonSearchContent('SearchSalesman.jsp?rowno='+rowBoundIndex);
            		 $('#agentGridId').jqxGrid('render');
         	   }
                  });
            
            $("#agentGridId").on('cellvaluechanged', function (event) {
            	var datafield = event.args.datafield;  
            	var row = event.args.rowindex;          
        		var comperc=0,commision=0,agentcommision=0;
				
            	if(datafield=="commperc" ){   
            		var totalamount=0.0;
			        var detailrows=$('#nidescdetailsGrid').jqxGrid('getrows');
			        for(var i=0;i<detailrows.length;i++){
						// && parseInt(detailrows[i].account)==17903 was there in if condition for exclusive removed as confirmed in mail
			        	if($.isNumeric(detailrows[i].nettotal || detailrows[i].nettotal!=''  || detailrows[i].nettotal!=null   || detailrows[i].nettotal!='undefined' )){
			            	totalamount+=parseFloat(detailrows[i].nettotal);
			            } 
			        }
					
					var percent=parseFloat($('#agentGridId').jqxGrid('getcellvalue',row,'commperc'));	
					if(!isNaN(percent)){			  			
				  		var agentamount=(percent/100)*totalamount;
				  		agentamount.toFixed(2);
				  		$('#agentGridId').jqxGrid('setcellvalue',row,'commamount',agentamount);
				  	}
					
			       /*  var agentrows=$('#agentGridId').jqxGrid('getrows');
				  	for(var i=0;i<agentrows.length;i++){
				  		if(agentrows[i].commperc!="" && agentrows[i].commperc!="undefined" && agentrows[i].commperc!=null && typeof(agentrows[i].commperc)!="undefined"){
				  			var percent=parseFloat(agentrows[i].commperc);
				  			var agentamount=(percent/100)*totalamount;
				  			agentamount.toFixed(2);
				  			$('#agentGridId').jqxGrid('setcellvalue',i,'commamount',agentamount);
				  		}
				  		else if(agentrows[i].commperc=="0"){
				  			$('#agentGridId').jqxGrid('setcellvalue',i,'commamount',0.00);
				  		}
				  	} */
					
            	}
            	/* else if(datafield=="commamount"){
            		var totalamount=0.0;
			        var detailrows=$('#nidescdetailsGrid').jqxGrid('getrows');
			        for(var i=0;i<detailrows.length;i++){
			        	if(detailrows[i].nettotal!="" && detailrows[i].nettotal!="undefined" && detailrows[i].nettotal!=null && typeof(detailrows[i].nettotal)!="undefined"){
			            	totalamount+=parseFloat(detailrows[i].nettotal);
			            } 
			        }
					
			        var agentrows=$('#agentGridId').jqxGrid('getrows');
				  	for(var i=0;i<agentrows.length;i++){
				  		if(agentrows[i].commamount!="" && agentrows[i].commamount!="undefined" && agentrows[i].commamount!=null && typeof(agentrows[i].commamount)!="undefined"){
				  			var percentvalue=parseFloat(agentrows[i].commamount);
				  			var percent=(percentvalue/totalamount)*100;
				  			percent=percent.toFixed(2);
				  			$('#agentGridId').jqxGrid('setcellvalue',i,'commperc',percent);
				  		}
				  		else if(agentrows[i].commperc=="0"){
				  			$('#agentGridId').jqxGrid('setcellvalue',i,'commperc',0.00);
				  		}
				  	}
					
            	} */
				
            });
        });

</script>

 <div id='jqxWidget'>
    	<div id="popupWindow2">
 			<div id='Menu2'>
        		<ul>
            		<li>Delete Selected Row</li>
        		</ul>
       		</div>
       	</div>
	</div>

<div id="agentGridId"></div>
    
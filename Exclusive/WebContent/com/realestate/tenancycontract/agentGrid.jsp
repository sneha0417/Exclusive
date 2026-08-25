  <%@page import="com.realestate.tenancycontract.ClsTenancyContractDAO" %>
<%ClsTenancyContractDAO DAO=new ClsTenancyContractDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");%> 
<script type="text/javascript">
		 var data21;  
        $(document).ready(function () { 
           
            var temp='<%=docno%>';
             
             if(temp>0){   
            	 data21='<%=DAO.agentloading(docno)%>';  
           	 }
                                
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
                         localdata: data21,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#agentGridId").jqxGrid(
            {
                width: '99.5%',
                height: 150,
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
            		comperc= $("#agentGridId").jqxGrid('getcellvalue',row, 'commperc');
            		if(comperc!=null && comperc!="" && comperc!="undefined" && typeof(comperc)!="undefined"){
            			if(parseFloat(comperc)>=100){
            				$.messager.alert('Warning','Commission Percent must be less than 100');
            				$('#agentGridId').jqxGrid('setcellvalue',row, "commperc",0.0);
            				$('#agentGridId').jqxGrid('setcellvalue',row, "commamount",0.0);
            				return false;
            			}
            			else{
            				var commvattype=$('#cmbcommvattype').val();
            				if(commvattype=="Inclusive"){
            					var commvatamount=$('#commvatamount').val();
            					if(commvatamount!="undefined" && commvatamount!="" && commvatamount!=null && typeof(commvatamount)!="undefined"){
            						commision=parseFloat($('#txtcommisionval').val())-parseFloat(commvatamount);
            					}
            				}
            				else{
            					commision=parseFloat($('#txtcommisionval').val());	
            				}
		            		agentcommision=commision * comperc/100; 
        		    		$('#agentGridId').jqxGrid('setcellvalue',row, "commamount",agentcommision );		
            			}
            		}
            		
            		
            	}
            	 
            	
            	
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
    
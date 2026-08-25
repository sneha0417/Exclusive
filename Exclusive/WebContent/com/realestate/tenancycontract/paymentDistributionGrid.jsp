 
  <%@page import="com.realestate.tenancycontract.ClsTenancyContractDAO" %>
<%ClsTenancyContractDAO DAO=new ClsTenancyContractDAO();
 %>
<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");%> 
<script type="text/javascript">
		 var data311;  
        $(document).ready(function () { 
           
            var temp='<%=docno%>';
             
             if(temp>0){   
            	 data311='<%=DAO.paymentloading(docno)%>'	;  
           	 }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'description', type: 'string'   },
     						{name : 'date', type: 'date' },
     						{name : 'amount', type: 'number'   },
     						{name : 'notes', type: 'string'   },
     						{name : 'chqno', type: 'string'   },
     						{name : 'paidto', type: 'string'   },
     						{name : 'paymentmethod', type: 'string'   },
     						{name : 'bankaccount', type: 'string'   },
     						{name : 'jvdetails',type:'string'}
                        ],
                         localdata: data311,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var jvhidden=false;
            if ($("#mode").val() == "A" || $("#mode").val() == "E") {
            	jvhidden=true;
            }
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['Bank','Cash','On Account'];
            var list1 = ['Self', 'Owner'];
            
            $("#paymentDistributionGridId").jqxGrid(
            {
                width: '99.5%',
                height: 150,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                disabled:true,     
                enabletooltips: true,
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Description', datafield: 'description', width: '15%' , editable:false },	
							{ text: 'Date', datafield: 'date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '5%'
								,
								  createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
						               editor.jqxDateTimeInput({ enableBrowserBoundsDetection: true});
						               
						             
						           }},	
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '7%', cellsalign: 'right', align: 'right',aggregates: ['sum'] },
							{ text: 'Notes', datafield: 'notes' }, 
							{ text: 'Cheque No', datafield: 'chqno', width: '10%' },
							
							{ text: 'Payment', datafield: 'paymentmethod', width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                	editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                            { text: 'Paid To', datafield: 'paidto', width: '15%' ,columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                    editor.jqxDropDownList({ autoDropDownHeight: true, source: list1 });
					              }
					          },
							{ text: 'Bank', datafield: 'bankaccount', width: '13%' },
							{ text: 'Reciept Details', datafield: 'jvdetails', width: '12%',hidden:jvhidden },
						]
            });
			
			$("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    		// create context menu
       		var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
       		$("#paymentDistributionGridId").on('contextmenu', function () {
           		return false;
       		});
            $("#Menu").on('itemclick', function (event) {
    	   		var args = event.args;
           		var rowindex = $("#paymentDistributionGridId").jqxGrid('getselectedrowindex');
           		if ($.trim($(args).text()) == "Delete Selected Row") {
               		var rowid = $("#paymentDistributionGridId").jqxGrid('getrowid', rowindex);
               		$("#paymentDistributionGridId").jqxGrid('deleterow', rowid);
           		}
       		});
            $("#paymentDistributionGridId").on('rowclick', function (event) {
           		if (event.args.rightclick) {
		   			if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
               			$("#paymentDistributionGridId").jqxGrid('selectrow', event.args.rowindex);
               			var scrollTop = $(window).scrollTop();
               			var scrollLeft = $(window).scrollLeft();
               			contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               			return false;
           			}
		   		}
       		});
          
            if ($("#mode").val() == "A" || $("#mode").val() == "E") {
            	  $("#paymentDistributionGridId").jqxGrid({ disabled: false});
            }
            
            $('#paymentDistributionGridId').on('cellvaluechanged', function (event) 
            {   
	            var rows = $('#paymentDistributionGridId').jqxGrid('getrows');
	            var rowlength= rows.length;
	            var rowindex1=event.args.rowindex;
	            
	            if(rowindex1 == rowlength - 1)
	            	{  
	            $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
            	} 
            });
            
            $("#paymentDistributionGridId").on('cellendedit', function (event) {
                var column = $("#paymentDistributionGridId").jqxGrid('getcolumn', event.args.datafield);
                var rowindex=event.args.rowindex;
                if(column.datafield=="paymentmethod"){
                	var datavalue=event.args.value;
                	if(datavalue=="Cash"){
                		$("#paymentDistributionGridId").jqxGrid('setcellvalue',rowindex,'paidto','Self');
                	}
                }
            });
        });

</script>
 <div id='jqxWidget'>
    	<div id="popupWindow">
 			<div id='Menu'>
        		<ul>
            		<li>Delete Selected Row</li>
        		</ul>
       		</div>
       	</div>
	</div>

<div id="paymentDistributionGridId"></div>
<%@page import="com.realestate.propertyowner.ClsPropertyOwnerDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<% String contextPath=request.getContextPath();%>

<%ClsPropertyOwnerDAO DAO= new ClsPropertyOwnerDAO(); 

String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();
 
%>
<script type="text/javascript">  
var accdata;
accdata='<%=DAO.AccountLoadByownerID(session,Integer.parseInt(docno))%>';

     $(document).ready(function () {  
         var source =
         {
             datatype: "json",
             datafields: [
						{name : 'doc_no', type: 'int'  },     
  						{name : 'bankname', type: 'string'  },  
  						{name : 'accnumber', type: 'string'  },
  						{name : 'accname', type: 'string'  },
  						{name : 'bankaddress', type: 'string'  },
  						{name : 'country', type: 'string'  },
  						{name : 'countryid', type: 'int'  },
  						{name : 'currencyid', type: 'string'  },
  						{name : 'currency', type: 'string'  },
  						{name : 'swiftcode', type: 'string'  },
  						{name : 'iban', type: 'string'  },
  						{name : 'remarks', type: 'string'  },
  						{name : 'chk', type: 'bool'  },
                     ],
                        localdata: accdata,  
             
             pager: function (pagenum, pagesize, oldpagenum) {
                 // callback called when a page or page size is changed.
             }
         };
        
         /* $('#jqxaccGrid').on('bindingcomplete', function (event) {
         	if ($("#mode").val() == "A" || $("#mode").val() == "E") {			 
     			$("#jqxaccGrid").jqxGrid('addrow', null, {});		 
     		}
     	}); */
         
     	 var selectFromMethod = false;
     	  
         var dataAdapter = new $.jqx.dataAdapter(source);
         
         $("#jqxaccGrid").jqxGrid(
         {
             width: '100%',
             height: 325,
             source: dataAdapter,
             editable: true,
             altRows:true,
             showaggregates: true,
             selectionmode: 'singlerow',
           
            /*  handlekeyboardnavigation: function (event) {
                 var rows = $('#jqxaccGrid').jqxGrid('getrows');
                 var rowlength= rows.length;
       	       var rowindex1=0;
                 var cell = $('#jqxaccGrid').jqxGrid('getselectedcell');
   				if (cell != undefined && cell.datafield == 'chk' ) {
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 13 || key == 9) { 
                     	$("#jqxaccGrid").jqxGrid('addrow', null, {});		    
                     }
                 }
             }, */
             columns: [
				{ text: 'SL#', sortable: false, filterable: false, editable: false,
				    groupable: false, draggable: false, resizable: false,
				    datafield: 'sl', columntype: 'number', width: '3%',
				    cellsrenderer: function (row, column, value) {
				        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
				}  
				},
				{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true },		
				{ text: 'Default', columntype: 'checkbox',datafield: 'chk', width: '1%',hidden:false ,editable: true},						
				{ text: 'Bank Name', datafield: 'bankname', editable: false },
				{ text: 'Account #', datafield: 'accnumber', width: '15%', editable: false },	
				{ text: 'Account Name', datafield: 'accname', editable: false, width: '10%' },	
				{ text: 'Address', datafield: 'bankaddress', editable: false, width: '10%' }, 
				{ text: 'Country', datafield: 'country', editable: false, width: '10%' }, 
				{ text: 'Countryid', datafield: 'countryid', editable: false, width: '10%',hidden:true }, 
				{ text: 'currencyid', datafield: 'currencyid', width: '10%',hidden:true },	
				{ text: 'currency', datafield: 'currency', editable: false, width: '5%' },						
				{ text: 'Swiftcode', datafield: 'swiftcode', width: '8%', editable: false },
				{ text: 'IBAN', datafield: 'iban', editable: false },	
				{ text: 'Remarks', datafield: 'remarks', editable: false, width: '10%' },							
			]
         });
         
         $('#jqxaccGrid').on( 'rowdoubleclick', function(event) {            	
             
 			
 			var boundIndex = event.args.rowindex;		    			 
 			
 			 $('#gridrowindex').val(boundIndex);
 			 $("#accdocno").val($('#jqxaccGrid').jqxGrid('getcellvalue', boundIndex, "doc_no"));    			
 			 $('#txtbankname').val($('#jqxaccGrid').jqxGrid('getcellvalue', boundIndex, "bankname"));
 			 $('#txtaccountno').val($('#jqxaccGrid').jqxGrid('getcellvalue', boundIndex, "accnumber"));
 			 $('#txtaccountname').val($('#jqxaccGrid').jqxGrid('getcellvalue', boundIndex, "accname"));
 			 $('#txtbankaddress').val($('#jqxaccGrid').jqxGrid('getcellvalue', boundIndex, "bankaddress"));
 			 $('#cmbbankcountry').val($('#jqxaccGrid').jqxGrid('getcellvalue', boundIndex, "countryid"));
 			 $('#cmbcurrency').val($('#jqxaccGrid').jqxGrid('getcellvalue', boundIndex, "currencyid")); 
 			 $('#txtbankswift').val($('#jqxaccGrid').jqxGrid('getcellvalue', boundIndex, "swiftcode"));
 			 $('#txtbankiban').val($('#jqxaccGrid').jqxGrid('getcellvalue', boundIndex, "iban"));
 			 $('#txtbankremarks').val($('#jqxaccGrid').jqxGrid('getcellvalue', boundIndex, "remarks")); 
 			 $('#defaultacc').val($('#jqxaccGrid').jqxGrid('getcellvalue', boundIndex, "chk")); 
 			  
 		});
         
         /* var selectedRow;
         $("#jqxaccGrid").on('cellselect', function (event) {
             var datafield = event.args.datafield;
             var rowindex = event.args.rowindex;
             if (datafield == "chk") {
                 if (!checkFirstColumn(rowindex)) {
                     $('#jqxaccGrid').jqxGrid('unselectcell', rowindex, datafield);
                 } else {
                     selectedRow = rowindex;
                 };
             } else {
                 if (rowindex != selectedRow) {
                     $('#jqxaccGrid').jqxGrid('unselectcell', rowindex, datafield);
                 };
             };
         });
         
         var checkFirstColumn = function (rowindex) {
             var selectedCells = $('#jqxaccGrid').jqxGrid('getselectedcells');
             for (var i = 0; i < selectedCells.length; i++) {
                 if (selectedCells[i].datafield == "chk" && selectedCells[i].rowindex != rowindex) {
                     return false;
                 };
             };
             return true;
         }; */
         
     });
</script>
<div id="jqxaccGrid"></div>

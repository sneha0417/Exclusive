<%@page import="com.fixedassets.assetposting.fixedassetposting.ClsFixedAssetDepreciationPostingDAO" %>
<%ClsFixedAssetDepreciationPostingDAO fdp=new ClsFixedAssetDepreciationPostingDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");
String day = request.getParameter("day")==null?"0":request.getParameter("day");
String deprDate = request.getParameter("deprdate")==null?"0":request.getParameter("deprdate").trim();
String trNo = request.getParameter("trno")==null?"0":request.getParameter("trno");
String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");%>

<style>
 .greenClass{
            background-color: #ACF6CB;
        }
.whiteClass{
           background-color: #fff;
        }
 </style>
 
<script type="text/javascript">
	     var data;   
		 var dataExcelExport; 
        $(document).ready(function () { 
            
             var temp='<%=check%>';
             var temp1='<%=trNo%>';
             
             if(temp=='1'){  
            	  data='<%=fdp.assetDetailsProcessing(branch,deprDate)%>';   
                  dataExcelExport='<%=fdp.assetDetailsProcessingExcelExport(branch,deprDate)%>';				  
             }else if(temp=='2'){  
           	      data='<%=fdp.assetDetailsCalculating(branch,day,deprDate)%>';
				  dataExcelExport='<%=fdp.assetDetailsCalculatingExcelExport(branch,day,deprDate)%>';
             }else if(temp1>0){
            	  data='<%=fdp.assetDetailsReloading(docNo,trNo)%>';
				  dataExcelExport='<%=fdp.assetDetailsReloadingExcelExport(docNo,trNo)%>';
             } 
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'assetid', type: 'string' },
     						{name : 'assetname', type: 'string' }, 
     						{name : 'assetgp', type: 'string'   },
     						{name : 'purdate', type: 'date'  },
     						{name : 'prch_cost', type: 'number'   },
     						{name : 'bookvalue', type: 'number'   },
     						{name : 'depr', type: 'number' },
     						{name : 'depr_amt', type: 'number'   },
     						{name : 'depacno', type: 'string'  },
     						{name : 'frmdate', type: 'string'  },
     						{name : 'accdepacno', type: 'string'  },
     						{name : 'depaccount', type: 'string'  },
     						{name : 'accdepaccount', type: 'string'  },
     						{name : 'asset_no', type: 'int' }
                        ],
                            localdata: data,    
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
    	        if(typeof(data.depr_amt)=="undefined" || data.depr_amt=="" ){
    	        	return "whiteClass"; 
    	        }
    	        else{
    	        	return "greenClass";
    	        };
    	          };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxvehicleDetails").jqxGrid(
            {
                width: '99%',
                height: 200,
                source: dataAdapter,
                editable: false,
                showaggregates: true,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Asset Id', datafield: 'assetid',  width: '8%' },
							{ text: 'Asset Name',   datafield: 'assetname',  width: '20%' },
							{ text: 'Group', datafield: 'assetgp', editable: false, width: '7%' },	
							{ text: 'Purchase Date', datafield: 'purdate', cellsformat: 'dd.MM.yyyy', editable: false, width: '10%' },	
							{ text: 'Purchase Price', datafield: 'prch_cost', width: '13%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'Book Value', datafield: 'bookvalue', width: '14%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum']},
							{ text: 'Depr%', datafield: 'depr', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Depriciation', datafield: 'depr_amt', editable: false, width: '18%', cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'From Date', datafield: 'frmdate', hidden: true, editable: false, width: '10%' },
							{ text: 'Dep Acno', datafield: 'depacno', hidden: true, editable: false, width: '10%' },
							{ text: 'Dep Account', datafield: 'depaccount', hidden: true, editable: false, width: '10%' },
							{ text: 'Acc Acno', datafield: 'accdepacno', hidden: true, editable: false, width: '10%' },
							{ text: 'Acc Account', datafield: 'accdepaccount', hidden: true, editable: false, width: '10%' },
							{ text: 'Asset No', datafield: 'asset_no', hidden: true, editable: false, width: '10%' },
						],
            });
            
            if(temp1>0){
            	$("#jqxvehicleDetails").jqxGrid('disabled', true);
            }
            
           var depramt=$('#jqxvehicleDetails').jqxGrid('getcolumnaggregateddata', 'depr_amt', ['sum'], true);
           var depramt1=depramt.sum;
           
           var balanceamt=$('#jqxvehicleDetails').jqxGrid('getcolumnaggregateddata', 'bookvalue', ['sum'], true);
           var balanceamt1=balanceamt.sum;
           
           if(depramt1<0){
        	   if(!isNaN(balanceamt1)){
    	           document.getElementById("txtdeprtotal").value=balanceamt1;
               }
           }else{
	           if(!isNaN(depramt1)){
		           document.getElementById("txtdeprtotal").value=depramt1;
	           }
           }            
           
           $("#overlay, #PleaseWait").hide();
           
        });
    </script>
    <div id="jqxvehicleDetails"></div>
    <input type="hidden" id="rowindex"/> 
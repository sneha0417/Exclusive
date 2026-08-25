<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
  <%@page import="com.dashboard.projectexecution.procurementstatus.ClsProcurementStatusDAO"%>
<%
ClsProcurementStatusDAO sd=new ClsProcurementStatusDAO();
%>
<%
String branchval=request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();
String fromdate=request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate");
String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid");
String contrid = request.getParameter("contrid")==null?"0":request.getParameter("contrid");
String prodid = request.getParameter("prodid")==null?"0":request.getParameter("prodid");
String brandid = request.getParameter("brandid")==null?"0":request.getParameter("brandid");
int check =request.getParameter("check")==null?0:Integer.parseInt(request.getParameter("check").trim());


%>

<style type="text/css">
    .orangeClass
    {
        background-color: #FDEBD0;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greenClass
    {
        background-color: #D1F2EB;
    }
     .greyClass
    {
        background-color: #EAEDED;
    }         
       .blueClass
    {
        background-color: #E8DAEF;
    }           
</style>

<script type="text/javascript">
var matdata;
$(document).ready(function () {

   var loadid='<%=check%>';
 if(loadid==1){
	  
	   matdata='<%=sd.materialGridLoad(session,branchval,fromdate,todate,clientid,contrid,prodid,brandid,check)%>' ;
   }
	 
 
 var rendererstring2=function (aggregates){
  
  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
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
	if(value=="undefined" || typeof(value)=="undefined")value=0.00;
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
}


            	 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'desc1', type: 'string'  },
							{name : 'product', type: 'string' },
     						{name : 'productid', type: 'string' },
     						{name : 'activity', type: 'string' },
     						{name : 'activityid', type: 'string' },
     						{name : 'productname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'qty', type: 'number'  },
     						{name : 'stkqty', type: 'number'  },
     						{name : 'resqty', type: 'number'  },
     						{name : 'purqty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'netotal', type: 'number'  },
     						{name : 'margin', type: 'number'  },
     						{name : 'invoiced', type: 'bool'  },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'proid', type: 'number'    },
     						{name : 'specid', type: 'number'    },
     						{name : 'rowno', type: 'number'    },
     						{name : 'brhid', type: 'number'    },
     						{name : 'locid', type: 'number'    },
     						{name : 'brandname', type: 'string'    },
     						{name : 'remqty', type: 'string'    },
     						{name : 'stypeid', type: 'number'    },
     						{name : 'site', type: 'string'    },
     						{name : 'sertype', type: 'string'    },
     						{name : 'brandid', type: 'number'    },
     						{name : 'purorder', type: 'number'    },
     						{name : 'oldbalqty', type: 'number'    },
     						{name : 'contrno', type: 'string'    },
     						{name : 'client', type: 'string'    },
     						{name : 'consissued', type: 'number'    },
     						{name : 'consbal', type: 'number'    },
     						{name : 'stkgen', type: 'number'    },
     						{name : 'stkresqty', type: 'number'    },
     						{name : 'purchaseqty', type: 'number'    },
     						{name : 'stktotal', type: 'number'    },
     						
     						
                        ],
                        
                        
                       
                         localdata: matdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            		
            };
            	
            		
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#procurementSubGrid").jqxGrid(
            {
                width: '99%',
                height: 490,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                columnsresize: true,
                statusbarheight: 20,
                selectionmode: 'singlecell',
                pagermode: 'default',
              
                columns: [
							{ text: 'SrNo', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Activty', datafield: 'activity', width: '10%',editable:false ,hidden:true},
							{text: 'activityid', datafield: 'activityid', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'Contract No.', datafield: 'contrno', width: '6%',editable:true },
							{text: 'Client', datafield: 'client', width: '15%',editable:false },
						
							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '8%',cellclassname: cellclassname,editable:false},  
							
							{ text: 'Product Name', datafield: 'productname', width: '15%'  ,cellclassname: cellclassname ,editable:false,hidden:false},
							{text: 'Brand', datafield: 'brandname', width: '14%',cellclassname: cellclassname,editable:false,aggregatesrenderer:rendererstring2},
							{ text: 'Unit', datafield: 'unit', width: '4%',editable:false,cellclassname: cellclassname,hidden:true },	
							
						
							{ text: 'BoQ', datafield: 'qty', width: '4%',editable:false,cellclassname: cellclassname, cellsformat: 'd2',editable:false, cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							
							{ text: 'RES Qty', datafield: 'resqty',columngroup:'Procurement', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'PR Qty', datafield: 'purqty',columngroup:'Procurement', width: '5%',cellclassname: cellclassname, cellsformat: 'd2' , cellsalign: 'right', align: 'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'PO Qty', datafield: 'purorder',columngroup:'Procurement', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'PURCH Qty', datafield: 'purchaseqty',columngroup:'Procurement', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							
							{ text: 'Bal Qty', datafield: 'remqty',columngroup:'Procurement',editable:false, width: '5%',cellclassname: cellclassname, cellsformat: 'd2' , cellsalign: 'right', align: 'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
						
							{ text: 'Issued', datafield: 'consissued',columngroup:'consumption',editable:false, width: '5%',cellclassname: cellclassname, cellsformat: 'd2' , cellsalign: 'right', align: 'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Balance', datafield: 'consbal',columngroup:'consumption',editable:false, width: '5%',cellclassname: cellclassname, cellsformat: 'd2' , cellsalign: 'right', align: 'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
						
							{ text: 'RES Qty', datafield: 'stkresqty',columngroup:'stockavail', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
							{ text: 'General', datafield: 'stkgen',columngroup:'stockavail', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
							{ text: 'Total', datafield: 'stktotal',columngroup:'stockavail', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
						
							{ text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname,hidden:true,editable:false },
							{ text: 'Margin', datafield: 'margin', width: '4%',editable:false,cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right',hidden:true,editable:false },
							{ text: 'Net Total', datafield: 'netotal', width: '8%', cellsformat: 'd2', cellsalign: 'right',hidden:true, align: 'right' ,editable: false,cellclassname: cellclassname},
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'rowno', datafield: 'rowno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'brhid', datafield: 'brhid', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'locid', datafield: 'locid', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'Old Bal Qty', datafield: 'oldbalqty',editable:false, width: '5%',hidden:true},
							/* { text: 'Invoiced', datafield: 'invoiced', columntype: 'checkbox', editable: true, checked: true, width: '5%',cellsalign: 'center', align: 'center' }, */
						],columngroups:
							[
						{text: 'Procurement', align:'center', width: '15%',name: 'Procurement'},
						{text: 'Consumption', align:'center', width: '10%',name: 'consumption'},
						{text: 'Stock Available', align:'center', width: '17%',name: 'stockavail'},
							 ]
            });
            
            $("#overlay, #PleaseWait").hide();  

        });
 
</script>

<div id="procurementSubGrid"></div>
<input type="hidden" id="rowindex">
 
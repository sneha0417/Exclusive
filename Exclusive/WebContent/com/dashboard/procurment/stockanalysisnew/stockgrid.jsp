<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.stockanalysis.ClsStockanalysisDAO" %>
<%   
	String hidbrand = request.getParameter("hidbrand")==null?"0":request.getParameter("hidbrand").trim();
	String hidtype = request.getParameter("hidtype")==null?"0":request.getParameter("hidtype").trim();
	String hidproduct = request.getParameter("hidproduct")==null?"0":request.getParameter("hidproduct").trim();
	String hidcat = request.getParameter("hidcat")==null?"0":request.getParameter("hidcat").trim();
	String hidsubcat = request.getParameter("hidsubcat")==null?"0":request.getParameter("hidsubcat").trim();
	String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
	String hidept = request.getParameter("hidept")==null?"0":request.getParameter("hidept").trim();
	String fromDate = request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").trim();
	String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
	
	
	
//	System.out.println("23467890=-rwqw6789=-6wAWE===========hidproduct========"+hidproduct);
	
	String hidlocid = request.getParameter("hidlocid")==null?"0":request.getParameter("hidlocid").trim();

	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
	
	String prodgroupby = request.getParameter("prodgroupby")==null?"0":request.getParameter("prodgroupby").trim();
	
	
	
	
	
	ClsStockanalysisDAO dao= new ClsStockanalysisDAO();
%>
<style type="text/css">
 
 
  

 .sl
  {
      background-color:#FCEFCE;
  }
  
 .prd
  {
      background-color:#ffe0cc;
  }
  
 .pr
  {
      background-color:#EBEBC1;
  }
  
    
   .advanceClass5
  {
      background-color: #FCC4F7;
  }
   .advanceClass4
  {
       background-color: #efd4f7;
  }
   .advanceClass3
  {
     
      background-color: #C4F3F5        ;
  }
   .advanceClass2
  {
      background-color:/*  #bed9f4; */ #CFECF1    ;  
  }
   .advanceClass1
  {
      background-color:   #eff4be;  ;
  }
   .advanceClass
  {
      background-color: #FBEFF5;
  }
  .balanceClass
  {
      background-color: #E0F8F1;
  }
  .unappliedClass
  {
     color: #FF0000;
  }     
</style>
<script type="text/javascript">
    
       var partdata;
       var type='<%=type%>';
    	
	  	if(type=='1'){ 
	  		<%-- dat1='<%=dao.stockLedgerSummary1(session,hidbrand,fromDate,toDate,hidtype,hidcat,hidsubcat,hidproduct,branchid,hidept,load,prodgroupby,hidlocid)%>';   --%>
	  		partdata='<%=dao.stockLedgeralabar(session,hidbrand,fromDate,toDate,hidtype,hidcat,hidsubcat,hidproduct,branchid,hidept,load,prodgroupby,hidlocid)%>';  
	  	} 
		else{
		partdata;
	}

$(document).ready(function () {
    // prepare the data
	  var rendererstring1=function (aggregates){
       	var value=aggregates['sum1'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
       }    
    
 var rendererstring=function (aggregates){
 	var value=aggregates['sum'];
	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	   {
		value=0.0;
	   }
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
    
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                   
                  
                     
                        {name : 'code', type: 'String'  },
                        {name : 'description', type: 'String'  },
                        {name : 'opening_qty', type: 'number'  },
                        {name : 'opening_value', type: 'number'  },
						{name : 'stock_qty', type: 'number'  },
						{name : 'stock_value', type: 'number'  },
						{name : 'issue_qty', type: 'number'  },
						{name : 'issue_value', type: 'number'  },
						{name : 'bal_qty', type: 'number'  },
						{name : 'balval', type: 'number'  },
						{name : 'bal_value', type: 'number'  },
						{name : 'costperunit', type: 'number'  },
						{name : 'psrno', type: 'String'},
						{name : 'specid', type: 'String'},
						
						
						],
				    localdata: partdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
    	
		/*  if (data.isqty !=0) {
            return "yellowClass";
        }else{
        	return "orangeClass";
        }; */
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#partSearchgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 25,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%' , pinned: true,cellclassname:'advanceClass1',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                      }, 
                    { text: 'Branch', datafield: 'branch',  width: '10%',hidden:true },
           	         { text: ' CODE', datafield: 'code',pinned: true,  width: '12%'  ,cellclassname:'advanceClass'}, 
					 { text: 'DESCRIPTION', datafield: 'description',pinned: true,  width: '30%',cellclassname:'advanceClass' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
					 { text: 'QUANTITY',datafield: 'opening_qty', width: '8%', cellsformat: 'd2',columngroup:'opening'  ,cellclassname:'balanceClass' },
					 { text: 'VALUE',datafield: 'opening_value', width: '9%', cellsformat: 'd2',columngroup:'opening' ,cellsalign: 'right', align:'right' ,cellclassname:'balanceClass' ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
					 { text: 'QUANTITY',datafield: 'stock_qty', width: '8%', cellsformat: 'd2',columngroup:'in' ,cellclassname:'advanceClass4'  },
					 { text: 'VALUE',datafield: 'stock_value', width: '9%', cellsformat: 'd2',columngroup:'in' ,cellsalign: 'right', align:'right' ,cellclassname:'advanceClass4' ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
				     { text: 'QUANTITY',datafield: 'issue_qty', width: '8%', cellsformat: 'd2',columngroup:'issued' ,cellclassname:'sl'  },
				     { text: 'VALUE',datafield: 'issue_value', width: '9%', cellsformat: 'd2',columngroup:'issued',cellsalign: 'right', align:'right' ,cellclassname:'sl' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 { text: 'QUANTITY', datafield: 'bal_qty', width: '8%', cellsformat: 'd2',columngroup:'balance'  ,cellclassname:'advanceClass3'  },
					 { text: 'VALUE', datafield: 'bal_value', width: '9%', cellsformat: 'd2',columngroup:'balance',cellsalign: 'right', align:'right' ,cellclassname:'advanceClass3' ,aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					 { text: 'COST PER UNIT', datafield: 'costperunit', width: '8%', cellsformat: 'd2' ,cellsalign: 'right', align:'right' ,cellclassname:'advanceClass5'},
					 { text: 'psrno', datafield: 'psrno', width: '10%',hidden:true},
					
					], columngroups: 
	                     [
	                       { text: 'OPENING STOCK', align: 'center', name: 'opening',width: '20%' },
	                       { text: 'IN STOCK', align: 'center', name: 'in',width: '20%' },
	                       { text: 'ISSUED STOCK', align: 'center', name: 'issued',width: '20%' },
	                       { text: 'BALANCE STOCK', align: 'center', name: 'balance',width: '20%' }
	                     ]
   
    });

    $("#overlay, #PleaseWait").hide();
});


</script>
<div id="partSearchgrid"></div>
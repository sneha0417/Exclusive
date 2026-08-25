<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.stockLedger.ClsStockLedger" %>
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
	
	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
	
	System.out.println("====load======"+load);
	ClsStockLedger dao= new ClsStockLedger();
%>
<style type="text/css">

 .op
  {
      background-color:#FCEFCE;
  }
  
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .greyClass
    {
        background-color: #e6e6e6;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
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
    .balanceClass
  {
      background-color: #E0F8F1;
  }
    
</style>
<script type="text/javascript">
    
       var detdata;
       var type='<%=type%>';
 
	  	if(type=='2'){ 
	  		 dat2='<%=dao.stockLedgerDetail2(session,hidbrand,fromDate,toDate,hidtype,hidcat,hidsubcat,hidproduct,branchid,hidept,load)%>';  
	  		detdata='<%=dao.stockLedgerDetail(session,hidbrand,fromDate,toDate,hidtype,hidcat,hidsubcat,hidproduct,branchid,hidept,load)%>';  
	  	} 
		else{
			detdata;
	}

$(document).ready(function () {
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
     var rendererstring2=function (aggregates){
	 	var value=aggregates['sum'];
		if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
		   {
			value=0.0;
		   }
	 	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	 }
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     
                  
                     
                        {name : 'pno', type: 'String'  },
                        {name : 'pname', type: 'String'  },
                        {name : 'date', type: 'String'  },
                        {name : 'docno', type: 'String'  },
                        {name : 'trans_type', type: 'String'  },
                        {name : 'opnqty', type: 'number'  },
                        {name : 'opnval', type: 'number'  },
						{name : 'inqty', type: 'number'  },
						{name : 'inval', type: 'number'  },
						{name : 'isqty', type: 'number'  },
						{name : 'isval', type: 'number'  },
						{name : 'balqty', type: 'number'  },
						{name : 'balval', type: 'number'  },
						{name : 'stv', type: 'number'  },
						{name : 'cpu', type: 'number'  },
						{name : 'cpu', type: 'number'  },
						{name : 'sl', type: 'String'},
						{name : 'specid', type: 'String'},
						{name : 'trtype', type: 'String'},
						{name : 'desc1', type: 'String'},
						
						
						],
				    localdata: detdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
    	
		 if (data.trtype=='in') {
            return "advanceClass4";
        }
		 else if(data.trtype=='OP')
			 {
			 return "op";
			 }
		 else
			 {
			 return "balanceClass";
			 }
		 
		 
		 ;
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#jqxStockDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        pagermode: 'default',
        editable:false,
        columns: [   
                   { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false, pinned: true,
                      datafield: 'sl', columntype: 'number', width: '4%', cellclassname: cellclassname,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    } ,
                     
                     { text: 'Branch', datafield: 'branch',  width: '10%',hidden:true }, 
           	         { text: 'DATE', datafield: 'date',  width: '6%', pinned: true, cellclassname: cellclassname }, 
           	         { text: 'TYPE', datafield: 'trans_type',  width: '4%', pinned: true, cellclassname: cellclassname},
					 { text: 'DOCNO', datafield: 'docno',  width: '8%', pinned: true, cellclassname: cellclassname},
					 { text: 'CLIENT/VENDOR', datafield: 'desc1', pinned: true,  width: '22%', cellclassname: cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
				/* 	 { text: 'QUANTITY',datafield: 'opnqty', width: '8%', cellsformat: 'd2',columngroup:'opening', cellclassname: cellclassname},
					 { text: 'VALUE',datafield: 'opnval', width: '9%', cellsformat: 'd2',columngroup:'opening' ,cellsalign: 'right', align:'right' , cellclassname: cellclassname ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
					 */ { text: 'QUANTITY',datafield: 'inqty', width: '8%' , cellsformat: 'd2',columngroup:'in', cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring2  },
					 { text: 'VALUE',datafield: 'inval', width: '8%', cellsalign: 'right', cellsformat: 'd2',columngroup:'in', cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring },
				     { text: 'QUANTITY',datafield: 'isqty', width: '8%',   cellsformat: 'd2',columngroup:'issued', cellclassname: cellclassname ,aggregates: ['sum'],aggregatesrenderer:rendererstring2 },
				     { text: 'VALUE',datafield: 'isval', width: '8%', cellsalign: 'right', cellsformat: 'd2',columngroup:'issued', cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 { text: 'QUANTITY', datafield: 'balqty', width: '8%',  cellsformat: 'd2',columngroup:'balance', cellclassname: cellclassname ,aggregates: ['sum'],aggregatesrenderer:rendererstring2 },
					 { text: 'VALUE', datafield: 'balval', width: '8%', cellsalign: 'right', cellsformat: 'd2',columngroup:'balance', cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					 { text: 'COST PER UNIT', datafield: 'cpu', cellsalign: 'right', width: '8%', cellsformat: 'd2', cellclassname: cellclassname},
					 { text: 'psrno', datafield: 'psrno', width: '10%',hidden:true},
					 { text: 'trtype', datafield: 'trtype', width: '10%',hidden:true},
					
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
<div id="jqxStockDetailGrid"></div>
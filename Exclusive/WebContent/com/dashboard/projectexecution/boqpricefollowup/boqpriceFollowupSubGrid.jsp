<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
  <%@page import="com.dashboard.projectexecution.boqpricefollowup.ClsBoqpriceFollowupDAO"%>
<%
ClsBoqpriceFollowupDAO sd=new ClsBoqpriceFollowupDAO();
%>
<%
String psrno=request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();

int loadid =request.getParameter("loadid")==null?0:Integer.parseInt(request.getParameter("loadid").trim());
%>

<script type="text/javascript">
var matdata;
$(document).ready(function () {
  
   var loadid=parseInt('<%=loadid%>');
 if(loadid==1){
	  
	   matdata='<%=sd.BoQSubGridLoad(session,psrno)%>';
   }
	 
 
 var rendererstring2=function (aggregates){
  	var value=aggregates['sum2'];
  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
  }    



	  var rendererstring1=function (aggregates){
    	var value=aggregates['sum1'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
    }
	  
	
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
}
            	 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'voc_no', type: 'string'  },
							{name : 'date', type: 'date' },
							{name : 'refname', type: 'string'  },
     						{name : 'productid', type: 'string' },
     						{name : 'productname', type: 'string'},
     						{name : 'brandname', type: 'string'    },
     						{name : 'unit', type: 'string'  },
     						{name : 'qty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'nettotal', type: 'number'  },
     						
     						
     						
                        ],
                        
                        
                       
                         localdata: matdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            		
            };
            	
            		
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#boqsubGrid").jqxGrid(
            {
                width: '99%',
                height: 180,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: false,
              
                statusbarheight: 20,
                selectionmode: 'singlerow',
                pagermode: 'default',
    
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'RFQ No', datafield: 'voc_no', width: '8%' },
							{text: 'date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Vendor Name', datafield: 'refname', width: '16%' },
							{ text: 'Product', datafield: 'productid', width: '7%'},  
  					
                            { text: 'Product Name', datafield: 'productname', width: '14%'  },
                            {text: 'brandname', datafield: 'brandname', width: '11%'},
							{ text: 'Unit', datafield: 'unit', width: '7%' },	
							{ text: 'Quantity', datafield: 'qty', width: '6%' },
							{ text: 'Amount', datafield: 'amount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Net Total', datafield: 'nettotal', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }
							
						]
            });
            
                                 
         
        });
</script>

   <div id="boqsubGrid"></div>
  

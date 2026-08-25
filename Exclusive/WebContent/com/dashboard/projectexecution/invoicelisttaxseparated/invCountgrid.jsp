<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.invoicelisttaxseparated.ClsInvoiceListDAO"%>
<%
ClsInvoiceListDAO DAO=new ClsInvoiceListDAO(); 
 String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();%>
 <% String frmdate =request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% String contract =request.getParameter("contract")==null?"0":request.getParameter("contract").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
 
<script type="text/javascript">
	
	 var invdata;
		 invdata= '<%=DAO.invCountgrid(session,date,branch,clientid,id,contract,frmdate)%>'; 
		 
$(document).ready(function () {
	
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	
     	if(typeof(value)=='undefined'){
     		value=0;
     	}
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
     }

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'dtype', type: 'string'  },
					{name : 'count', type: 'string'  }
						
						],
				    localdata: invdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#jqxInvCount").jqxGrid(
    {
        width: '100%',
        height: 120,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: '', datafield: 'dtype', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						
						
					]
    
    });
   
    $('#jqxInvCount').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var rowindex = event.args.rowindex;
    		    
    		    var clientid=$('#clientid').val();
    			 var date=$('#todate').val();
    			 var fmdate=$('#frmdate').val();
    			 var barchval = document.getElementById("cmbbranch").value;
    		     var dtype=$('#jqxInvCount').jqxGrid('getcellvalue', rowindex, "dtype");
    		     var id=1;
    		     var contract=document.getElementById("txtcontract").value;

    		    $("#overlay, #PleaseWait").show();
    		 
    		var id=1;
    		
    		 $("#profinvdiv").load("serviceCompletionGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&type="+dtype+"&contract="+contract+"&fmdate="+fmdate);
    				  
    				
    		});
});

function toDate(dateStr) {
    var parts = dateStr.split("-");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}
	
</script>
<div id="jqxInvCount"></div>
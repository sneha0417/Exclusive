<%@page import="com.dashboard.projectexecution.serviceCompletion.ClsServiceCompletionDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsServiceCompletionDAO sd=new ClsServiceCompletionDAO(); %>


 <% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
 <% int isradio =request.getParameter("isradio")==null?0:Integer.parseInt(request.getParameter("isradio").toString());%>
 
<script type="text/javascript">
	
	 var invdata;
	 var id='<%= id%>';
	 if(id==1){
		 invdata= '<%=sd.invCountgrid(session,date,branch,clientid,id,isradio)%>'; 
	 }
	 else{
		 invdata; 
	 }
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
					{name : 'count', type: 'string'  },
					{name : 'type', type: 'string'  }
						
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
						{ text: 'type', datafield: 'type', width: '30%',hidden:true},
						
					]
    
    });
    
    $("#overlay, #PleaseWait").hide();
    $('#jqxInvCount').on('rowdoubleclick', function (event) 
    		{ 
    	
    		     var rowindex = event.args.rowindex;
    		    
    		     var clientid=$('#clientid').val();
    			 var date=$('#todate').val();
    			 var barchval = document.getElementById("cmbbranch").value;
    		     var dtype=$('#jqxInvCount').jqxGrid('getcellvalue', rowindex, "dtype");
    		     var type=$('#jqxInvCount').jqxGrid('getcellvalue', rowindex, "type");
    		     var id=1;
    		     
    		     $("#jqxpinvGrid").jqxGrid('clear'); 
 				$("#jqxpinvDetGrid").jqxGrid('clear');
 				$("#jqxpsrvDetGrid").jqxGrid('clear'); 
 				hidcolumn(0);
 				$("#test").hide();
    		    $("#overlay, #PleaseWait").show();
    		    var isradio =document.getElementById("isradio").value;
    		 
    		var id=1;
    		
    		 $("#profinvdiv").load("serviceCompletionGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&type="+type+"&isradio="+isradio);
    				  
    				
    		});
    
});

function toDate(dateStr) {
    var parts = dateStr.split("-");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}
	
</script>
<div id="jqxInvCount"></div>
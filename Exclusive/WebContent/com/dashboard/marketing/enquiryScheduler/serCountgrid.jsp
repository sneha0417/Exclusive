<%@page import="com.dashboard.projectexecution.serviceScheduler.ServiceSchedulerDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ServiceSchedulerDAO sd=new ServiceSchedulerDAO(); %>


 <% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% String site =request.getParameter("site")==null?"0":request.getParameter("site").toString();%>
 <% String area =request.getParameter("area")==null?"0":request.getParameter("area").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
 <% int priority =request.getParameter("isprior")==null?0:Integer.parseInt(request.getParameter("isprior").toString());%>
 
<script type="text/javascript">
	
	 var schedata;
		 schedata= '<%=sd.serCountgrid(session,date,branch,clientid,id,priority,site,area)%>'; 

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
				    localdata: schedata,
        
        
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
    
    
    $("#jqxSerCount").jqxGrid(
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
   
    $('#jqxSerCount').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var rowindex = event.args.rowindex;
    		    
    		    var clientid=$('#clientid').val();
    			 var date=$('#todate').val();
    			 var barchval = document.getElementById("cmbbranch").value;
    			 var site=document.getElementById("txtsite").value;
    			 site=site.replace(' ', '%20').replace(' ', '%20').replace(' ', '%20');
    		     var dtype=$('#jqxSerCount').jqxGrid('getcellvalue', rowindex, "dtype");
    		     if(dtype=='CREG'){
    		    	 
    		    	 $('#jqxloaddataGrid').jqxGrid('showcolumn','dates');
    		    	 $('#jqxloaddataGrid').jqxGrid('hidecolumn','validupto');
    		     }
    		     else{
    		    	 $('#jqxloaddataGrid').jqxGrid('hidecolumn','dates');
    		    	 $('#jqxloaddataGrid').jqxGrid('showcolumn','validupto');
    		     }
    		     var id=1;
    		    $("#overlay, #PleaseWait").show();
    		   var isprior=document.getElementById("isprior").value;
    		   var area=document.getElementById("txtareaid").value;
    		    
    		$("#overlay, #PleaseWait").show();
    		var id=1;
    		$("#serschedulediv").load("serScheduleDetails.jsp?clientid="+clientid+"&date="+date+"&barchval="+barchval+"&dtype="+dtype+"&id="+id+"&isprior="+isprior+"&site="+site+"&area="+area);
    				  
    				
    		});
});

function toDate(dateStr) {
    var parts = dateStr.split("-");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}
	
</script>
<div id="jqxSerCount"></div>
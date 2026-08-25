<%@page import="com.dashboard.project.projectstatus.projectstatusDAO" %>
<%
	projectstatusDAO sd=new projectstatusDAO();
%>


 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null||request.getParameter("clientid")==""?"0":request.getParameter("clientid").toString();%>
 <% String asgngrpid =request.getParameter("asgngrpid")==null||request.getParameter("asgngrpid")==""?"0":request.getParameter("asgngrpid").toString();
 %>
 
<script type="text/javascript">
	
	 var satdata;
	 var bb='<%=rds%>';
	if(bb!='0'){
		satdata= '<%=sd.getStatusCount(fromdate,todate,rds,barchval,clientid,asgngrpid)%>';
	}
	else{
		bb=1;
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
                    
                 	{name : 'stat', type: 'string'  },
                 		{name : 'val', type: 'string'  },
                 		{name : 'rds', type: 'string'  }
						
						],
				    localdata: satdata,
        
        
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
    
    
    $("#jqxCount").jqxGrid(
    {
        width: '100%',
        height: 250,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'stat', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						
						{ text: 'Count', datafield: 'val', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'relodestatus', datafield: 'rds', width: '30%',hidden:true},
						
					]
    
    });
    if(bb==1)
	{
	 $("#jqxCount").jqxGrid('addrow', null, {});
	}
    $('#jqxCount').on('rowdoubleclick', function (event) 
    		{ 
    	

	    var boundIndex = event.args.rowindex;    
	    

	    $("#overlay, #PleaseWait").show();
	    var relodestatus = $('#jqxCount').jqxGrid('getcelltext',boundIndex, "rds");

	    $("#loadgriddata").load("gridDetails.jsp?rds="+relodestatus+"&froms="+'<%=fromdate%>'+"&tos="+'<%=todate%>'+"&barchval="+'<%=barchval%>'+"&dtype="+'<%=rds%>'+'&clientid='+'<%=clientid%>'+'&asgngrpid='+'<%=asgngrpid%>');
    	
    		    

    		});
});


	
</script>
<div id="jqxCount"></div>
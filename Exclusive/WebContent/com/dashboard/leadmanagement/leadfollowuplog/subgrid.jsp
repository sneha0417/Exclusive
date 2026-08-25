
<%@ page import="com.dashboard.leadmanagement.leadfollowuplog.ClsLeadFollowupLogDAO" %>
 <%
 	String test = request.getParameter("test")==null?"NA":request.getParameter("test").trim();
 	String fromdate = request.getParameter("from")==null?"0":request.getParameter("from").trim();
   	String todate = request.getParameter("to")==null?"0":request.getParameter("to").trim();
   	
   	
   	ClsLeadFollowupLogDAO cfld=new ClsLeadFollowupLogDAO();
 %> 
<script type="text/javascript">
	var temp1='<%=test%>';
	 var vehdatas;
	 var bb;
	if(temp1!='NA')
{
		vehdatas= '<%=cfld.subDetails(fromdate,todate) %>';
		
		bb=0;
}
	else{
		vehdatas;
		 bb=1;
	}
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
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
                    
                 
						{name : 'user', type: 'string'  },
						{name : 'count', type: 'string'  },
						{name : 'userid', type: 'string'  }
						
						],
				    localdata: vehdatas,
        
        
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
    
    
    $("#userdetails").jqxGrid(
    {
        width: '92%',
        height: 200,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'User', datafield: 'user', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Userid', datafield: 'userid', width: '30%',hidden:true},
					
						//relodestatus
					]
    
    });
    if(bb==1)
	{
	 $("#userdetails").jqxGrid('addrow', null, {});
	}
    $('#userdetails').on('rowdoubleclick', function (event) 
    		{ 
    	
    	
    		
    		    var boundIndex = event.args.rowindex;
    		    
   
    		    $("#overlay, #PleaseWait").show();
    		    var userid = $('#userdetails').jqxGrid('getcelltext',boundIndex, "userid");
    		    document.getElementById("user").innerText=$('#userdetails').jqxGrid('getcelltext', boundIndex, "user");
    		    $("#fleetdiv").load("detailsgrid.jsp?userid="+userid+"&froms="+'<%=fromdate%>'+"&tos="+'<%=todate%>');
    	 
    		});
});

	
	
</script>
<div id="userdetails"></div>
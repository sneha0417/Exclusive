<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.aviation.fuelstatus.ClsFuelStatusDAO"%>
<%
ClsFuelStatusDAO sd=new ClsFuelStatusDAO();
%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% String portid =request.getParameter("portid")==null?"0":request.getParameter("portid").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString(); %>
<% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString(); %>
 
 <style type="text/css">
.vioClass {
	/* background-color: #FECBE6; */
	background-color: #D8D8FF;
}
</style> 
<script type="text/javascript">

var data1;
var id='<%= id%>';
if(id>0){
	 data1= '<%=sd.serCountgrid(session,clientid,portid,id,fromdate,todate)%>'; 
}else{
	data1;
}


$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	
     	if(typeof(value)=='undefined'){
     		value=0;
     	}
     	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:10px; overflow: hidden;">' + " Total" + '</div>';
     }
     	
			
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'name', type: 'string'  },
					{name : 'dtype', type: 'string'  },
                 	{name : 'value', type: 'string'  }	
						],
				    localdata: data1,
        
        
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
        height: 175,
        source: dataAdapter,
        rowsheight:16,
        showaggregates:true,
        showstatusbar:false,
        statusbarheight: 17,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'name', width: '70%' ,aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'value', width: '30%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Dtype', datafield: 'dtype', hidden: true,width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					]
    
    });
   
    $('#jqxSerCount').on('rowdoubleclick', function (event) 
    		{ 
    	
    		     var rowindex = event.args.rowindex;
    		     var sortby = document.getElementById("cmbsortby").value;
    		     var clientid = document.getElementById("clientid").value;
    		     var portid = document.getElementById("portid").value;
    		     var dtype=$('#jqxSerCount').jqxGrid('getcellvalue', rowindex, "dtype");
    		     var id=1;
    		     $("#overlay, #PleaseWait").show();
    		     $("#listdiv").load("fsGrid.jsp?id="+id+"&dtype="+dtype+"&sortby="+sortby+"&clientid="+clientid+"&portid="+portid);
    				
    		});
});
</script>
<div id="jqxSerCount"></div>
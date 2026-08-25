<%@page import="com.dashboard.analysis.amcincomeexpense.ClsAmcIncomeExpense" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsAmcIncomeExpense sd=new ClsAmcIncomeExpense(); %>

 <% String radval =request.getParameter("radval")==null?"0":request.getParameter("radval").toString();%>
 <% String frmdate =request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% String reftype =request.getParameter("reftype")==null?"0":request.getParameter("reftype").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
 
<script type="text/javascript">
	
	 var schedata;
		 schedata= '<%=sd.countgrid(session,frmdate,todate,branch,clientid,id,radval,reftype)%>'; 

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
					{name : 'desc1', type: 'string' },
					{name : 'jbaction', type: 'string' }
						
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
    
    
    $("#jqxCount").jqxGrid(
    {
        width: '100%',
        height: 180,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: '', datafield: 'desc1', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'dtype', datafield: 'dtype',hidden:true, width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'jbaction', datafield: 'jbaction',hidden:true, width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						
					]
    
    });
   
    $('#jqxCount').on('rowdoubleclick', function (event) 
    		{ 
    	
    		     var rowindex = event.args.rowindex;
    		     var radval=$('#radval').val().trim();
    			 var clientid=$('#clientid').val();
    			 var frmdate=$('#fromdate').val();
    			 var todate=$('#todate').val();
    			 var barchval = document.getElementById("cmbbranch").value;
    		     var id=1;
    		     var dtype=$('#jqxCount').jqxGrid('getcellvalue', rowindex, "dtype");
    		     var jbaction=$('#jqxCount').jqxGrid('getcellvalue', rowindex, "jbaction");
    		     
    		    $("#overlay, #PleaseWait").show();
    		var id=1;
    		$("#incexpdiv").load("amcincomeexpenseDetails.jsp?clientid="+clientid+"&frmdate="+frmdate+"&todate="+todate+"&barchval="+barchval+"&id="+id+"&radval="+radval+"&dtype="+dtype+"&jbaction="+jbaction);
    				  
    				
    		});
});

function toDate(dateStr) {
    var parts = dateStr.split("-");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}
	
</script>
<div id="jqxCount"></div>
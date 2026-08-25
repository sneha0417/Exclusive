<%@page import="com.dashboard.projectexecution.serviceclose.ServiceCloseDAO"%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% ServiceCloseDAO DAO= new ServiceCloseDAO(); %>

 <%

 String contracttype = request.getParameter("contracttype")==null?"0":request.getParameter("contracttype");
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
 String refno = request.getParameter("refno")==null?"0":request.getParameter("refno"); 
 String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno"); 
 String todate = request.getParameter("date")==null?"0":request.getParameter("date");
 String frmdate = request.getParameter("frmdate")==null?"0":request.getParameter("frmdate");
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
 String branch =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();
 %>
 
<script type="text/javascript">

var schedata;
		 schedata= '<%=DAO.serCountgrid(session,cldocno, contracttype,refno,contractno,frmdate,todate,id,branch)%>'; 

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
                    {name : 'status', type: 'string'  },
                 	{name : 'statuss', type: 'string'  },
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
        height: 200,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'stat', datafield: 'status', width: '10%',hidden:true },                  
						{ text: '', datafield: 'statuss', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						
					]
    
    });
   
    $('#jqxSerCount').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var rowindex = event.args.rowindex;
    		    
    		    var date=$('#todate').val();
    			 var frmdate=$('#frmdate').val();
    			 
    			 var contractType=document.getElementById("cmbreftype").value;
    		 	 var cldocno=document.getElementById("clientid").value;
    		 	 var contractno=document.getElementById("txtcontract").value;
    			 var barchval = document.getElementById("cmbbranch").value;
    		     var status=$('#jqxSerCount').jqxGrid("getcellvalue", rowindex, "status");
    		   
    		     var id=1;
    		    $("#overlay, #PleaseWait").show();
    		
    		$("#serschedulediv").load('servicecloseDetails.jsp?contracttype='+contractType+'&cldocno='+cldocno+'&contractno='+contractno+'&date='+date+'&frmdate='+frmdate+'&id='+id+'&barchval='+barchval+'&status='+status);
    		if(status==6){
    			$("#btnid").hide();
    		}
    		else{
    			$("#btnid").show();
    		}
    				
    		});
});

function toDate(dateStr) {
    var parts = dateStr.split("-");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}
	
</script>
<div id="jqxSerCount"></div>
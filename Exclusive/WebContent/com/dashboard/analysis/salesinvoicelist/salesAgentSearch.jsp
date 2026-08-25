<%@page import="com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO" %>
<% ClsSalesInvoiceDAO csd=new ClsSalesInvoiceDAO();%>

<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var salesagentdata;
   if(id=='1'){
	   salesagentdata='<%=csd.getSalesAgent()%>';
	
}
else{
	salesagentdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'sal_name',type:'String'},
                  		
                  		
                  		],
				    localdata: salesagentdata,
        
        
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
    
    
    $("#salesAgentSearch").jqxGrid(
    {
        width: '100%',
        height: 310,
        source: dataAdapter,
        showaggregates:true,
        //filtermode:'excel',
        showfilterrow:true,
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No', filtertype:'number',datafield:'doc_no',width:'20%'},
       				{ text:'Name',filtertype:'input',columntype:'textbox',datafield:'sal_name',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
   
    $( "#btnok_salesman" ).click(function() {
    	var rows = $("#salesAgentSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Salesman";
        		document.getElementById("salesman").value="Salesman";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nSalesman";
        		document.getElementById("salesman").value+="\nSalesman";
        	}		
    	}
    
    	
    	document.getElementById("hidsalesman").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#salesAgentSearch').jqxGrid('getcellvalue',rows[i],'sal_name');
    		var docno=$('#salesAgentSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("salesman").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidsalesman").value=docno;
    		}
    		else{
    			document.getElementById("hidsalesman").value+=","+docno;
    		}
    	}
    	$('#salesagentwindow').jqxWindow('close');
    	});
    
    $( "#btncancel_salesman" ).click(function() {
    	$('#salesagentwindow').jqxWindow('close');
    	});
    
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_salesman" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_salesman" name="btncancel" class="myButton" >Cancel</button></div>
<div id="salesAgentSearch"></div>
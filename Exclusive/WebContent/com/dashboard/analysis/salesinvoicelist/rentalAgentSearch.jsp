<%@page import="com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO" %>
<% ClsSalesInvoiceDAO csd=new ClsSalesInvoiceDAO();%>

<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var rentalagentdata;
   if(id=='1'){
	   rentalagentdata='<%=csd.getRentalAgent()%>';
	
}
else{
	rentalagentdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'sal_name',type:'String'},
                  		
                  		
                  		],
				    localdata: rentalagentdata,
        
        
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
    
    
    $("#rentalAgentSearch").jqxGrid(
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
       				{ text:'Name',filtertype:'input',columntype:'textbox',datafield:'sal_name',width:'80%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $('#rentalAgentSearch').on('rowdoubleclick', function (event) 
    		{
    		   var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;   
    		    
    		    
    		    document.getElementById("hidrentalagent").value=$('#rentalAgentSearch').jqxGrid('getcellvalue',rowBoundIndex, "doc_no");
    		    document.getElementById("rentalagent").value=$('#rentalAgentSearch').jqxGrid('getcellvalue',rowBoundIndex, "sal_name");
    		    $('#rentalagentwindow').jqxWindow('close');
    		});

    $( "#btnok_rentalagent" ).click(function() {
    	var rows = $("#rentalAgentSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Rental Agent";	
        		document.getElementById("rentalagent").value="Rental Agent";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nRental Agent";
        		document.getElementById("rentalagent").value+="\nRental Agent";
        	}	
    	}
    	
    	
    	document.getElementById("hidrentalagent").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#rentalAgentSearch').jqxGrid('getcellvalue',rows[i],'sal_name');
    		var docno=$('#rentalAgentSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("rentalagent").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidrentalagent").value=docno;
    		}
    		else{
    			document.getElementById("hidrentalagent").value+=","+docno;
    		}
    	}
    	$('#rentalagentwindow').jqxWindow('close');
    	});
    
    $( "#btncancel_rentalagent" ).click(function() {
    	$('#rentalagentwindow').jqxWindow('close');
    	});
   
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_rentalagent" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_rentalagent" name="btncancel" class="myButton" >Cancel</button></div>
<div id="rentalAgentSearch"></div>
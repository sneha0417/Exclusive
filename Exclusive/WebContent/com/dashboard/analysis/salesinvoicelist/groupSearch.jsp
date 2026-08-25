<%@page import="com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO" %>
<% ClsSalesInvoiceDAO csd=new ClsSalesInvoiceDAO();%>

<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var groupdata;
   if(id=='1'){
	   groupdata='<%=csd.getGroup()%>';
	
}
else{
	groupdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'gname',type:'String'},
                  		
                  		
                  		],
				    localdata: groupdata,
        
        
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
    
    
    $("#groupSearch").jqxGrid(
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
       				{ text:'Group',filtertype:'input',columntype:'textbox',datafield:'gname',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnok_group" ).click(function() {
    	var rows = $("#groupSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Group";	
        		document.getElementById("group").value="Group";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nGroup";
        		document.getElementById("group").value+="\nGroup";
        	}
    	}
    
    	
    	document.getElementById("hidgroup").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#groupSearch').jqxGrid('getcellvalue',rows[i],'gname');
    		var docno=$('#groupSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("group").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidgroup").value=docno;
    		}
    		else{
    			document.getElementById("hidgroup").value+=","+docno;
    		}
    	}
    	$('#groupwindow').jqxWindow('close');
    	});
    
    $( "#btncancel_group" ).click(function() {
    	$('#groupwindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_group" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_group" name="btncancel" class="myButton" >Cancel</button></div>
<div id="groupSearch"></div>
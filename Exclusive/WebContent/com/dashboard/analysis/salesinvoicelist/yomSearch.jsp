<%@page import="com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO" %>
<% ClsSalesInvoiceDAO csd=new ClsSalesInvoiceDAO();%>

<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var yomdata;
   if(id=='1'){
	   yomdata='<%=csd.getYom()%>';
	
}
else{
	yomdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'yom',type:'String'},
                  		
                  		
                  		],
				    localdata: yomdata,
        
        
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
    
    
    $("#yomSearch").jqxGrid(
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
       				{ text:'Yom',filtertype:'input',columntype:'textbox',datafield:'yom',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $('#yomSearch').on('rowdoubleclick', function (event) 
    		{
    		   var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
   
    		    document.getElementById("hidyom").value=$('#yomSearch').jqxGrid('getcellvalue',rowBoundIndex, "doc_no");
    		    document.getElementById("yom").value=$('#yomSearch').jqxGrid('getcellvalue',rowBoundIndex, "yom");
    		    $('#yomwindow').jqxWindow('close');
    		});
    $( "#btnok_yom" ).click(function() {
    	var rows = $("#yomSearch").jqxGrid('selectedrowindexes');
    	/* document.getElementById("searchdetails").style.fontWeight='bold'; */
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="YOM";	
        		document.getElementById("yom").value="YOM";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nYOM";
        		document.getElementById("yom").value+="\nYOM";
        	}	
    	}
    	
    	/* var html = $('#searchdetails').html();
    	$('#searchdetails').html(html.replace('YOM', '<strong>$&</strong>'));
    	 */
    	document.getElementById("hidyom").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#yomSearch').jqxGrid('getcellvalue',rows[i],'yom');
    		var docno=$('#yomSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("yom").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidyom").value=docno;
    		}
    		else{
    			document.getElementById("hidyom").value+=","+docno;
    		}
    	}
    	$('#yomwindow').jqxWindow('close');
    	});
    
    $( "#btncancel_yom" ).click(function() {
    	$('#yomwindow').jqxWindow('close');
    	});
});

</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_yom" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_yom" name="btncancel" class="myButton" >Cancel</button></div>
<div id="yomSearch"></div>
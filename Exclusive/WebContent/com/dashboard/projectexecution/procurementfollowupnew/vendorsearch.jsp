<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.procurementfollowupnew.ClsProcurementFollowupnewDAO"%>
<%ClsProcurementFollowupnewDAO DAO= new ClsProcurementFollowupnewDAO();%>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
 
   var catdata;
   catdata='<%=DAO.vendorSearch(session)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'cldocno',type:'number'},
                  		{name : 'acno',type:'number'},
                  		{name : 'refname',type:'String'},
                  		{name : 'account',type:'nuumber'},
                  		
                  		
                  		],
				    localdata: catdata,
        
        
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
    
    
    $("#vendorSearch").jqxGrid(
    {
        width: '100%',
        height: 310,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'CL_DOCNO',datafield:'cldocno',width:'20%',hidden:true},
       				{ text: 'Doc_No',datafield:'acno',width:'20%',hidden:true},
       				{ text:'Account',datafield:'account',width:'25%'},
       				{ text:'Vendor',datafield:'refname',width:'75%'}
       				
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
	
    $('#vendorSearch').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;

        document.getElementById("hidvendorcldocno").value = $('#vendorSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
    	document.getElementById("hidvendoracno").value = $('#vendorSearch').jqxGrid('getcellvalue', rowindex1, "acno");
    	document.getElementById("hidvendoraccount").value = $('#vendorSearch').jqxGrid('getcellvalue', rowindex1, "account");
    	document.getElementById("vendor").value = $('#vendorSearch').jqxGrid('getcellvalue', rowindex1, "refname");
    	// txttypeatype txttypetype
        $('#pvendorwindow').jqxWindow('close');  
    });  
});

	
	 
</script>
<!-- <div align="center" style="padding-bottom:4px;"><button type="button" id="btnvendor" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div> -->
<div id="vendorSearch"></div>
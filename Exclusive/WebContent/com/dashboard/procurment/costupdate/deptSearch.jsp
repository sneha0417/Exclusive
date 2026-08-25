<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.stockLedger.ClsStockLedger" %>
<%ClsStockLedger DAO= new ClsStockLedger();%>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
 
   var deptdata;
   deptdata='<%=DAO.deptSearch(session)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'dept',type:'String'},
                  		
                  		
                  		],
				    localdata: deptdata,
        
        
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
    
    
    $("#deptSearch").jqxGrid(
    {
        width: '100%',
        height: 310,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'20%'},
       				{ text:'Department',datafield:'dept',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btndept" ).click(function() {
    	
    	var rows = $("#deptSearch").jqxGrid('selectedrowindexes');
   
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="DEPARTMENT";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidept").value="DEPARTMENT";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nDEPARTMENT";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidept").value+="\nDEPARTMENT";
        	}	
    	}
    	
		document.getElementById("hideptid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#deptSearch').jqxGrid('getcellvalue',rows[i],'dept');
    		var docno=$('#deptSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidept").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hideptid").value=docno;
    		}
    		else{
    			document.getElementById("hideptid").value+=","+docno;
    		}
    	}
   	
    	
    	
    	$('#pdeptwindow').jqxWindow('close');
    	});
    
     $("#btncancel" ).click(function() {
    	$('#pdeptwindow').jqxWindow('close');
    	});
});

	
	 
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btndept" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="deptSearch"></div>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();%>
<%String submodelid=request.getParameter("submodelid");%>
<%String brandid=request.getParameter("brandid");%>
<%String modelid=request.getParameter("modelid");%>
<script type="text/javascript">
var uomrow='<%=request.getParameter("rowno") %>';
$(document).ready(function () {
  
   var spec2data;
  
	   spec2data='<%=DAO.suitSpec2Search(session,submodelid,brandid,modelid) %>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'spec',type:'String'},
                  		
                  		
                  		],
				    localdata: spec2data,
        
        
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
    
    
    $("#spec2Search").jqxGrid(
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
       				{ text:'BedSize',datafield:'spec',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnspec2" ).click(function() {
    	
    	var rows = $("#spec2Search").jqxGrid('selectedrowindexes');
   
    	
    	
		document.getElementById("hidspec2id").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#spec2Search').jqxGrid('getcellvalue',rows[i],'spec');
    		var docno=$('#spec2Search').jqxGrid('getcellvalue',rows[i],'doc_no');
    		
    		if(i==0){
    			document.getElementById("hidspec2id").value=docno;
    		}
    		else{
    			document.getElementById("hidspec2id").value+=","+docno;
    		}
    	}
   	
    	$("#SuitDiv").load("suitGrid.jsp?stype=2&spec1id="+document.getElementById("hidspec1id").value+"&spec2id="+document.getElementById("hidspec2id").value+"&spec3id="+document.getElementById("hidspec3id").value);
    	
    	$('#spec2searchwindow').jqxWindow('close');
    	});
    
     $("#btncancel" ).click(function() {
    	$('#spec2searchwindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnspec2" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="spec2Search"></div>
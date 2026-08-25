<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.partSearch.ClsPartSearchDAO"%>
<%ClsPartSearchDAO DAO= new ClsPartSearchDAO();%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
  
   var spec1data;
  
	   spec1data='<%=DAO.suitSpec1Search(session)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'spec',type:'String'},
                  		
                  		
                  		],
				    localdata: spec1data,
        
        
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
    
    
    $("#spec1Search").jqxGrid(
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
    
    $( "#btnspec1" ).click(function() {
    	
    	var rows = $("#spec1Search").jqxGrid('selectedrowindexes');
   
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="BEDSIZE";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidspec1").value="BEDSIZE";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nBEDSIZE";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidspec1").value+="\nBEDSIZE";
        	}	
    	}
    	
		document.getElementById("hidspec1id").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#spec1Search').jqxGrid('getcellvalue',rows[i],'spec');
    		var docno=$('#spec1Search').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidspec1").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidspec1id").value=docno;
    		}
    		else{
    			document.getElementById("hidspec1id").value+=","+docno;
    		}
    	}
   	
    	
    	
    	$('#spec1window').jqxWindow('close');
    	});
    
     $("#btncancel" ).click(function() {
    	$('#spec1window').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnspec1" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="spec1Search"></div>
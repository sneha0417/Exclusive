<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.partSearch.ClsPartSearchDAO"%>
<%ClsPartSearchDAO DAO= new ClsPartSearchDAO();%>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
 
   var ptypedata;
   ptypedata='<%=DAO.typeSearch(session)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'ptype',type:'String'},
                  		
                  		
                  		],
				    localdata: ptypedata,
        
        
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
    
    
    $("#typeSearch").jqxGrid(
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
       				{ text:'TYPE',datafield:'ptype',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btntype" ).click(function() {
    	
    	var rows = $("#typeSearch").jqxGrid('selectedrowindexes');
   
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="TYPE";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidtype").value="TYPE";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nTYPE";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidtype").value+="\nTYPE";
        	}	
    	}
    	
		document.getElementById("hidtypeid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#typeSearch').jqxGrid('getcellvalue',rows[i],'ptype');
    		var docno=$('#typeSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidtype").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidtypeid").value=docno;
    		}
    		else{
    			document.getElementById("hidtypeid").value+=","+docno;
    		}
    	}
   	
    	
    	
    	$('#ptypewindow').jqxWindow('close');
    	});
    
     $("#btncancel" ).click(function() {
    	$('#ptypewindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btntype" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="typeSearch"></div>
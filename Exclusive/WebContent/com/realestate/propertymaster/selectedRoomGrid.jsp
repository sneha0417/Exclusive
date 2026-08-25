<%@page import="com.realestate.furniturefixtures.ClsFurnitureFixturesDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<% String contextPath=request.getContextPath();%>

<%ClsFurnitureFixturesDAO DAO= new ClsFurnitureFixturesDAO(); 

String pdocno=request.getParameter("docno")==null|| request.getParameter("docno")=="" ?"0":request.getParameter("docno").toString();
String chktype=request.getParameter("chktype")==null || request.getParameter("chktype")==""?"0":request.getParameter("chktype").toString();
String chktypes="0";


%>
<script type="text/javascript">  
		var roomdata;		 
		roomdata='<%=DAO.roomLoad(session,Integer.parseInt(pdocno))%>'; 	   
		
        $(document).ready(function () {         	                       
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'chk', type: 'bool'  },
							{name : 'doc_no', type: 'int'  },  
     						{name : 'rdesc1', type: 'string'  },  
     						{name : 'tick', type: 'bool'  },     	
                        ],
                         localdata: roomdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
           
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxSelectedRoomGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                editable: true,
                altRows:true,
                showaggregates: true,
                selectionmode: 'singlecell',   
                       
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
							}  
							},							
							{ text: '', columntype: 'checkbox',datafield: 'chk', width: '1%', editable: true },   
							{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true },						
							{ text: 'Room', datafield: 'rdesc1', editable: false },		
						]
            });
         
            if($('#mode').val()=='view')
	         {
          
           	$("#jqxSelectedRoomGrid").jqxGrid({
    			disabled : true
    		});
	           }
            else
            	{
             	$("#jqxSelectedRoomGrid").jqxGrid({
        			disabled : false
        		});
            	}
            
            $('#jqxSelectedRoomGrid').on( 'celldoubleclick', function(event) {            	
                 
    			
    			var boundIndex = event.args.rowindex;						
    			
    			var pdocno='<%=pdocno%>'; 	 
    			console.log(pdocno);
    			
    			var rdocno = $('#jqxSelectedRoomGrid').jqxGrid(
    					'getcellvalue', boundIndex, "doc_no");

    			var chk = $('#jqxSelectedRoomGrid').jqxGrid(
    					'getcellvalue', boundIndex, "chk");  // true or false 
 
    					
    			$('#txtroomid').val(rdocno);
    			
    			//set docno to a hiddenfield
    			$("#txtroomno").val(rdocno);

    			$("#divselectedfurfix").load(
    					"selectedFurfixGrid.jsp?rdocno=" + rdocno+"&pdocno="+pdocno); 
    		});
           
        });
</script>
<div id="jqxSelectedRoomGrid"></div>

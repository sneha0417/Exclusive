<%@page import="com.realestate.furniturefixtures.ClsFurnitureFixturesDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>

<% String contextPath=request.getContextPath();%>

<%ClsFurnitureFixturesDAO DAO= new ClsFurnitureFixturesDAO(); 

String psrno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();

String chktype=request.getParameter("chktype")==null?"0":request.getParameter("chktype").toString();
String chktypes="0";

/* System.out.println("==psrno===="+psrno); */

%>
<script type="text/javascript">  
		var roomdata;
		 
		roomdata='<%=DAO.roomMainLoad(session)%>'; 			  
		 
        $(document).ready(function () { 
        	                       
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'  },  
     						{name : 'rdesc1', type: 'string'  },  
     						{name : 'selectroom', type: 'bool'  },     	
                        ],
                         localdata: roomdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
           
            $('#jqxRoomGrid').on('bindingcomplete', function (event) {
          	  
        	});
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxRoomGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                editable: true,
                altRows:true,
                showaggregates: true,
                selectionmode: 'singlerow', 
                       
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
							}  
							},
							{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true },						
							{ text: 'Room', datafield: 'rdesc1', editable: false },		
						]
            }); 
        	 
            if($('#mode').val()=='view')
	         {
          
           	$("#jqxRoomGrid").jqxGrid({
    			disabled : true
    		});
	           }
            else
            	{
             	$("#jqxRoomGrid").jqxGrid({
        			disabled : false
        		});
            	}
            
            
            $('#jqxRoomGrid').on( 'rowdoubleclick', function(event) {            	
            
            			var boundIndex = event.args.rowindex;				
            			
            			var rdocno = $('#jqxRoomGrid').jqxGrid(
            					'getcellvalue', boundIndex, "doc_no");
            			//set docno to a hiddenfield
            			$("#docno").val(rdocno);

            			$("#divselectedroom").load(
            					"selectedRoomGrid.jsp?rdocno=" + rdocno);
            			$("#divselectedfurfix").load(
            					"selectedFurfixGrid.jsp?rdocno=" + rdocno);
            			
            			$('#roomwindow').jqxWindow('close');
            		
            		});
           
        });
</script>
<div id="jqxRoomGrid"></div>

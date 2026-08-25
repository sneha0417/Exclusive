<%@page import="com.realestate.furniturefixtures.ClsFurnitureFixturesDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
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
     						{name : 'chk', type: 'int'  },
                        ],
                         localdata: roomdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
           
            $('#jqxRoomGrid').on('bindingcomplete', function (event) {
            	if ($("#mode").val() == "A"  && $("#mode").val() == "E" ) {	   		  
        			$("#jqxRoomGrid").jqxGrid('addrow', null, {});
        		}
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
                selectionmode: 'singlecell',     
                handlekeyboardnavigation: function (event) {
                    var rows = $('#jqxRoomGrid').jqxGrid('getrows');
                    var rowlength= rows.length;
          	       var rowindex1=0;
                    var cell = $('#jqxRoomGrid').jqxGrid('getselectedcell');   
      				if (cell != undefined && cell.datafield == 'chk' ) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13 || key == 9) { 
                        	$("#jqxRoomGrid").jqxGrid('addrow', null, {});		    
                        }
                    }
                },        
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
							}  
							},
							{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true },						
							{ text: 'Room', datafield: 'rdesc1'},		
							{ text: '', datafield: 'chk', width: '1%' }
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
           
        });
</script>
<div id="jqxRoomGrid"></div>

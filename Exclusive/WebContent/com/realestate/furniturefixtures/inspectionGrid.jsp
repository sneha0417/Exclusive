<%@page import="com.realestate.furniturefixtures.ClsFurnitureFixturesDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<% String contextPath=request.getContextPath();%>

<%ClsFurnitureFixturesDAO DAO= new ClsFurnitureFixturesDAO(); 

String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").toString();
%>
<script type="text/javascript">  
		var insdata;
		  
		 insdata=  '<%=DAO.InspectionLoadByRoomID(session,rdocno)%>'; 
		 
        $(document).ready(function () { 
        	                       
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'  },  
     						{name : 'fdesc1', type: 'string'  },    
     						{name : 'sr_no', type: 'int'  },
     						{name : 'chk', type: 'int'  },
                        ],
                         localdata: insdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
           
            $('#jqxInspectionGrid').on('bindingcomplete', function (event) {
            	if ($("#mode").val() == "A"  && $("#mode").val() == "E" ) {			  
        			$("#jqxInspectionGrid").jqxGrid('addrow', null, {});
        		}
        	});
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxInspectionGrid").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                editable: true,
                altRows:true,
                showaggregates: true,
                selectionmode: 'singlecell', 
                handlekeyboardnavigation: function (event) {
                    var rows = $('#jqxInspectionGrid').jqxGrid('getrows');
                    var rowlength= rows.length;
          	       var rowindex1=0;
                    var cell = $('#jqxInspectionGrid').jqxGrid('getselectedcell');
      				if (cell != undefined && cell.datafield == 'chk' ) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13 || key == 9) { 
                        	$("#jqxInspectionGrid").jqxGrid('addrow', null, {});		    
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
							{ text: 'Description', datafield: 'fdesc1', editable: true },	
							{ text: 'sr_no', datafield: 'sr_no', width: '10%',hidden:true },
							{ text: '', datafield: 'chk', width: '1%' }
						]
            });        
            
            if($('#mode').val()=='view')
	         {
          
           	$("#jqxInspectionGrid").jqxGrid({
    			disabled : true
    		});
	           }
            else
            	{
             	$("#jqxInspectionGrid").jqxGrid({
        			disabled : false
        		});
            	}
            $("#jqxInspectionGrid").jqxGrid('addrow', null, {});
        });
</script>
<div id="jqxInspectionGrid"></div>

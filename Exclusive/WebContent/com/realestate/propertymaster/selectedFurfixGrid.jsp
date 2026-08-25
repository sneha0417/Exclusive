<%@page import="com.realestate.propertymaster.ClsPropertyMasterDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<% String contextPath=request.getContextPath();%>

<%ClsPropertyMasterDAO DAO= new ClsPropertyMasterDAO(); 

String rdocno=request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
String pdocno=request.getParameter("pdocno")==null || request.getParameter("pdocno")==""?"0":request.getParameter("pdocno").toString();
/* System.out.println("==psrno===="+psrno); */

%>
<script type="text/javascript">  
 var furdata;		  
 
 <%-- if ($("#mode").val() == "E") {	
	 furdata='<%=DAO.furnitureLoadByRoomID(session,Integer.parseInt(rdocno))%>'; 
 }

 if ( $("#mode").val() == "A") {	
	 furdata='<%=DAO.furnitureLoadByPropertyRoomID(session,Integer.parseInt(pdocno))%>'; 
 } --%>
 
 furdata='<%=DAO.furnitureLoadByPropertyRoomID(session,Integer.parseInt(pdocno),Integer.parseInt(rdocno))%>'; 
 
        $(document).ready(function () { 
        	                       
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'  },  
							{name : 'rdoc_no', type: 'int'  },  
     						{name : 'fdesc1', type: 'string'  },   
     						{name : 'chk', type: 'bool'  },
     						{name : 'dtype', type: 'string'  },
     						
     						//{name : 'sr_no', type: 'int'  },     						
                        ],
                         localdata: furdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
           
            $('#jqxselectedFurnfixGrid').on('bindingcomplete', function (event) {
            	/* if ($("#mode").val() == "A" || $("#mode").val() == "E") {			 
        			$("#jqxselectedFurnfixGrid").jqxGrid('addrow', null, {});		 
        		} */
        	});
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxselectedFurnfixGrid").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                editable: true,
                altRows:true,
                showaggregates: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                filterable : true,
                enabletooltips: true,
              /*   handlekeyboardnavigation: function (event) {
                    var rows = $('#jqxselectedFurnfixGrid').jqxGrid('getrows');
                    var rowlength= rows.length;
          	       var rowindex1=0;
                    var cell = $('#jqxselectedFurnfixGrid').jqxGrid('getselectedcell');
      				if (cell != undefined && cell.datafield == 'chk' ) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13 || key == 9) { 
                        	$("#jqxselectedFurnfixGrid").jqxGrid('addrow', null, {});		    
                        }
                    }
                }, */
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
							}  
							},
							{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'rdoc_no', datafield: 'rdoc_no', width: '10%',hidden:true },
							{ text: '', columntype: 'checkbox',datafield: 'chk', width: '1%',hidden:false ,editable: true},							
							{ text: 'Furniture and Fixtures', datafield: 'fdesc1', editable: true },
							{ text: 'Type', datafield: 'dtype', editable: false , width: '20%'},
							
							//{ text: 'sr_no', datafield: 'sr_no', width: '10%',hidden:true },							
						]
            });
        
        	
            if($('#mode').val()=='view')
	         {
          
           	/* $("#jqxselectedFurnfixGrid").jqxGrid({
    			disabled : true
    		}); */
	           }
            else
           	{
            	$("#jqxselectedFurnfixGrid").jqxGrid({
       			disabled : false
       		});
            	}
            
        });
</script>
<div id="jqxselectedFurnfixGrid"></div>

<%@page import="com.guideline.ClsGuidelineDAO" %> 
<%ClsGuidelineDAO gd=new ClsGuidelineDAO(); %>
<%-- <%@page import="com.operations.setup.jobprocessguideline.ClsProcessGuidelineDAO"%> --%>
<%@page import="javax.servlet.http.HttpSession" %>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">
        var data;
        
        data='<%=gd.menuLoad(session)%>';
        
        $(document).ready(function () { 	
        	
        	
            	 
           	
        	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'user_name', type: 'string' },
							{name : 'user_id', type: 'string' },
							
							
							
                        ],
                		    localdata: data, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxMenuGrid").jqxGrid(
            {
                width: '80%',
                height: 600,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                    
              //Add row method
                 handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxMenuGrid').jqxGrid('getrows');
                 	var rowlength=""+rows.length;
                    var cell = $('#jqxMenuGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'status' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxMenuGrid").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                },
                 
                columns: [
						    {  text: 'Sr. No.', sortable: false, filterable: false, editable: false,
						       groupable: false, draggable: false, resizable: false,datafield: '',
						       columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
						       cellsrenderer: function (row, column, value) {
						  	   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						      }  
							},                          
							{ text: 'User', datafield: 'user_name', width: '70%',editable:false },
							{ text: 'User Id', datafield: 'user_id', width: '70%',editable:false,hidden:true },
							
						]
            });
            $("#jqxMenuGrid").jqxGrid('addrow', null, {});
             
            $('#jqxMenuGrid').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
              	
              	 document.getElementById("txtdoctype").value=$('#jqxMenuGrid').jqxGrid('getcellvalue', rowindex1, "doc_type");
            document.getElementById("txtmenuname").value=$('#jqxMenuGrid').jqxGrid('getcellvalue', rowindex1, "menu_name");
            document.getElementById("txtmenuid").value=$('#jqxMenuGrid').jqxGrid('getcellvalue', rowindex1, "menu_id");
            document.getElementById("txtrefno").value=$('#jqxMenuGrid').jqxGrid('getcellvalue', rowindex1, "ref_no");
            
            
            
            //alert($('#jqxMenuGrid').jqxGrid('getcellvalue', rowindex1, "statusid"));
            
            var doc_type=$('#jqxMenuGrid').jqxGrid('getcellvalue', rowindex1, "doc_type");
            
            var rdoc_type=doc_type.replace(/ /g, "%20");
            
              $('#descGrid').load("descGrid.jsp?doctype="+rdoc_type);
              $('#gtwoGrid').load("gtwoGrid.jsp?doctype="+rdoc_type);
              $('#gthreeGrid').load("gthreeGrid.jsp?doctype="+rdoc_type);
        
              	
            		 });
        });
    </script>
    <div id="jqxMenuGrid"></div>
    <input type="hidden" id="rowindex"/>
    
    
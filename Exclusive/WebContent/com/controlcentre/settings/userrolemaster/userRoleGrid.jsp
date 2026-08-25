<%@page import="com.controlcentre.settings.userrolemaster.ClsUserRoleDAO" %>
<%ClsUserRoleDAO urd=new ClsUserRoleDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String roleId = request.getParameter("roleid")==null?"0":request.getParameter("roleid");%>
<script type="text/javascript">
        
    var data1;
        $(document).ready(function () { 	
        	 var temp='<%=roleId%>';
        	 
        	 if(temp>0)
           	 { 
        		 data1='<%=urd.userRoleGridReloading(roleId)%>';  
           	 }
             else
             {
            	 data1='<%=urd.userRoleGridLoading()%>';   
             } 
        	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'menu_name', type: 'string'  },
     						{name : 'add1', type: 'bool'   },
     						{name : 'edit', type: 'bool'  },
     						{name : 'del', type: 'bool'   },
     						{name : 'print', type: 'bool'  },
     						{name : 'attach', type: 'bool'   },
     						{name : 'excel', type: 'bool'   },
     						{name : 'email', type: 'bool'   },
     						{name : 'costing', type: 'bool'   },
     						{name : 'terms', type: 'bool'   },
     						{name : 'mno', type: 'int'  },
                            ],
                            localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxUserRole").jqxGrid({
            	width: '80%',
                height: 400,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlecell',
                editable: true,
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxUserRole').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxUserRole').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'excel' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxUserRole").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                },
                
                       
                columns: [							
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Menu', datafield: 'menu_name', editable: false, width: '23%'},			
							{ text: 'Add', datafield: 'add1', columntype: 'checkbox', width: '8%',cellsalign: 'center', align: 'center' },
							{ text: 'Edit', datafield: 'edit', columntype: 'checkbox', width: '8%',cellsalign: 'center', align: 'center' },
							{ text: 'Delete', datafield: 'del', columntype: 'checkbox', width: '8%',cellsalign: 'center', align: 'center' },
							{ text: 'Print', datafield: 'print', columntype: 'checkbox', width: '8%',cellsalign: 'center', align: 'center' },
							{ text: 'Attach', datafield: 'attach', columntype: 'checkbox', width: '8%',cellsalign: 'center', align: 'center' },
							{ text: 'Excel', datafield: 'excel', columntype: 'checkbox', width: '8%',cellsalign: 'center', align: 'center' },
							{ text: 'Email', datafield: 'email', columntype: 'checkbox', width: '8%',cellsalign: 'center', align: 'center' },
							{ text: 'Costing', datafield: 'costing', columntype: 'checkbox', width: '8%',cellsalign: 'center', align: 'center' },
							{ text: 'Terms', datafield: 'terms', columntype: 'checkbox', width: '8%',cellsalign: 'center', align: 'center' },
							{ text: 'MNO', datafield: 'mno', hidden:true, width: '10%'},
			              ]
            });
            
            if(temp>0){
            	$("#jqxUserRole").jqxGrid('disabled', true);
            } 
            
        });
    </script>
    <div id="jqxUserRole"></div>
 
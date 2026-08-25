<%@page import="com.controlcentre.settings.userrolebi.ClsUserRoleBIDAO" %>
<%ClsUserRoleBIDAO urb=new ClsUserRoleBIDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String roleId = request.getParameter("roleid")==null?"0":request.getParameter("roleid");%>
<script type="text/javascript">
        
    var data1;
        $(document).ready(function () { 	
        	 var temp='<%=roleId%>';
        	 
        	 if(temp>0)
           	 { 
        		 data1='<%=urb.userRoleGridReloading(roleId)%>';  
           	 }
             else
             {
            	 data1='<%=urb.userRoleGridLoading()%>';   
             } 
        	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'master', type: 'string'  },
     						{name : 'detail', type: 'string'   },
     						{name : 'permission', type: 'bool'  },
     						{name : 'email', type: 'bool'  },
     						{name : 'excel', type: 'bool'  },
     						{name : 'mno', type: 'int'   },
     						{name : 'dno', type: 'int'  }
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
            
            $("#jqxUserRoleBI").jqxGrid({
            	width: '70%',
                height: 400,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlecell',
                editable: true,
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxUserRoleBI').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxUserRoleBI').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'status' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxUserRoleBI").jqxGrid('addrow', null, {});
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
							{ text: 'Main', datafield: 'master', editable: false, width: '35%'},			
							{ text: 'Sub', datafield: 'detail', editable: false, width: '30%'},
							{ text: 'Status', datafield: 'permission', columntype: 'checkbox', width: '10%',cellsalign: 'center', align: 'center' },
							{ text: 'Email', datafield: 'email', columntype: 'checkbox', width: '10%',cellsalign: 'center', align: 'center' },
							{ text: 'Excel', datafield: 'excel', columntype: 'checkbox', width: '10%',cellsalign: 'center', align: 'center' },
							{ text: 'MNO', datafield: 'mno', hidden: true, width: '10%'},
							{ text: 'DNO', datafield: 'dno', hidden: true, width: '10%'},
			              ]
            });
            
            if(temp>0){
            	$("#jqxUserRoleBI").jqxGrid('disabled', true);
            } 
            
        });
    </script>
    <div id="jqxUserRoleBI"></div>
 
<%@page import="com.common.ClsExeFolio" %>
<%ClsExeFolio cef=new ClsExeFolio(); %>
<%-- <jsp:include page="../../includes.jsp"></jsp:include> --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<% int flag = request.getParameter("flag")==null?0:Integer.parseInt(request.getParameter("flag").trim()); 
%>


<script type="text/javascript">
        var ependata1;
        $(document).ready(function () { 	
         ependata1='<%=cef.exefolioDataGridload(flag,session)%>';
           	 
        	 //alert("===ependata1====="+ependata1);
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'branch', type: 'string' },
							{name : 'subdatetime', type: 'string' },
							{name : 'doctype', type: 'string' },
							{name : 'doc_no', type: 'string' },
							{name : 'voc_no', type: 'string' },
							{name : 'submitedby', type: 'string' },
							{name : 'btnclick', type: 'String'  },
							{name : 'path', type: 'String'  },
							{name : 'name', type: 'String'  },
							{name : 'refname', type: 'String'  },
							{name : 'desc1', type: 'String'  },
							{name : 'doc_type', type: 'String'  },
							
                        ],
                		    localdata: ependata1, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
           $("#jqxapprovalDataGrid").jqxGrid(
            {
                width: '100%',
                height: 150,  
                source: dataAdapter,
                editable: false,    
                selectionmode: 'singlerow',   
                filterable: true,
                showfilterrow: true,  
                columnsresize: true,
                enabletooltips: true,            
              //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxapprovalDataGrid').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxapprovalDataGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'inspstatus' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxapprovalDataGrid").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                },
                    
                columns: [
						    {  text: 'Sr. No.', sortable: false, filterable: false, editable: false,
						       groupable: false, draggable: false, resizable: false,datafield: '',
						       columntype: 'number', width: '6%',cellsalign: 'center', align: 'center',
						        cellsrenderer: function (row, column, value) {
						  	   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						      }  
							},                          
							{ text: 'Branch', datafield: 'branch', width: '5%' },
							{ text: 'DateTime', datafield: 'subdatetime', width: '15%' },
							{ text: 'Doc Type', datafield: 'doctype', width: '7%' },
							{ text: 'Doc No', datafield: 'doc_no', width: '7%' },    
							{ text: 'Submitted By', datafield: 'submitedby', width: '15%' },
							{ text: 'Client', datafield: 'refname', width: '15%' },
							{ text: 'Description', datafield: 'desc1'},
							{ text: 'Path',hidden:true, datafield: 'path', width: '20%' },
							{ text: 'name', datafield: 'name', width: '20%',hidden:true },
							{ text: 'dtype',hidden:true, datafield: 'dtype', width: '20%' },   
						]  
            });
             $("#overlay, #PleaseWait").hide();       
          $("#jqxapprovalDataGrid").on('rowdoubleclick', function (event) 
         		   {
         		    var datafield = event.args.datafield;
         		    var rowBoundIndex = event.args.rowindex;      
         		    var columnindex = event.args.columnindex;         
                      var rowindextemp = event.args.rowindex;
       				  var doc_no=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "doc_no");
       				  var path1=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "path");
       				  var brch=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "branch");
       				  var doctype=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "doctype");
       				  var name=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "name");
       				  document.getElementById('formName').value = name;
       				  document.getElementById('formCode').value = doctype;        
       				  document.getElementById('branchid').value = brch;
       				  document.getElementById('mode').value = "view";      
       				  var url=document.URL;                                       
         			  var reurl=url.split("com");          
       				  window.parent.formName.value=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "name");
       				  window.parent.formCode.value=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "doctype");
       				  var path= path1+"?mode=view&docno="+doc_no+"&exefolio=1&brch="+brch+"&doctype="+doctype+"&name="+name;
       				  var fpath=reurl[0]+""+path;
       				  $("#folio").attr("src",reurl[0]+""+path);       
         		   });    
        });  
    </script>
    <div id="jqxapprovalDataGrid"></div>
    <input type="hidden" id="rowindex"/>
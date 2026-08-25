<%@page import="com.emailnew.ClsEmailDAO" %> 
<%ClsEmailDAO ca=new ClsEmailDAO(); %>          
 <% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String formc = request.getParameter("formc")==null?"0":request.getParameter("formc");
 String brchid = request.getParameter("brchid")==null?"0":request.getParameter("brchid");
 %>
	<script type="text/javascript">            
	$(document).ready(function(){  
		var temp='<%=docNo%>';
		var data4;
		if(temp>0)  
			{  
			 data4='<%= ca.reGridload(docNo,formc,brchid) %>';                   
			}     
		else
			{
			  data4;
			}
		  var source =
        {
            datatype: "json",
            datafields: [
						{name : 'sr_no', type: 'string'  },
 						{name : 'extension', type: 'string'  },
 						{name : 'description', type: 'string'    },
 						{name : 'type', type: 'string'    },
 						{name : 'user', type: 'string'    },
 						{name : 'date', type: 'date'    },
 						{name : 'filename', type: 'string'    },
 					    {name : 'path', type: 'string'    }
 						     						
             ],
             localdata: data4, 
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
        
        $("#jqxAttach").jqxGrid(
        {
            width: '100%',
            height: 150, 
            source: dataAdapter,
            selectionmode: 'checkbox',  
            sortable: true,
            editable: true,
            columnsresize:true,
            filterable:true,
            showfilterrow:true,
            //pagermode: 'default',
            enabletooltips: true,
            sortable: true, 
            
            columns: [
                  	        //{ text: 'Select', columntype: 'checkbox', datafield: 'check', width: '6%' },
                  	        { text: 'SL#', sortable: false, filterable: false,editable: false,   
                                groupable: false, draggable: false, resizable: false,
                                datafield: 'sl', columntype: 'number', width: '4%',
                                cellsrenderer: function (row, column, value) {
                                    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                                }  
                              },  
							{ text: 'Doc Type', datafield: 'extension', width: '7%', editable: false },
							{ text: 'Description', datafield: 'description', editable: false },
							{ text: 'Type', datafield: 'type', width: '8%', editable: false },
							{ text: 'User', datafield: 'user', width: '15%', editable: false },
							{ text: 'Date', datafield: 'date', width: '10%', editable: false ,cellsformat:'dd.MM.yyyy'  },
							{ text: 'File Name', datafield: 'filename', width: '20%', editable: false },
							{ text: 'File Location', datafield: 'path', width: '20%', editable: false,hidden:true }  
	              ]
        });	
	});	
  </script>       
<body>
 <div id="jqxAttach">                               
</div>      
<iframe  id="my_iframe" style="display:none;"></iframe>
<a id="dwld" href="#" download></a>              
</body>
</html>   
<%@page import="com.common.ClsAttachmaster" %>
<%
	ClsAttachmaster ca=new ClsAttachmaster();
%>
 
 
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
        
        $("#jqxDocumentsAttach").jqxGrid(
        {
            width: '100%',
            height: 300,
            source: dataAdapter,
            editable: true,
            selectionmode: 'singlerow',
            columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                            datafield: 'sr_no', width: '10%',cellsalign: 'center', align: 'center', editable: false	},
							{ text: 'Doc Type', datafield: 'extension', width: '10%', editable: false },
							{ text: 'Description', datafield: 'description', width: '35%', editable: false },
							{ text: 'Type', datafield: 'type', width: '25%', editable: false },
							{ text: 'File Name', datafield: 'filename', width: '20%', editable: false },
							{ text: 'File Location', datafield: 'path', width: '20%', editable: false,hidden:true }
	              ]
        });	
		 $('#jqxDocumentsAttach').on('rowdoubleclick', function (event) 
            { 
             var rowindexes=event.args.rowindex;
             document.getElementById("filename").value= $('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename");
             SaveToDisk($('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "path"),$('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename"));
            }); 
		 
		 $('#jqxDocumentsAttach').on('rowclick', function (event) 
	              { 
	               var rowindexes=event.args.rowindex;
	               document.getElementById("filename").value= $('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename");
	              }); 
	});	
 
 
 
	</script>
<body>
 <div id="jqxDocumentsAttach"></div> 
</body>
</html>

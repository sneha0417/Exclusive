<%@page import="com.realestate.propertymaster.ClsPropertyMasterDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<% String contextPath=request.getContextPath();%>

<%ClsPropertyMasterDAO DAO= new ClsPropertyMasterDAO(); 

String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();
 
%>
<script type="text/javascript">  
		var accessdata;
		accessdata='<%=DAO.AccessLoadByPropertyID(session,Integer.parseInt(docno))%>';
		 
        $(document).ready(function () { 
        	                           
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'  },     
     						{name : 'acsutility', type: 'string'  },  
     						{name : 'acsno', type: 'string'  },
     						{name : 'aqty', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'chk', type: 'int'  },
     						{name : 'acid', type: 'int'  }
                        ],
                           localdata: accessdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
           
           
           $('#jqxaccessGrid').on('bindingcomplete', function (event) {
        	   
        	});  
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxaccessGrid").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                editable: true,
                altRows:true,
                showaggregates: true,
                selectionmode: 'singlecell', 
                handlekeyboardnavigation: function (event) {
                    var rows = $('#jqxaccessGrid').jqxGrid('getrows');
                    var rowlength= rows.length;
          	       var rowindex1=0;
                    var cell = $('#jqxaccessGrid').jqxGrid('getselectedcell');
      				if (cell != undefined && cell.datafield == 'chk' ) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13 || key == 9) { 
                        	$("#jqxaccessGrid").jqxGrid('addrow', null, {});		    
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
							{ text: 'Type of Key or Control', datafield: 'acsutility', editable: true },
							{ text: 'Identity', datafield: 'acsno', editable: true },	
							{ text: 'No of Keys', datafield: 'aqty', editable: true, width: '10%' },	
							{ text: 'sr_no', datafield: 'sr_no', width: '10%',hidden:true },
							{ text: '', datafield: 'chk', width: '2%' },
							{ text: 'acid', datafield: 'acid', width: '2%',hidden:true }, 
						]
            });
        
        	
           /*  if($('#mode').val()=='view')
	        {          
	           	$("#k").jqxGrid({
	    			disabled : true
	    		});
	        }
            else
            {
             	$("#jqxaccessGrid").jqxGrid({
        			disabled : false
        		});
            } */
        });
</script>
<div id="jqxaccessGrid"></div>

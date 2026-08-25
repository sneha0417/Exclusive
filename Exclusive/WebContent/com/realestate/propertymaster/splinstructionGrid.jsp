<%@page import="com.realestate.propertymaster.ClsPropertyMasterDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<% String contextPath=request.getContextPath();%>
<%ClsPropertyMasterDAO DAO= new ClsPropertyMasterDAO(); 
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString(); 
/* System.out.println("==psrno===="+psrno); */
%>
<script type="text/javascript">  
		var splinsdata;
		 
		splinsdata='<%=DAO.SpecialInstructionsLoadByPropertyID(session,Integer.parseInt(docno))%>';
		 console.log(splinsdata);
        $(document).ready(function () {        	
                	                       
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int' },  
     						{name : 'sp_inst', type: 'string'  },
     						{name : 'chk', type: 'string'  }, 
     						{name : 'spinsid', type: 'int'  },
     						{name : 'sr_no', type: 'int'  }
                        ],
                localdata: splinsdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
           
           /*  $('#jqxsplinsGrid').on('bindingcomplete', function (event) {
            	if ($("#mode").val() == "A" && $("#mode").val() == "E") {		 
        			$("#jqxsplinsGrid").jqxGrid('addrow', null, {});		 
        		}
        	}); */
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxsplinsGrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                editable: true,
                altRows:true,
                showaggregates: true,
                selectionmode: 'singlecell', 
                handlekeyboardnavigation: function (event) {
                    var rows = $('#jqxsplinsGrid').jqxGrid('getrows');
                    var rowlength= rows.length;
          	       var rowindex1=0;
                    var cell = $('#jqxsplinsGrid').jqxGrid('getselectedcell');
      				if (cell != undefined && cell.datafield == 'chk' ) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13 || key == 9) { 
                        	$("#jqxsplinsGrid").jqxGrid('addrow', null, {});		    
                        }
                    }
      	 }, 
                       
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";  } },
							{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true },						
							{ text: 'Special Instructions', datafield: 'sp_inst', editable: true },
							{ text: '',datafield: 'chk', width: '2%',editable:false},
							{ text: 'spinsid', datafield: 'spinsid', width: '2%',hidden:true },
							{ text: 'sr_no', datafield: 'sr_no', width: '2%',hidden:true }
						]
            });
            $("#jqxsplinsGrid").jqxGrid('addrow', null, {});
           
        	if ($("#mode").val() == "A" || $("#mode").val() == "E") {		 
    			$("#jqxsplinsGrid").jqxGrid('addrow', null, {});		 
    		}
            if($('#mode').val()=='view')
	         {
          
           	$("#jqxsplinsGrid").jqxGrid({
    			disabled : true
    		});
	           }
            else
            	{
             	$("#jqxsplinsGrid").jqxGrid({
        			disabled : false
        		});
            	}
             
        });
</script>
<div id="jqxsplinsGrid"></div>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.cargo.assignment.ClsAssignment"%>
<%
ClsAssignment assignment=new ClsAssignment();
%>
<script type="text/javascript">
$(document).ready(function () { 	
	var data1; 
	data1='<%=assignment.staffSearch()%>';
	var source =
	{
			datatype: "json",
			datafields: [
			             {name : 'sal_name', type: 'string'},  
			             {name : 'doc_no', type: 'int'   }
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
		            }		
            );
            $("#stasearch").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
                selectionmode: 'singlerow', 
                columns: [      
                            { text: 'Name', datafield: 'sal_name', width: '100%'   },	
							{ text: 'doc_no', datafield: 'doc_no', width: '10%' , hidden: true},
							]
            });
            $("#stasearch").on('rowdoubleclick', function (event) 
            {
            	var rowindextemp = event.args.rowindex;
            	$("#assignmentto").val($('#stasearch').jqxGrid('getcellvalue', rowindextemp, "sal_name"));
            	$("#hidassignmentid").val($('#stasearch').jqxGrid('getcellvalue', rowindextemp, "doc_no"));
            	$("#stasearch").jqxGrid('clear');
            	$('#staWindow').jqxWindow('close'); 
            });  
});
</script>
<div id=stasearch></div>
 
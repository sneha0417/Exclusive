 <%@page import="com.dashboard.accounts.postingnew.ClsPostingDAO" %>
<%ClsPostingDAO cpd=new ClsPostingDAO(); %>
 
 
 <% String paytype = request.getParameter("paytype")==null?"NA":request.getParameter("paytype").trim(); 
 String check = request.getParameter("check")==null?"NA":request.getParameter("check").trim();%>

<script type="text/javascript">
  var temp='<%=paytype%>';

	var data5;
	if(temp=='2'  || temp=='4')
	{ 
		  data5='<%=cpd.cardCommGridLoading(check)%>';  
	
	}
	
	$(document).ready(function () {
	   
	    // prepare the data
	    var source =
	    {
	        datatype: "json",
	        datafields: [
	
	                  		{name : 'mode' , type: 'String' },
							{name : 'commission',type:'number'}
	                  		
							],
					    localdata: data5,
	        
	        
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
	    
	    
	    $("#cardCommGrid").jqxGrid(
	    {
	    	width: '100%',
	        height: 90,
	        source: dataAdapter,
	        rowsheight:20,
	        editable: true,
            selectionmode: 'singlecell',
	        
	        columns: [
						   { text: '', sortable: false, filterable: false, editable: false,
						        groupable: false, draggable: false, resizable: false,datafield: '',
						        columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
						        cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						       }    
							},
							{ text: 'Card Type', datafield: 'mode', width: '50%', editable: false },
							{ text: 'Commission', datafield: 'commission', width: '37%',cellsformat:'d2',cellsalign:'right',align:'right' },
						]
	
	    });
	    
	});

	
	
</script>
<div id="cardCommGrid"></div>
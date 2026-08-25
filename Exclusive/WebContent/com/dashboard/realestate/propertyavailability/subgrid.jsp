<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.propertyavailability.*"%>
<%   
	String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
	String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	String managed = request.getParameter("managed")==null?"0":request.getParameter("managed").trim();
	ClsPropertyAvailabilityDAO DAO= new ClsPropertyAvailabilityDAO();
%>
<script type="text/javascript">
	var temp1=1;
	var vehdatas;
	var bb;
	var branch='<%=branchid%>';      
	if(temp1==1)
	{
		data1='<%=DAO.propertylist(uptodate,id,managed,branchid)%>';   
		bb=0;
	}else{
		vehdatas;
		 bb=1;
	}
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
     }

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 
						{name : 'status', type: 'string'  },
						{name : 'value', type: 'string'  },
						{name : 'relodestatus', type: 'string'  }
						
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
    $("#propertydet").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    });
    
    $("#propertydet").jqxGrid(
    {
        width: '90%',
        height: 200,
        source: dataAdapter,
        rowsheight:20,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'status', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Value', datafield: 'value', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'relodestatus', datafield: 'relodestatus', width: '30%',hidden:true},
						//relodestatus
					]
    
    });
    if(bb==1)
	{
	 $("#propertydet").jqxGrid('addrow', null, {});
	}    
    $("#propertydet").on('rowdoubleclick', function (event) 
    	{ 
    		var boundIndex = event.args.rowindex;        
		    $("#overlay, #PleaseWait").show();
		    var relodestatus = $('#propertydet').jqxGrid('getcelltext',boundIndex, "relodestatus");         
		    document.getElementById('hidreloadstatus').value=relodestatus;           
		    $("#propertydiv").load("propertyAvailabilityGrid.jsp?relodestatus="+relodestatus+"&branch="+branch+"&uptodate="+'<%=uptodate%>'+"&managed="+'<%=managed%>'+"&id=1");		    
	    }); 
});

	
	
</script>
<div id="propertydet"></div>
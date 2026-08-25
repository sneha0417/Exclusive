 <%@page import="com.dashboard.audit.costupdate.ClsCostupdateDAO" %>
<% ClsCostupdateDAO ccd=new ClsCostupdateDAO();%>
 <%
 	String branch=request.getParameter("branch")==null?"":request.getParameter("branch").trim();
 	String id=request.getParameter("id")==null?"":request.getParameter("id").trim();
 	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
 	String todate=request.getParameter("todate")==null?"":request.getParameter("todate").trim();
           	  %> 
           	  
  
<script type="text/javascript">
 var temp4='<%=branch%>';
var costmissingdata,costmissingdataExcel;
if(temp4!='')
{ 
	
	costmissingdata='<%= ccd.getMissingData(branch,fromdate,todate,id)%>';
	costmissingdataExcel='<%= ccd.getMissingDataExcel(branch,fromdate,todate,id)%>';
	
}
else
{
	costmissingdata;
} 
$(document).ready(function () {

	var rendererstring2=function (aggregates){
	 	var value=aggregates['sum'];
		if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
		   {
			value=0.0;
		   }
	 	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	 }

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		
						{name : 'description', type: 'string'  },
						{name : 'tr_no', type: 'number'  },
						{name : 'acno', type: 'string'  },
						{name : 'dtype', type: 'string'  },
						{name : 'doc_no', type: 'string'  },
						{name : 'dramount', type: 'number'  },
						{name : 'tranid', type: 'number'  }
						],
				    localdata: costmissingdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#costMissingGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
   
    	/* return "greyClass";
    	
	        var element = $(defaultHtml);
	        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
	        return element[0].outerHTML;


	
        */
    
    $("#costMissingGrid").jqxGrid(
    {
        width: '98%',
        height: 513,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 25,
        
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'checkbox',
        pagermode: 'default',
       
        columns: [
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
    						groupable: false, draggable: false, resizable: false,datafield: '',
    						columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
    						cellsrenderer: function (row, column, value) {
     							return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
  								}    
					},
					{ text: 'Ac No', datafield: 'acno', width: '10%' },
					{ text: 'Account',datafield: 'description',width:'51%'},
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Doc Type', datafield: 'dtype', width: '10%'},
					{ text: 'Amount', datafield: 'dramount', width: '11%',cellsformat:'d2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring2 },
					{ text: 'Tr_no', datafield: 'tr_no', width: '7%' ,hidden:true },
					{ text: 'tranid', datafield: 'tranid', width: '7%' ,hidden:true }
					/* { text: 'Staff Type', datafield: 'renttype', width: '5%' ,cellclassname: cellclassname },
					{ text: 'Idle days', datafield: 'idealdys', width: '10%' ,cellsalign: 'right', align:'right',cellclassname: 'advanceClass'}, */
											
						]
    
    });
    
});

	
	
</script>
<div id="costMissingGrid"></div>
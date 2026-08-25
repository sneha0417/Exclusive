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
var costupdatedata;
var costupdate;
if(temp4!='')
{ 
	
	costupdatedata='<%= ccd.getCosttran(branch,fromdate,todate,id)%>';
	costupdate='<%= ccd.getCosttranExcel(branch,fromdate,todate,id)%>';
}
else
{
	
	costupdatedata;
	} 
$(document).ready(function () {
   

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
						{name : 'jvamt', type: 'number'  },
						{name : 'costtranamt', type: 'number'  },
						{name : 'difference',type:'number'}
						
						
						],
				    localdata: costupdatedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#costupdateGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    var cellclassname =  function (row, column, value, data) {


  var ss= $('#costupdateGrid').jqxGrid('getcellvalue', row, "days");
	          if(parseInt(ss)<0)
	  		{
	  		
	  		return "yellowClass";
	  	
	  		}
    }
    	/* return "greyClass";
    	
	        var element = $(defaultHtml);
	        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
	        return element[0].outerHTML;


	
        */
    
    $("#costupdateGrid").jqxGrid(
    {
        width: '98%',
        height: 513,
        source: dataAdapter,
        showaggregates:true,
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
					{ text: 'Ac No', datafield: 'acno', width: '10%'  ,cellclassname: cellclassname },
					{ text: 'Account',datafield: 'description',width:'32%',cellclassname:cellclassname},
					{ text: 'Doc No', datafield: 'doc_no', width: '10%'    ,cellclassname: cellclassname},
					{ text: 'Doc Type', datafield: 'dtype', width: '10%'    ,cellclassname: cellclassname},
					{ text: 'Accounted', datafield: 'jvamt', width: '10%' ,cellclassname: cellclassname,cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'], cellclassname: 'appliedClass' },
					{ text: 'Cost Allocated', datafield: 'costtranamt', width: '10%' ,cellclassname: cellclassname,cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'], cellclassname: 'appliedClass'},
					{ text: 'Difference',datafield:'difference',width:'10%' ,cellclassname: cellclassname,cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'], cellclassname: 'appliedClass'},
					{ text: 'Tr_no', datafield: 'tr_no', width: '7%' ,cellclassname: cellclassname}
					/* { text: 'Staff Type', datafield: 'renttype', width: '5%' ,cellclassname: cellclassname },
					{ text: 'Idle days', datafield: 'idealdys', width: '10%' ,cellsalign: 'right', align:'right',cellclassname: 'advanceClass'}, */
											
						]
    
    });
    
    


    
});

	
	
</script>
<div id="costupdateGrid"></div>
<%@page import="com.dashboard.fixedasset.falist.ClsFaListDAO" %>
<%ClsFaListDAO cfld=new ClsFaListDAO(); %>

 <%String branch=request.getParameter("branch")==null?"NA":request.getParameter("branch"); 
 String assetgroup=request.getParameter("assetgroup")==null?"":request.getParameter("assetgroup");
 String check=request.getParameter("check")==null?"":request.getParameter("check");
 %>


<script type="text/javascript">
var init='<%=branch%>';
var data;
if(init!='NA'){
	data='<%=cfld.getAssetList(branch,assetgroup,check)%>';
	exportdata='<%=cfld.getAssetListExcel(branch,assetgroup,check)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'assetid' , type: 'String' },
						{name : 'assetname', type: 'String'  },
						{name : 'assetgrp', type: 'String'    },
						{name : 'assetloc', type: 'String'  },
						{name : 'supplier', type: 'String'  },
						{name : 'prefno', type: 'String'  },
						{name : 'pdate', type: 'date'  },
						{name : 'totalpval', type: 'number'  },
						{name : 'fixedassetac',type:'String'},
						{name :'accdeprac',type:'String'},
						{name :'deprac',type:'String'}
						],
				    localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    /* 
    
    var cellclassname = function (row, column, value, data) {
        if(typeof(data.amount)=="undefined" || data.amount=="" ){
        	return "greyClass"; 
        }
        else{
        	//alert(data.amount);
        	return "greenClass";
        };
          }; */
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#faListGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        columnsresize: true,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:false,
        columns: [
{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
}   },
						{ text: 'Asset ID', datafield: 'assetid', width: '11%'  },
						{ text: 'Asset Name', datafield: 'assetname', width: '25%' },
						{ text: 'Asset Group', datafield: 'assetgrp', width: '20%' },
						{ text: 'Asset Location', datafield: 'assetloc', width: '10%',},
						{ text: 'Supplier', datafield: 'supplier', width: '20%'},
						{ text: 'Pur Ref No', datafield: 'prefno', width: '18%'},
						{ text: 'Pur Date', datafield: 'pdate', width: '6%' ,cellsformat:'dd.MM.yyyy' },
						{ text: 'Total Pur Value', datafield: 'totalpval', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Fixed Asset A/c', datafield: 'fixedassetac', width: '20%'},
						{ text: 'Acc Depr A/c', datafield: 'accdeprac', width: '20%'},
						{ text: 'Depr A/c', datafield: 'deprac', width: '20%'}
											]

    });
   
});

	
	
</script>
<div id="faListGrid"></div>
<%@page import="com.dashboard.fixedasset.fixedassetissuelist.ClsFixedAssetIssueListDAO" %>
<%ClsFixedAssetIssueListDAO cfld=new ClsFixedAssetIssueListDAO(); %>

 <%
 String issuedstatus=request.getParameter("issue_stat")==null?"NA":request.getParameter("issue_stat"); 
 String check=request.getParameter("check")==null?"":request.getParameter("check"); 
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String groupno=request.getParameter("groupno")==null?"":request.getParameter("groupno");
 String empid=request.getParameter("empid")==null?"":request.getParameter("empid");

 %>


<script type="text/javascript">
var datagrid;
var ch='<%=check%>';
 
if(ch==1){
		datagrid='<%=cfld.getAssetList(issuedstatus,fromDate,toDate,groupno,check,empid)%>';
		var datagrid1='<%=cfld.getAssetListExcel(issuedstatus,fromDate,toDate,groupno,check,empid)%>';
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
						{name : 'issuedstatus', type: 'String'  },
						{name : 'date' ,type:'date'},
						{name : 'empname', type: 'String'  },
						{name : 'jobtype' ,type:'String'},
						{name : 'jobno' ,type:'String'},
						{name : 'assetloc', type: 'String'  },
						],
				    localdata: datagrid,
        
        
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
    

    
    $("#faIssueGrid").jqxGrid(
    {
        width: '98%',
        height: 490,
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
						{ text: 'Asset ID', datafield: 'assetid', width: '8%'  },
						{ text: 'Asset Name', datafield: 'assetname' ,width:'15%'},
						{ text: 'Asset Group', datafield: 'assetgrp', width: '15%' },
						{ text: 'Status',datafield:'issuedstatus',width:'10%'},
						{ text: 'Date',datafield:'date',width:'10%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Employee',datafield:'empname',width:'10%'},
						
						{ text: 'Job Type', datafield: 'jobtype', width: '10%'},
						{text:  'Job no',datafield:'jobno',width:'10%'},
						{ text: 'Asset Location', datafield: 'assetloc', width: '15%',},
						{ text: 'Sr No', datafield: 'srno', width: '10%',hidden:true}
						]
    });
    
   
});

</script>
<div id="faIssueGrid"></div>
<%@page import="com.dashboard.fixedasset.fixedassetissue.ClsFixedAssetIssueDAO" %>
<%ClsFixedAssetIssueDAO cfld=new ClsFixedAssetIssueDAO(); %>

 <%
 String issue_stat=request.getParameter("issue_stat")==null?"NA":request.getParameter("issue_stat"); 
 String check=request.getParameter("check")==null?"":request.getParameter("check"); 
 String groupno=request.getParameter("groupno")==null?"":request.getParameter("groupno");
 String issuestatus=request.getParameter("issuestatus")==null?"NA":request.getParameter("issuestatus"); 
 
 %>


<script type="text/javascript">
var datagrid;
var dataexcel;
var ch='<%=check%>';
var issue_st='<%=issue_stat%>';
if(ch==1){
	datagrid='<%=cfld.getAssetList(issue_stat,groupno)%>';
	dataexcel='<%=cfld.getAssetListExcel(issue_stat,groupno,issuestatus)%>';
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
						
						{name : 'transferbranchfrom', type: 'String'  },
						{name : 'transferbranchto', type: 'String'  },
						{name : 'issuedretdate', type: 'date'  },
						{name : 'issuedescription', type: 'String'  },
						
						{name : 'issuedt', type: 'date'  },
						{name : 'pdate', type: 'date'  },
						{name : 'totalpval', type: 'number'  },
						{name : 'fixedassetac',type:'String'},
						{name : 'accdeprac',type:'String'},
						{name : 'deprac',type:'String'},
						{name : 'doc_no' ,type:'String'},
						{name : 'srno' ,type:'String'},
						{name : 'issue_status' ,type:'String'},
						{name : 'type' ,type:'String'},
						{name : 'jobno', type: 'String'  },
						{name : 'type1' ,type:'String'},
						{name : 'type_no' ,type:'String'},
						{name : 'name' ,type:'String'},
						{name : 'assetinfo' ,type:'String'},
						{name : 'assetbrhid' ,type:'String'},
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
    
    $("#faIssueGrid").on("bindingcomplete", function (event) {
        
       if($('#issue_ret').val()=="tfr"){
    	  /*  $('#faIssueGrid').jqxGrid('setcolumnproperty','name','hidden',false);
    	   $('#faIssueGrid').jqxGrid('setcolumnproperty','type','hidden',false);
    	   $('#faIssueGrid').jqxGrid('setcolumnproperty','issuedt','hidden',false); */
    	   
    	   $('#faIssueGrid').jqxGrid('showcolumn', 'name');
		   $("#faIssueGrid").jqxGrid('showcolumn', 'type');
		   $("#faIssueGrid").jqxGrid('showcolumn', 'jobno');
		   $("#faIssueGrid").jqxGrid('showcolumn', 'issuedt');
		   $('#faIssueGrid').jqxGrid('showcolumn', 'transferbranchfrom');
		   $("#faIssueGrid").jqxGrid('showcolumn', 'transferbranchto');
		   $("#faIssueGrid").jqxGrid('hidecolumn', 'issuedretdate');
		   $('#faIssueGrid').jqxGrid('showcolumn', 'issuedescription');
			
       } else if($('#issue_ret').val()=="ret"){
    	  /*  $('#faIssueGrid').jqxGrid('setcolumnproperty','name','hidden',false);
    	   $('#faIssueGrid').jqxGrid('setcolumnproperty','type','hidden',false);
    	   $('#faIssueGrid').jqxGrid('setcolumnproperty','issuedt','hidden',false); */
    	   
    	   $('#faIssueGrid').jqxGrid('showcolumn', 'name');
		   $("#faIssueGrid").jqxGrid('showcolumn', 'type');
		   $("#faIssueGrid").jqxGrid('showcolumn', 'jobno');
		   $("#faIssueGrid").jqxGrid('showcolumn', 'issuedt');		   
		   $("#faIssueGrid").jqxGrid('showcolumn', 'issuedretdate');
		   $('#faIssueGrid').jqxGrid('hidecolumn', 'transferbranchfrom');
		   $("#faIssueGrid").jqxGrid('hidecolumn', 'transferbranchto');
		   $('#faIssueGrid').jqxGrid('showcolumn', 'issuedescription');
			
       } else {
    	   
    	   $('#faIssueGrid').jqxGrid('hidecolumn', 'name');
		   $("#faIssueGrid").jqxGrid('hidecolumn', 'type');
		   $("#faIssueGrid").jqxGrid('hidecolumn', 'jobno');
		   $("#faIssueGrid").jqxGrid('hidecolumn', 'issuedt');
		   $('#faIssueGrid').jqxGrid('hidecolumn', 'transferbranchfrom');
		   $("#faIssueGrid").jqxGrid('hidecolumn', 'transferbranchto');
		   $("#faIssueGrid").jqxGrid('hidecolumn', 'issuedretdate');
		   $('#faIssueGrid').jqxGrid('hidecolumn', 'issuedescription');
       }
       });
    
    
    $("#faIssueGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        columnsresize: true,
        showaggregates:true,
        statusbarheight:0,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        //pagermode: 'default',
        sortable:true,
        
        columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'Asset ID', datafield: 'assetid', width: '8%'  },
						{ text: 'Asset Name', datafield: 'assetname' ,width:'29%'},
						{ text: 'Asset Group', datafield: 'assetgrp', width: '15%' },
						{ text: 'Asset Location', datafield: 'assetloc', width: '15%',},
						{ text: 'Supplier', datafield: 'supplier', width: '18%'},
						{ text: 'Pur Ref No', datafield: 'prefno', width: '10%'},
						{ text: 'Job Type', datafield: 'type', width: '7%' },
						{ text: 'Job No', datafield: 'jobno', width: '8%' },
						{ text: 'Type1', datafield: 'type1', width: '10%',hidden: true},
						{ text: 'Type no',datafield:'type_no',width:'10%',hidden: true},
						{ text: 'Issue To',datafield:'name',width:'15%' },
						{ text: 'Issued On', datafield: 'issuedt', cellsformat: 'dd.MM.yyyy', width: '8%' },
						{ text: 'Transfered From', datafield: 'transferbranchfrom', width: '10%' },
						{ text: 'Transfered To', datafield: 'transferbranchto', width: '10%' },
						{ text: 'Returned On', datafield: 'issuedretdate', cellsformat: 'dd.MM.yyyy', width: '8%' },
						{ text: 'Description', datafield: 'issuedescription', width: '20%' },
						{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true},
						{ text: 'Sr No', datafield: 'srno', width: '10%',hidden:true},
						{ text: 'Issue Stst',datafield:'issue_status',width:'10%',hidden:true},
						{ text: 'Asset Info',datafield:'assetinfo',width:'10%',hidden:true},
						{ text: 'Asset BranchId',datafield:'assetbrhid',width:'10%',hidden:true}
						]
    });
    
    $("#overlay, #PleaseWait").hide();
    
    $('#faIssueGrid').on('rowdoubleclick', function (event) {
    	var rowindex1 = event.args.rowindex;  
    	
    			
				$('#issueddate').jqxDateTimeInput({disabled: false});
				$('#issueddate').val(new Date());
				$('#issuedtime').val(new Date());
				$('#issuedtime').jqxDateTimeInput({disabled: false});
				$("#save").attr("disabled",false);  
				$("#txtgroup").attr("disabled",false);
				$("#txtjobno").attr("disabled",false); 
				$("#txtdesp").attr("disabled",false); 
				$("#txtemp").attr("disabled",false); 
				$("#cmbjobtype").attr("disabled",false); 
				$("#cmbtype").attr("disabled",false);
				$("#txtbranch").attr("disabled",true);
				
				document.getElementById("hidbranch").value=$('#faIssueGrid').jqxGrid('getcellvalue', rowindex1, "assetbrhid");
				document.getElementById("hidfixmsrno").value=$('#faIssueGrid').jqxGrid('getcellvalue', rowindex1, "srno");
			   	document.getElementById("hidissustatus").value=$('#faIssueGrid').jqxGrid('getcellvalue', rowindex1, "issue_status");
		
		    	 var values= $('#faIssueGrid').jqxGrid('getcellvalue',rowindex1, "assetinfo");
    	 		 var sum2 = values.toString().replace(/\*/g, '\n');
      			 document.getElementById("issueinfo").value=sum2;
 });  
   
});

</script>
<div id="faIssueGrid"></div>
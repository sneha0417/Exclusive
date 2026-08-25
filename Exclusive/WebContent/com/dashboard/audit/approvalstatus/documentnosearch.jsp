<%@ page import="com.dashboard.audit.ClsAudit" %>
<%ClsAudit cas=new ClsAudit(); %>

<script type="text/javascript">
//alert("kjfgbji");
var	fleet= '<%=cas.Approvalsearch()%>';

$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'doc_no', type: 'string'  },
						{name : 'refname', type: 'string'  },
						{name : 'desc1', type: 'string'  }
       					],
				    localdata: fleet,
        
        
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
    
    
    $("#approvalsearchGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						 { text: 'Doc_No', datafield: 'doc_no', width: '30%' },
						{ text: 'Client', datafield: 'refname', width: '50%'},
						{ text: 'Description', datafield: 'desc1', width: '30%'},
						]
    
    });
    $('#approvalsearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    	//alert("passing");
    		    var boundIndex = event.args.rowindex;
    		    document.getElementById("appdoc_no").value= $('#approvalsearchGrid').jqxGrid('getcellvalue',boundIndex, "doc_no");
    		  //  alert("passing");
    		    //var values= $('#approvalsearchGrid').jqxGrid('getcellvalue',boundIndex, "appinfo");
    		    
    		   // var sum2 = values.toString().replace(/\*/g, ' \n');    
    		  //  var sum2 = values.toString().replace(/\./g, '\n');
    		   
    		   // document.getElementById("appinfo").value=sum2;
    		
    	        $('#Approvalwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="approvalsearchGrid"></div>
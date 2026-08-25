<%@page import="com.dashboard.accounts.clusteraccountstatement.ClsClusterAccountStatement"%>
<%ClsClusterAccountStatement DAO= new ClsClusterAccountStatement(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
   String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate");
   String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval");
   String cluster = request.getParameter("clusterdocno")==null?"0":request.getParameter("clusterdocno");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 
           	  
<style type="text/css">
      
   .greyClass
   {
       background-color: #E0ECF8;
   }
</style>

<script type="text/javascript">
	 var temp1='<%=branch%>';
	 var from='<%=fromDate%>';
	 var to='<%=toDate%>';
	 var data;

	 if(temp1!='NA')
     {
		 data= '<%=DAO.accountDetailsGridLoading(branch,fromDate,toDate,cluster,check)%>';
     }
	
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(typeof(value) == "undefined"){
       		value=0.00;
       	}
     	value=(parseFloat(value)).toFixed(2);
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Net Total" + '</div>';
     }
        
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'account', type: 'string'  },
					{name : 'netbalance', type: 'string'  },
					{name : 'doc_no', type: 'int'  }
						
					],
				    localdata: data,
        
        
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
    
    
    $("#accountDetailsGridID").jqxGrid(
    {
        width: '98%',
        height: 250,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						{ text: 'Accounts', datafield: 'account', width: '50%' , aggregates: ['sum1'], aggregatesrenderer:rendererstring1 },
						{ text: 'Net Balance', datafield: 'netbalance', width: '50%', cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Doc No', datafield: 'doc_no', width: '10%', hidden:true },
					]
    
    });
    
    $("#overlay, #PleaseWait").hide();    
    		
    $('#accountDetailsGridID').on('rowdoubleclick', function (event) {
    	 var boundIndex = event.args.rowindex;
    	 var docno = $('#accountDetailsGridID').jqxGrid('getcellvalue', boundIndex, "doc_no");
    	 document.getElementById("txtclusteraccount").value = docno;
    	
	     var branchval = document.getElementById("cmbbranch").value;
	   	 var fromdate = $('#fromdate').val();
	   	 var todate = $('#todate').val();
	   	 var clusterdocno = $('#txtclusterdocno').val();
   	 
   	     $("#overlay, #PleaseWait").show();
   	  
   	     $("#clusterAccountStatementDiv").load("clusterAccountStatementGrid.jsp?branchval="+branchval+'&check=1'+'&fromdate='+fromdate+'&todate='+todate+'&clusterdocno='+clusterdocno+'&clusteraccount='+$('#accountDetailsGridID').jqxGrid('getcellvalue', boundIndex, "doc_no"));
    }); 
    
});

	
	
</script>
<div id="accountDetailsGridID"></div>
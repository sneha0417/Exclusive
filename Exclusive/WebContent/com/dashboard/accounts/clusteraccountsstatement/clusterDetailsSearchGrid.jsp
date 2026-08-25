<%@page import="com.dashboard.accounts.clusteraccountstatement.ClsClusterAccountStatement"%>
<%ClsClusterAccountStatement DAO= new ClsClusterAccountStatement(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String clusterName = request.getParameter("clustersname")==null?"0":request.getParameter("clustersname");
 String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var clusterData='<%=DAO.clusterDetailsSearch(session,docNo,date,clusterName,check)%>';
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'int'   },
                        {name : 'date', type: 'string'  },
                        {name : 'name', type: 'string'   },
 						{name : 'description', type: 'string'  }
                    ],
            		localdata: clusterData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#clusterMainSearchGridID").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', width: '10%' },
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '10%' },
						{ text: 'Cluster Name', datafield: 'name', width: '30%' },
						{ text: 'Description', datafield: 'description', width: '50%' },
					]
        });
         
         $('#clusterMainSearchGridID').on('rowdoubleclick', function (event) {
             var rowindex1 =event.args.rowindex;
             document.getElementById("txtclusterdocno").value= $('#clusterMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
             document.getElementById("txtclustername").value= $('#clusterMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "name");
			 
			 $('#clusterDetailsWindow').jqxWindow('close'); 
       }); 
    });
</script>

<div id="clusterMainSearchGridID"></div>
    
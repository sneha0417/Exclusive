<%@page import="com.finance.posting.vehicledepreciationposting.ClsVehicleDepreciationPostingDAO"%>
<% ClsVehicleDepreciationPostingDAO DAO= new ClsVehicleDepreciationPostingDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String amount = request.getParameter("amount")==null?"0":request.getParameter("amount");
 String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
%> 

 <script type="text/javascript">
 
 			var data1='<%=DAO.vdpMainSearch(branch, partyname, docNo, date, amount)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'total', type: 'number' },
     						{name : 'user_name', type: 'String' },
     						{name : 'tr_no', type: 'int' }
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxVehicleDepreciationMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '20%' },
					 { text: 'Total', datafield: 'total', cellsformat: 'd2', width: '20%', cellsalign: 'right', align: 'right' },
					 { text: 'User Name', datafield: 'user_name', width: '40%' },
					 { text: 'Tr No', hidden: true, datafield: 'tr_no', width: '10%' },
					]
            });
            
			  $('#jqxVehicleDepreciationMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                $("#jqxVehDepreciationPostingDate").jqxDateTimeInput('val', $("#jqxVehicleDepreciationMainSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("docno").value= $('#jqxVehicleDepreciationMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txttrno").value= $('#jqxVehicleDepreciationMainSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
                
                 var indexVal = document.getElementById("txttrno").value;
	   			 if(indexVal>0){
	   	         $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?trno="+indexVal);
	   			 }
	   	         
	   			 var indexVal1 = document.getElementById("docno").value;
	   	         var indexVal2 = document.getElementById("txttrno").value;
	   	         if(indexVal1>0){
	   	         $("#vehiclesDetailsDiv").load("vehiclesDetailsGrid.jsp?docno="+indexVal1+"&trno="+indexVal2);
   	             } 
   	         
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="jqxVehicleDepreciationMainSearch"></div>
    
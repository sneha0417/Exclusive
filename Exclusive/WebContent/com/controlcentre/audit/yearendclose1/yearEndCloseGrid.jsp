<%@page import="com.controlcentre.audit.yearendclose.ClsYearEndCloseDAO"%>
<% ClsYearEndCloseDAO DAO = new ClsYearEndCloseDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String accountingYearFrom = request.getParameter("accountingYearFrom")==null?"0":request.getParameter("accountingYearFrom");
   String ycloseDateFrom = request.getParameter("ycloseDateFrom")==null?"0":request.getParameter("ycloseDateFrom");
   String yearEndDate = request.getParameter("yearEndDate")==null?"0":request.getParameter("yearEndDate");
   String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
   String trNo = request.getParameter("trno")==null?"0":request.getParameter("trno");%> 
<script type="text/javascript">
		var data;  
        $(document).ready(function () { 
           
            var temp='<%=trNo%>';
             
             if(temp>0){   
            	 	data='<%=DAO.yearEndCloseGridReloading(trNo)%>';
           	 } else {
           		    data='<%=DAO.yearEndCloseGridLoading(accountingYearFrom,ycloseDateFrom,yearEndDate)%>';
           	 }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'docno', type: 'int' },
     						{name : 'account', type: 'string'   },
     						{name : 'accountname', type: 'string'  },
     						{name : 'currencyid', type: 'int'   },
     						{name : 'rate', type: 'number' },
     						{name : 'amount', type: 'number' },
     						{name : 'description', type: 'string'   },
     						{name : 'brhid', type: 'int'   }
                        ],
                         localdata: data,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#yearEndCloseGridID").jqxGrid(
            {
                width: '70%',
                height: 350,
                source: dataAdapter,
                editable: false,
                showaggregates: true,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No', hidden: true, datafield: 'docno',  width: '5%' },
							{ text: 'Account', datafield: 'account',  width: '10%' },	
							{ text: 'Account Name', datafield: 'accountname', width: '30%' },	
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', width: '10%' },
							{ text: 'Rate', datafield: 'rate', hidden: true, cellsformat: 'd2', width: '4%', cellsalign: 'right', align: 'right' },
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Description', datafield: 'description', width: '40%' },
							{ text: 'Branch Id', hidden: true, datafield: 'brhid', width: '10%' },
						]
            });
         	  
            if(temp>0){
            	$("#yearEndCloseGridID").jqxGrid('disabled', true);
            }
          
            var amount=$('#yearEndCloseGridID').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
            if(!isNaN(amount)){
      		    funRoundAmt(amount,"txtnettotal");
      		  }
      		 else{
		    	 funRoundAmt(0.00,"txtnettotal");
		     }
});
        
</script>
<div id="yearEndCloseGridID"></div>
    
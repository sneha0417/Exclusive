<%@page import="com.dashboard.realestate.contractpdcupdate.*"%>
<% ClsContractPDCUpdateDAO DAO= new ClsContractPDCUpdateDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 <%
String type=request.getParameter("type")==null?"":request.getParameter("type");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String paymenttrno=request.getParameter("paymenttrno")==null?"0":request.getParameter("paymenttrno");
String tenantacno=request.getParameter("tenantacno")==null?"0":request.getParameter("tenantacno");
%> 

 <script type="text/javascript">
var existingbrvdata=[];
var id='<%=id%>';
if(id=="1"){
	existingbrvdata='<%=DAO.brvSearchData(type,id,session,paymenttrno,tenantacno)%>';
}
 			
			$(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'description', type: 'String' },
                            {name : 'doc_no', type: 'int'},
     						{name : 'date', type: 'date'},
     						{name : 'amount', type: 'number'},
     						{name : 'chqno', type: 'String' },
     						{name : 'chqdt', type: 'date'  },
     						{name : 'tr_no',type:'string'}
                          	],
                          	localdata: existingbrvdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#existingbrvsearchgrid").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
                     { text: 'Party Name', datafield: 'description', width: '25%' },
					 { text: 'Doc No', datafield: 'doc_no', width: '15%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '15%' },
					 { text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right' },
					 { text: 'Cheque No', datafield: 'chqno', width: '15%' },
					 { text: 'Cheque Date', datafield: 'chqdt', cellsformat: 'dd.MM.yyyy' , width: '15%' },
					 { text: 'TR No', datafield: 'tr_no', width: '15%' ,hidden:true},
					]
            });
            
			  $('#existingbrvsearchgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                var type='<%=type%>';
                if(type=="0"){
                	$('#existingbrvwindow').jqxWindow('close');
                	$('#existingbrv').val($('#existingbrvsearchgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                	$('#hidexistingbrv').val($('#existingbrvsearchgrid').jqxGrid('getcellvalue', rowindex1, "tr_no"));
                }
                else if(type=="1"){
                	$('#newbrvwindow').jqxWindow('close');
                	$('#newbrv').val($('#existingbrvsearchgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                	$('#hidnewbrv').val($('#existingbrvsearchgrid').jqxGrid('getcellvalue', rowindex1, "tr_no"));
                }
            });   
				           
}); 
				       
                       
    </script>
    <div id="existingbrvsearchgrid"></div>
    
<%@page import="com.operations.crm.callregister.ClsCallRegisterDAO"%>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientsname = request.getParameter("clientsname")==null?"0":request.getParameter("clientsname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String calltype = request.getParameter("calltype")==null?"":request.getParameter("calltype");
 String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
%> 

 <script type="text/javascript">
 var regno='<%=regno%>';
 //alert(regno);
 			var data8='<%=DAO.cregMainSearch(session, clientsname, docNo, date, calltype, regno)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'regno', type: 'String' },
     						{name : 'client', type: 'String' },
     						{name : 'calltype', type: 'String' },
                          	],
                          	localdata: data8,
                
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
            $("#cregMainSearchGridID").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
							 { text: 'Doc No', datafield: 'doc_no', width: '15%' },
							 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '15%' },
							 { text: 'Client', datafield: 'client', width: '40%' },
							 { text: 'Call Type', datafield: 'calltype', width: '10%' },
							 { text: 'Reg No', datafield: 'regno', width: '20%' },
					]
            });
            
			  $('#cregMainSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;

                document.getElementById("txtclientname").value= $('#cregMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "client");
                document.getElementById("docno").value= $('#cregMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmCallRegister select').attr('disabled', false);
                $('#callRegisterDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmCallRegisterss").submit();
                $('#frmCallRegister select').attr('disabled', true);
                $('#callRegisterDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="cregMainSearchGridID"></div>
    
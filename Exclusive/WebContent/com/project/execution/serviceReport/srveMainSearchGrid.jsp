<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<% ClsServiceReportDAO DAO = new ClsServiceReportDAO(); %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientsname = request.getParameter("clientsname")==null?"0":request.getParameter("clientsname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String contractstype = request.getParameter("contractstype")==null?"0":request.getParameter("contractstype");
 String contractsno = request.getParameter("contractsno")==null?"0":request.getParameter("contractsno");
 String schedulesno = request.getParameter("schedulesno")==null?"0":request.getParameter("schedulesno");
%> 

 <script type="text/javascript">
 
 			var data6='<%=DAO.srveMainSearch(session, clientsname, docNo, date, contractstype, contractsno,schedulesno)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'client', type: 'String' },
							{name : 'site', type: 'String' },
     						{name : 'contracttype', type: 'String' },
     						{name : 'contractno', type: 'String' },
     						{name : 'scheduleno', type: 'String' },
     						{name : 'chkrect', type: 'String' },
     						{name : 'rect', type: 'String' },
                          	],
                          	localdata: data6,
                
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
            $("#srveMainSearchGridID").jqxGrid(
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
							 { text: 'Site', datafield: 'site', width: '30%' },
							 { text: 'Cont. Type', datafield: 'contracttype', width: '10%' },
							 { text: 'Contract No', datafield: 'contractno', width: '10%' },
							 { text: 'Schedule No', datafield: 'scheduleno', width: '10%' },
							 { text: 'Check Rectification', datafield: 'chkrect', width: '10%' ,hidden:false},
							 { text: 'Rectification', datafield: 'rect', width: '10%',hidden:false},
					]
            });
            
			  $('#srveMainSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("txtcustomer").value= $('#srveMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "client");
                document.getElementById("docno").value= $('#srveMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmServiceReport select').attr('disabled', false);
                $('#serviceReportDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmServiceReport").submit();
                $('#frmServiceReport select').attr('disabled', true);
                $('#serviceReportDate').jqxDateTimeInput({disabled: true});
                document.getElementById("chkrect").value=$('#srveMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "chkrect");
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="srveMainSearchGridID"></div>
    
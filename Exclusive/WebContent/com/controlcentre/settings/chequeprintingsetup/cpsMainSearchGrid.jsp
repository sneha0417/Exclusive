<%@page import="com.controlcentre.settings.chequeprintingsetup.ClsChequeSetUpDAO" %>
<%ClsChequeSetUpDAO csu=new ClsChequeSetUpDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String chqdate = request.getParameter("chqdate")==null?"0":request.getParameter("chqdate");
 String documentno = request.getParameter("documentno")==null?"0":request.getParameter("documentno");
 String bankid = request.getParameter("bankid")==null?"0":request.getParameter("bankid");
 String bankname = request.getParameter("bankname")==null?"0":request.getParameter("bankname");
%> 

 <script type="text/javascript">
 
 var data1='<%=csu.cpsMainSearch(session, chqdate, documentno, bankid, bankname)%>';
        $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'int'  },
     						{name : 'date', type: 'date' },
     						{name : 'bankid', type: 'String' },
     						{name : 'bankname', type: 'String' } 
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
            $("#jqxclientsearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
     					
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '10%' },
					 { text: 'Date', datafield: 'date', width: '15%', cellsformat: 'dd.MM.yyyy' },
					 { text: 'Bank Id', datafield: 'bankid', width: '15%' },
					 { text: 'Bank Name', datafield: 'bankname', width: '60%' }
					]
            });
            
			  $('#jqxclientsearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("docno").value= $('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtbankid").value= $('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "bankid");
                document.getElementById("txtbankname").value= $('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "bankname");
                
                $('#jqxChqPrintSetUpDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmChequePrintingSetUp").submit();
                $('#jqxChqPrintSetUpDate').jqxDateTimeInput({disabled: true});
                
                $('#window').jqxWindow('close');
            });  
				           
}); 
				       
                       
    </script>
    <div id="jqxclientsearch"></div>
    
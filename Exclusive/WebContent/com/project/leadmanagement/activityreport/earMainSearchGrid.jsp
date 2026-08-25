<%@page import="com.project.leadmanagement.activityreport.ClsActivityReportDAO"%> 
<% ClsActivityReportDAO DAO=new ClsActivityReportDAO(); %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String highlight = request.getParameter("highlight")==null?"0":request.getParameter("highlight");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String status = request.getParameter("status")==null?"0":request.getParameter("status");
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); 
%> 

 <script type="text/javascript">
 
 			var data1='<%=DAO.earMainSearch(session, highlight, docNo, date, status, check)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'highlight', type: 'String' }, 
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'fromstatus', type: 'number' }
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
            $("#earMainSearchGridID").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			
                columns: [
                     { text: 'Highlight', datafield: 'highlight', width: '40%' },
					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '20%' },
					 { text: 'Status', datafield: 'fromstatus', width: '20%' },
					]
            });
            
			  $('#earMainSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txthighlight").value= $('#earMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "highlight");
                document.getElementById("docno").value= $('#earMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmActivityReport select').attr('disabled', false);
                $('#activityDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmActivityReport").submit();
                $('#frmActivityReport select').attr('disabled', true);
                $('#activityDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="earMainSearchGridID"></div>
    
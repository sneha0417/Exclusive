<%@page import="com.gwinternal.operations.changesdone.ClsChangesDoneDAO"%>
<% ClsChangesDoneDAO DAO= new ClsChangesDoneDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String forms = request.getParameter("forms")==null?"0":request.getParameter("forms");
 String projects = request.getParameter("projects")==null?"0":request.getParameter("projects");
 String description = request.getParameter("description")==null?"0":request.getParameter("description");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
 			var data='<%=DAO.chngMainSearch(session, docNo, date, forms, projects, description, check)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'projects', type: 'String' },
     						{name : 'form_name', type: 'String' }, 
     						{name : 'description', type: 'String' },
     						{name : 'employee', type: 'String' } 
                          	],
                          	localdata: data,
                
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
            $("#chngMainSearchGridID").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '15%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '15%' },
					 { text: 'Projects', datafield: 'projects', width: '25%' },
					 { text: 'Form', datafield: 'form_name', width: '15%' },
					 { text: 'Description', datafield: 'description', width: '15%' },
					 { text: 'Employee', datafield: 'employee', width: '15%' },
					]
            });
            
			  $('#chngMainSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtchangedformdescription").value= $('#chngMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("docno").value= $('#chngMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmChangesDone select').attr('disabled', false);
                $('#changesDoneDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmChangesDone").submit();
                $('#frmChangesDone select').attr('disabled', true);
                $('#changesDoneDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="chngMainSearchGridID"></div>
    
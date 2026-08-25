 <%@page import="com.project.execution.quotationnew.ClsQuotationDAO"%> 
<%ClsQuotationDAO DAO= new ClsQuotationDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String code = request.getParameter("code")==null?"0":request.getParameter("code");
 String name = request.getParameter("name")==null?"0":request.getParameter("name");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var tempData='<%=DAO.templateSearchGridLoading(code, name, check)%>'; 
	
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                         {name : 'doc_no', type: 'int'  },
						 {name : 'code', type: 'string'   },
						 {name : 'name', type: 'string'  }
                    ],
            		localdata: tempData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#templateSearchGridId").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '10%' },
						{ text: 'Code', datafield: 'code', width: '40%' },
						{ text: 'Name', datafield: 'name', width: '60%' },
					]
        });
        
         $('#templateSearchGridId').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
           
            document.getElementById("txttemplatecode").value = $('#templateSearchGridId').jqxGrid('getcellvalue', rowindex1, "code");
        	document.getElementById("txttemplatename").value = $('#templateSearchGridId').jqxGrid('getcellvalue', rowindex1, "name");
        	document.getElementById("txttemplateid").value = $('#templateSearchGridId').jqxGrid('getcellvalue', rowindex1, "doc_no");
        	
            $('#templatesearchwindow').jqxWindow('close');  
        });  
    });
</script>

<div id="templateSearchGridId"></div>
    
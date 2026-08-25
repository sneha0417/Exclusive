<%@page import="com.dashboard.cargo.joblisting.*" %>
<% ClsJobListing DAO=new ClsJobListing(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<script type="text/javascript">
        
       var data1= '<%=DAO.jobnoSearch()%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'jobno', type: 'String'},
     						{name : 'doc_no', type: 'String'}
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxJobnoGrid").jqxGrid(
            {
                width: '95%',
                height: 345,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Job No',  datafield: 'doc_no', width: '100%' },
							{ text: 'joblistno', datafield: 'jobno', hidden :true }
						]
            });
            
             $('#jqxJobnoGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("jobno").value = $('#jqxJobnoGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("hidjobno").value = $('#jqxJobnoGrid').jqxGrid('getcellvalue', rowindex1, "jobno");
            	$('#jobnoSearchWindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="jqxJobnoGrid"></div>
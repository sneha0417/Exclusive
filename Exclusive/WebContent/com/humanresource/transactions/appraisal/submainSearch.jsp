<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.humanresource.transactions.appraisal.ClsAppraisalDAO"%>
<% ClsAppraisalDAO viewDAO= new ClsAppraisalDAO();
   String empns = request.getParameter("empns")==null?"0":request.getParameter("empns");
   String empids = request.getParameter("empids")==null?"0":request.getParameter("empids");
   String docnoss = request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
   String mobnos = request.getParameter("mobnos")==null?"0":request.getParameter("mobnos");
%> 

<script type="text/javascript">
 
	var loaddata1='<%=viewDAO.mainSrearch(empns,empids,docnoss,mobnos)%>';
	 
        $(document).ready(function () { 
 
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'name', type: 'String'},
     						{name : 'empid', type: 'String'},
     						{name : 'doc_no', type: 'String'}, 
     						{name : 'date', type: 'date'},
     						{name : 'empids', type: 'String'}, 
     						{name : 'pmmob', type: 'String'}, 
                          	],
                          	localdata: loaddata1,
                
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
            
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 290,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
     					
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '10%' ,columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'dd.MM.yyyy' },
							{ text: 'Emp ID', datafield: 'empids', width: '20%'},
							{ text: 'Name', datafield: 'name', width: '40%' }, 
							{ text: 'MOB', datafield: 'pmmob', width: '20%'},
                         	{ text: 'empdoc', datafield: 'empid', width: '15%',hidden:true},
					
					]
            });
    
			$('#jqxmainsearch').on('rowdoubleclick', function (event)  { 
				    var rowindex1=event.args.rowindex;
					funReset();
				    document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				    $('#window').jqxWindow('close');
				    funSetlabel();
				    document.getElementById("frmappraisal").submit();
				            
         		  });	 
              }); 
				       
                       
</script>
<div id="jqxmainsearch"></div>

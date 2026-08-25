<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
String mobno=request.getParameter("mobno")==null?"0":request.getParameter("mobno");
String aa=request.getParameter("aa")==null?"0":request.getParameter("aa");
String client=request.getParameter("client")==null?"0":request.getParameter("client");
String refno=request.getParameter("refno")==null?"0":request.getParameter("refno");
%>
<%@page import="com.cargo.costingforinvoicing.ClsCostingForInvoicingDAO"%>
<% ClsCostingForInvoicingDAO DAO = new ClsCostingForInvoicingDAO(); %> 
<script type="text/javascript"> 
var data; 
var temps='<%=aa%>';
if(temps='yes')
{
	var vahReqmaster= '<%=DAO.refSearchMasters(session,docnoss,mobno,aa,client,refno) %>'; 
}
else
{
	  vahReqmaster;  
}

$(document).ready(function () { 	
	var source =
	{
			datatype: "json",
			datafields: [
			             {name : 'masterdocno', type: 'int'},  
			       
			             {name : 'date', type: 'date'  },
			             {name : 'jobno', type: 'string'   },
			             {name : 'refname', type: 'string'  },
			           
			             {name : 'mob', type: 'string'  },
			             {name : 'refno', type: 'string'  },
			           
			             
			             ],
			             localdata: vahReqmaster,
			             pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
			             }
	};
	var dataAdapter = new $.jqx.dataAdapter(source,
			{
		loadError: function (xhr, status, error) {
			alert(error);    
		}
			}		
	);

	$("#jqxrefnoSearch").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                columns: [      
                            { text: 'doc_no', datafield: 'masterdocno', width: '20%' ,hidden: true},	
						 
							{ text: 'Jobno', datafield: 'jobno', width: '8%', editable: false },
							
							{ text: 'Date', datafield: 'date', width: '10%' ,cellsformat:'dd.MM.yyyy', editable: false},
							{ text: 'Client', datafield: 'refname' , editable: false },
							{ text: 'Ref No', datafield: 'refno', width: '10%'  , editable: false},
						 
							{ text: 'MOB', datafield: 'mob', width: '15%'   },
							 
			              ]
               
            });
            $("#jqxrefnoSearch").on('cellvaluechanged', function (event) 
            {
            	document.getElementById("errormsg").innerText="";
            });
            $("#jqxrefnoSearch").on("celldoubleclick", function (event)
            {
        		    var args = event.args;
        		    var rowBoundIndex = event.args.rowindex;
        		    var refno = $('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"jobno");
        		    $('#refno').val(refno);
        		    $('#refnos').val($('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"refno"));
        		    $('#mastertr_no').val($('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"masterdocno"));
        		    
        		    document.getElementById("errormsg").innerText="";
        		    $("#enqdiv").load('estmgrid.jsp?rdocno='+$('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"masterdocno"));
        		    $("#expdiv").load('expgrid.jsp?rdocno1='+$('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"jobno"));
        		    $('#refnosearchwindow').jqxWindow('close');
            });
});
    </script>
    <div id=jqxrefnoSearch></div>
 
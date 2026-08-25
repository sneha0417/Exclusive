<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
String datess=request.getParameter("datess")==null?"0":request.getParameter("datess");
String aa=request.getParameter("aa")==null?"0":request.getParameter("aa");
String client=request.getParameter("client")==null?"0":request.getParameter("client");
%>
<%@page import="com.cargo.estimation.ClsEstimationDAO"%>
<% ClsEstimationDAO DAO = new ClsEstimationDAO(); %> 
<script type="text/javascript">
var data;
var temps='<%=aa%>';
if(temps='yes')
{
	var vahReqmaster= '<%=DAO.refSearchMasters(session,docnoss,datess,aa,client) %>'; 
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
			             {name : 'voc_no', type: 'int'},  
			             {name : 'doc_no', type: 'int'},
			             {name : 'date', type: 'date'  },
			             {name : 'cldocno', type: 'string'   },
			             {name : 'refname', type: 'string'  },
			             {name : 'address', type: 'string'  },
			             {name : 'mob', type: 'string'  },
			             {name : 'email', type: 'string'  },
			             {name : 'remarks', type: 'string'  },
			             
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
                height: 320,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                columns: [      
                            { text: 'doc_no', datafield: 'doc_no', width: '20%' ,hidden: true},	
							{ text: 'DocNo', datafield: 'voc_no', width: '20%', editable: false },	
							{ text: 'Date', datafield: 'date', width: '30%' ,cellsformat:'dd.MM.yyyy', editable: false},
							{ text: 'Client', datafield: 'refname', width: '50%', editable: false },
							{ text: 'cldocno', datafield: 'cldocno', width: '2%' ,hidden: true, editable: false},
							{ text: 'address', datafield: 'address', width: '2%'  },
							{ text: 'mob', datafield: 'mob', width: '2%'  ,hidden:true },
							{ text: 'email', datafield: 'email', width: '2%'  ,hidden:true },
							{ text: 'remarks', datafield: 'remarks', width: '2%'  ,hidden:true },
			              ]
               
            });
            $("#jqxrefnoSearch").on('cellvaluechanged', function (event) 
            {
            	document.getElementById("errormsg").innerText="";
            });
            $("#jqxrefnoSearch").on("celldoubleclick", function (event)
            {
        		    var rowBoundIndex = event.args.rowindex;  
        		    var refno = $('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"voc_no");
        		    $('#refno').val(refno);
        		    $('#hidrefno').val($('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"doc_no"));
        		    $('#txtclient').val($('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"cldocno"));
        		    $('#txtclientname').val($('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"refname"));
        		    $('#txtaddress').val($('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"address"));
        		    $('#txtmobile').val($('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"mob"));
        		    $('#txtemail').val($('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"email"));
        		    $('#txtRemarks').val($('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"remarks"));
        		    $("#enqdiv").load('reqDetails.jsp?enqrdocno='+$('#jqxrefnoSearch').jqxGrid('getcellvalue',rowBoundIndex,"doc_no"));
        		    $('#refnosearchwindow').jqxWindow('close');
            });
});
    </script>
    <div id=jqxrefnoSearch></div>
 
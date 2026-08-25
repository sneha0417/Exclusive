   <%@page import="com.dashboard.project.callregisterdetail.ClscallregisterDetailDAO"%>
     <%
     ClscallregisterDetailDAO cmd= new ClscallregisterDetailDAO();
     %>
 
 

 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
  <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String complid =request.getParameter("complid")==null?"0":request.getParameter("complid").toString();%>

<% String userid =request.getParameter("userid")==null?"0":request.getParameter("userid").toString();%>
 <% String ctype =request.getParameter("ctype")==null?"0":request.getParameter("ctype").toString();%>
 
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
    
 
<script type="text/javascript">
 var temp4='<%=id%>';
var enqdata,enqlistexcel;

 if(temp4==1)
{ 
	 enqdata='<%=cmd.estCenterdata(fromdate,todate,branch,complid,userid,ctype)%>' ; 
	 enqlistexcel='<%=cmd.enquirylistExcel(fromdate,todate,branch,complid,userid,ctype)%>'; 
		// alert(enqdata);
} 
else
{ 
	
	enqdata;
	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                   
 						{name : 'docno', type: 'String' },
 						{name : 'date', type: 'date' },
 						{name : 'user', type: 'String' },
 						{name : 'site', type: 'String' },
 						{name : 'refname', type: 'String' },
 						{name : 'pldate', type: 'date' },
 						{name : 'sertype', type: 'String' },
 						{name : 'asgngrp', type: 'String' },
 						{name : 'emp', type: 'String' },
 						{name : 'compl', type: 'String' },
 						{name : 'duration', type: 'String' }
						],
				    localdata: enqdata,
        
        
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
   
    $("#callDetailgrid").jqxGrid(
    {
        width: '99%',
        height: 540,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        columnsresize:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                    
					{ text: 'DOC NO',  datafield: 'docno', width: '5%' },
					 { text: 'DATE', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy : HH:mm'},
					 { text: 'USER', width: '9%', datafield: 'user' },
					 { text: 'CLIENT',  datafield: 'refname', width: '17%' },					 
					{ text: 'SERVICE TYPE', width: '12%', datafield: 'sertype' },
					{ text: 'SITE', width: '15%', datafield: 'site' },
					{ text: 'COMPLAINT', width: '15%', datafield: 'compl' },
					{ text: 'PLANNED ON',  datafield: 'pldate', width: '8%',cellsformat:'dd.MM.yyyy : HH:mm' },
					{ text: 'ASSIGN.GROUP', datafield: 'asgngrp', width: '8%' },
					{ text: 'EMPLOYEE', datafield: 'emp', width: '8%' },
					
					{ text: 'DURATION', width: '6%', datafield: 'duration' },
				
					]
   
    });
    $("#overlay, #PleaseWait").hide();
 
   
});


</script>
<div id="callDetailgrid"></div>
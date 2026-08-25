<%@page import="com.dashboard.realestate.tenancymanagement.*"%>
<% ClsTenancyManagementDAO DAO= new ClsTenancyManagementDAO(); %>        
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>     
 <%
     String userid=request.getParameter("userid")==null?"0":request.getParameter("userid").toString();
 %>                
<script type="text/javascript">          
var pdata;         
 pdata='<%=DAO.pendingGrid(userid) %>';                                                 
 
$(document).ready(function(){  

        var source =
        {
            datatype: "json",            
            datafields: [   
                        {name : 'crtuser', type: 'string'},     
                        {name : 'userid', type: 'string'},      
                        {name : 'ass_user', type: 'string'},  
                      	{name : 'doc_no', type: 'string'},
 						{name : 'strt_date',type:'date'},
 						{name : 'strt_time',type:'string'},
                      	{name : 'description', type: 'string'},      
                      	{name : 'status',type:'string'}, 
                      	{name : 'user',type:'string'},  
             ],
             localdata: pdata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        $("#pendingGrid").on("bindingcomplete", function (event) {
        	
        });   
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#pendingGrid").jqxGrid(  
                {
                	width: '100%',
                    height: 200,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    //Add row method 
                    columns: [            
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },             
    					{ text: 'Doc No',datafield: 'doc_no', width: '4%'},            
    					{ text: 'Created User',datafield: 'crtuser', width: '12%'},  
    					{ text: 'St.Date',datafield: 'strt_date', width: '6%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'St.Time',datafield: 'strt_time', width: '6%',cellsformat:'dd.MM.yyyy HH:mm:ss'},         
    					{ text: 'Description',datafield: 'description'},       
    					{ text: 'User',datafield: 'user', width: '12%'}, 
    					{ text: 'Status',datafield: 'status', width: '8%'}, 
    					{ text: 'Assignuser',datafield: 'ass_user', width: '12%',hidden:true},  
    					{ text: 'createuser',datafield: 'userid', width: '12%',hidden:true},
    	              ]                                         
                }); 
        $('#pendingGrid').on('rowdoubleclick', function (event) {    
            
            var rowindex2 = event.args.rowindex;                      
            document.getElementById("txtpendocno").value=$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
            document.getElementById("txtasgnuser").value=$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "ass_user");
            document.getElementById("txtcrtuser").value=$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "userid");
            document.getElementById("txtoldstatus").value=$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "status");
            var crtuser=$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "userid");
            funstatusval(crtuser); 
           
            
        	$('#flwupdiv').load('taskfollowupGrid.jsp?docno='+$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "doc_no"));  
        });       
	});
</script>
<div id="pendingGrid"></div>
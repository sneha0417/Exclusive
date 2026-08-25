<%@ page import="com.dashboard.audit.loginprivilage.ClsLoginPrivilageDAO" %>
<% ClsLoginPrivilageDAO DAO=new ClsLoginPrivilageDAO(); %>
<% String user = request.getParameter("user")==null?"":request.getParameter("user");
   String rpttype = request.getParameter("rpttype")==null?"":request.getParameter("rpttype");
   String check = request.getParameter("check")==null?"":request.getParameter("check");
%>
<script type="text/javascript">
	var data;
	var temp='<%=check%>';

	if(temp=='1'){ 
		 data='<%=DAO.userLoginPrivilageGridLoading(user,rpttype,check)%>';
	}
	
	$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'doc_no', type: 'String'  },
					{name : 'user_name', type: 'String' },
					{name : 'date', type: 'date'  },
					{name : 'win_cmp', type: 'String' },
					{name : 'win_user', type: 'String' },
					{name : 'mac_address', type: 'String' },
					{name : 'userinfo', type: 'String' }

				    ],
				    localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#loginPrivilageGridID").on("bindingcomplete", function (event) {$('#overlay,#PleaseWait').hide();});
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#loginPrivilageGridID").jqxGrid(
    {
    	width: '99%',
        height: 525,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        columnsresize:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
					{ text: 'Sr. No.',datafield: '',columntype:'number', width: '8%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}   },	
					{ text: 'Doc No',datafield:'doc_no', hidden: true, width:'10%'},
					{ text: 'Username',datafield:'user_name',width:'22%'},
					{ text: 'Date & Time',datafield:'date', cellsformat: 'dd.MM.yyyy HH:mm:ss', width:'10%'},
					{ text: 'Computer', datafield: 'win_cmp', width: '20%' },
					{ text: 'Profile', datafield: 'win_user', width: '20%' },
					{ text: 'MAC Address', datafield: 'mac_address', width: '20%' },
					{ text: 'User Info', datafield: 'userinfo', hidden: true, width: '20%' }
					
					]
    
    });
    
    $('#loginPrivilageGridID').on('rowdoubleclick', function (event)  { 
    	var rowindex1 = event.args.rowindex;
    	
    	if(document.getElementById("rdapproval").checked==true){
    		
	    	document.getElementById("txtprivilageuser").value= $('#loginPrivilageGridID').jqxGrid('getcellvalue',rowindex1, "doc_no");
	    	document.getElementById("txtprivilagemacaddress").value= $('#loginPrivilageGridID').jqxGrid('getcellvalue',rowindex1, "mac_address");
	    	
	    	$('#btnPrivilage').attr("disabled",false);
	    	var values= $('#loginPrivilageGridID').jqxGrid('getcellvalue',rowindex1, "userinfo");
	    	var sum2 = values.toString().replace(/\*/g,'\n');
	    	document.getElementById("txtprivilaging").value=sum2;
	    	
    	}
    			
    });
    
});

</script>
<div id="loginPrivilageGridID"></div>
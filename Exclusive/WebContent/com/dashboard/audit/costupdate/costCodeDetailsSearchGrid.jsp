 <%@page import="com.dashboard.audit.costupdate.ClsCostupdateDAO" %>
<% ClsCostupdateDAO ccd=new ClsCostupdateDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String type = request.getParameter("type")==null?"0":request.getParameter("type");
   String costcode = request.getParameter("costCode")==null?"0":request.getParameter("costCode");
   String costcodename = request.getParameter("costCodeName")==null?"0":request.getParameter("costCodeName");
   String regno = request.getParameter("RegNo")==null?"0":request.getParameter("RegNo");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>  
<script type="text/javascript">
        
       var costsearch = '<%=ccd.costCodeDetailsSearch(type, costcode, costcodename, regno, check)%>';
       
       $(document).ready(function () { 
    	   
    	   var costtype='<%=type%>';
    	   
    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'string' },
							{name : 'reg_no', type: 'string'  },
                            {name : 'code', type: 'string'  },
                            {name : 'name', type: 'string'  }
                        ],
                		 localdata: costsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#costCodeSearchGridID").on("bindingcomplete", function (event) {
			    if (costtype !="6"){
            		$('#costCodeSearchGridID').jqxGrid('hidecolumn', 'reg_no');
			    }
            });
			
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costCodeSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Docno', datafield: 'doc_no', width: '20%', hidden: true },
							{ text: 'Reg No.', datafield: 'reg_no', width: '20%' },
							{ text: 'Cost Code', datafield: 'code', width: '20%' },
							{ text: 'Cost Group', datafield: 'name' },
						]
            });
            
            
             $('#costCodeSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                if($('#cmbcosttype').val().trim()=='3' || $('#cmbcosttype').val().trim()=='4'){
                	document.getElementById("hidcostcode").value = $('#costCodeSearchGridID').jqxGrid('getcellvalue', rowindex1, "code");
                	document.getElementById("costcode").value = $('#costCodeSearchGridID').jqxGrid('getcellvalue', rowindex1, "code");
            		document.getElementById("costcodename").value = $('#costCodeSearchGridID').jqxGrid('getcellvalue', rowindex1, "name");
                } else if($('#cmbcosttype').val().trim()=='5'){
                	document.getElementById("hidcostcode").value = $('#costCodeSearchGridID').jqxGrid('getcellvalue', rowindex1, "code");
                	document.getElementById("costcode").value = $('#costCodeSearchGridID').jqxGrid('getcellvalue', rowindex1, "code");
            		document.getElementById("costcodename").value = $('#costCodeSearchGridID').jqxGrid('getcellvalue', rowindex1, "name");
                }
                else{
                	document.getElementById("costcode").value = $('#costCodeSearchGridID').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("hidcostcode").value = $('#costCodeSearchGridID').jqxGrid('getcellvalue', rowindex1, "code");
            	document.getElementById("costcodename").value = $('#costCodeSearchGridID').jqxGrid('getcellvalue', rowindex1, "name");
                }    	       	
            	$('#costCodeDetailsWindow').jqxWindow('close'); 
            });  
        });
       
</script>
<div id="costCodeSearchGridID"></div>
 
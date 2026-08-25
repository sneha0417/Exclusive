<%@page import="com.fixedassets.masters.groupmaster.ClsFixedAssetGroupDAO" %>
<%ClsFixedAssetGroupDAO fag=new ClsFixedAssetGroupDAO(); %>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <script type="text/javascript">
 
 var datagrp='<%=fag.grpgridLoad(session)%>';
        $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'doc_no', type: 'int'  },
     						{name : 'grp_name', type: 'String' },
     						{name : 'grp_code', type: 'String' },
     						{name : 'grpdate', type: 'date' }
                          	],
                          	localdata: datagrp,
                
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
            $("#jqxgroupgrid").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
     					
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '10%' },
					 { text: 'Group Name', datafield: 'grp_name', width: '40%' },
					 { text: 'Group Code', datafield: 'grp_code', width: '30%'},
					 { text: 'Date', datafield: 'grpdate', width: '20%', cellsformat: 'dd.MM.yyyy'  }
					]
            });
            
            if(document.getElementById("mode").value=='A'){
            	$('#jqxgroupgrid').jqxGrid({ disabled: true});
            }
            
			  $('#jqxgroupgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                 document.getElementById("docno").value= $('#jqxgroupgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("fgmname").value= $('#jqxgroupgrid').jqxGrid('getcellvalue', rowindex1, "grp_name");
                document.getElementById("fgmcode").value= $('#jqxgroupgrid').jqxGrid('getcellvalue', rowindex1, "grp_code");
                document.getElementById("fgmdate").value= $('#jqxgroupgrid').jqxGrid('getcellvalue', rowindex1, "grpdate");
               
            });  
				           
}); 
				       
                       
    </script>
    <div id="jqxgroupgrid"></div>
    
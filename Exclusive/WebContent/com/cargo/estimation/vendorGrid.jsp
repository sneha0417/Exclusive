<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.cargo.estimation.ClsEstimationDAO" %>
<%
ClsEstimationDAO DAO=new ClsEstimationDAO();
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
String id = request.getParameter("id")==null?"0":request.getParameter("id");
%> 
<script type="text/javascript">
var cldata;
var id='<%=id%>';
if(id>0){
	cldata = '<%=DAO.searchVendor(session,clname,mob,id)%>';
}
    $(document).ready(function () { 
    	var num = 0; 
    	var source = 
    	{
    			datatype: "json",
    			datafields: [
     						
     						{name : 'refname', type: 'String'  },
     						{name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						{name : 'cldocno', type: 'String'  }
     						],
     						localdata: cldata,
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
            $("#Jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
     					
                columns: [
					
					{ text: 'NAME', datafield: 'refname', width: '30%' },
					{ text: 'ADDRESS', datafield: 'address', width: '55%' }, 
					{ text: 'MOB', datafield: 'per_mob', width: '15%' },
					{ text: 'cldocno', datafield: 'cldocno', width: '5%', hidden: true },
					]
            });
				           $('#Jqxclientsearch').on('rowdoubleclick', function (event) 
				           { 
				              	var rowindex2=event.args.rowindex;
				              	var rowindex1 = $('#rowindex').val();
				              	$("#jqxEstimation").jqxGrid('setcellvalue', rowindex1, "vendor", $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex2, "refname"));
				              	$("#jqxEstimation").jqxGrid('setcellvalue', rowindex1, "vndid", $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex2, "cldocno"));
				              	$('#vendorsearchwindow').jqxWindow('close');
				              	
				           }); 	 
                  }); 
    </script>
    <div id="Jqxclientsearch"></div>
    
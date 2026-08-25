<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.cargo.assignment.ClsAssignment"%>
<%ClsAssignment assignment=new ClsAssignment();%>
<%
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
String aa = request.getParameter("aa")==null?"0":request.getParameter("aa");
%> 
<script type="text/javascript">
var cldata; 
var aa='<%=aa%>';
 $(document).ready(function () { 
     if(aa=="yes"){   	 
    	 cldata='<%=assignment.vendorSearch(session,clname,mob,aa)%>';
    	 
     }
     else{
    	 cldata=[];
     }
        	 var source = 
        	 {
                datatype: "json",
                datafields: [
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						{name : 'mail1', type: 'String'  }
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
            $("#jqxvndsearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                columns: [
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '10%' },
					{ text: 'NAME', datafield: 'refname', width: '30%' },
					{ text: 'ADDRESS', datafield: 'address', width: '60%' }, 
					{ text: 'MOB', datafield: 'per_mob', width: '15%' ,hidden:true},
					{ text: 'Mail', datafield: 'mail1', width: '20%',hidden:true },
					]
            });
			$('#jqxvndsearch').on('rowdoubleclick', function (event) 
			{ 
				var rowindex1=event.args.rowindex;
				$("#assignmentto").val($('#jqxvndsearch').jqxGrid('getcellvalue', rowindex1, "refname"));
				$("#hidassignmentid").val($('#jqxvndsearch').jqxGrid('getcellvalue', rowindex1, "cldocno"));
				$('#jqxvndsearch').jqxGrid('clear');
				$('#vndwindow').jqxWindow('close');
			}); 	 
   }); 
    </script>
    <div id="jqxvndsearch"></div>
    
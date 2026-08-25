<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.projectexecution.deploytechnician.ClsDeployTechnicianDAO"%> 
<% ClsDeployTechnicianDAO DAO=new ClsDeployTechnicianDAO(); %>
<% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString().trim();
   String empdocno = request.getParameter("empdocno")==null?"0":request.getParameter("empdocno").trim();
   String check =request.getParameter("check")==null?"0":request.getParameter("check").toString().trim();
 %>

<script type="text/javascript">
 		
 		var data4= '<%= DAO.manPowerAssignedOnDateGridLoading(session,date,empdocno,check) %>';
 		
        $(document).ready(function () { 	
             
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'date', type: 'date'  },
							{name : 'codeno', type: 'String'  },
							{name : 'name', type: 'String'  },
							{name : 'intime', type: 'date'  }, 
     						{name : 'outtime', type: 'date'  },
     						{name : 'totalvalue', type: 'number' }
     						
                 ],
                 localdata: data4,
                
                
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
            
            $("#manPowerAssignedOnDateGridId").jqxGrid(
            {
                width: '99.5%',
                height: 303,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates: true,
             	localization: {thousandsSeparator: ""},
             	
                columns: [
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '14%' },
							{ text: 'Code', datafield: 'codeno', width: '11%' },
							{ text: 'Name', datafield: 'name', width: '37%' },
							{ text: 'From', datafield: 'intime', cellsformat: 'HH:mm', width: '10%' },
							{ text: 'To', datafield: 'outtime', cellsformat: 'HH:mm', width: '10%' },
							{ text: 'Total', datafield: 'totalvalue',cellsformat: 'd2',cellsalign:'right',align:'right', width: '18%', aggregates: ['sum'], aggregatesrenderer:rendererstring }
		
	              ]
            });
             
            $("#overlay, #PleaseWait").hide();
            
        });
    
</script>
<div id="manPowerAssignedOnDateGridId"></div>

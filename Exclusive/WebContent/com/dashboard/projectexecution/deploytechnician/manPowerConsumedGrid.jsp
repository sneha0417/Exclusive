<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.projectexecution.deploytechnician.ClsDeployTechnicianDAO"%> 
<% ClsDeployTechnicianDAO DAO=new ClsDeployTechnicianDAO(); %>
<% String costtype =request.getParameter("costtype")==null?"0":request.getParameter("costtype").toString().trim();
   String costcode = request.getParameter("costcode")==null?"0":request.getParameter("costcode").trim();
   String check =request.getParameter("check")==null?"0":request.getParameter("check").toString().trim();
 %>

<script type="text/javascript">
 		
 		var data3= '<%= DAO.manPowerConsumedGridLoading(session,costtype,costcode,check) %>';
 		
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
							{name : 'codeno', type: 'String'  },
							{name : 'name', type: 'String'  },
     						{name : 'utilizedhrs', type: 'String'  },
     						{name : 'costperhour', type: 'number' },
     						{name : 'totalvalue', type: 'number' },
     						{name : 'doc_no', type: 'int'  },
     						{name : 'normalhrs', type: 'String'  }
     						
                 ],
                 localdata: data3,
                
                
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
            
            $("#manPowerConsumedGridId").jqxGrid(
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
							{ text: 'Code', datafield: 'codeno', width: '11%' },
							{ text: 'Name', datafield: 'name', width: '38%' },
							{ text: 'Utilized Hrs', datafield: 'utilizedhrs', width: '15%' },
							{ text: 'Cost / Hr', datafield: 'costperhour',cellsformat: 'd2',cellsalign:'right',align:'right', width: '18%' },
							{ text: 'Total', datafield: 'totalvalue',cellsformat: 'd2',cellsalign:'right',align:'right', width: '18%', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Emp Id', datafield: 'doc_no',hidden: true, width: '10%' },
							{ text: 'Normal Hrs', datafield: 'normalhrs',hidden: true, width: '10%' },
		
	              ]
            });
             
            $("#overlay, #PleaseWait").hide();
            
        });
    
</script>
<div id="manPowerConsumedGridId"></div>

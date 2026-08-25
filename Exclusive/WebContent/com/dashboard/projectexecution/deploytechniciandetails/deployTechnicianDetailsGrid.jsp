<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.projectexecution.deploytechniciandetails.ClsDeployTechnicianDetailsDAO"%>
<% ClsDeployTechnicianDetailsDAO DAO=new ClsDeployTechnicianDetailsDAO(); %>

<% String costtype =request.getParameter("costtype")==null?"0":request.getParameter("costtype").toString().trim();
   String costcode = request.getParameter("costcode")==null?"0":request.getParameter("costcode").trim();
   String check =request.getParameter("check")==null?"0":request.getParameter("check").toString().trim();
 %> 

<script type="text/javascript">
 		var data1;
 		var data1= '<%= DAO.deployTechnicianDetailsGridLoading(session,costtype,costcode,check) %>';
 	
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
                 localdata: data1,
                
                
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
            
            $("#deployTechnicianDetailsGridId").jqxGrid(
            {
                width: '100%',
                height: 250,
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
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '15%' },
							{ text: 'Code', datafield: 'codeno', width: '10%' },
							{ text: 'Name', datafield: 'name'},
							{ text: 'From', datafield: 'intime', cellsformat: 'HH:mm', width: '10%' },
							{ text: 'To', datafield: 'outtime', cellsformat: 'HH:mm', width: '10%' },
							{ text: 'Total', datafield: 'totalvalue',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right', width: '10%', aggregates: ['sum'], aggregatesrenderer:rendererstring }
		
	              ]
            });
             
            $("#overlay, #PleaseWait").hide();
        });
    
</script>
<div id="deployTechnicianDetailsGridId"></div>

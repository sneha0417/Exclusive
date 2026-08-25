<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.maintenanceaudit.ClsMaintenanceAuditDAO"%>
<% ClsMaintenanceAuditDAO DAO= new ClsMaintenanceAuditDAO();   %>
<%   
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();    
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%>
<style>
	.redClass
    {
    	background-color: #FFEBEB;
    }
</style>
<script type="text/javascript">        
      
       var type='<%=id%>';
       var padata,dataexcel;
    	 
	  	if(type=='1'){ 
	  		padata='<%=DAO.getPropertyData(fromdate,todate,id)%>';  
	  	} 
		else{
			padata;
	}

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [    
                        {name : 'jvtrno', type: 'String'  },
                        {name : 'owneracno', type: 'String'  },
                        {name : 'voc_no', type: 'String'  },
                        {name : 'posttrno', type: 'String'  },
                        {name : 'mrfacno', type: 'String'  },
                        {name : 'margin', type: 'String'  },
                        {name : 'acno', type: 'String'  },
                        {name : 'accountno', type: 'String'  },
                        {name : 'accountname', type: 'String'  },
                        {name : 'doc_no', type: 'String'  },
                        {name : 'property', type: 'String'  },
                        {name : 'tenant', type: 'String'  },
                        {name : 'classified', type: 'String'  },
                        {name : 'job', type: 'String'  },
						{name : 'proacno', type: 'String'  },
						{name : 'proname', type: 'String'  },
						{name : 'priority', type: 'String'  },
						{name : 'estcost', type: 'String'  },
						{name : 'comments', type: 'date'  },    
						{name : 'date', type: 'date'  },
						{name : 'brhid', type: 'String'  },
						{name : 'status', type: 'String'  },
						
						{name : 'managed', type: 'String'  },
						{name : 'prid', type: 'String'  },
						{name : 'owner_name', type: 'String'  },
						{name : 'unit_number', type: 'String'  },
						{name : 'jv_vocno', type: 'String'  },
						{name : 'blockamt', type: 'number'  },
						{name : 'total', type: 'number'  },
						],  
				    localdata: padata,
        
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
    
    $("#pagrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    });
   
    $("#pagrid").jqxGrid(
    {
        width: '100%',
        height: 255,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlerow',                 
       	showfilterrow: true,
        sortable:true,
        enabletooltips:true,                          
        pagermode: 'default',   
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,      
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
                    { text: 'Doc No', datafield: 'voc_no',  width: '6%'},       
                    { text: 'Date', datafield: 'date',  width: '5%',cellsformat:'dd.MM.yyyy' },    
                    { text: 'Doc No', datafield: 'doc_no',hidden:true},    
                    { text: 'brhid', datafield: 'brhid',hidden:true}, 
                    { text: 'jvtrno', datafield: 'jvtrno',hidden:true}, 
                    { text: 'ID', datafield: 'prid',  width: '6%'  },
                    { text: 'Unit Number', datafield: 'unit_number',  width: '6%'  },
                    { text: 'Property', datafield: 'property',  width: '18%'  },  
                    { text: 'M', datafield: 'managed',  width: '2%'  },
                    { text: 'Owner', datafield: 'owner_name',  width: '13%'  },      
                    { text: 'Tenant', datafield: 'tenant',  width: '15%'  },
                	   { text: 'Classified', datafield: 'classified',  width: '7%' ,hidden:true }, 
                	   { text: 'Job', datafield: 'job',  width: '15%',hidden:true  }, 
                	   { text: 'Provider Acno', datafield: 'proacno',  width: '10%',hidden:true   }, 
                	   { text: 'Provider Name', datafield: 'proname',  width: '15%' ,hidden:true  },   
                	   { text: 'Priority', datafield: 'priority',  width: '4%',cellsformat:'dd.MM.yyyy',hidden:true  },
     	           { text: 'Estimated Cost', datafield: 'estcost',align:'right',cellsalign:'right',cellsformat:'d2',  width: '7%',hidden:true   },  
     	           { text: 'Comments', datafield: 'comments',  width: '20%' ,hidden:true  },   
     	           { text: 'Tenantacno', datafield: 'acno',hidden:true  },   
     	           { text: 'Mrfacno', datafield: 'mrfacno',hidden:true  },
     	           { text: 'owneracno', datafield: 'owneracno',hidden:true  },
     	           { text: 'Owneracname', datafield: 'accountname',hidden:true  },  
     	           { text: 'Margin', datafield: 'margin',hidden:true  },
     	           { text: 'Posttrno', datafield: 'posttrno',hidden:true  },
     	           { text: 'JV Docno', datafield: 'jv_vocno',  width: '5%'},  
     	           { text: 'Block Amount', datafield: 'blockamt',  width: '6%',cellsalign:"right",align:"right",cellsformat:"d2"},        
     	           { text: 'Total', datafield: 'total', width: '6%', editable: false,cellsalign:'right',cellsformat:'d2',align:'right' },
     	           { text: 'Status', datafield: 'status',  width: '8%'},          
    ]		 
    });   
    $("#overlay, #PleaseWait").hide();
     $('#pagrid').on('rowdoubleclick', function (event) {                                      
            var rowindex2 = event.args.rowindex;                      

			document.getElementById("hidbrhid").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "brhid");
			document.getElementById("hidvocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "voc_no");
            document.getElementById("hiddocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
            $('.textpanel p').text('Doc No '+$('#pagrid').jqxGrid('getcellvalue',rowindex2,'voc_no')+' - '+$('#pagrid').jqxGrid('getcellvalue', rowindex2, "property"));
            $('.comments-container').html('');   
            funloadestgrid();  
        });  
      
});
</script>
<div id="pagrid"></div>
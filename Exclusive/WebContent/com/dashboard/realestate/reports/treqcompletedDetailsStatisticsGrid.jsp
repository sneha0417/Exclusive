<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.reports.ClsReportsDAO"%>
<% ClsReportsDAO DAO= new ClsReportsDAO(); %>       
<%   
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	String mtype = request.getParameter("mtype")==null?"":request.getParameter("mtype").trim();
%>
<style>
	.redClass
    {
    	background-color: #FFEBEB;
    }
</style>
<script type="text/javascript">        
       var tnrcddata;
       tnrcddata='<%=DAO.loadtreqcompleteStatistics(mtype,id)%>';                        

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
						{name : 'owid', type: 'String'  },
						],  
				    localdata: tnrcddata,
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
		 if (parseInt(data.jvtrno)>0) {                 
          return "redClass";
      }
    };
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    $("#jqxtnrcstscgrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    });
   
    $("#jqxtnrcstscgrid").jqxGrid(
    {
        width: '100%',
        height: 250,
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
                  { text: 'SL#', sortable: false, filterable: false, editable: false, cellclassname:cellclassname,      
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
               { text: 'Doc No', datafield: 'voc_no',  width: '6%', cellclassname:cellclassname},       
               { text: 'Date', datafield: 'date',  width: '5%',cellsformat:'dd.MM.yyyy' , cellclassname:cellclassname},    
               { text: 'Doc No', datafield: 'doc_no',hidden:true},    
               { text: 'brhid', datafield: 'brhid',hidden:true}, 
               { text: 'jvtrno', datafield: 'jvtrno',hidden:true}, 
               { text: 'ID', datafield: 'prid',  width: '6%' , cellclassname:cellclassname }, 
               { text: 'Unit Number', datafield: 'unit_number',  width: '6%'  , cellclassname:cellclassname},     
               { text: 'Property', datafield: 'property',  width: '18%' , cellclassname:cellclassname },  
               { text: 'M', datafield: 'managed',  width: '2%' , cellclassname:cellclassname },
               { text: 'Owner', datafield: 'owner_name',  width: '13%' , cellclassname:cellclassname },      
               { text: 'Tenant', datafield: 'tenant',  width: '15%', cellclassname:cellclassname  },
           	   { text: 'Classified', datafield: 'classified',  width: '7%' , cellclassname:cellclassname,hidden:true }, 
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
	           { text: 'JV Docno', datafield: 'jv_vocno',  width: '5%', cellclassname:cellclassname},  
	           { text: 'Block Amount', datafield: 'blockamt',  width: '6%', cellclassname:cellclassname,cellsalign:"right",align:"right",cellsformat:"d2"},        
	           { text: 'Total', datafield: 'total', width: '6%', editable: false,cellsalign:'right',cellsformat:'d2',align:'right', cellclassname:cellclassname },
	           { text: 'Status', datafield: 'status',  width: '8%', cellclassname:cellclassname},   
	           { text: 'owid', datafield: 'owid',hidden:true  },
    ]		 
    });
    $("#overlay, #PleaseWait").hide();   
});
</script>
<div id="jqxtnrcstscgrid"></div>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.reports.ClsReportsDAO"%>
<% ClsReportsDAO DAO= new ClsReportsDAO(); %>       
<%   
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	String mtype = request.getParameter("mtype")==null?"":request.getParameter("mtype").trim();
%>
<style type="text/css">   
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {   
        background-color: #FFFFD1;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
     .greenClass
    {
        background-color: #ACF6CB;
    }
</style>
<script type="text/javascript">
    
       var type='<%=id%>';
       var pdsdata;
	   pdsdata='<%=DAO.loadpropertyStatistics(mtype,id)%>';                

$(document).ready(function () {
	
    // prepare the data  
    var source =
    {
        datatype: "json",
        datafields: [   
                        {name : 'doc_no', type: 'String'  },
                        {name : 'pstatus', type: 'String'  },
                        {name : 'mgprpty', type: 'String'  },
                        {name : 'prid', type: 'String'  },
                        {name : 'unit_number', type: 'String'  },
                        {name : 'tenant', type: 'String'  },
                        {name : 'accname', type: 'String'  },
                        {name : 'unit_of', type: 'String'  },
                        {name : 'type', type: 'String'  },
                        {name : 'unit_type', type: 'String'  },
						{name : 'area', type: 'String'  },
						{name : 'landmark', type: 'String'  },
						{name : 'transaction_type', type: 'String'  },
						{name : 'owner_name', type: 'String'  },
						{name : 'availability_date', type: 'date'  },    
						{name : 'date', type: 'date'  },
						{name : 'terms_warranty', type: 'date'  },						 
						{name : 'comment', type: 'String'  },
						{name : 'commentby', type: 'String'  },
						{name : 'commentdate', type: 'date'  }, 
						{name : 'temail', type: 'String'  },
						{name : 'tmobno', type: 'String'  },
						{name : 'oemail', type: 'String'  },
						{name : 'omobno', type: 'String'  },
						{name : 'constdate', type: 'date'  },
						{name : 'conenddate', type: 'date'  },
						{name : 'rentalval', type: 'number'  }, 
						],
				    localdata: pdsdata,
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
		 if (data.pstatus ==1) {
            return "greenClass";
        }else if (data.pstatus ==0){
        	return "redClass";
        }else{};
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
  		 {
      		loadError: function (xhr, status, error) {
              alert(error);    
             }		            
        }		
    );
    
    $("#jqxpdetstcsgrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    }); 
    
    $("#jqxpdetstcsgrid").jqxGrid(
    {
        width: '100%',
        height: 300,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlerow',                 
       	showfilterrow: true,
        sortable:true,                                
        pagermode: 'default',   
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%' ,cellclassname: cellclassname,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
               { text: 'Date', datafield: 'date',  width: '5%' ,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy' },
               { text: 'Doc No', datafield: 'doc_no' ,cellclassname: cellclassname,hidden:true},         
               { text: 'Status', datafield: 'pstatus' ,cellclassname: cellclassname,hidden:true},   
               { text: 'Managed', datafield: 'mgprpty' ,cellclassname: cellclassname,hidden:true},   
               { text: 'ID', datafield: 'prid',  width: '7%'  ,cellclassname: cellclassname },
               { text: 'Property', datafield: 'accname',  width: '15%' ,cellclassname: cellclassname},  
               { text: 'Owner', datafield: 'owner_name',  width: '15%' ,cellclassname: cellclassname},                
               { text: 'Tenant', datafield: 'tenant',  width: '15%' ,cellclassname: cellclassname}, 
               { text: 'Unit Number', datafield: 'unit_number',  width: '7%'  ,cellclassname: cellclassname },
           	   { text: 'Type', datafield: 'type',  width: '7%'  ,cellclassname: cellclassname}, 
           	   { text: 'Unit Type', datafield: 'unit_type',  width: '7%'  ,cellclassname: cellclassname }, 
           	   { text: 'Area', datafield: 'area',  width: '10%'  ,cellclassname: cellclassname },   
           	   { text: 'Availability Date', datafield: 'availability_date',  width: '8%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
           	   { text: 'Email', datafield: 'temail',  width: '13%'  ,cellclassname: cellclassname,columngroup:'tn' },
	           { text: 'Mob No', datafield: 'tmobno',  width: '10%'  ,cellclassname: cellclassname,columngroup:'tn'  },
	           { text: 'Email', datafield: 'oemail',  width: '13%'  ,cellclassname: cellclassname,columngroup:'ow'  },
	           { text: 'Mob No', datafield: 'omobno',  width: '10%'  ,cellclassname: cellclassname,columngroup:'ow'  },
	           { text: 'Start Date', datafield: 'constdate',  width: '6%' ,cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname,columngroup:'cn' },
	           { text: 'End Date', datafield: 'conenddate',  width: '6%' ,cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname,columngroup:'cn' },
	           { text: 'Rental Value', datafield: 'rentalval',  width: '7%'  ,cellsalign:'right',align:'right',cellsformat:'d2',cellclassname: cellclassname },
			  ],columngroups: 
			      [
			        { text: 'Owner', align: 'center', name: 'ow',width: '20%' },
			        { text: 'Tenant', align: 'center', name: 'tn',width: '10%' },
			        { text: 'Contract', align: 'center', name: 'cn',width: '10%' }
			      ]
    });
    $("#overlay, #PleaseWait").hide();
});    
</script>
<div id="jqxpdetstcsgrid"></div>
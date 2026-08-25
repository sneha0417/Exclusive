<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.propertyavailability.*"%>
<%   
	String branch = request.getParameter("branch")==null?"0":request.getParameter("branch").trim();
	String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	String relodestatus = request.getParameter("relodestatus")==null?"0":request.getParameter("relodestatus").trim();
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	String managed = request.getParameter("managed")==null?"0":request.getParameter("managed").trim();
	ClsPropertyAvailabilityDAO DAO= new ClsPropertyAvailabilityDAO();
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
    
     .pinkClass
    {
        background-color: #FFE3FF;
    }
    
</style>
<script type="text/javascript">
    
       var type='<%=id%>';                    
       var pagrid;
    	 
	  	if(type=='1'){ 
	  		pagrid='<%=DAO.getPropertyData(uptodate,relodestatus,id,managed,branch)%>';    
	  	} 
		else{
			pagrid;
	}

$(document).ready(function () {
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
             
						{name : 'prid', type: 'String'  },
						{name : 'm', type: 'String'  },
						{name : 's', type: 'String'  },
						{name : 'r', type: 'String'  },
						{name : 'h', type: 'String'  },
						{name : 'accname', type: 'String'  }, 	
						{name : 'buildup_area', type: 'String'  },
						{name : 'area_sq', type: 'String'  },
						{name : 'yard', type: 'String'  },
						{name : 'terms_rentalvaluefrom', type: 'String'  },
						{name : 'desc1', type: 'String'  },
						{name : 'specialnotes', type: 'String'  },
						{name : 'contactperson', type: 'String'  },
						{name : 'conatctnumber', type: 'String'  },
						{name : 'no_of_rooms', type: 'String'  },
						
                        {name : 'unit_number', type: 'String'  },
                        {name : 'unit_of', type: 'String'  },
                        {name : 'type', type: 'String'  },
                        {name : 'unit_type', type: 'String'  },
						{name : 'area', type: 'String'  },
						{name : 'landmark', type: 'String'  },
						{name : 'transaction_type', type: 'String'  },
						{name : 'owner_name', type: 'String'  },
						{name : 'availability_date', type: 'date'  },
						{name : 'expdt', type: 'date'  },
						{name : 'active', type: 'String'  },
						{name : 'doc_no', type: 'String'  },
						{name : 'statusname', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'address1', type: 'String'  },
						],
				    localdata: pagrid,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, pagrid) {
    //	alert(padata.active);
		if (pagrid.active == 0) {
            return "redClass";
        }
		if (!(pagrid.statusname=="Vacant")) {
            return "pinkClass";
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
        height: 520,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlerow',                 
       	showfilterrow: true,
        sortable:true,
        enabletooltips: true,                        
                      
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
               { text: 'Property Id', datafield: 'prid', cellclassname: cellclassname, width: '8%'},
               { text: 'M', datafield: 'm', cellclassname: cellclassname, width: '2%'},
               { text: 'S', datafield: 's', cellclassname: cellclassname, width: '2%'},
               { text: 'R', datafield: 'r',cellclassname: cellclassname,  width: '2%'},
               { text: 'H', datafield: 'h',cellclassname: cellclassname,  width: '2%'},
               { text: 'Property Id', datafield: 'accname', cellclassname: cellclassname, width: '15%'},
               { text: 'Nearest Land Mark', datafield: 'landmark',cellclassname: cellclassname,  width: '10%'  },
               { text: 'Availability Date', datafield: 'availability_date', cellclassname: cellclassname, width: '8%',cellsformat:'dd.MM.yyyy' },
               { text: 'Expiry Date', datafield: 'expdt', cellclassname: cellclassname, width: '8%',cellsformat:'dd.MM.yyyy' },
               { text: 'Status', datafield: 'statusname',cellclassname: cellclassname,  width: '10%'  },
               { text: 'Remarks', datafield: 'remarks', cellclassname: cellclassname, width: '10%' , hidden:true},
               { text: 'Owner Name', datafield: 'owner_name',cellclassname: cellclassname,  width: '15%'},
               { text: 'Unit Number', datafield: 'unit_number', cellclassname: cellclassname, width: '5%'  },
           	   { text: 'Unit Of', datafield: 'unit_of',  width: '10%' ,cellclassname: cellclassname, hidden:true }, 
           	   { text: 'Type', datafield: 'type',cellclassname: cellclassname,  width: '3%'  }, 
           	   { text: 'Unit Type', datafield: 'unit_type',cellclassname: cellclassname,  width: '5%'  }, 
           	   { text: 'Area', datafield: 'area',cellclassname: cellclassname,  width: '10%'  },
           		{ text: 'Address', datafield: 'address1',cellclassname: cellclassname,  width: '10%'  },
           	
           	   { text: 'Area Sq.', datafield: 'area_sq',cellclassname: cellclassname,  width: '5%'  },
           	{ text: 'BuildUpArea', datafield: 'buildup_area',cellclassname: cellclassname,  width: '5%'  },
           	{ text: 'Yard', datafield: 'yard',cellclassname: cellclassname,  width: '5%'  },
           		{ text: 'Value', datafield: 'terms_rentalvaluefrom', cellclassname: cellclassname, cellsformat: 'd2',cellsalign:'right',align:'right', width: '5%'  },
           		{ text: 'Description', datafield: 'desc1', cellclassname: cellclassname, width: '10%'  },
           		{ text: 'Sp. Notes', datafield: 'specialnotes', cellclassname: cellclassname, width: '10%'  },
           		{ text: 'Contact Person', datafield: 'contactperson',cellclassname: cellclassname,  width: '10%'  },
           		{ text: 'Contact No', datafield: 'conatctnumber', cellclassname: cellclassname, width: '10%'  },
           		{ text: 'No Room', datafield: 'no_of_rooms', cellclassname: cellclassname, cellsformat: 'd2',cellsalign:'right',align:'right',  width: '5%'  },
           		{ text: 'active', datafield: 'active', cellclassname: cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right',  width: '5%' ,hidden:true },
           		{ text: 'doc_no', datafield: 'doc_no', cellclassname: cellclassname, width: '10%' , hidden:"true" },   
   				
    ]		 
    });

    
    $("#overlay, #PleaseWait").hide();
    $('#pagrid').on('rowdoubleclick', function (event) {
    	var rowindex2 = event.args.rowindex; 
    	showPropertyMasterInTab( $('#pagrid').jqxGrid('getcellvalue',rowindex2,'doc_no'));
    });  
});


</script>
<div id="pagrid"></div>
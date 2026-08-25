
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.propertymanagement.ClsPropertyManagementDAO"%>
<%   
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();    
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	String status = request.getParameter("status")==null?"0":request.getParameter("status").trim();
	String cmbmanage = request.getParameter("cmbmanage")==null?"":request.getParameter("cmbmanage").trim();
	ClsPropertyManagementDAO DAO= new ClsPropertyManagementDAO();           
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
       var padata,dataexcel;
    	 
	  	if(type=='1'){ 
	  		padata='<%=DAO.getPropertyData(fromdate,todate,id,status,cmbmanage)%>';  
	  		<%-- dataexcel='<%=DAO.getPropertyExcel(fromdate,todate,id)%>'; --%>             
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
						{name : 'statuschangeby', type: 'String'  },
						{name : 'warrantychangeby', type: 'String'  },
						/* {name : 'viewroom', type: 'String'  }, */
						{name : 'temail', type: 'String'  },
						{name : 'tmobno', type: 'String'  },
						{name : 'oemail', type: 'String'  },
						{name : 'omobno', type: 'String'  },
						{name : 'constdate', type: 'date'  },
						{name : 'conenddate', type: 'date'  },
						{name : 'rentalval', type: 'number'  },  
						{name : 'optid', type: 'String'  },  
						{name : 'brhid', type: 'String'  },  
						],
				    localdata: padata,
        
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
    
    $("#pagrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    }); 
    
    $("#pagrid").jqxGrid(
    {
        width: '100%',
        height: 480,
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
               { text: 'brhid', datafield: 'brhid' ,cellclassname: cellclassname,hidden:true}, 
               { text: 'ID', datafield: 'prid',  width: '7%'  ,cellclassname: cellclassname },
               { text: 'Owner', datafield: 'owner_name',  width: '15%' ,cellclassname: cellclassname},
               { text: 'Property', datafield: 'accname',  width: '15%' ,cellclassname: cellclassname},  
               { text: 'Mob No', datafield: 'omobno',  width: '10%'  ,cellclassname: cellclassname,columngroup:'ow'  },
               { text: 'Email', datafield: 'oemail',  width: '13%'  ,cellclassname: cellclassname,columngroup:'ow'  },
               { text: 'Tenant', datafield: 'tenant',  width: '15%' ,cellclassname: cellclassname}, 
               { text: 'Mob No', datafield: 'tmobno',  width: '10%'  ,cellclassname: cellclassname,columngroup:'tn'  },
               { text: 'Email', datafield: 'temail',  width: '13%'  ,cellclassname: cellclassname,columngroup:'tn' },
	           
               
               { text: 'Unit Number', datafield: 'unit_number',  width: '7%'  ,cellclassname: cellclassname },
           	  /*  { text: 'Unit Of', datafield: 'unit_of',  width: '7%' ,cellclassname: cellclassname  },  */
           	      
           	   { text: 'Availability Date', datafield: 'availability_date',  width: '8%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
	           { text: 'Nearest Land Mark', datafield: 'landmark',  width: '10%' ,cellclassname: cellclassname  },
	           { text: 'Warranty Date', datafield: 'terms_warranty',  width: '5%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname   },
	           { text: 'Transaction Type', datafield: 'transaction_type',  width: '10%'  ,cellclassname: cellclassname }, 
	           { text: 'Last Comment', datafield: 'comment',  width: '10%' ,cellclassname: cellclassname  },
	           { text: 'Commented By', datafield: 'commentby',  width: '8%' ,cellclassname: cellclassname  },
	           { text: 'Commented Date', datafield: 'commentdate',  width: '8%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname  },
	           { text: 'Status Updatedby', datafield: 'statuschangeby',  width: '8%' ,cellclassname: cellclassname  },
	           { text: 'Warranty Updatedby', datafield: 'warrantychangeby',  width: '8%' ,cellclassname: cellclassname  },
	           /* { text: ' ', datafield: 'viewroom',columntype: 'button',filterable: false,editable:false, width: '6%'},   */
	           
	           
	           
	           { text: 'Start Date', datafield: 'constdate',  width: '6%' ,cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname,columngroup:'cn' },
	           { text: 'End Date', datafield: 'conenddate',  width: '6%' ,cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname,columngroup:'cn' },
	           { text: 'Rental Value', datafield: 'rentalval',  width: '7%'  ,cellsalign:'right',align:'right',cellsformat:'d2',cellclassname: cellclassname },
	           { text: 'OptID', datafield: 'optid',  width: '7%'  ,cellclassname: cellclassname },
	           { text: 'Type', datafield: 'type',  width: '7%'  ,cellclassname: cellclassname}, 
           	   { text: 'Unit Type', datafield: 'unit_type',  width: '7%'  ,cellclassname: cellclassname }, 
           	   { text: 'Area', datafield: 'area',  width: '10%'  ,cellclassname: cellclassname },
    ],columngroups: 
        [
          { text: 'Owner', align: 'center', name: 'ow',width: '20%' },
          { text: 'Tenant', align: 'center', name: 'tn',width: '10%' },
          { text: 'Contract', align: 'center', name: 'cn',width: '10%' }
        ]
         
    });
    $("#overlay, #PleaseWait").hide();
     $('#pagrid').on('rowdoubleclick', function (event) {                
            var rowindex2 = event.args.rowindex;                      
            document.getElementById("hidbrhid").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "brhid");            
            document.getElementById("hiddocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "doc_no");  
            document.getElementById("txtexistowner").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "owner_name");          
            
            document.getElementById("txtexistwarranty").value=$('#pagrid').jqxGrid('getcelltext', rowindex2, "terms_warranty");
            $('#selectedrow').html('');
            $('#selectedrow').html('Owner :' +$('#pagrid').jqxGrid('getcellvalue', rowindex2, "owner_name")+',Prop.ID:'+$('#pagrid').jqxGrid('getcellvalue', rowindex2, "prid"));
            $('#btnviewrooms').show();
            $('#wdate').val($('#pagrid').jqxGrid('getcellvalue', rowindex2, "terms_warranty")); 
            
            $('#cmbpstatus').val($('#pagrid').jqxGrid('getcellvalue', rowindex2, "pstatus")); 
            $('#cmbpmngd').val($('#pagrid').jqxGrid('getcellvalue', rowindex2, "mgprpty"));
               $('.comments-container').html('');        
        });  
     
    /*  $('#pagrid').on('cellclick', function (event)       
       		{ 
	           	var rowindex1=event.args.rowindex;
	           	var datafield = event.args.datafield;
	           	if(datafield=="viewroom"){   
	                  var docno=$('#pagrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
	                  LoadRoomsFurniture(docno);
	                  $('#roomfurnitureModal').modal('toggle');
           	}
       		 }); */
    
});
</script>
<div id="pagrid"></div>
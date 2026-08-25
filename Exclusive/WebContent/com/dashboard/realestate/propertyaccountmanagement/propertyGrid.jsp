<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.propertyaccountmanagement.ClsPropertyAccountManagementDAO"%>
<%   
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();    
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	String status = request.getParameter("status")==null?"0":request.getParameter("status").trim();
	String actype = request.getParameter("actype")==null?"0":request.getParameter("actype").trim();
	ClsPropertyAccountManagementDAO DAO= new ClsPropertyAccountManagementDAO();           
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
       var padata;
    	 
	  	if(type=='1'){ 
	  		padata='<%=DAO.getPropertyData(fromdate,todate,id,status,actype)%>';  
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
						{name : 'mrfacno', type: 'String'  },
						{name : 'owneracno', type: 'String'  },
						{name : 'brhid', type: 'String'  },
						
						{name : 'macno', type: 'String'  },
						{name : 'oacno', type: 'String'  },
						{name : 'maccount', type: 'String'  },
						{name : 'oaccount', type: 'String'  }, 
						{name : 'owid', type: 'String'  }, 
						{name : 'ownermail', type: 'String'  }, 
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
               { text: 'owid', datafield: 'owid' ,cellclassname: cellclassname,hidden:true},
               { text: 'ID', datafield: 'prid',  width: '7%'  ,cellclassname: cellclassname },
               { text: 'Property', datafield: 'accname',  width: '15%' ,cellclassname: cellclassname},  
               { text: 'Owner', datafield: 'owner_name',  width: '15%' ,cellclassname: cellclassname},   
               { text: 'Owner E-mail', datafield: 'ownermail',  width: '13%' ,cellclassname: cellclassname},
               { text: 'Tenant', datafield: 'tenant',  width: '15%' ,cellclassname: cellclassname},
               { text: 'Unit Number', datafield: 'unit_number',  width: '7%'  ,cellclassname: cellclassname },
           	  /*  { text: 'Unit Of', datafield: 'unit_of',  width: '7%' ,cellclassname: cellclassname  },  */
           	   { text: 'Type', datafield: 'type',  width: '7%'  ,cellclassname: cellclassname}, 
           	   { text: 'Unit Type', datafield: 'unit_type',  width: '7%'  ,cellclassname: cellclassname }, 
           	   { text: 'Area', datafield: 'area',  width: '10%'  ,cellclassname: cellclassname },   
           	   { text: 'Availability Date', datafield: 'availability_date',  width: '8%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
	           { text: 'Nearest Land Mark', datafield: 'landmark',  width: '10%' ,cellclassname: cellclassname  },
	           { text: 'Warranty Date', datafield: 'terms_warranty',  width: '5%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname   },
	           { text: 'Transaction Type', datafield: 'transaction_type',  width: '10%'  ,cellclassname: cellclassname }, 
	           { text: 'Last Comment', datafield: 'comment',  width: '10%' ,cellclassname: cellclassname  },
	           { text: 'Commented By', datafield: 'commentby',  width: '8%' ,cellclassname: cellclassname  },
	           { text: 'Commented Date', datafield: 'commentdate',  width: '8%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname  },
	           /* { text: ' ', datafield: 'viewroom',columntype: 'button',filterable: false,editable:false, width: '6%'},   */
	           { text: 'Status Updatedby', datafield: 'statuschangeby',  width: '8%' ,cellclassname: cellclassname  },
	           { text: 'Warranty Updatedby', datafield: 'warrantychangeby',  width: '8%' ,cellclassname: cellclassname  },
	           { text: 'brhid', datafield: 'brhid' ,cellclassname: cellclassname,hidden:true},  
	           { text: 'owneracno', datafield: 'owneracno' ,cellclassname: cellclassname,hidden:true},  
	           { text: 'mrfacno', datafield: 'mrfacno' ,cellclassname: cellclassname,hidden:true},  
	           
	           { text: 'macno', datafield: 'macno' ,cellclassname: cellclassname,hidden:true},
	           { text: 'oacno', datafield: 'oacno' ,cellclassname: cellclassname,hidden:true},
	           { text: 'maccount', datafield: 'maccount' ,cellclassname: cellclassname,hidden:true},
	           { text: 'oaccount', datafield: 'oaccount' ,cellclassname: cellclassname,hidden:true},            
    ]		       
    });
    $("#overlay, #PleaseWait").hide();
     $('#pagrid').on('rowdoubleclick', function (event) {           
            var rowindex2 = event.args.rowindex;    
            document.getElementById("hidemail").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "ownermail");     
            document.getElementById("hidownid").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "owid");  
            document.getElementById("hidproperty").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "accname");          
            document.getElementById("hiddocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
            document.getElementById("hidbrhid").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "brhid");
            document.getElementById("hidowneracno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "owneracno");
            document.getElementById("hidmrfacno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "mrfacno");      
            document.getElementById("txtexistowner").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "owner_name");          
            document.getElementById("hidmacno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "macno"); 
            document.getElementById("hidoacno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "oacno"); 
            document.getElementById("hidmaccount").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "maccount");    
            document.getElementById("hidoaccount").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "oaccount"); 
                 
            //document.getElementById("txtexistwarranty").value=$('#pagrid').jqxGrid('getcelltext', rowindex2, "terms_warranty");
            $('#selectedrow').html('');
            $('#selectedrow').html('Owner :' +$('#pagrid').jqxGrid('getcellvalue', rowindex2, "owner_name")+',Prop.ID:'+$('#pagrid').jqxGrid('getcellvalue', rowindex2, "prid"));
            $('#btnviewrooms').show();
            //$('#wdate').val($('#pagrid').jqxGrid('getcellvalue', rowindex2, "terms_warranty")); 
            
            $('#cmbpstatus').val($('#pagrid').jqxGrid('getcellvalue', rowindex2, "pstatus")); 
            $('#cmbpmngd').val($('#pagrid').jqxGrid('getcellvalue', rowindex2, "mgprpty"));
            $('.comments-container').html('');     
            $('#modalsplinstruction').modal('toggle'); 
            $("#splinsdiv").load("splinstructionGrid.jsp?docno="+$('#pagrid').jqxGrid('getcellvalue', rowindex2, "owid")+"&id="+1);
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
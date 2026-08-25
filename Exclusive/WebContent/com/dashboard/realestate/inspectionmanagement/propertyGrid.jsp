<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.inspectionmanagement.ClsInspectionManagementDAO"%>
<%   
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();    
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	ClsInspectionManagementDAO DAO= new ClsInspectionManagementDAO();           
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
                {name : 'doc_no', type: 'String'  }, 
				{name : 'pdocno', type: 'String'  }, 
                {name : 'property', type: 'String'  },
                {name : 'tenant', type: 'String'  },
                {name : 'owner', type: 'String'  },
                {name : 'terms_insptype', type: 'String'  },
				{name : 'terms_insasper', type: 'String'  },
				{name : 'ins_date', type: 'date'  },
				{name : 'tenantemail', type: 'String'  },	 
				{name : 'pdate', type: 'String'  },	
				{name : 'tdocno', type: 'String'  },	
				{name : 'tdate', type: 'String'  },
				{name : 'uname', type: 'String'  },	
				{name : 'unitno', type: 'String'  },	
				{name : 'status', type: 'String'  },	
				{name : 'instype', type: 'String'  },	
				{name : 'seqno', type: 'String'  },	
				],  
		    localdata: padata,        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
		 if (data.isqty !=0) {
            return "yellowClass";
        }else{
        	return "orangeClass";
        };
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
               { text: 'Doc No', datafield: 'doc_no',  width: '6%',hidden:true},     
			   { text: 'property Doc No', datafield: 'pdocno',  width: '6%',hidden:false},
               { text: 'Unit No', datafield: 'unitno',  width: '6%'},  
               { text: 'Quater Seq. No', datafield: 'seqno',  width: '6%'},     
               { text: 'Property', datafield: 'property' }, 
               { text: 'Owner', datafield: 'owner',  width: '15%'  }, 
               { text: 'Tenant', datafield: 'tenant',  width: '15%'  },    
           	   { text: 'Inspection Type', datafield: 'terms_insptype',  width: '15%'  }, 
           	   { text: 'Inspection As Per', datafield: 'terms_insasper',  width: '7%'  }, 
           	   { text: 'Schedule Inspection Date', datafield: 'ins_date',  width: '7%',cellsformat:'dd.MM.yyyy' }, 
           	   { text: 'Assigned User', datafield: 'uname',  width: '7%'  },
           	   { text: 'Status', datafield: 'status',  width: '7%'  },     
           	   { text: 'Tenant Email', datafield: 'tenantemail',  width: '15%',hidden:true},  
           	   { text:  'pdate', datafield: 'pdate',  width: '15%',hidden:true},  
           	   { text: 'tdocno', datafield: 'tdocno',  width: '6%',hidden:true},
           	   { text: 'tdate', datafield: 'tdate',  width: '6%',hidden:true},
           	   { text: 'instype', datafield: 'instype',  width: '6%',hidden:true},
    ]		 
    });
    $("#overlay, #PleaseWait").hide();
    $('#pagrid').on('rowdoubleclick', function (event) {    	
            var rowindex2 = event.args.rowindex;                      
            document.getElementById("hidinstype").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "instype");
            document.getElementById("hiddocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
            document.getElementById("hidpdate").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "pdate");
            document.getElementById("hidtdocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "tdocno");
            document.getElementById("hidtdate").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "tdate");
			document.getElementById("hidtdate").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "tdate");
            document.getElementById("hidtemail").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "tenantemail");
            document.getElementById("hidproperty").value=$('#pagrid').jqxGrid('getcelltext', rowindex2, "pdocno");
             
            var docno=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
            
            $('#statushisdiv').load(
					"statushistoryGrid.jsp?docno=" + docno);
			$('#inshisdiv').load(
					"inspectionhistoryGrid.jsp?pdocno=" + docno+"&id="+1);
			 $('.textpanel p').text($('#pagrid').jqxGrid('getcellvalue', rowindex2, "property"));
            $('.comments-container').html('');
        });        
});
</script>
<div id="pagrid"></div>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.handoverback.ClsHandOverBackDAO"%>
<% String contextPath=request.getContextPath();%>
<%   
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();    
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	String hand = request.getParameter("hand")==null?"0":request.getParameter("hand").trim();
	ClsHandOverBackDAO DAO= new ClsHandOverBackDAO();           
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
	  		padata='<%=DAO.getPropertyData(hand,id)%>';  
	  	<%-- 	dataexcel='<%=DAO.getPropertyDataExcel(hand,id)%>'; --%>        
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
                {name : 'voc_no', type: 'String'  }, 
                {name : 'pname', type: 'String'  },
                {name : 'refname', type: 'String'  },
                {name : 'owner', type: 'String'  },
                {name : 'uname', type: 'String'  },
				{name : 'date', type: 'date'  },
				{name : 'fromdate', type: 'date'  },
				{name : 'todate', type: 'date'  },
				{name : 'unitno1', type: 'String'  },
				{name : 'ownemail', type: 'String'  },
				{name : 'emailbtn',type:'string'},
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
        height: 450,
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
               { text: 'Contract No', datafield: 'voc_no',  width: '5%'}, 
               { text: 'Doc No', datafield: 'doc_no',  width: '5%',hidden:true}, 
               { text: 'Date', datafield: 'date',  width: '5%',cellsformat:'dd.MM.yyyy' },
               { text: 'Tenant', datafield: 'refname' },
               { text: 'Unit N', datafield: 'unitno1',  width: '5%'  },
               { text: 'Property', datafield: 'pname' ,  width: '20%'}, 
               { text: 'Owner', datafield: 'owner'  }, 
               { text: 'From Date', datafield: 'fromdate',  width: '5%',cellsformat:'dd.MM.yyyy' },
               { text: 'To Date', datafield: 'todate',  width: '5%',cellsformat:'dd.MM.yyyy' },
               { text: 'Assigned User', datafield: 'uname',  width: '10%'  },
               { text: 'Owner mail', datafield: 'ownemail',  width: '10%'  ,hidden:true},
               { text: 'Email', datafield: 'emailbtn', width: '6%',columntype: 'button',editable:false, filterable: false},
    ]		 
    });
    $("#overlay, #PleaseWait").hide();
    $("#pagrid").on('cellclick', function (event){
	    var datafield = event.args.datafield;
	    var rowBoundIndex = event.args.rowindex;
	    var columnindex = event.args.columnindex;
	    if(datafield=="emailbtn"){    
	    	funSendEmail(rowBoundIndex);       
	     }
    });
    $('#pagrid').on('rowdoubleclick', function (event) {    	
            var rowindex2 = event.args.rowindex;                      
           document.getElementById("hiddocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
           $('.textpanel p').text($('#pagrid').jqxGrid('getcellvalue', rowindex2, "pname"));
           /*document.getElementById("hidpdate").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "pdate");
            document.getElementById("hidtdocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "tdocno");
            document.getElementById("hidtdate").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "tdate");
            document.getElementById("hidtemail").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "tenantemail");
            document.getElementById("hidinsdate").value=$('#pagrid').jqxGrid('getcelltext', rowindex2, "ins_date");
             
            var docno=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
            
            $('#statushisdiv').load(
					"statushistoryGrid.jsp?docno=" + docno);
			$('#schedulehisdiv').load(
					"schedulehistoryGrid.jsp?docno=" + docno);
			 $('.textpanel p').text($('#pagrid').jqxGrid('getcellvalue', rowindex2, "property"));
            $('.comments-container').html(''); */
        });        
});

function funSendEmail(boundIndex){
	$("#overlay, #PleaseWait").hide();
	var email=$('#pagrid').jqxGrid('getcelltext',boundIndex, "ownemail");
	var cldocno=0;
	// $('#pagrid').jqxGrid('getcelltext',boundIndex, "cldocno");
	var client=$('#pagrid').jqxGrid('getcelltext',boundIndex, "owner");
	var propname=$('#pagrid').jqxGrid('getcelltext',boundIndex, "pname");
	var unit=$('#pagrid').jqxGrid('getcelltext',boundIndex, "unitno1"); 
	unit=unit.replace(/\D/g, "");
	var cc="";
	if((unit % 2)==1){
		cc="sarah@exclusive-links.com";
	}else {
		cc="paul@exclusive-links.com";
	}
	var brchid=1;     
	var userid="<%= session.getAttribute("USERID").toString() %>";        
		var contrctno=$('#pagrid').jqxGrid('getcelltext',boundIndex, "voc_no");                                       
		var frmdet="BPIA";                      
		var dtype="BPIA";  
		var subject="Property Hand Back ";
		var fname="Inspection ";
		var message="Property Hand Back ";
		//alert(document.getElementById("hndover").checked);
    	if(document.getElementById("hndover").checked){
			subject="Property Hand Over";
			message="<p>Dear "+client+",<br><br>I will now contact your Tenant to arrange the Handover for "+propname+" Apartment . <br><br> Please Confirm the below with me,<br><br> -         Move-in documents have been send to the building Management and Move-in Approval has been received ?<br>-          All Spesial request from the tenants side before Move in (if any) have been passed onto Paul Birley for Approval ? <br><br> Please note *Handover will be arranged as per Tenancy Start date <br><br> I look forward to hearing from you soonest, ";                        			
		}

	window.open("<%=contextPath%>/com/emailnew/Email.jsp?formcode="+dtype+"&docno="+contrctno+"&brchid="+brchid+"&frmname="+fname+"&recipient="+email+"&cldocno="+cldocno+"&client="+client+"&userid="+userid+"&dtype="+frmdet+"&msg="+message+"&subject="+subject+"&cc="+cc,"E-Mail","menubar=0,resizable=1,width=900,height=950");
}

</script>
<div id="pagrid"></div>
   <%@page import="com.dashboard.audit.documentcontrolregister.ClsDocmntCntrlRegDAO"%>
     <%ClsDocmntCntrlRegDAO cmd= new ClsDocmntCntrlRegDAO(); %>
 <% String contextPath=request.getContextPath();%>
 
 <%
    String barchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
  	String chk_val = request.getParameter("chk_val")==null?"0":request.getParameter("chk_val").trim();
 %> 
           	  
 <style type="text/css">
  
    .yellowClass
    {
        background-color: #F8E489;  
    }
    
    .orangeClass
    {
        background-color: #FAD7A0;
    }
  .greenClass
    {
        background-color: #7AFA90;
    }
     .whiteClass
    {
        background-color: #FFFFFF;
    }
</style>
<script type="text/javascript">

 var temp4='<%=barchval%>';

var leasedatas,documentntcontrolexcel;

 if(temp4!='NA' )
{ 
	
	 leasedatas='<%=cmd.docmntContrlRegGrid(barchval,id,chk_val)%>' ; 
	 documentntcontrolexcel='<%=cmd.docmntContrlRegGridexcel(barchval,id,chk_val)%>' ;
} 

else{
	
 leasedatas=[];
	
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                        {name : 'doc_no', type: 'String'  },
                        {name : 'name', type: 'String'  },
						{name : 'issue_date', type: 'date'  },
						{name : 'exp_date', type: 'date'  },
						{name : 'desc', type: 'String'  },
						{name : 'note', type: 'String'  },
						{name : 'attach', type: 'String'  },
						],
				    localdata: leasedatas,
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
    
    
    $("#docCntrlRegId").jqxGrid(
    {
        width: '99%',
        height: 535,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
    //selectionmode: 'singlecell',
        pagermode: 'default',
        editable:false,
        columnsresize:true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%', 
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                     { text: 'Doc No', datafield: 'doc_no',  width: '6%'}, 
                     { text: 'Document Name', datafield: 'name',  width: '20%' }, 
           	         { text: 'Description', datafield: 'desc',  width: '25%' }, 
					 { text: 'Issue Date', datafield: 'issue_date', width: '7%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Expiry Date', datafield: 'exp_date', width: '7%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Notes',datafield: 'note'},
				     { text: '',  datafield: 'attach',columntype: 'button', width: '6%' },
					]

   
    });
    $("#overlaysub, #PleaseWaitsub").hide();
     
   $('#docCntrlRegId').on('celldoubleclick', function (event) 
   { 
	   var rowindex1=event.args.rowindex;
	   document.getElementById("hidocno").value=$('#docCntrlRegId').jqxGrid('getcellvalue',rowindex1,"doc_no");
	   if($('#chkvalue').val()=="1"){
	   		$('#dataupdate').attr('disabled',false);
	   		$('#datadelete').attr('disabled',false);      
	   		$('#txtdocnameupd').attr('disabled',false);
	   		$('#txtdescupd').attr('disabled',false);
	   		$('#expupdatefromdate').jqxDateTimeInput('disabled',false);
	   		$('#expupdatetodate').jqxDateTimeInput('disabled',false);
	   		$('#txtnoteupd').attr('disabled',false);
	   		document.getElementById("txtdocnameupd").value=$('#docCntrlRegId').jqxGrid('getcellvalue',rowindex1,"name");
	   		document.getElementById("txtdescupd").value=$('#docCntrlRegId').jqxGrid('getcellvalue',rowindex1,"desc");
	   		document.getElementById("txtnoteupd").value=$('#docCntrlRegId').jqxGrid('getcellvalue',rowindex1,"note");
	   		$('#expupdatefromdate').jqxDateTimeInput('val',$('#docCntrlRegId').jqxGrid('getcellvalue',rowindex1,"issue_date"));
	   		$('#expupdatetodate').jqxDateTimeInput('val',$('#docCntrlRegId').jqxGrid('getcellvalue',rowindex1,"exp_date"));
	   }
		if($('#chkvalue').val()=="2"){
			$('#update').attr('disabled',false);
    	}
    		 });	 
    
   $('#docCntrlRegId').on('cellclick', function (event) 
		   { 
	   var brch="1";
	   var rowindex1=event.args.rowindex;
	   var datafield=event.args.datafield;
	   if(datafield=="attach"){
		var doc_no=$('#docCntrlRegId').jqxGrid('getcellvalue',rowindex1,"doc_no");
		   var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode=BDCR&docno="+doc_no+"&brchid="+brch+"&frmname="+document.getElementById("detailname").value,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
					  myWindow.focus();
	   }
	   
		   });	 
});


</script>
<div id="docCntrlRegId"></div>
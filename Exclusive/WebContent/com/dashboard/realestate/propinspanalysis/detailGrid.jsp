<%@page import="com.dashboard.realestate.propinspanalysis.*" %>
<% String contextPath1=request.getContextPath();%>
<%
	ClsPropInspAnalysisDAO DAO=new ClsPropInspAnalysisDAO();
	String id= request.getParameter("id")==null?"0":request.getParameter("id"); 
 	String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
	String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
	String tenantdocno = request.getParameter("tenantdocno")==null?"":request.getParameter("tenantdocno").trim();
	String propdocno = request.getParameter("propdocno")==null?"":request.getParameter("propdocno").trim();
	
%>
  <style type="text/css">
  .advanceClass
  {
      color: #FF0000;
  }
  .yellowClass
        {
        
       
       background-color: #FFB6C1; 
        /*   background-color: #eedd82;  */
        }
</style>
<script type="text/javascript">
var detaildata=[];
var id='<%=id%>';
if(id=="1"){
	detaildata='<%=DAO.getDetailData(branch,fromdate,todate,tenantdocno,propdocno,id)%>';
}
$(document).ready(function () {  
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
        	{name : 'inspdocno', type: 'number'   },
            {name : 'propdocno', type: 'number'   },
            {name : 'tncdocno', type: 'number'   },
            {name : 'tncvocno',type:'number'},
            {name : 'inspdate', type: 'date'   },
            {name : 'insptype', type: 'string'   },
            {name : 'unitno1', type: 'string'   },
            {name : 'propname', type: 'string'   },
            {name : 'tenantname', type: 'string'   },
            {name : 'scheduledate', type: 'date'   },
     		{name : 'skipped', type: 'number'   },
     		{name : 'inspstatus', type: 'string'   },
     		{name : 'inspuser',type:'string'},
     		{name : 'attachbtn',type:'string'},
     		{name : 'signstatus',type:'string'},  
     		{name : 'emailbtn',type:'string'},
     		{name : 'email',type:'string'},
     		{name : 'cldocno',type:'string'},
     		{name : 'editbtn',type:'string'},
     		{name : 'compl',type:'string'},
     		
     	],
        localdata: detaildata, 
                
        pager: function (pagenum, pagesize, oldpagenum) {
        	// callback called when a page or page size is changed.
        }
	};
    var cellclassname =  function (row, column, value, data) {
    var confirm=$('#detailGrid').jqxGrid('getcellvalue', row, "compl");
    
    if(parseInt(confirm)>0)
  	  {
  	  return "yellowClass";
  	  }
    }
    var dataAdapter = new $.jqx.dataAdapter(source);
    $("#detailGrid").jqxGrid(
    {
    	width: '100%',
        height: 550,
        source: dataAdapter,
        columnsresize:true,
        filterable: true,
        selectionmode: 'singlerow',
        showfilterrow: true,
        sortable:true,
        enabletooltips:true,    
        
		columns: [
			{ text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '4%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },
        	{ text: 'Doc No', datafield: 'inspdocno', width: '4%',cellclassname: cellclassname},
        	{ text: 'Doc No', datafield: 'propdocno', width: '6%',hidden:true },
        	{ text: 'Doc No', datafield: 'tncdocno', width: '6%',hidden:true },
        	{ text: 'TNC #', datafield: 'tncvocno', width: '4%',cellclassname: cellclassname},
			{ text: 'Date', datafield: 'inspdate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname },
			{ text: 'Type', datafield: 'insptype', width: '5%',cellclassname: cellclassname },
			{ text: 'Unit', datafield: 'unitno1', width: '5%',cellclassname: cellclassname },
			{ text: 'Property', datafield: 'propname' ,cellclassname: cellclassname },
			{ text: 'Tenant', datafield: 'tenantname' , width: '14%',cellclassname: cellclassname},
			{ text: 'Schedule Date ', datafield: 'scheduledate' , width: '6%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
			{ text: 'User', datafield: 'inspuser' , width: '8%',cellclassname: cellclassname},
			{ text: 'compl', datafield: 'compl', width: '6%',hidden:true },
			{ text: 'Skipped', datafield: 'skipped', width: '6%',hidden:true },
			{ text: 'Status', datafield: 'inspstatus', width: '5%',cellclassname: cellclassname },
			{ text: 'Insp Status', datafield: 'signstatus', width: '6%' ,cellclassname: cellclassname},
			{ text: 'Edit', datafield: 'editbtn', width: '6%',columntype: 'button',editable:false, filterable: false},
			{ text: 'Attach', datafield: 'attachbtn', width: '6%',columntype: 'button',editable:false, filterable: false},
			{ text: 'Email', datafield: 'emailbtn', width: '6%',columntype: 'button',editable:false, filterable: false},
			{ text: 'cldocno', datafield: 'cldocno', width: '6%',hidden:true },
			{ text: 'email', datafield: 'email', width: '6%',hidden:true },
		]
	});
            
    $('#detailGrid').on('rowdoubleclick', function (event) {
		var boundIndex = event.args.rowindex;
		var docno = $('#detailGrid').jqxGrid('getcelltext',boundIndex, "inspdocno");  
		var url=document.URL;    
	    var reurl=url.split("com/");                 
	    var win= window.open(reurl[0]+"propertyinspection/printPropertyInspLogin.action?docno="+docno+"&dtype=BPI","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();                   
    }); 
	  $("#detailGrid").on('cellclick', function (event){
    		    var datafield = event.args.datafield;
    		    var rowBoundIndex = event.args.rowindex;
    		    var columnindex = event.args.columnindex;      
  			    var docno=$('#detailGrid').jqxGrid('getcellvalue',rowBoundIndex, "inspdocno");     
				if(datafield=="attachbtn"){
			            		 // document.getElementById("docnoss").value=$('#detailGrid').jqxGrid('getcellvalue',rowBoundIndex, "inspdocno");
			         funAttachBtn(docno);      
			      }
				if(datafield=="emailbtn"){    
					funAttachPrint(docno,rowBoundIndex);       
			     }
				if(datafield=="editbtn"){
					var url=document.URL;    
				    var reurl=url.split("com/");    
				    var insptype=$('#detailGrid').jqxGrid('getcellvalue',rowBoundIndex, "insptype");
				    var win= window.open(reurl[0]+"propertyinspection/dashboard.jsp?docno="+docno+"&dtype=BPI&mode=E&insptype="+insptype,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				    win.focus();
				}
	});


    $("#overlay, #PleaseWait").hide();
});
	function funAttachPrint(docno,boundIndex){  
		$("#overlay, #PleaseWait").show();
		var doctype="BPIA";    
		var dtype="BPI";    
		var userid="<%= session.getAttribute("USERNAME").toString() %>";      
	    var x=new XMLHttpRequest();   
	    x.onreadystatechange=function(){
	    if (x.readyState==4 && x.status==200){
	    		var items=x.responseText.trim(); 
	    		if(parseInt(items)>0){  
	    			  funSendEmail(boundIndex);       
					}else{
						 $("#overlay, #PleaseWait").hide();
					} 
	    	 }
	    }     
	    x.open("GET","attachPrint.jsp?docno="+docno+'&doctype='+doctype+'&dtype='+dtype+'&userid='+userid,true);                                                          
	    x.send();    
	} 
	function funSendEmail(boundIndex){
		$("#overlay, #PleaseWait").hide();
		var email=$('#detailGrid').jqxGrid('getcelltext',boundIndex, "email");
		var cldocno=$('#detailGrid').jqxGrid('getcelltext',boundIndex, "cldocno");
		var client=$('#detailGrid').jqxGrid('getcelltext',boundIndex, "tenantname");
		var type=$('#detailGrid').jqxGrid('getcelltext',boundIndex, "insptype"); 
		var brchid=1;     
		var userid="<%= session.getAttribute("USERID").toString() %>";        
   		var contrctno=$('#detailGrid').jqxGrid('getcelltext',boundIndex, "inspdocno"); 
   		
   		var unit=$('#detailGrid').jqxGrid('getcelltext',boundIndex, "unitno1"); 
   		unit=unit.replace(/\D/g, "");
   		var cc="";
   		if((unit % 2)==1){
   			cc="sarah@exclusive-links.com";
   		}else {
   			cc="paul@exclusive-links.com";
   		}
   		
   		var frmdet="BPIA";                      
   		var dtype="BPIA";  
   		var subject="Inspection ";
   		var fname="Inspection ";
   		
   		var message="Inspection ";   
   		if(type.trim()=="Hand Over"){
   			subject="Property Hand Over";
   			message="<p>Dear "+client+",<br><br>Exclusive Links Property Management Team would like to take this opportunity to welcome you to your new home. <br><br> Please find attached a copy of the signed Handover Key Receipt and Handover Report for your information. <br><br> I have reported the pending issues to management and maintenance co-ordinator, who will be in touch with you. <br><br> Just as reference, it is expected that all our tenants maintain the upkeep of their unit where possible and only use us for major matters that may cause damage to the fabric of the property itself, i.e. electrical, major leaks and AC etc. <br><br> Any major maintenance and/or repair are the responsibility of the Landlord and should be reported direct to our office. <br><br> ";             			
   		}
		
		window.open("../../../../com/emailnew/Email.jsp?formcode="+dtype+"&docno="+contrctno+"&brchid="+brchid+"&frmname="+fname+"&recipient="+email+"&cldocno="+cldocno+"&client="+client+"&userid="+userid+"&dtype="+frmdet+"&msg="+message+"&subject="+subject+"&cc="+cc,"E-Mail","menubar=0,resizable=1,width=900,height=950");
	}
	function funAttachBtn(docno){
		$("#windowattach").jqxWindow('setTitle',"Inspection - "+docno);
		changeAttachContent("<%=contextPath1%>/com/dashboard/Attach.jsp?formCode=BPI&docno="+docno+"&barchvals=1");		
	}    
	function changeAttachContent(url) {
		$.get(url).done(function (data) {
		$('#windowattach').jqxWindow('open');
		
		$('#windowattach').jqxWindow('setContent',data);
		 $('#windowattach').jqxWindow('bringToFront');
		});       
	}    
</script>
<div id="detailGrid"></div>
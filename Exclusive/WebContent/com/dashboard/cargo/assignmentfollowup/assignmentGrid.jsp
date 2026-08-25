
<%@page import="com.dashboard.cargo.assignmentfolloup.ClsassignmentFolloup" %>
<%ClsassignmentFolloup cfar=new ClsassignmentFolloup();
String id=request.getParameter("check")==null?"0":request.getParameter("check");
String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();



%>
<% String contextPath=request.getContextPath();%>
<script type="text/javascript">
var datas;
var id='<%=id%>';
$(document).ready(function () {
	if(id=='1'){
		datas='<%=cfar.gridDataLoad(branchval,fromdate,todate)%>';
	}
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'doc_no', type: 'String'  },
                        {name : 'enqno', type: 'String'  },
						{name : 'jobno', type: 'String'  },
						{name : 'client', type: 'String'  },
						{name : 'salesman', type: 'String'  },
						{name : 'desc1', type: 'String'  },
						{name : 'pol', type: 'String'  },
						{name : 'pod', type: 'String'  },
						{name : 'qty', type: 'number'  },
						{name : 'mode', type: 'String'  },
						{name : 'smode', type: 'String'  },
						{name : 'shipment', type: 'String'  },
						{name : 'srvtype', type: 'String'  },
						{name : 'agto', type: 'String'  },
						{name : 'brhid', type: 'String'  },
						{name : 'adocno', type: 'String'  },
						{name : 'refno', type: 'String'  },
						{name : 'typeid', type: 'String'  },
						{name : 'cur_status', type: 'String' },
						{name : 'cur_substatus', type: 'String' },
						{name : 'attach', type: 'String' },
						
						
						
						
						],
				    localdata: datas,
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
    
    $("#jqxAssignmentgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        sortable:true,
        columnsresize: true,
        selectionmode: 'checkbox',
        //pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '3%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                     { text: 'ENQUIRY NO',datafield: 'enqno', width: '6%' },
         			 { text: 'JOB NO', datafield: 'jobno', width: '4%'},
         			 { text: 'CLIENT',datafield: 'client', width: '25%' },
         			 { text: 'REF NO', datafield: 'refno', width: '12%'},
         			 { text: 'SALESMAN',datafield: 'salesman', width: '12%' },
         		     { text: 'DESCRIPTION', datafield: 'desc1',  width: '9%'  },
                     { text: 'POL', datafield: 'pol',  width: '8%'  },
                     { text: 'POD', datafield: 'pod',  width: '8%'  },
                     { text: 'QTY', datafield: 'qty',  width: '5%',cellsformat: 'd2'  },
           	         { text: 'MODE', datafield: 'mode',  width: '5%' }, 
           	         { text: 'SUB MODE', datafield: 'smode',  width: '6%' },
           	         { text: 'SHIPMENT', datafield: 'shipment',  width: '8%' },
           	         { text: 'SERVICE TYPE', datafield: 'srvtype',  width: '8%'},
           	         { text: 'CURRENT STATUS', datafield: 'cur_status',  width: '8%'},
           	      	 { text: 'SUBSTATUS', datafield: 'cur_substatus',  width: '6%'},
           	     	 { text: 'typeid', datafield: 'typeid',  width: '10%',hidden:true},
           	   		 { text: 'ATTACH',  datafield: 'attach',columntype: 'button', width: '6%' },
				     { text: 'adocno', datafield: 'adocno',  width: '6%' , hidden: true},
           	      	 { text: 'doc_no', datafield: 'doc_no',  width: '6%' , hidden: true},
           	         { text: 'agto', datafield: 'agto',  width: '6%', hidden: true},
           	         { text: 'brhid', datafield: 'brhid',  width: '6%', hidden: true},
					]
   
    });
    
    $("#overlay, #PleaseWait").hide();
    
    $('#jqxAssignmentgrid').on('rowselect', function (event){
    	var rowindextemp = event.args.rowindex;
    	var datafield = event.args.datafield;
    	$('#txtstatus').attr("disabled",false);
    	$('#txtasset').attr("disabled",false);
    	$('#txtsdocno').attr("disabled",false);
    	$('#txtstdocno').attr("disabled",false);
    	$('#update').attr("disabled",false);
    	$("#doc_no").val($('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindextemp, "doc_no"));
    	$("#hidbrhid").val($('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindextemp, "brhid"));
    	
    	if(datafield=="attach"){
     		var brchid=$("#jqxAssignmentgrid").jqxGrid('getcellvalue', rowindextemp, "brhid"); 
     		var docno=$("#jqxAssignmentgrid").jqxGrid('getcellvalue', rowindextemp, "jobno");
     		var frmdet="SJOB";
     		
     		if ($("#docno").val()!="") {
			
			   var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmdet
						 +"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
						  myWindow.focus();
		
     		} else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			    }
     		 
            }
   
    });
    
    
    $('#jqxAssignmentgrid').on('cellclick', function (event){
    	var rowindextemp = event.args.rowindex;
    	var datafield = event.args.datafield;
    	 
    	if(datafield=="attach"){
     		var brchid=$("#jqxAssignmentgrid").jqxGrid('getcellvalue', rowindextemp, "brhid"); 
     		var docno=$("#jqxAssignmentgrid").jqxGrid('getcellvalue', rowindextemp, "jobno");
     		var frmdet="SJOB";
     		
     		if ($("#docno").val()!="") {
			
			   var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmdet
						 +"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
						  myWindow.focus();
		
     		} else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			    }
     		 
            }
   
    });
   
   
});


</script>
<div id="jqxAssignmentgrid"></div>
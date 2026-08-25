<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.operations.vehicletransactions.vehicleinspection.*"%>
<%
ClsVehicleInspectionDAO inspdao=new ClsVehicleInspectionDAO();
String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype").toString();
String type=request.getParameter("type")==null?"":request.getParameter("type").toString();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno").toString();
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno").toString();
String regno=request.getParameter("regno")==null?"":request.getParameter("regno").toString();
String date=request.getParameter("date")==null?"":request.getParameter("date").toString();
String mode=request.getParameter("mode")==null?"0":request.getParameter("mode").toString();

%>
<script type="text/javascript">
	var mode='<%=mode%>';
	var datadocsearch;
	if(mode=="1"){
		datadocsearch='<%=inspdao.getDoc(reftype,branch,docno,fleetno,regno,date,mode,type)%>';
	}
	else{
		datadocsearch=[];
	}

        $(document).ready(function () { 	
        	
            // var url="demo.txt"; 
        	var num = 0;
        	var source =
            {
                datatype: "json",
                datafields: [
	{name : 'doc_no' , type:'number'},
	{name : 'voc_no',type:'number'},
	{name : 'date' , type:'date'},
	{name :'fleet_no',type:'String'},
	{name : 'reftype',type:'String'},
	{name : 'insurexcess',type:'number'},
	{name : 'reg_no',type:'String'},
	{name : 'refname',type:'String'}
	],
                
                localdata: datadocsearch,
                //url: url,
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
           
            $("#docSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                filterable:true,
              //  showfilterrow:true,
               // rowsheight:18,
                //statusbarheight:25,
                columnsresize: true,
                //columnsheight: 15,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
             	//showaggregates:true,
               //showstatusbar:true,
               // editable:true,
                //Add row method
                    handlekeyboardnavigation: function (event) {
                                },
                columns: [
{ text: 'Ref Doc No',filtertype: 'number',  datafield: 'voc_no',  width: '20%'},
{ text: 'Ref Origignal Doc No',filtertype: 'number',  datafield: 'doc_no',  width: '25%',hidden:true},
{ text: 'Date',  filtertype: 'date',datafield:'date', width:'20%' ,cellsformat:'dd.MM.yyyy'},
{ text: 'Fleet', columntype: 'textbox', filtertype: 'input',datafield:'fleet_no', width:'20%' },
{ text: 'Reg No', datafield:'reg_no', width:'20%' },
{ text: 'Ref Type',columntype: 'textbox', filtertype: 'input', datafield:'reftype', width:'20%' },
{ text: 'Insur Excess', datafield:'insurexcess', width:'25%',cellsformat:'d2',hidden:true },
{ text: 'Ref Name', datafield:'refname', width:'25%',hidden:true }

	              ], 
            });
            $('#docSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
   				document.getElementById("rdocno").value=$("#docSearch").jqxGrid('getcellvalue', rowindex1, "doc_no");
   				document.getElementById("refvoucherno").value=$("#docSearch").jqxGrid('getcellvalue', rowindex1, "voc_no");
   				document.getElementById("rfleet").value=$("#docSearch").jqxGrid('getcellvalue', rowindex1, "fleet_no");
   			 document.getElementById("regno").value=$("#docSearch").jqxGrid('getcellvalue', rowindex1, "reg_no");
   				document.getElementById("client").value=$("#docSearch").jqxGrid('getcellvalue', rowindex1, "refname");
			 $('#existingdiv').load('existingGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc=0');
   			 $('#existmaintenancediv').load('existmaintenanceGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc=0');
   				$('#docwindow').jqxWindow('close');
           		document.getElementById("hidinsurexcess").value=$("#docSearch").jqxGrid('getcellvalue', rowindex1, "insurexcess");
            });  
            var rows=$("#docSearch").jqxGrid("getrows");
            var rowcount=rows.length;
            if(rowcount==0){
            	$("#docSearch").jqxGrid("addrow", null, {});	
            }
            

        });
            </script>
            <div id="docSearch"></div>
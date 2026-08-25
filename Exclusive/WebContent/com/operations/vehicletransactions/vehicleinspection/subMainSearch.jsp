
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionDAO" %>
 <%
 
 String cmbtype = request.getParameter("cmbtype")==null?"0":request.getParameter("cmbtype");
 String cmbreftype=request.getParameter("cmbreftype")==null?"0":request.getParameter("cmbreftype");
 String fleetno=request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
 String refdocno = request.getParameter("refdocno")==null?"0":request.getParameter("refdocno");
 String date = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
 String regno=request.getParameter("regno")==null?"0":request.getParameter("regno");
 
 ClsVehicleInspectionDAO dao= new ClsVehicleInspectionDAO();
 
%> 
 <script type="text/javascript">
 
  var loaddata;

 loaddata='<%=dao.mainSearch(cmbtype,cmbreftype,fleetno,refdocno,date,docno,branch,regno)%>';
               
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             
                         	
							{name : 'doc_no' , type: 'string' },
							{name : 'refvoucherno',type:'string'},
							{name : 'date' , type:'date'},
							{name : 'type' , type:'String'},
							{name : 'reftype' , type:'string'},
							 {name : 'refdocno',type:'string'},
							 {name :'amount',type:'number'},
							 {name :'accident',type:'number'},
							 {name :'polrep',type:'string'},
							 {name :'acdate',type:'date'},
							 {name :'coldate',type:'date'},
							 {name :'place',type:'string'},
							 {name :'fine',type:'number'},
							 {name :'remarks',type:'string'},
							 {name :'claim',type:'number'},
							 {name :'rfleet',type:'string'},
							 {name : 'reg_no',type:'string'},
      							{name : 'agmtbranch',type:'string'},
      						{name : 'refname',type:'String'}
      						
      						
                          	],
                          	localdata: loaddata,
                          
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,

                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
				
					{ text: 'Doc No', datafield: 'doc_no', width: '14.28%'},
				{ text: 'Date',  datafield: 'date',  width: '14.28%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Type',  datafield: 'type',  width: '14.28%' },
					{ text:'Fleet', datafield:'rfleet',width:'14.28%'},
					{ text: 'Reg No',datafield:'reg_no',width:'14.28%'},
					{ text:'Ref Type',datafield:'reftype',width:'14.28%'},
					{ text: 'Original Ref Docno', datafield:'refdocno', width:'14.28%',hidden:true},
					{ text: 'Ref Docno', datafield:'refvoucherno', width:'14.28%'},			//Reference Voucher No
					{ text: 'Amount', datafield:'amount', width:'20%',hidden:true,cellsformat:'d2'},
					{ text: 'Accident', datafield:'accident', width:'20%' },
					{ text: 'PRCS', datafield:'polrep', width:'20%',hidden:true},
					{ text: 'Acc Date', datafield:'acdate', width:'20%',hidden:true,cellsformat:'dd.MM.yyyy' },
					{ text: 'Collect Date', datafield:'coldate', width:'20%',hidden:true,cellsformat:'dd.MM.yyyy'},
					{ text: 'Place', datafield:'place', width:'20%',hidden:true },
					{ text: 'Fine', datafield:'fine', width:'20%',hidden:true ,cellsformat:'d2'},
					{ text: 'Remarks', datafield:'remarks', width:'20%',hidden:true },
					{ text: 'Claim', datafield:'claim', width:'20%',hidden:true },
					{ text: 'Agreement Branch',datafield:'agmtbranch',width:'20%',hidden:true},
					 { text: 'Client',datafield:'refname',width:'10%',hidden:true}
					 
			
					
					
					]
            });
    
            $("#jqxmainsearch").jqxGrid('addrow', null, {});
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        		var rowindex=event.args.rowindex;
				            	document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex, "doc_no");
				            	document.getElementById("refvoucherno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex, "refvoucherno");
				            	 $("#date").jqxDateTimeInput('val',$("#jqxmainsearch").jqxGrid('getcellvalue', rowindex, "date"));
				            	 $('#cmbtype').val($("#jqxmainsearch").jqxGrid('getcellvalue', rowindex, "type"));
				            	 $('#cmbreftype').val($("#jqxmainsearch").jqxGrid('getcellvalue', rowindex, "reftype"));
				            	 $('#cmbagmtbranch').val($("#jqxmainsearch").jqxGrid('getcellvalue', rowindex, "agmtbranch"));
				            	 document.getElementById("rdocno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex, "refdocno");
				            	 document.getElementById("amount").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex, "amount");
				            	 document.getElementById("hidaccidents").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex, "accident");
				            	 if($('#jqxmainsearch').jqxGrid('getcellvalue', rowindex, "accident")=="1"){
				            		 document.getElementById("chkaccidents").checked=true;
				            	 }
				            	 else{
				            		 document.getElementById("chkaccidents").checked=false;
				            	 }
				            	 
				            	 document.getElementById("prcs").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex, "polrep");
				            	 $("#accdate").jqxDateTimeInput('val',$("#jqxmainsearch").jqxGrid('getcellvalue', rowindex, "acdate"));
				            	 $("#collectdate").jqxDateTimeInput('val',$("#jqxmainsearch").jqxGrid('getcellvalue', rowindex, "coldate"));
				            	 document.getElementById("accplace").value=$("#jqxmainsearch").jqxGrid('getcellvalue', rowindex, "place");
				            	 document.getElementById("accfines").value=$("#jqxmainsearch").jqxGrid('getcellvalue', rowindex, "fine");
				            	 document.getElementById("rfleet").value=$("#jqxmainsearch").jqxGrid('getcellvalue', rowindex, "rfleet");
				            	 document.getElementById("accremarks").value=$("#jqxmainsearch").jqxGrid('getcellvalue', rowindex, "remarks");
				           		document.getElementById("regno").value=$('#jqxmainsearch').jqxGrid('getcellvalue',rowindex,'reg_no');
				           		 document.getElementById("client").value=$('#jqxmainsearch').jqxGrid('getcellvalue',rowindex,'refname');
				            	 $('#cmbclaim').val($("#jqxmainsearch").jqxGrid('getcellvalue', rowindex, "claim"));
				    			 $('#existingdiv').load('existingGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
				    			 $('#newdiv').load('newgrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value+'&code='+document.getElementById("formdetailcode").value);
				    			 $('#existmaintenancediv').load('existmaintenanceGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
				    			 $('#newmaintenancediv').load('newmaintenanceGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
				            $('#window').jqxWindow('close');

				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    


<%@page import="com.operations.vehicletransactions.movement.ClsMovementDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
String reftype = request.getParameter("reftype")==null?"0":request.getParameter("reftype");
 String searchdate = request.getParameter("msearchdate")==null?"":request.getParameter("msearchdate");
 String fleetno = request.getParameter("mfleetno")==null?"0":request.getParameter("mfleetno");
 String docno = request.getParameter("mdocno")==null?"0":request.getParameter("mdocno");
String regno=request.getParameter("mregno")==null?"0":request.getParameter("mregno");
String status=request.getParameter("status")==null?"0":request.getParameter("status");
ClsMovementDAO movdao=new ClsMovementDAO();
%> 
 <script type="text/javascript">
 
  var loaddata;

  loaddata='<%=movdao.mainSearch(reftype,searchdate,fleetno,docno,regno,status)%>';
               
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             
                         	
                         
     						{name : 'date', type: 'date'  },
     						 {name : 'fleet_no', type: 'String'  }, 
     						{name : 'status', type: 'String'  },
      						{name : 'doc_no', type: 'String'  },
      						{name :'st_desc',type:'string'},
      						{name : 'reg_no',type:'string'}
      						
      						
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
					{ text: 'DOC NO', datafield: 'doc_no', width: '16.66%' },
					{ text: 'DATE', datafield: 'date', width: '16.66%',cellsformat:'dd.MM.yyyy' },
					{ text: 'STATUS', datafield: 'status', width: '16.66%'},
					{ text:'REF TYPE',datafield:'st_desc',width: '16.66%'},
					{ text: 'FLEET NO', datafield: 'fleet_no', width: '16.66%' },
					{ text: 'REG NO', datafield: 'reg_no', width: '16.66%' }
					
					
					
					 
			
					
					
					]
            });
    
           // $("#jqxmainsearch").jqxGrid('addrow', null, {});
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	   var row2=event.args.rowindex;
				                document.getElementById("txtfleetno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "fleet_no");
				                document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "doc_no");
				                $("#date").jqxDateTimeInput('val',$("#jqxmainsearch").jqxGrid('getcellvalue', row2, "date"));
				            	$('#date').jqxDateTimeInput({ disabled: false});
				            	$('#dateout').jqxDateTimeInput({ disabled: false});
				            	//$('#accdate').jqxDateTimeInput({ disabled: false});
				            	$('#closedate').jqxDateTimeInput({ disabled: false});
				            	
				            	$('#garagedeldate').jqxDateTimeInput({ disabled: false});
				            	$('#garagecollectdate').jqxDateTimeInput({ disabled: false});
				            	//$('#collectdate').jqxDateTimeInput({ disabled: false});
				            	//alert("::::"+$('#mvmainsearch').jqxGrid('getcellvalue', row2, "status")+":::::");
				            	if($('#jqxmainsearch').jqxGrid('getcellvalue', row2, "status")=="OUT"){
				            		document.getElementById("movtempstatus").value="OUT";
				            	}
				            	funSetlabel();
				            	 $("#overlay, #PleaseWait").show(); 
				            	document.getElementById("frmMovement").submit();
								 $('#window').jqxWindow('close');
				                });
				            var rows=$("#jqxmainsearch").jqxGrid('getrows');
				            var rowlength=rows.length;
				            if(rowlength==0){
				          	  $("#jqxmainsearch").jqxGrid('addrow', null, {});

				            }
				            
				            		 });	 
				           
        
               
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    

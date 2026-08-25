<%@ page import="com.dashboard.audit.ClsAudit" %>
<% ClsAudit cat=new ClsAudit(); %>

 <%
 
String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
  String formname=request.getParameter("formname")==null?"0":request.getParameter("formname");
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 %>
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var approvalstatusexcel;
 var datasssss;
 var aa,maindata;
 //alert(temp4);
  if(temp4!='NA')
 { 

 
 maindata=<%=cat.mainfollow(barchval,formname,docno,check)%>
 approvalstatusexcel=<%=cat.excelmainfollow(barchval,formname,docno,check)%> 
 aa=0;
 //alert(maindata);
 }
  
  
  else
	  {
	  maindata;
	  approvalstatusexcel;
	  aa=1;
	  }
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                         	{name : 'branch', type: 'String'  },
     						//{name : 'date', type: 'date'},
     						{name : 'doc_no', type: 'String'}, 
     						{name : 'doctype', type: 'String'},
     						{name : 'username', type: 'String'  },
     						{name : 'refname', type: 'String' },
     					    {name : 'desc1', type: 'String'  },
     						{name : 'subdatetime', type: 'date'  },
     						{name : 'user_name', type: 'String'  },
     						{name : 'remarks', type: 'String'  },
     						{name : 'level', type: 'String'  }
     						
     						     						
     						
                          	],
                          	localdata: maindata,
                          	       
          
				
                
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
            $("#duedategrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 550,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
                columns: [
                          
							{ text: 'Branch', datafield: 'branch', width: '12%' },
							//{ text: 'Date', datafield: 'date', width: '9%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Doc_no', datafield: 'doc_no', width: '11%' },
							{text: 'Dtype', datafield: 'doctype', width: '11%'},
							{ text: 'Client', datafield: 'refname', width: '14%'},
							{ text: 'Description', datafield: 'desc1', width: '14%'},
							{ text: 'Datetime', datafield: 'subdatetime', width: '13%',cellsformat:'dd.MM.yyyy'},
						    { text: 'Username', datafield: 'user_name', width: '15%' },
							{ text: 'Remarks', datafield: 'remarks', width: '11%' },
							{ text: 'Approvallevel', datafield: 'level', width: '10%' }
										
					]
            });
         
            if(aa==1)
        	{
        	 $("#duedategrid").jqxGrid('addrow', null, {});
        	}
      
            $('#duedategrid').on('rowdoubleclick', function (event) 
            		{ 
        	  var rowindex1=event.args.rowindex;
        	  document.getElementById("rentaldoc").value="";
        	  document.getElementById("remarks").value="";
        	  document.getElementById("branchids").value="";
        	  document.getElementById("fleetno").value="";
        	  document.getElementById("grgid").value="";
        	  
        	  $('#cmbinfo').val("");
        		 $('#cmbinfo').attr("disabled",false);
        		 $('#remarks').attr("readonly",false);
        		 $('#driverUpdate').attr("disabled",false);
        	  
        	  document.getElementById("rentaldoc").value=$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        	  document.getElementById("fleetno").value=$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
        	  document.getElementById("grgid").value=$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "garageid");
            
        	  document.getElementById("branchids").value=$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "brhid");
        	
              
       
              
              
              $("#detaildiv").load("detailgrid.jsp?rdoc="+$('#duedategrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
        	  
            		});
            
        });
        
        
				       
                       
    </script>
    
    <div id="duedategrid"></div>
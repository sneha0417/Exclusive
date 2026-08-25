<%@page import="com.project.execution.projectInvoice.ClsProjectInvoiceDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%
 ClsProjectInvoiceDAO DAO= new ClsProjectInvoiceDAO();
 %>
 <%
  String trno=request.getParameter("pjinvtrno")==null?"0":request.getParameter("pjinvtrno").trim().toString();
 
 %>
    <script type="text/javascript">
    var servdata;
    var trno='<%=trno%>';
    var bb;
     if(trno>0){
		
    	servdata = '<%=DAO.serviceGridLoad(session,trno)%>';
    	bb=3;
    	
  }
     else{
    	 bb=5;
     }
    
    
        $(document).ready(function () { 	
         var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'dtype' , type: 'String' },
                          
     						{name : 'date', type: 'date'  },
     						{name : 'docno', type: 'String'  },
     						{name : 'amount', type: 'String'  },
     						
     						{name : 'descp', type: 'String'  },
     						{name : 'lfee', type: 'String'  }
                          	],
                 localdata: servdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            $("#serviceGrid").on("bindingcomplete", function (event) {
             	
             	 var rowlength=$("#serviceGrid").jqxGrid('rows').records.length;
             	 
             	if(rowlength>0){
             		var legalamt= $('#serviceGrid').jqxGrid('getcellvalue', 0, "lfee");
             		var seramt= $('#serviceGrid').jqxGrid('getcellvalue', 0, "amount");
             		
           		    document.getElementById("txtlegalamt").value=legalamt;
           		    document.getElementById("txtseramt").value=seramt;
             
           		 var txtlegalamt=document.getElementById("txtlegalamt").value;
          		 var txtseramt=document.getElementById("txtseramt").value;
          		 var txtexptotal=document.getElementById("txtexptotal").value;
          		 
             		 /* var grtotal=(parseFloat(txtexptotal)+parseFloat(txtlegalamt)+parseFloat(txtseramt));
             		 document.getElementById("txtnettotal").value=grtotal; */
             		
             	}
             	 
                });
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#serviceGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable:true,
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc Type', datafield: 'dtype', width: '16%',editable:false },
					
					{ text: 'Doc No', datafield: 'docno', width: '10%',editable:false},
					{ text: 'Date', datafield: 'date', width: '10%',editable:false,cellsformat:'dd.MM.yyyy' },
					{text: 'Description',datafield:'descp',width:'40%',editable:false},
					{text: 'Amount',datafield:'amount',width:'10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:true},
					{text: 'Legal Fee',datafield:'lfee',width:'10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:true}
					
					]
            });
            
            
    		    
    		    $("#serviceGrid").on('cellvaluechanged', function (event) 
                        {
                	
                	var datafield = event.args.datafield;
            		
        		    var rowBoundIndex = event.args.rowindex;
        		    var amount=0.0;
        		    var legalamt=0.0;
              	    
        		    if(datafield=="amount")
        		  {
        		    	
        		    	amount= $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
                   	  
                   	 if(!(amount==""||typeof(amount)=="undefined"|| typeof(amount)=="NaN" ))
          		   {
                   		document.getElementById("txtseramt").value=amount;
                   		
                 	    
          		   }
                   
    		    	
       		   }
        		    
        		    if(datafield=="lfee")
          		  {
          		    	
        		    	legalamt= $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "lfee");
        		   
                     	 if(!(legalamt==""||typeof(legalamt)=="undefined"|| typeof(legalamt)=="NaN" ))
            		   {
                     		document.getElementById("txtlegalamt").value=legalamt;
                     		
                   	    
            		   }
                     
      		    	
         		   }
        		    
        		     var txtlegalamt=document.getElementById("txtlegalamt").value;
             		 var txtseramt=document.getElementById("txtseramt").value;
             		 var txtexptotal=document.getElementById("txtexptotal").value;
             		 var grtotal=(parseFloat(txtexptotal)+parseFloat(txtlegalamt)+parseFloat(txtseramt));
             		 document.getElementById("txtnettotal").value=grtotal;
       		    
                	
              });
            	
              
            
            if($('#mode').val()=='view'){
       		 $("#serviceGrid").jqxGrid({ disabled: true});
       		
           }
           /*  $('#serviceGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="stype"))
	    	   {
 		    	 getserType(rowBoundIndex);
	    	   }
 		    			
            		});
       */
       if(bb==5)
    	   {
           $("#serviceGrid").jqxGrid('addrow', null, {});
    	   }
    	 
      
        });
    </script>
    <div id="serviceGrid"></div>

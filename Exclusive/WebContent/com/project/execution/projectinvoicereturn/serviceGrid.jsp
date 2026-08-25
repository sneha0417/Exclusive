<%@page import="com.project.execution.projectInvoicereturn.ClsProjectInvoiceReturnDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% ClsProjectInvoiceReturnDAO DAO= new ClsProjectInvoiceReturnDAO(); %>
<% String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
   String pjinvtrno=request.getParameter("pjinvtrno")==null?"0":request.getParameter("pjinvtrno").trim().toString();
   String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString(); %>
    <script type="text/javascript">
    var servdata;
	var gridload='<%=gridload%>';
    
    var bb;
    if(gridload>0){
    	servdata = '<%=DAO.serviceGridLoading(session,pjinvtrno)%>';
    	bb=3;
    	
  }
    if(gridload<=0){
    	servdata = '<%=DAO.serviceGridReoading(session,trno) %>';
    	bb=3;
    }
     else{
    	 bb=5;
     }
    
    
        $(document).ready(function () { 	
         
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'dtype' , type: 'String' },
     						{name : 'date', type: 'date'  },
     						{name : 'docno', type: 'String'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'atotal', type: 'number'  },
     						{name : 'legalchrg', type: 'number'  },
     						{name : 'retamount', type: 'number'  },
     						{name : 'retlegalcharge', type: 'number'  },
     						{name : 'descp', type: 'String'  },
     						{name : 'lfee', type: 'number'  }
                          	],
                 localdata: servdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            $("#serviceGrid").on("bindingcomplete", function (event) {
             	
             	 //var rowlength=$("#serviceGrid").jqxGrid('rows').records.length;
             	 
             	var rows = $("#serviceGrid").jqxGrid('getrows');
             	
             	if(parseInt(rows.length)>0){
             		var legalamt= $('#serviceGrid').jqxGrid('getcellvalue', 0, "lfee");
             		var seramt= $('#serviceGrid').jqxGrid('getcellvalue', 0, "amount");
             		var netseramt= $('#serviceGrid').jqxGrid('getcellvalue', 0, "atotal");
             		var netlegalamt = $('#serviceGrid').jqxGrid('getcellvalue', 0, "legalchrg");
             		var netretseramt= $('#serviceGrid').jqxGrid('getcellvalue', 0, "retamount");
             		var netretlegalamt = $('#serviceGrid').jqxGrid('getcellvalue', 0, "retlegalcharge");
             		
           		    document.getElementById("txtlegalamt").value=legalamt;
           		    document.getElementById("txtseramt").value=seramt;
           			document.getElementById("txtpjivnettotal").value=netseramt;
           			document.getElementById("txtpjivnetlegalamt").value=netlegalamt;
           			document.getElementById("txtpjivnetrettotal").value=netretseramt;
           			document.getElementById("txtpjivnetretlegalamt").value=netretlegalamt;
           		
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
                sortable: true,
                selectionmode: 'singlecell',
                editable: true,
                sortable: true,
	
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
					{ text: 'Description',datafield:'descp',width:'40%',editable:false},
					{ text: 'Amount',datafield:'amount',width:'10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:true},
					{ text: 'Legal Fee',datafield:'lfee',width:'10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:true},
					{ text: 'Net Amount',datafield:'atotal',width:'10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false, hidden: true },
					{ text: 'Legal Fee Net Amount',datafield:'legalchrg',width:'10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false, hidden: true },
					{ text: 'Net Returned Amount',datafield:'retamount',width:'10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false, hidden: true },
					{ text: 'Legal Fee Net Returned Amount',datafield:'retlegalcharge',width:'10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false, hidden: true }
					
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
                   		
                   		 var netseramt=document.getElementById("txtpjivnettotal").value;
                   		 var netretseramt=document.getElementById("txtpjivnetrettotal").value;
                 		
                   		 if(((parseFloat(netseramt)-parseFloat(netretseramt))-parseFloat(amount))<0) {
                   			document.getElementById("errormsg").innerText="Amount exceeds Invoice Amount : "+(parseFloat(netseramt)-parseFloat(netretseramt));
                   		    $('#serviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "amount",(parseFloat(netseramt)-parseFloat(netretseramt)));
                   		    return 0;
                   		 }
                   		
                   		 document.getElementById("txtseramt").value=amount;
                   		
                 	    
          		   }
                   
    		    	
       		   }
        		    
        		    if(datafield=="lfee")
          		  {
          		    	
        		    	legalamt= $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "lfee");
        		   
                     	 if(!(legalamt==""||typeof(legalamt)=="undefined"|| typeof(legalamt)=="NaN" ))
            		   {
                     		var netlegalamt=document.getElementById("txtpjivnetlegalamt").value;
                     		var netretlegalamt=document.getElementById("txtpjivnetretlegalamt").value;
                     		
                     		if(((parseFloat(netlegalamt)-parseFloat(netretlegalamt))-parseFloat(legalamt))<0) {
                       			document.getElementById("errormsg").innerText="Legal Amount exceeds Invoice Amount : "+(parseFloat(netlegalamt)-parseFloat(netretlegalamt));
                       			$('#serviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "lfee",(parseFloat(netlegalamt)-parseFloat(netretlegalamt)));
                       			return 0;
                       		 }
                     		
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
       
       $('#serviceGrid').on('cellclick', function(event) 
       		{
       	
       	document.getElementById("errormsg").innerText="";
       	
       		});
       
       /* if(bb==5)
    	   {
           $("#serviceGrid").jqxGrid('addrow', null, {});
    	   } */
    	 
      
        });
    </script>
    <div id="serviceGrid"></div>

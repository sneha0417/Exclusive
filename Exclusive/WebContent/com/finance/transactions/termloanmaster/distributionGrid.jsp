<%@page import="com.finance.transactions.termloanmaster.ClstermloanmasterDAO" %>
<%
ClstermloanmasterDAO vd1=new ClstermloanmasterDAO();
%>
<%@page import="javax.servlet.http.HttpServletRequest" %> 
<%@page import="javax.servlet.http.HttpSession" %>
 
<%
String masterdoc = request.getParameter("docnos")==null?"0":request.getParameter("docnos").trim();
String detvaliss = request.getParameter("detvalis")==null?"0":request.getParameter("detvalis");



String documentNo = request.getParameter("docNo")==null?"NA":request.getParameter("docNo");

 
%>
<style type="text/css">
        .disableClass{
            color: #999;
        }
</style>
<script type="text/javascript">


        //var data3;  
        $(document).ready(function () { 
     
            
        	var temp211='<%=detvaliss%>';

        	var temp1='<%=documentNo%>';

        var data1113;
            
          var temp="";
   
        if(temp1!='NA')
            	 {
            	 
            	 data1113='<%=vd1.exportdescription(documentNo) %>';  	 
            	 }
         
          
            if(parseInt(temp211)==10)  
            	  {
            	 
            	data1113='<%=vd1.descriptionssss(masterdoc) %>';
            	 
             
            	 
              
                  
                temp=0;
            	  }
              else
            	  {
            	   
            	  temp=1;
            	  data1113;
            	  } 
             
             
      
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name : 'sr_no', type: 'int'  }, 
     						{name : 'date', type: 'string'   },
     						{name : 'chqno', type: 'string'   },
     						{name : 'priamount', type: 'number'  },
     						{name : 'interest', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'bpvno', type: 'number'  }
                        ],
                		  localdata: data1113, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
 
   
            
            
            var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
               } 
               var rendererstring1=function (aggregates){
                  	var value=aggregates['sum1'];
                  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
                  }       
            var cellclassname = function (row, column, value, data) {
               
            }; 
//
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxDistributionGrid").jqxGrid(
            {
                width: '100%',
                height: 400,
                source: dataAdapter,
                editable: true,
                showaggregates:true,
                showstatusbar:true,
              //  disabled:true,
                statusbarheight: 20,
                localization: {thousandsSeparator: ""},
                rowsheight:20,
                selectionmode: 'singlecell', 
                
                columns: [
							{ text: 'Sr. No.', datafield: 'sr_no',  width: '5%', cellsalign: 'center', align: 'center', editable: false, cellclassname: cellclassname},
							{ text: 'Date', datafield: 'date',  width: '15%',  cellclassname: cellclassname, editable: false},
							{ text: 'Cheque No', datafield: 'chqno',  width: '18%',   cellclassname: cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 ,
								cellbeginedit: function (row) {
									var payment=document.getElementById("paymentmethod").value;
									var clstatus=document.getElementById("clstatus").value;
									
								  if(parseInt(payment)==2 || parseInt(clstatus)==1 )
									  {
									       return false;
										 }
								    
								  }	
							},
							{ text: 'Principal Amount', datafield: 'priamount',  width: '16%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: true,
								cellbeginedit: function (row) {
									 
									var clstatus=document.getElementById("clstatus").value;
									
								  if(parseInt(clstatus)==1 )
									  {
									       return false;
										 }
								    
								  }	},
							{ text: 'Interest', datafield: 'interest',  width: '16%', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring , editable: false},
							{ text: 'Amount', datafield: 'amount',   width: '18%',cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname ,aggregates: ['sum'],aggregatesrenderer:rendererstring , editable: true},
							{ text: 'Bpv No', datafield: 'bpvno',  width: '12%',  cellclassname: cellclassname, editable: false },
						]
            });
            
 
            if(temp1!='NA')
           	 {
            
                var summaryData1= $("#jqxDistributionGrid").jqxGrid('getcolumnaggregateddata', 'priamount', ['sum'],true);
                 
                  document.getElementById("priamounts").value=summaryData1.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
            	
           	 }
          //Add empty row
    
          
              else if(parseInt(temp)==1)
            	  {
            	  $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
            	  } 
              else
            	  {
            	  
            	  }
          
            if($('#mode').val()=="view")
            	{
            	$("#jqxDistributionGrid").jqxGrid({ disabled: true});
            	}
            
            
            
          
              $("#jqxDistributionGrid").on('cellvaluechanged', function (event) 
                      {

            	  
                      	var datafield = event.args.datafield;
                  		
              		    var rowBoundIndex = event.args.rowindex;
              
              		     
                      		if(datafield=="priamount" && document.getElementById("samp").value=="")
                      		    {
                      			
                      	 
                      			document.getElementById("errormsg").innerText="";
                      			
                      			document.getElementById("samp").value=1;
                      			valchange(rowBoundIndex);
                      			document.getElementById("samp").value="";
                      		    }
			if(datafield=="amount" && document.getElementById("samp").value=="")
                      		{
			   
				  var perint=document.getElementById("perinterest").value;
            	    var instnos=document.getElementById("instnos").value;
            	    document.getElementById("samp").value="1";
            	var amount=$('#jqxDistributionGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
            	
             
		           // var interest=parseFloat(priamount)*(parseFloat(perint)/100)*(parseFloat(instnos)/12); 
            var priamount=0;
			priamount=(parseFloat(amount)/ ( 1 + ( parseFloat(perint)/100)*(parseFloat(instnos)/12)));
//				select (7840/ (1+ ( 4 /100*(36/12))) );
	
					 var interest=parseFloat(amount)-parseFloat(priamount);
              
					$('#jqxDistributionGrid').jqxGrid('setcellvalue',rowBoundIndex, "interest" ,interest );
					$('#jqxDistributionGrid').jqxGrid('setcellvalue',rowBoundIndex, "priamount" ,priamount); 
      	                   
      	                   var summaryData1= $("#jqxDistributionGrid").jqxGrid('getcolumnaggregateddata', 'priamount', ['sum'],true);
      	                
      	                   document.getElementById("priamounts").value=summaryData1.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
      	                 document.getElementById("samp").value="";
				}
                      	
                      		});
          
              function valchange(rowBoundIndex)
              {
            	  var perint=document.getElementById("perinterest").value;
            	    var instnos=document.getElementById("instnos").value;
            	  
            	var priamount=$('#jqxDistributionGrid').jqxGrid('getcellvalue', rowBoundIndex, "priamount");
            	
             
		            var interest=parseFloat(priamount)*(parseFloat(perint)/100)*(parseFloat(instnos)/12); 

					
					 var amount=parseFloat(priamount)+parseFloat(interest);
              
					$('#jqxDistributionGrid').jqxGrid('setcellvalue',rowBoundIndex, "interest" ,interest );
					$('#jqxDistributionGrid').jqxGrid('setcellvalue',rowBoundIndex, "amount" ,amount); 
      	                   
      	                   var summaryData1= $("#jqxDistributionGrid").jqxGrid('getcolumnaggregateddata', 'priamount', ['sum'],true);
      	                
      	                   document.getElementById("priamounts").value=summaryData1.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
      	                  
      	                   
      	      
      		    
              }  
   
        });
    </script>
    <div id="jqxDistributionGrid"></div>
    <input type="hidden" id="samp">
 
    
 
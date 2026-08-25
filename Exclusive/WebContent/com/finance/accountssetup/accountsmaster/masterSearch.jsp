<%@page import="com.finance.accountssetup.accountsMaster.ClsAccMasterDAO" %>
<%ClsAccMasterDAO amd =new ClsAccMasterDAO(); %>

<%--  <jsp:include page="../../../includes.jsp"></jsp:include>  --%>
    <script type="text/javascript">
    var data= '<%=amd.searchDetails() %>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'docno' , type: 'number' },
     						{name : 'date', type: 'String'  },
     						{name : 'description', type: 'String'  },
     						{name : 'head' , type: 'String' },
     						{name : 'account', type: 'String'  },
     						{name : 'm_s', type: 'String'  },
     						{name : 'grpno', type: 'String'  },
     						{name : 'br1', type: 'String'  },
     						{name : 'br2', type: 'String'  },
     						{name : 'den', type: 'String'  },
     						{name : 'md', type: 'String'  },
     						{name : 'alevel', type: 'String'  },
     						
     						{name : 'curid', type: 'String'  },
     						{name : 'rate', type: 'number'  },
     						{name : 'curr', type: 'String'  },
     					 
     						
     						                	],
                 localdata: data,
                
                
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
            $("#jqxAccmasterSearch").jqxGrid(
            {
                width: '100%',
                height: 352,
                source: dataAdapter,
         
               altRows: true,
              
                selectionmode: 'singlerow',
                pagermode: 'default',
                showfilterrow: true,
                filterable: true,
              
	
                columns: [
					{ text: 'Doc No', datafield: 'docno', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '20%' ,hidden:true},
					{ text: 'Account', datafield: 'account', width: '15%' },
					{ text: 'M/D', datafield: 'md', width: '10%' },
					{ text: 'Description', datafield: 'description', width: '65%' },
					{ text: 'head', datafield: 'head',hidden:true },
					{ text: 'M_S', datafield: 'm_s',hidden:true },
					{ text: 'grpNo', datafield: 'grpno',hidden:true },
					{ text: 'br1', datafield: 'br1',width:"10%",hidden:true  },
					{ text: 'br2', datafield: 'br2',width:"10%",hidden:true  },
					{ text: 'DEN', datafield: 'den',width:"10%",hidden:true },
					{ text: 'Alevel', datafield: 'alevel',hidden:true },
					
					{ text: 'curid', datafield: 'curid',hidden:true },
					{ text: 'rate', datafield: 'rate',hidden:true },
					{ text: 'curr', datafield: 'curr',hidden:true },
					
					
					 
						]
            });
           
          
             $('#jqxAccmasterSearch').on('rowdoubleclick', function (event) 
            		{ 
            	 var rowindex1=event.args.rowindex;
            	
            	 $('#date_accountmaster').val($("#jqxAccmasterSearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
                document.getElementById("docno").value= $('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "docno");
              
                if($('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "m_s")==0)
             	   {
                	//alert("tran");
                 	//category1
                 	 document.getElementById('radiotick').value=3;        // for radio ckek update
                 	 document.getElementById("category3").checked = true;
                   
        
		            $('#tansaccgroup').val($('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "grpno"));
		         
                    document.getElementById("transcaccgpname").value=$('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "head");
                    document.getElementById("transacccode").value= $('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "account");
                  	document.getElementById("transaccname").value=$('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "description");
                  	
                  	
                    document.getElementById("currs").value=$('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "curr");
                    document.getElementById("currsid").value=$('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "curid");
                    var rates=$('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "rate");
                	funRoundRate(rates,"ratess");
                  	                  
                  	$('#branchone').val($('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "br1"));
                  		$('#branchtwo').val($('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1,"br2"));
                  	 	document.getElementById('mainaccgroup').value="";
                  		 document.getElementById('mainacccode').value="";
                		 document.getElementById('mainacconame').value="";
                		 
                		 document.getElementById('subaccgroup').value="";
                		 document.getElementById('subaccgpname').value="";
                		 document.getElementById('subacccode').value="";
                		 document.getElementById('subaccname').value="";
                		 
                		 
                		 document.getElementById('otherdis').value=3;
                  		
                		 document.getElementById('maindel').value=3;
                		 document.getElementById('tran_account').value="tranacc";
                		   document.getElementById('sub_account').value="";
                		   document.getElementById('main_account').value="";
                  		
                		 funSetlabel();
                  	$('#window').jqxWindow('close');
             	   } 
                 else if($('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "grpno")!=0)
                 {
                	//alert("submain");
                	document.getElementById("category2").checked = true;
                	 document.getElementById('radiotick').value=2; // for radio ckek update
                	
		           	$('#subaccgroup').val($('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "docno"));
                    document.getElementById("subaccgpname").value=$('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "head");
                    document.getElementById("subacccode").value= $('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "account");
                  	document.getElementById("subaccname").value=$('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "description");
                  	
                  	document.getElementById('mainaccgroup').value="";
               	    document.getElementById('mainacccode').value="";
        		    document.getElementById('mainacconame').value="";
        		    
        		    document.getElementById('tansaccgroup').value="";
        		    document.getElementById('transcaccgpname').value="";
        		    document.getElementById('transacccode').value="";
        		    document.getElementById('transaccname').value="";
        		    
        		    document.getElementById('otherdis').value=2;
        		    document.getElementById('maindel').value=2;
        		    document.getElementById('sub_account').value="subacc";
        		    document.getElementById('tran_account').value="";
         		   
         		   document.getElementById('main_account').value="";
        			 funSetlabel();
                  	$('#window').jqxWindow('close');
                  
                } 
                
                 else if($('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "grpno")==0){
                	//alert("main");
                	
                	document.getElementById("category1").checked = true;
                	
                	
                	 document.getElementById('radiotick').value=1;   // for radio ckek update
                	
           
               
             
                	$('#mainaccgroup').val($('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "den"));
                	
                    document.getElementById("mainacccode").value= $('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "account");
                  	document.getElementById("mainacconame").value=$('#jqxAccmasterSearch').jqxGrid('getcellvalue', rowindex1, "description");
                  	 document.getElementById('subaccgroup').value="";
                  	 document.getElementById('subaccgpname').value="";
            		 document.getElementById('subacccode').value="";
            		 document.getElementById('subaccname').value="";
            		 
            		 document.getElementById('tansaccgroup').value="";
            		 document.getElementById('transcaccgpname').value="";
            		 document.getElementById('transacccode').value="";
            		 document.getElementById('transaccname').value="";
            		 
            		 
            		 document.getElementById('otherdis').value=1; // other text box disable
            		 document.getElementById('maindel').value=1;
            		 document.getElementById('main_account').value="mainacc";
            		 document.getElementById('sub_account').value="";
         		    document.getElementById('tran_account').value="";
            		 funSetlabel();
         			//$('#mainaccgroup').attr('disabled', false);
                  	$('#window').jqxWindow('close');
                }
                	
           
                
                
            		 });   
      
        }); 
    </script>
    <div id="jqxAccmasterSearch"></div>

<%@page import="com.controlcentre.settings.costcentermaster.ClsCostCenterDAO" %>
<% ClsCostCenterDAO ccd=new ClsCostCenterDAO();%>

<%--  <jsp:include page="../../../includes.jsp"></jsp:include>  --%>
    <script type="text/javascript">
    var costdata= '<%=ccd.searchDetails() %>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {                                    
                datatype: "json",   
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'date', type: 'String'  },
     						{name : 'description', type: 'String'  },
     						{name : 'costgroup' , type: 'String' },
     						{name : 'costcode', type: 'String'  },
     						{name : 'm_s', type: 'String'  },
     						{name : 'md', type: 'String'  },
     						{name : 'grpno', type: 'String'  },
     						{name : 'costtype', type: 'String'  },
     						{name : 'alevel', type: 'String'  }
     				
     						
     						                	],
                 localdata: costdata,
                
                
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
            $("#costcenterSearch").jqxGrid(
            {
                width: '100%',
                height: 352,
                source: dataAdapter,
               // columnsresize: true,
                //pageable: true,
               altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                showfilterrow: true,
                filterable: true,
                //Add row method
	
                columns: [        
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '20%' ,hidden:true},
					{ text: 'costcode', datafield: 'costcode', width: '15%' },
					{ text: 'M/D', datafield: 'md', width: '10%' },
					{ text: 'Description', datafield: 'description', width: '65%' },
					{ text: 'costgroup', datafield: 'costgroup',hidden:true },
					{ text: 'M_S', datafield: 'm_s',hidden:true },
					{ text: 'grpNo', datafield: 'grpno',hidden:true },
					{ text: 'Costtype', datafield: 'costtype',width:"10%",hidden:true },
					{ text: 'Alevel', datafield: 'alevel',hidden:true }
						]
            });
           
          
             $('#costcenterSearch').on('rowdoubleclick', function (event) 
            		{ 
            	 var rowindex1=event.args.rowindex;
            	
            	 $('#date_accountmaster').val($("#costcenterSearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
                document.getElementById("docno").value= $('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              
                if($('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "m_s")==0)
             	   {
                
                 	//category1
                 	 document.getElementById('radiotick').value=3;        // for radio ckek update
                 	 document.getElementById("category3").checked = true;
            
             		
         		
                 	
 		            $('#tansaccgroup').val($('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "grpno"));
                    document.getElementById("transcaccgpname").value=$('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "costgroup");
                    document.getElementById("transacccode").value= $('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "costcode");
                  	document.getElementById("transaccname").value=$('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "description");
          
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
                
                else if($('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "grpno")!=0)
                {
                
                	document.getElementById("category2").checked = true;
                	 document.getElementById('radiotick').value=2; // for radio ckek update
		           	$('#subaccgroup').val($('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                    document.getElementById("subaccgpname").value=$('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "costgroup");
                    document.getElementById("subacccode").value= $('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "costcode");
                  	document.getElementById("subaccname").value=$('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "description");
                  	
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
                
                else if($('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "grpno")==0){
                	
                	
                	document.getElementById("category1").checked = true;
                	
                	
                	 document.getElementById('radiotick').value=1;   // for radio ckek update

          	
           
                	$('#mainaccgroup').val($('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "costtype"));
                	
                    document.getElementById("mainacccode").value= $('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "costcode");
                  	document.getElementById("mainacconame").value=$('#costcenterSearch').jqxGrid('getcellvalue', rowindex1, "description");
                  	 document.getElementById('subaccgroup').value="";
                  	 document.getElementById('subaccgpname').value="";
            		 document.getElementById('subacccode').value="";
            		 document.getElementById('subaccname').value="";
            		 
            		 document.getElementById('tansaccgroup').value="";
            		 document.getElementById('transcaccgpname').value="";
            		 document.getElementById('transacccode').value="";
            		 document.getElementById('transaccname').value="";
            		 
            		 document.getElementById('maindel').value=1;
            		 document.getElementById('otherdis').value=1; // other text box disable
            		 
            		 document.getElementById('main_account').value="mainacc";
            		 document.getElementById('sub_account').value="";
         		    document.getElementById('tran_account').value="";
            		 
            		 
            		 funSetlabel();
            		
                  	$('#window').jqxWindow('close');
                }
                	
           
                
                
            		 });   
      
        }); 
    </script>
    <div id="costcenterSearch"></div>

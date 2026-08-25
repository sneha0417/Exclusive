<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>
 
<%

ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();

%>     <% 
	String niorder = request.getParameter("niorder")==null?"NA":request.getParameter("niorder").trim().toString();
           System.out.println("------niorder----"+niorder);
           	  %>  
 
<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
 <script type="text/javascript">
 
 


	 var descdata1='<%=viewDAO.slnosearch(niorder)%>'; 
	
        $(document).ready(function () { 	
       
            
       
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'rowno', type: 'string'  },
							    {name : 'type', type: 'string'  },
								{name : 'acno', type: 'number'    },
								{name : 'account', type: 'string'    },
								{name : 'description', type: 'string'    },
								{name : 'qty', type: 'int'    },
								{name : 'unitprice', type: 'number'    },	
								{name : 'discount', type: 'number'    },
								
								{name : 'total', type: 'number'    },
								{name : 'desc1', type: 'number'    },
								{name : 'srno', type: 'number'    },
								
								 {name : 'taxper', type: 'number'  },  
	        					 {name : 'taxamount', type: 'number'  },
	        					{name : 'taxperamt', type: 'number'  },
     						
     						
                 ],
              
                 localdata: descdata1,
                
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

            
            
            $("#slnosearch").jqxGrid(
            {
            	 width: '100%',
                 height: 355,
                 source: dataAdapter,
             
                 editable: false,
                 showfilterrow: true, 
                 filterable: true, 
                 selectionmode: 'singlerow',
                 pagermode: 'default',
                
                         
                
                columns: [
                

                            { text: 'SR NO', datafield: 'srno', width: '10%' },
                      	    { text: 'Type', datafield: 'type', width: '10%' ,hidden:true},
                      	    { text: 'rowno', datafield: 'rowno', width: '10%' ,hidden:true},   
							{ text: 'Account', datafield: 'account', width: '10%' },
							{ text: 'Account Name', datafield: 'description', width: '25%' },
							{ text: 'Qty', datafield: 'qty', width: '10%'},
							{ text: 'Discount', datafield: 'discount', width: '15%',hidden:true},
							{ text: 'Unitprice', datafield: 'unitprice', width: '20%',cellsalign: 'right', align:'right',cellsformat:'d2' ,hidden:true },
							{ text: 'Total', datafield: 'total', width: '20%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,editable:true,hidden:true},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right' ,hidden:true  },
							{ text: 'Net Total', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right'   ,editable:false,hidden:true },
						 
							
							{ text: 'headdoc', datafield: 'acno', width: '20%',hidden:true },
							{ text: 'Description', datafield: 'desc1', width: '25%' },
							
						
	              ]
            });
           
  
            
 			
            
            $('#slnosearch').on('rowdoubleclick', function (event) {
                
           	 var  rowindex2=event.args.rowindex;
           //	account,accname,qty,unitprice,total,nettotal
           	
            /*  $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowval').val(), "type",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "type"));
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowval').val(), "account",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "account"));
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowval').val(), "accname",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "description")); */
            /*  var rowvals=$('#rowindex1').val();
             if(parseInt(rowvals)>0)
            	 {
            	 var aa=parseInt(rowvals)-1;
            	 alert("--------"+aa);
              var qtys=$('#nidescdetailsGrid').jqxGrid('getcellvalue', aa, "qty");
              var qtys1=$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "qty");
            	 alert(qtys);
            	 var actqty=parseFloat(qtys1)-parseFloat(qtys);
            	 alert(actqty);
                 $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "qty",actqty);
                 $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "qutval",actqty);
                 
            	 }
             else
            	 {
                 $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "qty",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
                 $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "qutval",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "qty")); 
            	 }
   */
       $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "qty",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
         $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "qutval",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
              $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "unitprice",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "total",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "total"));
            
             
    /*          $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowval').val(), "headdoc",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "acno")); */
             
      $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "discount",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "discount"));
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "description",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "desc1"));
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "rowno",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "rowno"));
                  
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "taxper",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "taxper"));
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "taxperamt",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "taxperamt"));
             $('#nidescdetailsGrid').jqxGrid('setcellvalue',$('#rowindex1').val(), "taxamount",$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "taxamount"));
             
          
            
             
             //document.getElementById("refslno").value=$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "srno");
             
          /*  var temp=document.getElementById("rowval").value;
           temp2=parseInt(temp)+1;
           document.getElementById("rowval").value="";
            document.getElementById("rowval").value=temp2; 
           $("#nidescdetailsGrid").jqxGrid('addrow', null, {});  */
             $('#nipurchslnosearch').jqxWindow('close');
           }); 
           

 
        });
    </script>
    <div id="slnosearch"></div>
   <input type="hidden" id="rowindex"/> 
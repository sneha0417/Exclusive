   

  <%@page import="com.dashboard.realestate.tenancycontractlist.ClstenancyContractListDAO" %>
<%ClstenancyContractListDAO DAO=new ClstenancyContractListDAO();
 

 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

	String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
	
	
	String prdocno = request.getParameter("prdocno")==null?"0":request.getParameter("prdocno").trim();
	String searchby = request.getParameter("searchby")==null?"0":request.getParameter("searchby").trim();
 
 
%>
<script type="text/javascript">


var datamain11='<%=DAO.listsearch(barchval,fromdate,todate,aa,cldocno,prdocno,searchby) %>'; 
var datamain1='<%=DAO.listsearchexcel(barchval,fromdate,todate,aa,cldocno,prdocno,searchby) %>'; 


 
        $(document).ready(function () {  
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'number'   },
                            {name : 'voc_no', type: 'number'   },
                            {name : 'date', type: 'date'   },
                            {name : 'amount', type: 'number'   },
                            {name : 'pamount', type: 'number'   },
                            {name : 'period_from', type: 'date'   },
                            {name : 'period_to', type: 'date'   },
     						{name : 'refname', type: 'string'   },
     						{name : 'protype', type: 'string'   },
     						{name : 'period', type: 'string'   },
     						{name : 'period_no', type: 'number'   },
     						{name : 'pname', type: 'string'   },
     						{name : 'not_period', type: 'number'   },
     				 
     					     						  
                        ],
                		localdata: datamain11, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            var cellclassname = function (row, column, value, data) {
            	
//       		 if (data.isqty !=0) {
//                   return "yellowClass";
//               }else{
//               	return "orangeClass";
//               };
          };
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#searshgrid1").jqxGrid(
            {
                width: '100%',
                height: 550,
                source: dataAdapter,
                columnsresize:true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                sortable:true,
                columns: [
                
   						
						{ text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true },
                         
                            { text: 'Doc No', datafield: 'voc_no', width: '6%' },
							{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Amount ', datafield: 'amount' , width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname  },
							{ text: 'Payamount ', datafield: 'pamount' , width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname  },
							{ text: 'Tenant ', datafield: 'refname' , width: '19%'  },
							{ text: 'Type', datafield: 'protype', width: '7%' },
							{ text: 'Property', datafield: 'pname', width: '8%' },
							{ text: 'Period', datafield: 'period', width: '8%' },
							{ text: 'Period No', datafield: 'period_no', width: '6%'  },
							{ text: 'From', datafield: 'period_from', width: '7%' ,cellsformat:'dd.MM.yyyy' },
							{ text: 'To', datafield: 'period_to', width: '7%',cellsformat:'dd.MM.yyyy'  },
							{ text: 'Not_Period ', datafield: 'not_period', width: '7%' },
							
							
						]
            });
            
             $('#searshgrid1').on('rowdoubleclick', function (event) {    
                var rowindex1 = event.args.rowindex;
                
           	    $("#Update").attr('disabled', false );
            	var docno=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	
            	
            	document.getElementById("brhid").value=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "brhid");;
            	
        	    document.getElementById("masterdocno").value=docno;
        	    
 
       
         	    
         	   
         	   
         	   
          
             
            }); 
             $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="searshgrid1"></div>
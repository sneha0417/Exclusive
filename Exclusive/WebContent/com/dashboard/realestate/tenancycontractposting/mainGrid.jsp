<%@page import=" com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO" %>
  
<%	
	ClsTenancyContractPostingDAO DAO=new ClsTenancyContractPostingDAO(); 
 	String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa");
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim(); 
%>
<style>
.greenClass
{
	background-color: #ACF6CB;
}
</style>
<script type="text/javascript">
 
var datamain11= '<%=DAO.listsearch(barchval,fromdate,todate,aa) %>'; 
 
        $(document).ready(function () {  
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },                            
                            {name : 'voc_no', type: 'int'   },                         
                            {name : 'date', type: 'date'   },                            
                            {name : 'period_from', type: 'date'   },
                            {name : 'period_to', type: 'date'   },     					 
     						{name : 'refname', type: 'string'   },   
     						{name : 'protype', type: 'string'   },
     						{name : 'period', type: 'string'   },
     						{name : 'period_no', type: 'string'   },
     						{name : 'pname', type: 'string'   },
     						{name : 'not_period', type: 'string'   },
     						{name : 'totalamount', type: 'string'   },
     						{name : 'recieptstatus',type:'string'},
     						{name : 'unitno',type:'string'}
     					  
                        ],
                		localdata: datamain11, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            var cellclassname = function (row, column, value, data) {
        		if(data.recieptstatus=="1"){
            		return "greenClass";
            	}
        	};
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#searshgrid1").jqxGrid(
            {
                width: '100%',
                height: 190,
                source: dataAdapter,
                columnsresize:true,
                //filtermode:'excel',
                filterable: true,
                sortable: true,
                showfilterrow:true,
                selectionmode: 'singlerow',
                
                columns: [ 
                          
						{ text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true ,cellclassname: cellclassname},
                        { text: 'Doc No', datafield: 'voc_no', width: '6%',cellclassname: cellclassname },
						{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname },							 
						{ text: 'Tenant ', datafield: 'refname'  ,cellclassname: cellclassname },
						{ text: 'Type', datafield: 'protype', width: '7%',cellclassname: cellclassname },
						{ text: 'Property', datafield: 'pname', width: '20%',cellclassname: cellclassname },
						{ text: 'Unit No', datafield: 'unitno', width: '8%',cellclassname: cellclassname },
						{ text: 'Period', datafield: 'period', width: '8%',cellclassname: cellclassname },
						{ text: 'Period No', datafield: 'period_no', width: '6%',cellclassname: cellclassname  },
						{ text: 'From', datafield: 'period_from', width: '7%' ,cellsformat:'dd.MM.yyyy',cellclassname: cellclassname },
						{ text: 'To', datafield: 'period_to', width: '7%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname  },
						{ text: 'Not_Period ', datafield: 'not_period', width: '7%',cellclassname: cellclassname },						
						{ text: 'total', datafield: 'totalamount', width: '6%',hidden:true ,cellclassname: cellclassname},
						{ text: 'Reciept Status', datafield: 'recieptstatus', width: '6%',hidden:true ,cellclassname: cellclassname},
						 
						]
            });
            
             $('#searshgrid1').on('rowdoubleclick', function (event) {    
                var rowindex1 = event.args.rowindex;
                $('#maingridrowindex').val(rowindex1);
           	    $("#Update").attr('disabled', false );
            	var nettotal=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "totalamount");
            	$('#txtmainnettotal').val(nettotal);
            	
            	var docno=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	
            	document.getElementById("brhid").value=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "brhid");;
            	
        	    document.getElementById("masterdocno").value=docno;
        	     
         	    $("#listdiv1").load("termsOfContractGrid.jsp?docno="+docno+"&id=1");
         		$("#listdiv2").load("paymentDistributionGrid.jsp?docno="+docno+"&id=1");
         		$("#agentdiv").load("agentGrid.jsp?docno="+docno+"&id=1");
         		var recieptstatus=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "recieptstatus");
         		if(recieptstatus=="1"){
         			$('#btnreciept').attr('disabled',true);
         			$('#paymentDistributionGridId').jqxGrid({disabled:true});
         		}
         		else{
         			$('#btnreciept').attr('disabled',false);
         			$('#paymentDistributionGridId').jqxGrid({disabled:false});
         		}
         		  $('#prdocno').val(docno);
                 
            }); 
             $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="searshgrid1"></div>
    <input type="hidden" name="maingridrowindex" id="maingridrowindex">
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<% String contextPath=request.getContextPath();%>
<%ClsProductDAO DAO= new ClsProductDAO(); 
String psrno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
%>
<script type="text/javascript">
var pmdata;
 
  var psrno='<%=psrno%>';
if(psrno>0){
	 pmdata='<%=DAO.pmLoad(session,psrno)%>'; 
	 pm=1;
}
else{  
	pmdata='<%=DAO.pmLoad()%>'; 
	  pm=1;
  }   

        $(document).ready(function () { 
        	
     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						 {name : 'slno', type: 'number' }, 
     						 
     						{name : 'catid', type: 'number'  },        
     						{name : 'cat_name', type: 'string'   },
     						{name : 'price1', type: 'number'   },
     						{name : 'price2', type: 'number' },
     						{name : 'price3', type: 'number'  },
							{name : 'discount1', type: 'number' },
							{name : 'discount2', type: 'number' },
							{name : 'discount3', type: 'number' },
							{name : 'qty1', type: 'number' },
							{name : 'qty2', type: 'number' },
							{name : 'qty3', type: 'number' },
							
							{name : 'foc1', type: 'number' },
							{name : 'foc2', type: 'number' },
							{name : 'foc3', type: 'number' }
							
                        ],
                         localdata: pmdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
           
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxpmgt").jqxGrid(
            {
                width: '100%',
                height: 152,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                 handlekeyboardnavigation: function (event) {
              
   },
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                            }   },
						 	{ text: 'doc_no', datafield: 'catid', editable: false,  width: '18%',hidden:true},
							{ text: 'Category', datafield: 'cat_name', editable: false  },
							  
							{ text: 'Max Rate1', datafield: 'price1', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',columngroup:'rate' },
							{ text: 'Mid Rate2', datafield: 'price2', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' ,columngroup:'rate'},
							{ text: 'Min Rate3', datafield: 'price3', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',columngroup:'rate' },
							
							{ text: 'Discount 1', datafield: 'discount1', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',columngroup:'discount' },
							{ text: 'Discount 2', datafield: 'discount2', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',columngroup:'discount' },
							{ text: 'Discount 3', datafield: 'discount3', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' ,columngroup:'discount'},
							{ text: 'QTY 1', datafield: 'qty1', cellsformat: 'd2', width: '8%',  columngroup:'foc' },
							{ text: 'FOC 1', datafield: 'foc1', cellsformat: 'd2', width: '6%', cellsalign: 'right', align: 'right' ,columngroup:'foc'},
							{ text: 'QTY 2', datafield: 'qty2', cellsformat: 'd2', width: '8%', columngroup:'foc'},
							{ text: 'FOC 2', datafield: 'foc2', cellsformat: 'd2', width: '6%', cellsalign: 'right', align: 'right',columngroup:'foc' },
							{ text: 'QTY 3', datafield: 'qty3', cellsformat: 'd2', width: '8%', columngroup:'foc'},
							{ text: 'FOC 3', datafield: 'foc3', cellsformat: 'd2', width: '6%', cellsalign: 'right', align: 'right' ,columngroup:'foc'},

						], columngroups: 
	             			[
	               				{ text: 'Rate', align: 'center', name: 'rate',width: '20%' },
	               				{ text: 'Discount', align: 'center', name: 'discount',width: '10%' },
	               				{ text: 'FOC', align: 'center', name: 'foc',width: '10%' }
	             			]
            });
         
     

            
            if($('#mode').val()=='view')
	         {
            	 
           	$("#jqxpmgt").jqxGrid({
    			disabled : true
    		});
	           }
            
            
        });
</script>
<div id="jqxpmgt"></div>

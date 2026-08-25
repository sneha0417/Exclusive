<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<% String contextPath=request.getContextPath();%>
<%ClsProductDAO DAO= new ClsProductDAO(); 
String psrno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();


String chktype=request.getParameter("chktype")==null?"0":request.getParameter("chktype").toString();
String chktypes="0";

/* System.out.println("==psrno===="+psrno); */

%>
<script type="text/javascript">  
		var prddata;
		
		var pm;
		var psrno='<%=psrno%>';
		if(psrno=='0'){
			 prddata='<%=DAO.prdbranchLoad(session,chktype)%>'; 
			 
		}
		else{
			 prddata='<%=DAO.prdbranchLoad(session,psrno,chktype)%>'; 
			 
		}
		
        $(document).ready(function () { 
        	chkpms();                       
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'bdocno', type: 'int'  },
     						{name : 'selects', type: 'bool' }, 
     						{name : 'discontinued', type: 'bool'   },
     						{name : 'branch', type: 'string'  },
     						{name : 'bin', type: 'string'   },
     						{name : 'minstock', type: 'number'   },
     						{name : 'maxstock', type: 'number' },
     						{name : 'retailprice', type: 'number'  },
							{name : 'wholesale', type: 'number' },
							{name : 'normal', type: 'number'  },
							
							{name : 'reorderlevel', type: 'number'  },
							{name : 'reorderqty', type: 'number'  }
							 
							
                        ],
                         localdata: prddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
           
            $('#jqxProductGrid').on('bindingcomplete', function (event) {
                 
        	});
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxProductGrid").jqxGrid(
            {
                width: '100%',
                height: 120,
                source: dataAdapter,
                editable: true,
                altRows:true,
                showaggregates: true,
                selectionmode: 'singlecell', 
                       
                columns: [
							{ text: 'Branch id', datafield: 'bdocno', width: '10%',hidden:true },
							{ text: 'Select', datafield: 'selects', columntype: 'checkbox',checked:false,  width: '10%',cellsalign: 'center', align: 'center' },
							{ text: 'Discontinued', datafield: 'discontinued', columntype: 'checkbox', checked:false,  width: '10%',cellsalign: 'center', align: 'center' },
							{ text: 'Company/Branch Name', datafield: 'branch', editable: false },	
							{ text: 'Bin', datafield: 'bin', width: '10%' },	
							{ text: 'Min. Stock', datafield: 'minstock', width: '15%' },
							{ text: 'Max. Stock', datafield: 'maxstock', width: '15%' },
							
							{ text: 'Reorder Level', datafield: 'reorderlevel', width: '15%', cellsformat: 'd2' }, 
							{ text: 'Reorder Qty', datafield: 'reorderqty', width: '15%' , cellsformat: 'd2'},
							
							{ text: 'Retail Price', datafield: 'retailprice', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' },
							{ text: 'Whole Sale', datafield: 'wholesale', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' },
							{ text: 'Normal', datafield: 'normal', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' },
						]
            });
        
        	
        	
            function chkpms()
            {
         	   
         	   
            	var x = new XMLHttpRequest();
          		x.onreadystatechange = function() {
          			if (x.readyState == 4 && x.status == 200) {
          			var	items = x.responseText.trim();
          			 
          		 
          			if(parseInt(items)==1)
          				{
          			 
          				   $('#jqxProductGrid').jqxGrid('hidecolumn', 'retailprice');
          	        	   $('#jqxProductGrid').jqxGrid('hidecolumn', 'wholesale');
          	        	   $('#jqxProductGrid').jqxGrid('hidecolumn', 'normal');
          				
          				}
          			else
          				{
          				   $('#jqxProductGrid').jqxGrid('showcolumn', 'retailprice');
          	        	   $('#jqxProductGrid').jqxGrid('showcolumn', 'wholesale');
          	        	   $('#jqxProductGrid').jqxGrid('showcolumn', 'normal');
          				}
          			
          	 
          			} else {
          			}
          		}
          		x.open("GET", "checkpricemgt.jsp", true);
          		x.send();
               
         	   
            }	
            if($('#mode').val()!='view' && psrno=='0')
	         {
             
            $("#jqxProductGrid").jqxGrid({
    			disabled : false
    		});
	         }
            
            if($('#mode').val()=='view')
	         {
         $('#jqxProductGrid').jqxGrid('setcolumnproperty','selects','hidden',true);
           $('#jqxProductGrid').jqxGrid('setcolumnproperty','discontinued','hidden',true);
           	$("#jqxProductGrid").jqxGrid({
    			disabled : true
    		});
	           }
          
        });
</script>
<div id="jqxProductGrid"></div>

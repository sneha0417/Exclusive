<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<% String contextPath=request.getContextPath();%>
<%ClsProductDAO DAO= new ClsProductDAO(); 
String psrno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();

 

 

%>
<script type="text/javascript">  
		var prddata1;
		
 		var pm;
		var psrno='<%=psrno%>';
		if(psrno>0){
			 prddata1='<%=DAO.ssedingLoad(session,psrno)%>'; 
			 
		}
		else{
			prddata1;
			 
		}  
		
        $(document).ready(function () { 
            
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							 
     					 
     						{name : 'discontinued', type: 'bool'   },
     						{name : 'part_no', type: 'string'  },
     						 
							{name : 'priority', type: 'number'}
							
						 
							   
							
							
                        ],
                         localdata: prddata1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
           
       
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxseding").jqxGrid( 
            {
                width: '100%',
                height: 140,
                source: dataAdapter,
                editable: true,
                altRows:true,
             
                selectionmode: 'singlecell', 
                       
                columns: [
                          
                      	{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
                    	    return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                    	}   },
                          
                      		{ text: 'Part_No', datafield: 'part_no', width: '25%',		cellbeginedit: function (row) {
					               if (row==0)
					                {
					                     return false;
					                }} },  	
							{ text: 'Priority', datafield: 'priority' , width: '20%'  } , 
							{ text: 'Discontinued', datafield: 'discontinued', columntype: 'checkbox', checked:false ,cellsalign: 'center', align: 'center' },
							 
							]
            });
            
            $("#jqxseding").on('cellvaluechanged', function (event) 
                    {
                    
            		     var rowindex1=event.args.rowindex;
           			     var rows = $('#jqxseding').jqxGrid('getrows');
           	               var rowlength= rows.length;
           	               if(rowindex1 == rowlength - 1)
           	               	{  
           	            	  
           	               $("#jqxseding").jqxGrid('addrow', null, {});
           	               
           	            
           	         
           	               	} 
                   	 
                    });
            
            if($('#mode').val()=='view')
	         {
         	$("#jqxseding").jqxGrid({
  			disabled : true
  		});
	           }
         
        });
</script>
<div id="jqxseding"></div>

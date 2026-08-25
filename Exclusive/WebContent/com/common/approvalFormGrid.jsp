<%-- <jsp:include page="../../includes.jsp"></jsp:include> --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<style type="text/css">
        .headClass
        {
            background-color: #FFEBC2;
        }
        .redClass
        {
            background-color: #FFEBEB;
        }
        .violetClass
        {
            background-color: #EBD6FF;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        .greenClass
        {
           background-color: #CEFFCE;
        }
        
</style>


<script type="text/javascript">
        var jdata;
        $(document).ready(function () { 	
        	
			  jdata='';
        	  
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'flag', type: 'int'   },
							{name : 'status', type: 'string'  }, 
      						{name : 'approval', type: 'string'   },
      						{name : 'general', type: 'string'   }
                        ],
                		    localdata: jdata, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
                if (data.flag == '1') {
                    return "violetClass";
                }
                else{
                	return "redClass";
                };
            }; 
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxApprovalGrid").jqxGrid(
            {
                width: '100%',
                height: 480,
                source: dataAdapter,
                selectionmode: 'singlerow',
                       
                columns: [
{ text: 'Flag', datafield: 'flag', cellclassname: cellclassname , width: '5%' },
{ text: ' ', datafield: 'status', cellclassname: cellclassname , width: '45%' },
{ text: 'Approval', datafield: 'approval', cellclassname: cellclassname , width: '25%' },	
{ text: 'General', datafield: 'general', cellclassname: cellclassname , width: '30%' },
							
						]
            });
            
            $('#jqxApprovalGrid').on('celldoubleclick', function (event) {
            
        		var rowindextemp = event.args.rowindex;
                var flag=$("#jqxApprovalGrid").jqxGrid('getcellvalue', rowindextemp, "flag");
               
                //var date=document.getElementById("jqxFilterUptoDate").value;
              
                $('#approvalDataGrid').load("approvalDataGrid.jsp?flag="+flag);
         		
          
                });
         
        });
    </script>
    <div id="jqxApprovalGrid"></div>
    <input type="hidden" id="rowindex"/>
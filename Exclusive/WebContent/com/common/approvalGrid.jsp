<%@page import="com.common.ClsExeFolio" %>
<%ClsExeFolio cef=new ClsExeFolio(); %>

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
        .violetsClass
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
        	
			  jdata='<%=cef.exefolioGridload(session)%>';
        	  
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
            
            
            var cellsrenderer = function (row, column, value, defaultHtml) {
                var rows11 = $("#jqxApprovalGrid").jqxGrid('getrows');
                
                
                   if ( row == 0 ) {
                    //alert("row3"+row3);
                       var element = $(defaultHtml);
                       element.css({ 'background-color': '#e6e6fa', 'width': '100%', 'height': '100%', 'margin': '0px' });
                       return element[0].outerHTML;
                   }
                 if ( row == 1 ) {
                     //alert("row3"+row3);
                        var element = $(defaultHtml);
                        element.css({ 'background-color': '#ffffe0', 'width': '100%', 'height': '100%', 'margin': '0px' });
                        return element[0].outerHTML;
                    }
                  
                   if (row == 2) {
                    //alert(row3);
                       var element = $(defaultHtml);
                       element.css({ 'background-color': '#ffe4e1', 'width': '100%', 'height': '100%', 'margin': '0px' });
                       return element[0].outerHTML;
                   }
                   
                   if (row == 3) {
                       //alert(row3);
                          var element = $(defaultHtml);
                          element.css({ 'background-color': '#CEFFCE', 'width': '100%', 'height': '100%', 'margin': '0px' });
                          return element[0].outerHTML;
                      }
                   
                   
                   
                   
                   return defaultHtml;
               }
            
            var cellclassname = function (row, column, value, data) {
                if (data.flag == '1') {
                	
                    return "violetsClass";
                }
                else{
                	return "redClass";
                };
            }; 
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxApprovalGrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                selectionmode: 'singlerow',
                       
                columns: [
{ text: 'Flag', datafield: 'flag' , width: '5%',cellsrenderer: cellsrenderer },
{ text: ' ', datafield: 'status', width: '45%',cellsrenderer: cellsrenderer },
{ text: 'Approval', datafield: 'approval' , width: '25%',cellsrenderer: cellsrenderer },	
{ text: 'General', datafield: 'general' , width: '25%',cellsrenderer: cellsrenderer },
							
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
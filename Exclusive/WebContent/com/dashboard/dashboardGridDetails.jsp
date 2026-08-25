<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String docNo = request.getParameter("txtdetail1")==null?"0":request.getParameter("txtdetail1"); 
	String desc = request.getParameter("indexDesc")==null?"0":request.getParameter("indexDesc"); 
%>

<script type="text/javascript">
        var data1;
        $(document).ready(function () { 	
        	 var temp='<%=docNo%>'; 
			 var desc='<%=desc%>'; 
        	
        	 if(temp>0)
           	 {     
            	  data1='<%=DAO.detailSearch(docNo,session)%>';   
           	 }
             else 
           	 {
            	 data1='<%=DAO.detail(session)%>';
           	 }    
        	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'description', type: 'string'   },
                    
                            {name : 'doc_no', type: 'int'  },
                            {name : 'flag', type: 'int'  },
                            {name : 'path', type: 'string'   },
                            {name : 'dtype', type: 'string'   }
                        ],
                		    localdata: data1, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
                if (data.flag == 1) {
                    return "redClass";
                };
            }; 
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxDashBoardDetail").jqxGrid(
            {
                width: '95%',
                height: 489,
                source: dataAdapter,
                selectionmode: 'singlerow',
                       
                columns: [
							{ text: 'Description', datafield: 'description', cellclassname: cellclassname, width: '100%' },
						
							{ text: 'Doc No', hidden: true, datafield: 'doc_no', cellclassname: cellclassname, width: '5%' },
							{ text: 'Flag', datafield: 'flag', hidden: true, cellclassname: cellclassname , width: '10%' },
							{ text: 'Path', datafield: 'path', hidden: true, cellclassname: cellclassname , width: '10%' },
							{ text: 'dtype', datafield: 'dtype', hidden: true, cellclassname: cellclassname , width: '10%' }
							
						]
            });
            
            $('#jqxDashBoardDetail').on('celldoubleclick', function (event) {
            	  if(event.args.columnindex == 0)
            	  {
            		//var value = event.args.value;   
					var rowindextemp = event.args.rowindex;
            	   <%-- <%String detail="";%>
            		"value",'<%=detail%>'
            		<%
            		session.setAttribute("DETAILNAME",detail );
            		%>
					
            	    
            	    document.getElementById("rowindex").value = rowindextemp; --%>
					
            	    var url=document.URL;
					 var reurl=url.split("com/");
					
					var detName=$("#jqxDashBoardDetail").jqxGrid('getcellvalue', rowindextemp, "description");
					var path=$("#jqxDashBoardDetail").jqxGrid('getcellvalue', rowindextemp, "path");
					var docno=$("#jqxDashBoardDetail").jqxGrid('getcellvalue', rowindextemp, "doc_no");
					//alert(reurl[0]+""+path);
					top.addTab( detName,reurl[0]+""+path+"?name="+detName+"&main="+desc+"&docno="+docno);
            		}
            	  
                });
         
        });
    </script>
    <div id="jqxDashBoardDetail"></div>
    <input type="hidden" id="rowindex"/>
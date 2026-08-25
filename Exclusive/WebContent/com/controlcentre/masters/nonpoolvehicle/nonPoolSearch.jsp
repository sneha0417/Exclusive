<%@page import="com.controlcentre.masters.nonpoolvehicle.ClsNonPoolVehDAO" %>
<%ClsNonPoolVehDAO cnp=new ClsNonPoolVehDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String searchdate = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String regno=request.getParameter("regno")==null?"0":request.getParameter("regno");
String color=request.getParameter("color")==null?"0":request.getParameter("color");
String group=request.getParameter("group")==null?"0":request.getParameter("group");
%> 
<script type="text/javascript">
     var data= '<%=cnp.mainSearch(session,searchdate,fleetno,docno,regno,color,group)%>'; 
     
        $(document).ready(function () { 	
            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'fleet_no' , type: 'String' },
     						{name : 'flname', type: 'String'  },
     						{name : 'reg_no', type: 'String'  },
     						{name : 'color',type:'String'},
     						{name : 'gid',type:'string'},
     						{name:'doc_no',type:'String'},
     						{name :'date',type:'date'}
                 ],
                localdata: data,
                //url: url,
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
            $("#nonPoolSearch").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Fleet', datafield: 'fleet_no', width: '16.66%' },
							{ text: 'Fleet Name', datafield: 'flname', width: '60%',hidden:true },
							{ text: 'Reg No', datafield: 'reg_no', width: '16.66%' },
							{ text: 'Date', datafield: 'date', width: '16.66%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Doc No', datafield: 'doc_no', width: '16.66%' },
							{ text:'Color',datafield:'color',width:'16.66%'},
							{text:'Group',datafield:'gid',width:'16.66%'}
	              ]
            });
           
            $('#nonPoolSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
                document.getElementById("fleetno").value= $('#nonPoolSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no"); 
                document.getElementById("fleetname").value = $("#nonPoolSearch").jqxGrid('getcellvalue', rowindex1, "flname");
                document.getElementById("regno").value = $("#nonPoolSearch").jqxGrid('getcellvalue', rowindex1, "reg_no");
                $('#window').jqxWindow('close');
              
                $("#frmNonpoolvehicle").submit();
                //getGridDetails();
                
            });  
        });
    </script>
    <div id="nonPoolSearch"></div>

<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
<jsp:include page="../../includes.jsp"></jsp:include>
<style>
.redClass{
color: red;
}
.blueClass{
color: blue;
}
</style>
<script type="text/javascript">
   
        var data5 = '<%=DAO.toAddedList(session)%>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int' },
							{name : 'date', type: 'date' },
							{name : 'title', type: 'string'  },
     						{name : 'description', type: 'string' },
     						{name : 'priority', type: 'string'   }
                        ],
                		  localdata: data5, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
                if (data.priority == 'HIGH') {
                    return "redClass";
                }else if (data.priority == 'LOW') {
                    return "blueClass";
                };
            }; 
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAddedList").jqxGrid(
            {
                width: '100%',
                height: 190,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                       
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', hidden: true , width: '10%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , cellclassname: cellclassname, width: '20%' },
							{ text: 'Title', datafield: 'title',  cellclassname: cellclassname , width: '30%' },
                            { text: 'Description', datafield: 'description',  cellclassname: cellclassname , width: '50%' },
							{ text: 'Priority', datafield: 'priority', hidden:true, cellclassname: cellclassname , width: '10%' },
						]
            });
            
            
            $('#jqxAddedList').on('rowdoubleclick', function (event) {
      			var rowindex1 = event.args.rowindex;
      			
      			document.getElementById("txttitle").value= $('#jqxAddedList').jqxGrid('getcellvalue', rowindex1, "title");
      			$("#jqxDate").jqxDateTimeInput('val', $("#jqxAddedList").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("cmbpriority").value= $('#jqxAddedList').jqxGrid('getcellvalue', rowindex1, "priority");
                document.getElementById("txtdescription").value= $('#jqxAddedList').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("docno").value= $('#jqxAddedList').jqxGrid('getcellvalue', rowindex1, "doc_no");
      			
		});
            
            
        });
    </script>
    <div id="jqxAddedList"></div>
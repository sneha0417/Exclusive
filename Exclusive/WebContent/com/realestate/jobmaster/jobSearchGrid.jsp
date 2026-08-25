<%@page import="com.realestate.jobmaster.ClsJobMasterDAO" %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>    
<%@page import="javax.servlet.http.HttpSession" %>        
<%
     ClsJobMasterDAO cud=new ClsJobMasterDAO();   
	 String job = request.getParameter("job")==null ?"":request.getParameter("job");
	 String docno = request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
	 String date = request.getParameter("date")==null || request.getParameter("date")==""?"0":request.getParameter("date");
	 String id = request.getParameter("id")==null ?"":request.getParameter("id");     
 %>      
<script type="text/javascript">
  
	var  data1= '<%= cud.jobMainSearch(session,job,docno,date,id) %>';    
        
  		$(document).ready(function (){ 	
            var source =  
            {
                datatype: "json",
                datafields: [
                          	{name : 'name' , type: 'String' },
     						{name : 'doc_no', type: 'int'  },
     						{name : 'date', type: 'date'  }
                 ],
               localdata: data1,
               
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
            $("#jqxrequestSearch").jqxGrid(
            {
            	width: '100%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                
                columns: [
					{ text: 'Doc No',  datafield: 'doc_no', width: '10%' },
					{ text: 'Date',  datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Description', datafield: 'name' },
	              ]
            });
            
            $('#jqxrequestSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				
				$('#frmJobmaster select').attr('disabled', false);
			    $('#jqxDate').val($('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "date"));
			    document.getElementById("txtjobdesc").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("docno").value= $('#jqxrequestSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				setValues();
                $('#window').jqxWindow('close');
            });    
        });
  		
</script>

<div id="jqxrequestSearch"></div>

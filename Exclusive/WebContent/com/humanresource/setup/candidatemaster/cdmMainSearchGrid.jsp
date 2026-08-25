<%@page import="com.humanresource.setup.candidatemaster.ClsCandidateMasterDAO" %>
<%ClsCandidateMasterDAO DAO=new ClsCandidateMasterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String cdmname = request.getParameter("cdmname")==null?"0":request.getParameter("cdmname");
 String cdmdocno = request.getParameter("cdmdocno")==null?"0":request.getParameter("cdmdocno");
 String cdmrefno = request.getParameter("cdmrefno")==null?"0":request.getParameter("cdmrefno");
 String cdmdob = request.getParameter("cdmdob")==null?"0":request.getParameter("cdmdob");
%> 

 <script type="text/javascript">
 
 		var data3='<%=DAO.candidateMainSearch(session,cdmname,cdmdocno,cdmrefno,cdmdob)%>';
        $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'name', type: 'String' },
     						{name : 'dob', type: 'date' },
     						{name : 'doc_no', type: 'int'  },
     						{name : 'refno', type: 'String' },
                          	],
                          	localdata: data3,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#cdmSearchGridID").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
     					
                columns: [
					 { text: 'Name', datafield: 'name', width: '50%' },
					 { text: 'DOB', datafield: 'dob', width: '25%', cellsformat: 'dd.MM.yyyy' },
					 { text: 'Ref No', datafield: 'refno', width: '25%' }, 
					 { text: 'Doc No', datafield: 'doc_no', hidden: true, width: '10%' },
					]
            });
            
			  $('#cdmSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                $('#mode').attr('disabled', false );
                document.getElementById("mode").value="view";
                document.getElementById("docno").value= $('#cdmSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $("#cvAnalyseGridID").jqxGrid({ disabled: false});
                $("#frmCandidateMaster").submit();
                setValues();
                $('#window').jqxWindow('close');
            });  
				           
}); 
				       
                       
    </script>
    <div id="cdmSearchGridID"></div>
    
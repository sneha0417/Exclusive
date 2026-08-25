<%@page import="com.dashboard.analysis.amcexpirystatus.amcExpiryStatusDAO" %>
<%
	amcExpiryStatusDAO sd=new amcExpiryStatusDAO();
%>

    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


<% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String branchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>

 <script type="text/javascript">
 var data,amcexpiryexcel;
 var temp='<%=rds%>';
 var bb='<%=branchval%>';
	if(bb!='0'){
 data= '<%= sd.loadGridData(fromdate,todate,rds,branchval)%>';
 amcexpiryexcel= '<%= sd.loadGridExcel(fromdate,todate,rds,branchval)%>';
	}
	else{
		bb=5;
	}
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'cperson', type: 'String' },
     						{name : 'refdtype', type: 'String' },
     						{name : 'refno', type: 'String' },
     						{name : 'sdate', type: 'date' },
     						{name : 'edate', type: 'date' },
     						{name : 'cval', type: 'String' },
     						{name : 'salman',type:'String' },
     						{name : 'lfee', type: 'String' },
     						{name : 'amcno', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'siteadd', type: 'String' },
     						
     					     						
                 ],
                 localdata: data,
                
                
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
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '99%',
                height: 520,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '5%' },
					{ text: 'Doc Type',  datafield: 'dtype', width: '5%' },
					{ text: 'AMC No.',  datafield: 'amcno', width: '8%',hidden:true },
					
					{ text: 'Client', datafield: 'client', width: '15%' },
					{ text: 'Contact Person', datafield: 'cperson', width: '14%' },
					{text:'Sales Man',datafield:'salman',width:'10%'},
					{ text: 'Site', datafield: 'site', width: '13%' },
			//		{ text: 'Site Details', datafield: 'siteadd', width: '12%' },
					{ text: 'Ref Dtype', datafield: 'refdtype', width: '6%' },
					{ text: 'Ref No', datafield: 'refno', width: '10%' },
					{ text: 'Start Date', datafield: 'sdate', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'End Date', datafield: 'edate', width: '7%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Contract Value',  datafield: 'cval', width: '9%' },
					
					{ text: 'Legal Fees',  datafield: 'lfee', width: '9%' },
					
					
					
	              ]
            });
            if(bb==5)
        	{
        	 $("#jqxloaddataGrid").jqxGrid('addrow', null, {});
        	}

                 $("#overlay, #PleaseWait").hide();
                 if(temp=="RE")  //not invo
         		{
             	
         		   $('#jqxloaddataGrid').jqxGrid('showcolumn', 'amcno');
         		   
         		}
                 
                
        });
    </script>
    <div id="jqxloaddataGrid"></div>

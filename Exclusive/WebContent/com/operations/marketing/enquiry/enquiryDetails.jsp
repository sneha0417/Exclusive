<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.enquiry.ClsEnquiryDAO" %>


 <%
 ClsEnquiryDAO DAO= new ClsEnquiryDAO();
           	String enqrdocno = request.getParameter("enqrdocno")==null?"0":request.getParameter("enqrdocno").trim();
           //System.out.println("---------"+enqrdocno);
           	  %> 
<script type="text/javascript">

           	  
           	var temp1='<%=enqrdocno%>';
            var hide;
            var enqdata1;
            if(temp1>0)
          	 {
            	 var enqdata1= '<%=DAO.searchrelode(enqrdocno,session)%>';
            	 
          	   hide=2; 
          	 } 
            else
          	 { 
            	var enqdata1;
            	var codes;
            	var list;
            	 <%-- var codes="<%=com.operations.marketing.enquiry.ClsEnquiryAction.searchTariff()%>"; --%>  
            	/*  var list = codes.split(","); */ 
          	/* 	 /* '[{"Name":""},{"Date of Birth":""},{"Age":""},{"dbage":""},{"Nationality":""},{"Mob No":""},{"Licence#":""},{"Lic Issued":""},{"dbLic Issued":""},{"calcuLic Issued":""},{"Licence#":""},{"Lic Issued":""},{"dbLic Issued":""},{"calcuLic Issued":""},{"Lic Expiry":""},{"Lic Type":""},{"Iss From":""},{"Passport#":""},{"Pass Exp":""},{"doc_no":""}]'; */
          	 } 
   <%--  var data= '<%=com.operations.marketing.enquiry.ClsEnquiryAction.searchDetails() %>'; --%>
  
        $(document).ready(function () { 	
        
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'descritpion', type: 'string'  },
     						{name : 'qty', type: 'string'   },
     						{name : 'remarks', type: 'string'   },
     						{name : 'sr_no', type: 'int'  }
     						
     											
                 ],
                 localdata: enqdata1,
                
                
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

            
            
            $("#jqxEnquiry").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
            
                disabled:true,
                editable: true,
                altRows: true,
             
                selectionmode: 'singlecell',
                pagermode: 'default',
                
       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            
							{ text: 'Description', datafield: 'descritpion', width: '42%' },	
							{ text: 'Qty', datafield: 'qty', width: '11%'},
							{ text: 'Remarks', datafield: 'remarks', width: '43%'}
			              ]
               
            });
            $("#jqxEnquiry").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    
            
            
            	   if(datafield=="qty")
            		   {
           
            $("#jqxEnquiry").jqxGrid('addrow', null, {});
            		   }
            	   
                    });
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#jqxEnquiry").jqxGrid({ disabled: false}); 
    		}
            

        });
    </script>
    <div id="jqxEnquiry"></div>
  <input type="hidden" id="rowindex"/> 
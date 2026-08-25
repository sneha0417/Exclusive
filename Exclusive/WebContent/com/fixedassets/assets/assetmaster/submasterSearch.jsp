<%@page import="com.fixedassets.assets.assetmaster.ClsAssetmasterDAO" %>
<%ClsAssetmasterDAO amd=new ClsAssetmasterDAO(); %>

 <%
 //assetname,assetid,sdocno,assetgroup,chk
String assetname = request.getParameter("assetname")==null?"0":request.getParameter("assetname");
 String assetid = request.getParameter("assetid")==null?"0":request.getParameter("assetid");
 String sdocno = request.getParameter("sdocno")==null?"0":request.getParameter("sdocno");
 String assetgroup = request.getParameter("assetgroup")==null?"0":request.getParameter("assetgroup");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");

%> 
       <script type="text/javascript">


        	 var barnddata1='<%=amd.masterSearch(session,assetname,assetid,sdocno,assetgroup,chk)%>';
        	 
        
    		  
			 
		$(document).ready(function () { 	
    
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'string'  },
                            {name : 'assetid', type: 'string'  },
                            {name : 'assetname', type: 'string'  },
                            {name : 'date', type: 'date'  },
                            {name : 'gpname', type: 'string'  },
                            {name : 'sr_no', type: 'string'  },
                            
     						
                        ],
                		
                		//  url: url1,
                 localdata: barnddata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mastersearch").jqxGrid(
            {
            	   width: '99.9%',
            	   height: 285,
                   source: dataAdapter,
               
                 
                   selectionmode: 'singlerow',
                   pagermode: 'default',
            
                
            
                       
                columns: [
						
                          


                     
                            
                              { text: 'Doc NO', datafield: 'doc_no', width: '10%' },
                              { text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
                              { text: 'Asset Group', datafield: 'gpname', width: '30%' },
                              { text: 'Asset Id', datafield: 'assetid', width: '15%' },
                              { text: 'Asset Name', datafield: 'assetname', width: '35%' },
                              { text: 'srno', datafield: 'sr_no', width: '50%' ,hidden:true},
                       
                            
                        
                         
	             
						]
            });
            $('#mastersearch').on('rowdoubleclick', function (event) 
            		{ 
        	  var rowindex1=event.args.rowindex;
        	
        			document.getElementById("docno").value=$("#mastersearch").jqxGrid('getcellvalue', rowindex1, "doc_no");
        			document.getElementById("srno").value=$("#mastersearch").jqxGrid('getcellvalue', rowindex1, "sr_no");
        			//document.getElementById("masterrefno").value=$("#jqxmainsearch").jqxGrid('getcellvalue', rowindex1, "vocno");
	   			
	              $('#window').jqxWindow('close');
	              funSetlabel();
	              document.getElementById("frmassetmastrer").submit();

            		 });	
          
        });
    </script>
    <div id="mastersearch"></div>
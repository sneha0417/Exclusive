<%@page import="com.cargo.transportmasters.servicetype.ClsServiceTypeDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% ClsServiceTypeDAO cd=new ClsServiceTypeDAO(); %>
<% String contextPath=request.getContextPath();%>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<script type="text/javascript">
		 var data;  
        $(document).ready(function () { 
           
            var temp='<%=check%>';
             
             if(temp>0){   
            	 data='<%=cd.getServiceTypeGrid(check)%>';    
           	 }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date' }, 
     						{name : 'srvtype', type: 'string'   },
     						{name : 'modename', type: 'string'  },
     						{name : 'submode', type: 'string'   },
     						{name : 'shipment', type: 'String'   },
     						{name : 'modeid', type: 'int'  },
     						{name : 'smodeid', type: 'int'  },
     						{name : 'shipid', type: 'int'  }
     					
                        ],
                         localdata: data,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxServiceType").jqxGrid(
            {
                 width: '99.5%',
                 height:310,
	             source: dataAdapter,
	             showfilterrow: true,
	             filterable: true,
	             selectionmode: 'singlerow',
	             sortable: true,
	             altrows:true,
              
                columns: [
							{ text: 'Doc No', datafield: 'doc_no',filtertype: 'number', editable: false, width: '10%' },
                            { text: 'Date', datafield: 'date',filtertype: 'date', cellsformat: 'dd.MM.yyyy',  editable: false, width: '10%' },	
							{ text: 'Service Type', datafield: 'srvtype',filtertype: 'textbox', editable: false, width: '20%' },
							{ text: 'Mode', datafield: 'modename',filtertype: 'list', editable: false, width: '20%' },
							{ text: 'Mode Id', datafield: 'modeid',filtertype: 'number', width: '20%',hidden: true,editable: false },
							{ text: 'Submode', datafield: 'submode',filtertype: 'list', editable: false, width: '20%' },
							{ text: 'SubMode Id', datafield: 'smodeid',filtertype: 'number', width: '20%',hidden: true,editable: false },
							{ text: 'Shipment', datafield: 'shipment', filtertype: 'list',width: '20%',editable: false },
							{ text: 'Shipment Id', datafield: 'shipid', filtertype: 'number',width: '20%',hidden: true,editable: false },
							]
            });
            $('#jqxServiceType').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxServiceType').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#servicedate").jqxDateTimeInput('val', $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("servicetype").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "srvtype");
                document.getElementById("hidcmbmode").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "modeid");
                document.getElementById("hidcmbsubmode").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "smodeid");
                document.getElementById("hidcmbshipment").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "shipid");
                getMode();getShipment();
               
                $('#window').jqxWindow('hide');
            }); 
            
        });
    </script>
    <div id="jqxServiceType"></div>
    

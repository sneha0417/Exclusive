<%@page import="com.finance.nipurchase.suppliers.ClsVendorDetailsDAO" %>
<%  ClsVendorDetailsDAO DAO=new ClsVendorDetailsDAO(); %>
<%
 String vndname = request.getParameter("vndname")==null?"0":request.getParameter("vndname");
 String vndaccno = request.getParameter("vndaccno")==null?"0":request.getParameter("vndaccno");
 String vndmob = request.getParameter("vndmob")==null?"0":request.getParameter("vndmob");
 String vndtel = request.getParameter("vndtel")==null?"0":request.getParameter("vndtel");
%> 
<script type="text/javascript">
  		
  		var data1= '<%= DAO.vndMainSearch(vndname,vndaccno,vndmob,vndtel) %>';
        
  		$(document).ready(function (){ 	
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'refname' , type: 'String' },
     						{name : 'acno', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'per_tel', type: 'String'  },
     						{name : 'doc_no', type: 'int'  }
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
            $("#jqxVendorSearch").jqxGrid(
            {
            	width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                
                columns: [
					{ text: 'Name', datafield: 'refname', width: '40%' },
					{ text: 'Account No.', datafield: 'acno', width: '20%' },
					{ text: 'Mobile No.', datafield: 'per_mob', width: '20%' },
					{ text: 'Telephone No.', datafield: 'per_tel', width: '20%' },
					{ text: 'Doc No', hidden: true, datafield: 'doc_no', width: '5%' },
	              ]
            });
            
            $('#jqxVendorSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtvendorname").value= $('#jqxVendorSearch').jqxGrid('getcellvalue', rowindex1, "refname");
                document.getElementById("txtaccount").value= $('#jqxVendorSearch').jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("txttel").value= $('#jqxVendorSearch').jqxGrid('getcellvalue', rowindex1, "per_tel");
                document.getElementById("txtmob").value= $('#jqxVendorSearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
                document.getElementById("docno").value= $('#jqxVendorSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                $('#frmVendorDetails select').attr('disabled', false);
                $('#jqxVendorDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmVendorDetails").submit();
                $('#frmVendorDetails select').attr('disabled', true);
                $('#jqxVendorDate').jqxDateTimeInput({disabled: true});
                $('#window').jqxWindow('close');
            }); 
        });
    </script>
    <div id="jqxVendorSearch"></div>

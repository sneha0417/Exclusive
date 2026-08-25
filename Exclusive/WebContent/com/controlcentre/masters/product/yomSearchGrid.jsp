<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();%>
<%String type=request.getParameter("type");%>
<%String yomfrm=request.getParameter("yomfrm")==null?"0":request.getParameter("yomfrm").toString();%>
<%String yomto=request.getParameter("yomto")==null?"0":request.getParameter("yomto").toString();%>
<%String suitrows=request.getParameter("suitrows")==null?"0":request.getParameter("suitrows").toString();%>
<script type="text/javascript">
 	var uomrow='<%=request.getParameter("rowno") %>';
 	var type='<%=request.getParameter("type") %>';
     var yomsearch= '<%=DAO.yomSearch(session,type,yomfrm,yomto,suitrows) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'string'  },
                              {name : 'yom', type: 'string'  }
                            ],
                       localdata: yomsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#yomsearch").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '40%',hidden:true},
                              { text: 'Yom', datafield: 'yom', width: '100%' },
                              
						]
            });
            
             
          $('#yomsearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                if(type=="frm"){
                	$('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'yomfrm',$('#yomsearch').jqxGrid('getcellvalue', rowindex1, "yom"));
                    $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'yomfrmid',$('#yomsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                    
                  	$('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'yomto','');
                    $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'yomtoid','');
                }
                else if(type=="to"){
                	$('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'yomto',$('#yomsearch').jqxGrid('getcellvalue', rowindex1, "yom"));
                    $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'yomtoid',$('#yomsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                }
                                
              $('#yomsearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="yomsearch"></div> 
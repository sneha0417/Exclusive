<%@page import="com.dashboard.fixedasset.fixedassetregister.ClsFixedAssetRegister"%>
<%ClsFixedAssetRegister DAO= new ClsFixedAssetRegister(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String assetNo = request.getParameter("assetno")==null?"0":request.getParameter("assetno").trim();
     String group = request.getParameter("group")==null?"0":request.getParameter("group").trim();
     String rptType = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype");
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 
     
<style type="text/css">
  .opnClass
  {
      color: #298A08;
  }
  .additionClass
  {
      color: #0101DF;
  }
  .deletionClass
  {
     color: #FF0000;
  }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      var temp1='<%=fromDate%>';
	  var temp2='<%=toDate%>';
	  
	  	if(temp!='NA'){ 
	  		data='<%=DAO.fixedAsssetGridLoading(branchval, fromDate, toDate, assetNo, group, rptType, check)%>';
	  		var dataExcelExport='<%=DAO.fixedAsssetExcelExport(branchval, fromDate, toDate, assetNo, group, rptType, check)%>';
	  	}
  	
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'assetid' , type: 'String' },
							{name : 'asset_no' , type: 'int' },
     						{name : 'assetname', type: 'String'  },
     						{name : 'age',type:'int'},
     						{name : 'deprper',type:'number'},
     						{name : 'purdate',type:'date'},
     						{name : 'assetgp',type:'String'},
     						{name : 'assetopn',type:'number'},
     						{name : 'assetadd',type:'number'},
     						{name : 'assetdel',type:'number'},
     						{name : 'assettotal',type:'number'},
     						{name : 'depropn',type:'number'},
     						{name : 'depradd',type:'number'},
     						{name : 'deprdel',type:'number'},
     						{name : 'deprtotal',type:'number'},
     						{name : 'nettotal',type:'number'},
     						{name : 'prevyear',type:'number'}
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
            $("#fixedAssetRegisterGrid").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                rowsheight:25,
                statusbarheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                showaggregates: true,
             	showstatusbar:true,
                editable: false,
                
                columns: [
							{ text: 'No.', sortable: false, filterable: false, editable: false,
						    	groupable: false, draggable: false, resizable: false,datafield: '',
						    	columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						    	cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						      }    
							},
							{ text: 'Asset Id', datafield: 'assetid',editable:false, width: '6%'},
							{ text: 'Asset No', datafield: 'asset_no',hidden: true, width: '14%'},
							{ text: 'Asset Name', datafield: 'assetname',editable:false, width: '14%'},
							{ text: 'Group Name', datafield: 'assetgp',editable:false, width: '10%'},
							{ text: 'Age(M)', datafield: 'age', width: '4%', editable:false},
							{ text: 'Depr(%)', datafield: 'deprper', width: '5%', cellsformat:'d2', editable:false},
							{ text: 'Pur Date', datafield: 'purdate', width: '6%',editable:false ,cellsformat:'dd.MM.yyyy',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'OPN', datafield: 'assetopn', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Asset',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Addition', datafield: 'assetadd', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Asset',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'Deletion',datafield:'assetdel', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Asset',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: 'deletionClass' },
							{ text: 'Total',  datafield:'assettotal',width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Asset',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'OPN', datafield: 'depropn', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Depreciation',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Addition', datafield: 'depradd', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Depreciation',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'Deletion',datafield:'deprdel', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Depreciation',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'deletionClass' },
							{ text: 'Total',  datafield:'deprtotal',width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'Depreciation',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Net Total',  datafield:'nettotal',width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Prevoius Year',  datafield:'prevyear',width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }
							],
							columngroups: 
							  [
							    { text: 'Asset', align: 'center', name: 'Asset',width: '20%' },
							    { text: 'Depreciation', align: 'center', name: 'Depreciation',width: '20%' }
							 
							  ]
            });
            
            if(temp=='NA'){
                $("#fixedAssetRegisterGrid").jqxGrid("addrow", null, {});
            }

			$("#overlay, #PleaseWait").hide();
			
			 $('#fixedAssetRegisterGrid').on('rowdoubleclick', function (event) {
				    var rowindex=event.args.rowindex;
	                var desc= "Fixed Asset Register"; 
	                var assetno=$('#fixedAssetRegisterGrid').jqxGrid('getcellvalue', rowindex, "asset_no");
          	        var url=document.URL;
					var reurl=url.split("com/");
					
					var detName=$('#fixedAssetRegisterGrid').jqxGrid('getcellvalue', rowindex, "assetname");
					var path="com/dashboard/fixedasset/fixedassetregister/fixedAssetDetailedGrid.jsp";
					top.addTab( detName,reurl[0]+""+path+"?name="+detName+"&main="+desc+"&branchval="+temp+'&assetno='+assetno+'&fromdate='+temp1+'&todate='+temp2+'&check=1');
	          	    
	              });
            
        });

</script>
<div id="fixedAssetRegisterGrid"></div>

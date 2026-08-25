<%@page import="com.controlcentre.settings.currencybook.ClsCurrencyBookDAO" %>
<%ClsCurrencyBookDAO cbd=new ClsCurrencyBookDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); 
   String disable = request.getParameter("disable")==null?"0":request.getParameter("disable");
%>

<script type="text/javascript">
       var data1;
        $(document).ready(function () { 	
              
        	var temp='<%=check%>';
        	var temp1='<%=disable%>';
            
            if(temp>0)
          	 { 
             data1='<%=cbd.currencyBookGridLoading(session) %>';      
             }
            
             // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'code', type: 'String' },
     						{name : 'c_rate', type: 'number' },
     						{name : 'type', type: 'String' },
     						{name : 'curid', type: 'int' },
     						{name : 'basecode', type: 'String' },
     						{name : 'description', type: 'String' }
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
		            });
            
            var list = ['M', 'D'];

            $("#jqxCurrencyBook").jqxGrid(
            {
                width: '55%',
                height: 350,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                   
                    //Search Pop-Up
                    var cell1 = $('#jqxCurrencyBook').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'code') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	CurrencySearchContent('currencySearchGrid.jsp'); 
                          }
                    }
                },
                    
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Currency', datafield: 'code', editable: false, width: '22%' },	
							{ text: 'Rate', datafield: 'c_rate', cellsalign: 'right', align: 'right', width: '14%' },
							{ text: 'Type', datafield: 'type', width: '14%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
							{ text: 'Currency Id', datafield: 'curid', hidden:true, width: '10%' },
							{ text: 'Base Currency Code', datafield: 'basecode', hidden:true, width: '10%' },
							{ text: 'Description', datafield: 'description', editable: false, width: '40%' },
						]
            });   
            
          	  if(temp1>0){  
             	 $("#jqxCurrencyBook").jqxGrid({ disabled: true}); 
              }
          	 
          	$('#jqxCurrencyBook').on('celldoubleclick', function (event) {
          	  if(event.args.columnindex == 1)
          		  {
          			var rowindextemp = event.args.rowindex;
          			document.getElementById("rowindex").value = rowindextemp;
          			CurrencySearchContent('currencySearchGrid.jsp');
          			
                    } 
              });
          	
          	 $("#jqxCurrencyBook").on('cellvaluechanged', function (event){
                 var rowindex1=event.args.rowindex;
                
                 var code = $('#jqxCurrencyBook').jqxGrid('getcellvalue', rowindex1, "code");
         		 var rate = $('#jqxCurrencyBook').jqxGrid('getcelltext', rowindex1, "c_rate");
                 var type = $('#jqxCurrencyBook').jqxGrid('getcellvalue', rowindex1, "type");
                 var basecode = $('#jqxCurrencyBook').jqxGrid('getcellvalue', rowindex1, "basecode");
                 funRoundRate(rate,"txtcurrencybookround");
                 
                 if(type=="M"){
               	     var description = (basecode+" * "+$("#txtcurrencybookround").val()+" = 1 "+code);
               	     $('#jqxCurrencyBook').jqxGrid('setcellvalue', rowindex1, "description" ,description);
   		          }else if(type=="D"){
   		    	     var description = ($("#txtcurrencybookround").val()+" "+code+" = 1 "+basecode);
             	     $('#jqxCurrencyBook').jqxGrid('setcellvalue', rowindex1, "description" ,description);
   		         }
                 
                 $('#jqxCurrencyBook').jqxGrid('setcellvalue', rowindex1, "c_rate" ,$("#txtcurrencybookround").val());
                 
              }); 
         	 
          	var rows = $('#jqxCurrencyBook').jqxGrid('getrows');
      	    var rowlength= rows.length;
      		for(i=0;i<=rowlength-1;i++)
      		{
      		  var code = $('#jqxCurrencyBook').jqxGrid('getcellvalue', i, "code");
      		  var rate = $('#jqxCurrencyBook').jqxGrid('getcelltext', i, "c_rate"); 
              var type = $('#jqxCurrencyBook').jqxGrid('getcellvalue', i, "type");
              var basecode = $('#jqxCurrencyBook').jqxGrid('getcellvalue', i, "basecode");
              funRoundRate(rate,"txtcurrencybookround");
              
              if(type=="M"){
            	  var description = (basecode+" * "+rate+" = 1 "+code);
            	  $('#jqxCurrencyBook').jqxGrid('setcellvalue', i, "description" ,description);
		      }else if(type=="D"){
		    	 var description = (rate+" "+code+" = 1 "+basecode);
          	     $('#jqxCurrencyBook').jqxGrid('setcellvalue', i, "description" ,description);
		       }
      	  }
});

</script>

<div id="jqxCurrencyBook"></div>
<input type="hidden" id="rowindex"/>
<input type="hidden" id="txtcurrencybookround"/>  
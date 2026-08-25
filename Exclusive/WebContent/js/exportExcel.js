/*
 * jQuery Client Side Excel Export Plugin Library exclusively for JqxGrid
 *
 * March 21, 2019 - All Copyrights reserved to Rahis ARM
 * 
 */

(function ($) {
    var $defaults = {
        containerid: null
        , datatype: 'table'
        , dataset: null
        , columns: null
        , returnUri: false
        , worksheetName: "My Worksheet"
        , encoding: "utf-8"
        , gridId:"gridid"
		, gridType:"jqxGrid"
    };

    var $settings = $defaults;

    $.fn.excelexportjs = function (options) {

        $settings = $.extend({}, $defaults, options);

        var gridData = [];
        var excelData;

        return Initialize();
		
		function Initialize() {
            var type = $settings.datatype.toLowerCase();

            BuildDataStructure(type);


            switch (type) {
                case 'table':
                    excelData = Export(ConvertFromTable());
                    break;
                case 'json':
                    excelData = Export(ConvertDataStructureToTable());
                    break;
                case 'xml':
                    excelData = Export(ConvertDataStructureToTable());
                    break;
                case 'jqgrid':
                    excelData = Export(ConvertDataStructureToTable());
                    break;
            }

       
            if ($settings.returnUri) {
                return excelData;
            }
            else {

                if (!isBrowserIE())
                {
                /*	var dt = new Date();
                    var day = dt.getDate();
                    var month = dt.getMonth() + 1;
                    var year = dt.getFullYear();
                    var hour = dt.getHours();
                    var mins = dt.getMinutes();
                    var postfix = day + "." + month + "." + year + "_" + hour + "." + mins;
                    //creating a temporary HTML link element (they support setting file names)*/
                    var a = document.createElement('a');
                    //getting data from our div that contains the HTML table
                    var data_type = 'data:application/vnd.ms-excel';
                    //var table_div = document.getElementById($settings.containerid);
                    //var table_html = table_div.outerHTML.replace(/ /g, '%20');
                    var table_html = ConvertDataStructureToTable();
                    blob = new Blob([excelData],{type: 'text/html'});
                    var bigdata= window.webkitURL.createObjectURL(blob);
                    a.href = bigdata;
                    //setting the file name
                    a.download =$settings.worksheetName + '.xls';
                    //triggering the function
                    a.click();
                    //just in case, prevent default behaviour
                    //e.preventDefault();
                	//window.open(excelData);
                
                }

               
            }
        }

        function BuildDataStructure(type) {
            switch (type) {
                case 'table':
                    break;
                case 'json':
                    gridData = $settings.dataset;
                	
                    break;
                case 'xml':
                    $($settings.dataset).find("row").each(function (key, value) {
                        var item = {};

                        if (this.attributes != null && this.attributes.length > 0) {
                            $(this.attributes).each(function () {
                                item[this.name] = this.value;
                            });

                            gridData.push(item);
                        }
                    });
                    break;
                case 'jqgrid':
                    $($settings.dataset).find("rows > row").each(function (key, value) {
                        var item = {};

                        if (this.children != null && this.children.length > 0) {
                            $(this.children).each(function () {
                                item[this.tagName] = $(this).text();
                            });

                            gridData.push(item);
                        }
                    });
                    break;
            }
        }

        function ConvertFromTable() {
            var result = $('<div>').append($('#' + $settings.containerid).clone()).html();            
            return result;
        }

        function ConvertDataStructureToTable() {
            var result = "<table id='tabledata' style='width:100%;'>";

            result += "<thead><tr>";
            var columngroups=$("#"+$settings.gridId).jqxGrid("columngroups");
            
            $($settings.columns).each(function (key, value) {
            	if (this.ishidden != true) {
            
                    result += "<th";
                    if (this.align != null && this.align != "" && this.align != "undefined" ) {
                        result += " align='" + this.align + "'";
                    }
                    //alert(result);
                    if (this.width != null) {
                        result += " style='width: " + this.width + ";background-color:#EAF2F8;'";
                    }
                    result += ">";
                    result += this.columngrouptext!=""?this.columngrouptext+" "+this.headertext:this.headertext;
                    result += "</th>";
                }
            });
            result += "</tr></thead>";
            result += "<tbody>";
            var cols=$("#"+$settings.gridId).jqxGrid("columns");
            var rows=$("#"+$settings.gridId).jqxGrid("getdisplayrows");
            for(var i=0,srno=1;i<rows.length;i++,srno++){
                
        		result += "<tr>";
        		var rowdata=rows[i];
        		for(var j=0;j<cols.records.length;j++){
        			//console.log(cols.records[j]);
        			var datafield=cols.records[j].datafield;
                    var hidden=cols.records[j].hidden;
                    var width=cols.records[j].width;
                    var align=cols.records[j].align;
        			if(hidden!=true){
        				//alert(datafield);
        				var datatext="";
        				
        				if(j==0 && datafield.charAt(0)!="_"){
        					if(datafield=="" || datafield=="undefined" || typeof(datafield)=="undefined" || datafield==null){
								datatext=srno+"";
							}
        					if(datatext==""){
        						datatext=$("#"+$settings.gridId).jqxGrid("getcelltext",rowdata.boundindex,datafield);
    							if(datatext==null || datatext=="" || datatext=="undefined" || typeof(datatext)=="undefined"){
    								datatext=srno+"";
    							}
        					}
        					
        				}
        				else if(datafield!="" && datafield!="undefined" && typeof(datafield)!="undefined" && datafield!=null && datafield.charAt(0)!="_"){
        					datatext=$("#"+$settings.gridId).jqxGrid("getcelltext",rowdata.boundindex,datafield);
        				}
        				if(datatext!="" && datatext!="undefined" && typeof(datatext)!="undefined" && datatext!=null){
        					result += "<td";
                			if (width != null) {
                                result += " style='width: " + width + "'";
                            }
                			result += ">";
                			result += datatext;
                			result += "</td>";
        				}
            		}
        		}
        		
        		result += "</tr>";
            }
            
            result += "</tbody>";

            result += "</table>";

            return result;
        }

        function Export(htmltable) {

            if (isBrowserIE()) {
        
                exportToExcelIE(htmltable);
            }
            else {
                var excelFile = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:x='urn:schemas-microsoft-com:office:excel' xmlns='http://www.w3.org/TR/REC-html40'>";
                excelFile += "<head>";
                excelFile += '<meta http-equiv="Content-type" content="text/html;charset=' + $defaults.encoding + '" />';
                excelFile += "<!--[if gte mso 9]>";
                excelFile += "<xml>";
                excelFile += "<x:ExcelWorkbook>";
                excelFile += "<x:ExcelWorksheets>";
                excelFile += "<x:ExcelWorksheet>";
                excelFile += "<x:Name>";
                excelFile += "{worksheet}";
                excelFile += "</x:Name>";
                excelFile += "<x:WorksheetOptions>";
                excelFile += "<x:DisplayGridlines/>";
                excelFile += "</x:WorksheetOptions>";
                excelFile += "</x:ExcelWorksheet>";
                excelFile += "</x:ExcelWorksheets>";
                excelFile += "</x:ExcelWorkbook>";
                excelFile += "</xml>";
                excelFile += "<![endif]-->";
                /*excelFile += "</title>"+$settings.worksheetName+"</title>";*/
                excelFile += "</head>";
                excelFile += "<body>";
                excelFile += htmltable.replace(/"/g, '\'');
                excelFile += "</body>";
                excelFile += "</html>";

                /*var uri = "data:application/vnd.ms-excel;base64,";
                var ctx = { worksheet: $settings.worksheetName, table: htmltable };

                return (uri + base64(format(excelFile, ctx)));*/
                return excelFile;
            }
        }

        function base64(s) {
            return window.btoa(unescape(encodeURIComponent(s)));
        }

        function format(s, c) {
            return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; });
        }

        function isBrowserIE() {
            var msie = !!navigator.userAgent.match(/Trident/g) || !!navigator.userAgent.match(/MSIE/g);
            if (msie > 0) {  // If Internet Explorer, return true
                return true;
            }
            else {  // If another browser, return false
                return false;
            }
        }

        function exportToExcelIE(table) {


            var el = document.createElement('div');
            el.innerHTML = table;

            var tab_text = "<table border='2px'><tr bgcolor='#87AFC6'>";
            var textRange; var j = 0;
            var tab;
                  

            if ($settings.datatype.toLowerCase() == 'table') {            
                tab = document.getElementById($settings.containerid);  // get table              
            }
            else{
                tab = el.children[0]; // get table
            }

          
        
            for (j = 0 ; j < tab.rows.length ; j++) {
                tab_text = tab_text + tab.rows[j].innerHTML + "</tr>";
                //tab_text=tab_text+"</tr>";
            }

            tab_text = tab_text + "</table>";
            tab_text = tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
            tab_text = tab_text.replace(/<img[^>]*>/gi, ""); // remove if u want images in your table
            tab_text = tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");

            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
            {
                txtArea1.document.open("txt/html", "replace");
                txtArea1.document.write(tab_text);
                txtArea1.document.close();
                txtArea1.focus();
                sa = txtArea1.document.execCommand("SaveAs", true, $settings.worksheetName);
            }
            else                
                sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));

            return (sa);


        }
        
    };
})(jQuery);


//get columns
function getColumns(gridId){
	var header = [];
	var cols=$("#"+gridId).jqxGrid("columns");
	for (var i = 0; i < cols.records.length; i++) {
		var datatype="string";
		if(cols.records[i].cellsformat.includes("dd.MM.yyyy")){
			datatype="date";
		}
		else if(cols.records[i].cellsformat.includes("d2")){
			datatype="number";
		}
		var datafield=cols.records[i].datafield;
		var obj = {} 
		console.log(cols.records[i]);
		if(datafield!="" && datafield!="undefined" && typeof(datafield)!="undefined" && datafield!=null && datafield.charAt(0)!="_"){
			obj["headertext"] = cols.records[i].text;
			obj["datafield"] = cols.records[i].datafield;
			obj["datatype"] = datatype;
			obj["ishidden"]=cols.records[i].hidden;
			obj["width"]=cols.records[i].width;
			obj["align"]=cols.records[i].align;
			var columngrouptext="";
			if(cols.records[i].parent!=null && cols.records[i].parent!="" && cols.records[i].parent!="undefined"){
				columngrouptext=cols.records[i].parent.text;
			}
			obj["columngrouptext"]=columngrouptext;
			obj["percentwidth"]=cols.records[i]._percentagewidth;
			
			header.push(obj);
		}
	}
	return header;
}
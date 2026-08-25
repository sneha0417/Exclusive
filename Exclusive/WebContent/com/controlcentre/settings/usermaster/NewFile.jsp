<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="keywords" content="jQuery Tree, Tree Widget, Tree" /> 
    <meta name="description" content="The jqxTree can display a checkboxes next to its items. You can also enable three-state checkboxes. In this mode, when the user
     checks an item, its sub items also become checked. When there is an unchecked item, the parent item is in indeterminate state." />
    <title id='Description'>The jqxTree can display a checkboxes next to its items. You can also enable three-state checkboxes. In this mode, when the user
     checks an item, its sub items also become checked. When there is an unchecked item, the parent item is in indeterminate state.</title>
     <link rel="stylesheet" href="../../../../css/jqx.base.css" type="text/css"/>
    <script type="text/javascript" src="../../../../js/jqxbuttons.js"></script>
    <script type="text/javascript" src="../../../../js/jqxscrollbar.js"></script>
    <script type="text/javascript" src="../../../../js/jqxpanel.js"></script>
    <script type="text/javascript" src="../../../../js/jqxtree.js"></script>
    <script type="text/javascript" src="../../../../js/jqxcheckbox.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // create jqxTree
            $('#jqxTree').jqxTree({ height: '200px', hasThreeStates: true, checkboxes: true, width: '930px'});
            $('#jqxTree').css('visibility', 'visible');
            /*            $('#jqxCheckBox').jqxCheckBox({ width: '200px', height: '25px', checked: true });
             $('#jqxCheckBox').on('change', function (event) {
                var checked = event.args.checked;
                $('#jqxTree').jqxTree({ hasThreeStates: checked });
            });
 */            /* $("#jqxTree").jqxTree('selectItem', $("#home")[0]); */
        });
        
        

    </script>
</head>
<body class='default' onload="getTreeDetails();">
    <div id='jqxWidget'>
        <div style='float: left;'>
            <div id='jqxTree' style='visibility: hidden; float: left; margin-left: 20px;'>
                <ul id="tree">
        <script>
        function getTreeDetails() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var compItems = items[0].split(",");
					var brchItems = items[1].split(",");
					var optionsli = '<li>'+compItems+'</li><ul>';
					for (var i = 0; i < brchItems.length; i++) {
						optionsli += '<li>'+brchItems[i]+'</li>';
					}
					optionsli += '</ul>';
					//alert(optionsli);
					$("ul#tree").append(optionsli);
					//setValues(); 
				} else {
				}
			}
			x.open("GET", "getTreeDet.jsp", true);
			x.send();
		}
        
        </script>
                	<%-- 	<s:iterator var="al" status="status1" value="%{x.responseText}">
											<li>
												ss<s:property value='key'/>
												 <ul>
						                            <li><s:property value='value'/></li>
						                        </ul>
											</li>
										</s:iterator>
					 --%>			
                    <li>FIRE 7 LCC
                        <ul>
                            <li>FIRE 7 LCC</li>
                            <li>FIRE 7 LCC 2</li>
                        </ul>
                    </li>
                    <li>AROMA
                        <ul>
                            <li>AROMA Branch1</li>
                            <li>AROMA Branch2</li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
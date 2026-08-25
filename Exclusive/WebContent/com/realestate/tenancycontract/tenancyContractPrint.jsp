<%@page pageEncoding="utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<style>
@media print {
    .pagebreakdiv {page-break-after: always;}
}
</style>


</head>

<body style="font-size:10px; background-color: white;">
<div id="mainBG" class="homeContent" data-type="background">
  <br/> <br/> <br/><br/><br/><br/><br/><br/>
<table width="100%">
<tr><td>
<fieldset>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="">
  <tr>
    <td width="6%" height="44"><b>Date</b></td>
    <td width="16%">:&nbsp;<label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td>
    <td width="35%">&nbsp;</td>
    <td width="21%" align="right"><b>Contract No:&nbsp;</b><label id="lblcontractno" name="lblcontractno"><s:property value="lblcontractno"/></label>&emsp;</td>
    </tr>
  <tr>
    <td colspan="2">Landlord</td>
    <td colspan="3">:&nbsp;<label id="lbllnadlord" name="lbllandlord"><s:property value="lbllandlord"/></label>&nbsp;(Property owner)</td>
    </tr>
  <tr>
    <td colspan="2">Tenant</td>
    <td colspan="3">:&nbsp;<label id="lbltenant" name="lbltenant"><s:property value="lbltenant"/></label></td>
    </tr>
  <tr>
    <td colspan="2">Period of Tenancy</td>
    <td>:&nbsp;<label id="lblperiodtenancy" name="lblperiodtenancy"><s:property value="lblperiodtenancy"/></label></td>
    <td colspan="-1">&nbsp;</td>
    <td width="22%">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">Subject of Tenancy</td>
    <td>:&nbsp;FlatNo.&nbsp;
    	<label id="lblsubjecttenancy" name="lblsubjecttenancy"><s:property value="lblsubjecttenancy"/></label>
    	,&nbsp; Bedroom</td>
    <td colspan="-1">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">Purpose of Tenancy</td>
    <td>:&nbsp;<label id="lblpurposetenancy" name="lblpurposetenancy"><s:property value="lblpurposetenancy"/></label></td>
    <td colspan="-1">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3">From : <label id="lblfrom" name="lblfrom"><s:property value="lblfrom"/></label>
    	&nbsp;To : <label id="lblto" name="lblto"><s:property value="lblto"/></label></td>
    <td colspan="2">Rent : <label id="lblrent" name="lblrent"><s:property value="lblrent"/></label>
      /-&nbsp;
      ( <label id="lblrentwords" name="lblrentwords"><s:property value="lblrentwords"/></label>&nbsp;)</td>
      
    </tr>
  <tr>
    <td colspan="2">Term of Payment</td>
    <td>:&nbsp;<label id="lblpayterm" name="lblpayterm"><s:property value="lblpayterm"/></label></td>
    <td colspan="-1">Area(approx.)  Sqft.</td>
    <td>:&nbsp;<label id="lblarea" name="lblarea"><s:property value="lblarea"/></label></td>
  </tr>
  <tr>
    <td colspan="2">CONTACT NO.</td>
    <td>:&nbsp;<label id="lblcontactno" name="lblcontactno"><s:property value="lblcontactno"/></label></td>
    <td colspan="-1">PREMISES NO.</td>
    <td>:&nbsp;<label id="lblpremisesno" name="lblpremisesno"><s:property value="lblpremisesno"/></label></td>
  </tr>
  <tr>
    <td height="45" colspan="2" valign="top">DEWA NO.</td>
    <td valign="top">:&nbsp;<label id="lbldewano" name="lbldewano"><s:property value="lbldewano"/></label></td>
    <td colspan="-1" valign="top">Plot No.</td>
    <td valign="top">:&nbsp;<label id="lblplotno" name="lblplotno"><s:property value="lblplotno"/></label></td>
  </tr>
  </table>
  </fieldset></td></tr>
  
  <tr><td><fieldset>
  <table width="100%">
  <tr>
    <td width="25%"><b><u>Contract Signatory</u></b>&nbsp;</td>
    <td>:&nbsp;</td>
    <td width="22%">&nbsp;</td>
    <td width="21%">&nbsp;</td>
  </tr>
  <tr>
    <td height="27" valign="top">Expiry date of Passport</td>
    <td valign="top">:&nbsp;<label id="lblpassportexp" name="lblpassportexp"><s:property value="lblpassportexp"/></label></td>
    <td valign="top">Expiry date of Visa</td>
    <td valign="top">:&nbsp;<label id="lblvisaexp" name="lblvisaexp"><s:property value="lblvisaexp"/></label></td>
  </tr>
   <tr>
    <td ><b><u>Cheque Signatory</u></b>&nbsp;</td>
    <td>:&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="52" valign="top">Expiry date of Passport</td>
    <td valign="top">:&nbsp;<label id="lblpassportexp" name="lblpassportexp"><s:property value="lblpassportexp"/></label></td>
    <td valign="top">Expiry date of Visa</td>
    <td valign="top">:&nbsp;<label id="lblvisaexp" name="lblvisaexp"><s:property value="lblvisaexp"/></label></td>
  </tr>
  <tr>
    <td colspan="2">Company Signing Contract  :&nbsp;</td>
    <td width="22%">&nbsp;</td>
    <td width="21%">&nbsp;</td>
  </tr>
  <tr>
    <td height="36" colspan="2" valign="top">Expiry Date of Trade License :&nbsp;
    	<label id="lbltradelicenseexp" name="lbltradelicenseexp"><s:property value="lbltradelicenseexp"/></label></td>
    <td valign="top">Expiry Date</td>
    <td valign="top">:&nbsp;</td>
  </tr>
  <tr>
    <td><u><b>Extra Observations : </b></u></td>
    <td width="32%">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3" align="center">SECURITY DEPOSIT AED <label id="lblsecurity" name="lblsecurity"><s:property value="lblsecurity"/></label>
      &nbsp;(REFUNDABLE)</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">&emsp;&emsp;-<span style="font-size: small"> For Residential (based  on type) Use Only/Excluding Car Park.</span></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</fieldset></td></tr>
</table>
<br/>   
<table width="100%" border="0" cellspacing="2" cellpadding="1">
  <tr>
    <td width="50%" height="44">Conditions Mutually  Agreed Upon as Under<span dir="RTL"> </span><span dir="RTL"><span dir="RTL"> </span>: </span></td>
    <td width="49%" align="right">: لقد تم الإتفاق المتبادل على الشروط الوارد ذكرها أدناه</td>
    <td width="1%">&nbsp;</td>
  </tr>
  <tr>
    <td style="text-align: justify"><strong>1</strong>. The tenant may neither sub-lease the leased  prop&shy;erty or may part thereof to any third party, nor share the leased  property, in whole or in part, with any natural or corporate person, or permit  any of the foresaid to occupy the leased property indepen&shy;dently. In the event,  the tenant shall commit a breach of this provision; the landlord/agent shall  have the right to immediately evict the tenant. Te&shy;nant agrees to cancel the  lease agreement and pay two months&rsquo; rent as cancellation charges.</td>
    <td align="right" valign="top" style="text-align: right"><span style="text-align: justify">يجب على المستأجر أن لا يؤجر العقارالمستأجر أو أي جزء منه من الباطن إلى أي طرف آخر أو إشراك أي شخص طبيعي أو هيئة إعتبارية كلياً أو جزئياً في العقار المستأجر أو يسمح لأي مما ذكر آنفاً بشغل العقار المستأجر بصفة مستقلة . وفي حالة خرق المستأجر لهذا الشرط يحق لصاحب العقار / الوكيل أن يطرد المستأجر لهذا فوراً من العقار . ويوافق المستأجر على دفع إيجار شهرين كغرامة إلغاء عقد الإيجار</span></td>
  <td valign="top">.1</td>
  </tr>
  <tr>
    <td style="text-align: justify"><strong><span dir="RTL">2</span></strong>.The tenant may not  erect any permanent fixtures, fittings or extensions on the leased property  without written approval of the landlord / agent, in case the tenant shall  erect such fixtures, fittings or extension with the approval of the  landlord/agent, they shall become an integral part of the leased property.  However, upon the handing over of the leased property to the landlord/agent the  tenant shall, is so required by the landlord/agent, be liable to remove such  fixtures, fittings and extensions at the tenant&rsquo;s own expense. The tenant may  notify or hang advertisement boards on any part of the leased property without  prior written approval of the landlord/agent, who will have the right to remove  any unauthorized fittings at the tenant's own expense.</td>
    <td align="right" valign="top" style="text-align: right"><span style="text-align: justify">يجب على المستأجر عدم إنشاء أية تجهيزات ، تركيبات أو توسعات بصفة مستديمة في العقار المستأجر إلا بعد الحصول على لموافقة الخطية المسبقة من صاحب العقار/ الوكيل وفي حالة إنشاء المستأجر لتلك التجهيزات ، التركيبات ، التوسعات على نفقته الخاصة إذا طلب منه صاحب العقار / الوكيل ذلك حين تسليمه العقار المستأجر إلى صاحب العقار / الوكيل. لا يحق للمستأجر تعليق إعلان أو لوحة إعلانات على العقار دون الحصول عليه موافقة خطية من صاحب العقار / الوكيل ويحق لصاحب العقار / الوكيل مطالبة المستأجر إزالة كافة التركيبات المخالفة على نفقة المستأجر</span></td>
  <td valign="top">.2</td>
  </tr>
  <tr>
    <td style="text-align: justify"><strong>3</strong>. The tenant shall be responsible for the payment of all government,  municipal fees and RERA registra&shy;tion fees which might be imposed now or in the  future for the leased property together with elec&shy;tricity, water and sewerage  bills.</td>
    <td align="right" valign="top" style="text-align: right"> يتحمل المستأجر تسديد كافة الرسوم/ ضرائب الحكومة والبلدية والتسجيل لدى (ريرا) سواء تفرض الآن أو في المستقبل على العقار المستأجر علاوة على تسديد فواتير الكهرباء والمياه والصرف الصحي</td>
  <td valign="top">.3</td>
  </tr>
  <tr>
    <td style="text-align: justify"><strong>4</strong>. The tenant undertakes to insure the contents  of the premises against all risks such as bursting of water pipe, fire,  hail-storm, etc, and any other unex&shy;pected and / or natural / unnatural  disasters. The landlord and or his agent will not be responsi&shy;ble for any  accident / injury / loss of property or loss of life that may occur by the  tenant, by other person inside the premises or due to any unex&shy;pected and / or  natural / unnatural disasters as men&shy;tioned above. The tenant agrees to  discharge the landlord and / or his agent from any such liability.</td>
    <td align="right" valign="top" style="text-align: right">يتعهد المستأجر بتأمين محتويات العقار ضد جميع الأخطار مثل الناتجة عن إنفجار أنابيب المياه والحريق والعواصف وغيرها من الكوارث الطبيعية وغير الطبيعية/ غير متوقعة ولن يكون صاحب العقار أو وكيله مسؤولا عن أية حادثه أو إصابة أو ضرر للممتلكات أو للأرواح يتعرض لها المستأجر أو الأشخاص داخل العقار بسبب أية كوارث طبيعية أو غير طبيعية والمذكورة أعلاه والمستأجر يوافق على إبراء ذمة صاحب العقار ووكيله عن مثل هذه المسئوليات</td>
  <td valign="top">.4</td>
  </tr>
  <tr>
    <td style="text-align: justify"><strong>5</strong><span dir="RTL">. </span>The landlord/agent  shall have the right to enter and inspect the demised premises during reasonable  hours and whenever deemed necessary.</td>
    <td align="right" valign="top" style="text-align: right">يحق لصاحب العقار/ الوكيل الدخول إلى العقار المستأجر بغرض التفتيش أثناء الأوقات الملائمة وحيثما كانت هنالك ضرورة لذلك</td>
  <td valign="top">.5</td>
  </tr>
  <tr>
    <td style="text-align: justify"><strong>6</strong><span dir="RTL">. </span>By signing this contract, the tenant confirms  that he has received the property and its attachments in a good condition and  undertakes that on expiry of the period of tenancy to hand back the leased  property to the landlord/agent in the same good condition. The tenant  undertakes to paint the above premises, if he vacates the premises before three  years.</td>
    <td align="right" valign="top" style="text-align: right">بالتوقيع على هذا العقد يقر المستأجر بأنه إستلم العقار وملحقاته بحالة جيدة ويتعهد بتسليم العقار إلى المالك / الوكيل بعد إنقضاء فترة التأجير بنفس تلك الحالة الجيدة ، كما يتعهد المستأجر بطلاء العين المؤجرة المذكورة أعلاه إذا أخلى العين المؤجرة قبل ثلاث سنوات</td>
  <td valign="top">.6</td>
  </tr>
   <tr><td>&nbsp;</td></tr>
   <tr><td>&nbsp;</td></tr>
   <tr><td>&nbsp;</td></tr>
   <tr><td>&nbsp;</td></tr>
   <tr><td>&nbsp;</td></tr>
  <tr>
    <td style="text-align: justify"><strong>7</strong><span dir="RTL">. </span>If the tenant wishes to vacate or want to renew  the lease for the short period (minimum fifteen days) of above premises, the  tenant should inform the landlord/agent two months in advance of the expiry of  the contract in writing by read Post, fax or email. Rent structure for short  term renewal of tenancy contract will be applicable (10% rent increase for 32 days  to 92 days and 25% rent increase for 15 days to 31 days) as per annual rent. In  case the tenant remains in possession of any of the Leased Premises after the  expiry of the Tenancy contract, then tenant has to pay 150% of the rent for the  period from expiry until you vacate all of the Leased Premises in accordance  with the Tenancy Contract.</td>
    <td align="right" valign="top" style="text-align: right">إذا رغب المستأجر في الإخلاء أو أراد تجديد عقد الإيجار لفترة قصيرة (بحد أدنى خمسة عشر يوماً) فإنه يتوجب عليه إخطار صاحب العقار/ الوكيل كتابة مقدماً قبل إنتهاء العقد بشهرين إما بالبريد المسجل أو الفاكس/ الإيميل برغبته في تجديد عقد الإيجار لفترة قصيرة والذي سيكون خاضع ل (%10 زيادة إيجار من 32 يوماً إلى 92 يوماً ول 25% زيادة إيجار من 15 يوماً إلى 31 يوم  حسب قيمة الإيجار السنوي ، وفي حالة عدم إخلاء العقار بعد إنتهاء عقد الإيجار فإن المستأجر يلتزم بدفع ماقيمته 150% من قيمة الإيجار للفترة من تاريخ إنتهاء العقد وتاريخ إخلاء العقار وفق شروط وأحكام عقد الإيجار</td>
  <td valign="top">.7</td>
  </tr>
  <tr>
    <td style="text-align: justify"><strong>8</strong>. In case if the tenant vacates or want to renew  the lease of the above premise for short period 9minimum fifteen days) and  fails to inform the landlord/agent two months before the expiry of the  contract, then tenant has to pay two months &lsquo;rent as cancellation charges plus  the rent for the short period (minimum fifteen days</td>
    <td align="right" valign="top" style="text-align: right">إذغ رغب المستأجر في إخلاء أو تجديد عقد إيجار العين المذكورة لفترة قصيرة (كحد أدنى خمسة عشر يوماً) ولم يخطر المالك/ الوكيل قبل إنتهاء العقد بشهرين فعلى المستأجر أن يدفع إيجار شهرين كغرامة إلغاء بالإضافة إلى إيجار الفترة القصيرة (كحد أدنى خمسة عشر يوماً</td>
  <td valign="top">.8</td>
  </tr>
  <tr>
    <td style="text-align: justify"><strong>9. </strong>If the tenant wishes to cancel the lease  agreement before its expiry, then the tenant has to pay minimum two months  &lsquo;rent as cancellation charges. But it will be at the sole discretion of the  landlord/agent to accept or to reject the cancellation of the lease.</td>
    <td align="right" valign="top" style="text-align: right">يجب أن يدفع المستأجر على الأقل إيجار شهرين كغرامة إلغاء عقد إذا رغب في فسخ عقد الإيجار قبل إنتهاء المدة المقررة له. ويحق لصاحب العقار/ الوكيل بشكل مطلق في أن يقبل أو يرفض إلغاء عقد الإيجار</td>
  <td valign="top">.9</td>
  </tr>
  <tr>
    <td style="text-align: justify"><strong>10</strong><span dir="RTL">. </span><span dir="RTL"><span dir="RTL"> </span></span>The landlord and/or his agent reserve the right  to increase the rent of the above property by informing the tenant one month  prior to the expiry of the contract.</td>
    <td align="right" valign="top" style="text-align: right">يحق لصاحب العقار /الوكيل المطالبة بزيادة القيمة الإيجارية للعقار المذكور أعلاه بمنح المستأجر إنذاراً بتلك الزيادة مدته شهر قبل إنتهاء عقد الإيجار</td>
  <td valign="top">.10</td>
  </tr>
    <tr>
    <td style="text-align: justify"><strong>11. </strong>In case of returned / bounced Cheque the tenant  has to pay the penalty of AED 1,000/- along with the returned Cheque amount in  cash within 3 working days of the returned Cheque, if the payment is received  within 10 days of the returned Cheque date, landlord / or his agent shall have  the right to evict the tenant and repossess the leased property and to require  the tenant to pay all the damage resulting from such breach in addition to as  the landlords/agents other rights under the provisions of this tenancy  contract. 100 Dhs (Hundred Dirhams) Daily penalty shall be applied for every  delay in repayment from the date of paying till the full settlement.</td>
    <td align="right" valign="top" style="text-align: right">في حالة إرتجاع/ ارتداد الشيك فإنه يتعين على المستأجر دفع غرامة قدرها 1,000 درهم إضافة على دفع مبلغ الشيك نقداً خلال 3 أيام عمل من تاريخ إرتجاع الشيك . وإذا لم يتم إستلام مبلغ الغرامة ومبلغ الشيك نقداً خلال 10 أيام من تاريخ إرتجاع الشيك يحق للمالك/ الوكيل في طرد المستأجر إستلام العقار المستأجر ةم طالبة المستأجر بالتعويض عن كافة الأضرار الناتجة من خرق الشروط والأحكام علاوة على إسترداد كافة حقوق صاحب العقار / الوكيل المتارتبة بموجب هذا العقد للتأجير كما تضاف غرامة يومية عن كل يوم تأخير في سداد القيمة الإيجارية من تاريخ إ‘ستحقاقها قدرها 100 درهم وذلك حتى تمام الدفع</td>
  <td valign="top">.11</td>
  </tr>
  <tr>
    <td style="text-align: justify"><p><strong>12</strong><span dir="RTL">. </span><span dir="RTL"><span dir="RTL"> </span></span>Property will be  used ONLY for the purpose of tenancy and as mentioned in the preamble of the  lease contract and the tenant shall not use the premises to carry out any  profession, trade/business, or for any illegal purposes. Advertising of any  profession, trade, business, goods or services, through any advertisement  mode/source (like notice, brochure, banner, board, etc.), is prohibited in this  resid3ential premises. The premises shall not be used for any illegal or  immoral purpose in contravention of any UAE/DUBAI regulation or by Law.</p></td>
    <td align="right" valign="top" style="text-align: right"> يجب إستخدام العقار فقط للغرض المؤجر لإجله والمذكور في صدر عقد الإيجار ويجب على المستأجر عدم إستخدام العين المؤجرة لتنفيذ أي أعمال مهنية/ تجارية أو لأي أغراض غير قانونية . ويحظر الإعلان عن أي مهنة أو تجارة أو عمل أو بضائع أو خدمات عن طريق أي طريقة / مصدر إعلاني (مثل الإخطارأوالكتيب أواللوحات الإعلانية وغيرها) في هذا المبنى السكني . كما يجب عدم إستخدام العين المؤجرة لغرض غير أخلاقي أو غير قانوني يتعارض مع أنظمة / لوائح أو قوانين إمارة دبي / دولة الإمارات العربية المتحدة</td>
  <td valign="top">.12</td>
  </tr>
  <tr>
    <td style="text-align: justify"><strong>13</strong>. The tenant should take no objection letter from  the landlord/agent before vacating the mentioned premises.</td>
    <td align="right" valign="top" style="text-align: right">على المستأجر أن يستلم خطاب عدم ممانعة من المالك / الوكيل قبل إخلاء العقار المذكور أعلاه</td>
  <td valign="top">.13</td>
  </tr>
  <tr>
    <td style="text-align: justify"><span dir="RTL"> </span><strong><span dir="RTL"><span dir="RTL"> </span>14</span></strong>. The tenant undertakes to  comply with all rules and regulations applying to the premises including but  not limited to environmental, health and safety laws regulations.</td>
    <td align="right" valign="top" style="text-align: right">يجب على المستأجر أن ينصاع لكافة القوانين واللوائح المتبعة في العقار بما في ذلك على سبيل المثال لا الحصر القوانين الخاصة بالسلامة والصحة والبيئة</td>
  <td valign="top">.14</td>
  </tr>
  <tr>
    <td style="text-align: justify"><strong>15</strong>. If the tenant commits a breach of any of the  conditions contained herein the landlord/agent shall have the right to evict  the tenant and repossess the leased property and to require the tenant to pay  all the damage resulting from such breach in addition to as the  landlords/agent&rsquo;s other rights under the provisions of this tenancy contract.</td>
    <td align="right" valign="top" style="text-align: right">إذا خرق المستأجر أياً من الشروط والأحكام المضمنة في هذه الوثيقة وملحاقتها فإنه يحق لصاحب العقار/ الوكيل طرد المستأجر والإستيلاء على العقار المستأجرر ومطالبة المستأجر بالتعويض عن كافة الأضرار الناتجة من خرق الشروط والأحكام علاوة على إسترداد كافة حقوق صاحب العقار/ الوكيل المترتبة بموجب عقد الإيجار</td>
  <td valign="top">.15</td>
  </tr>
  <tr>
    <td style="text-align: justify"><p><span dir="RTL"> </span><strong><span dir="RTL"><span dir="RTL"> </span>16</span></strong>. If the tenant wishes to vacate the leased property of leave  the country he has to inform the landlord/agent and obtain his written consent.  If the tenant evacuates the leased property without the consent of the  landlord/agent then the landlord/agent has the right to break in the lease  property as the legal owner of the property and in this case the tenant has no  right to object or complain.</p></td>
    <td align="right" valign="top" style="text-align: right">إذا رغب المستأجر في إخلاء العقار أو مغادرة الدولة فعليه أن يخطر صاحب العقار/ الوكيل للحصول على موافقته الخطية .ويحق لصاحب العقار / وكيلاه بصفته المالك القانوني أن يفتح العقار المستأجر في حالة مغادرة المستأجر للعقار دون موافقة صاحب العقار/الوكيل ولا يحق عندها للمستأجر الإعتراض أو الشكوى من هذا التصرف</td>
  <td valign="top">.16</td>
  </tr>
  <tr>
    <td style="text-align: justify"><span dir="RTL"> </span><strong><span dir="RTL"><span dir="RTL"> </span>17</span></strong>. No waiver of any terms of  the lease agreement shall be effective unless made in writing.</td>
    <td align="right" valign="top" style="text-align: right">لن يكون التنازل عن أيه شروط من إتفاقية التأجير ساري المفعول مالم يتم النص عليه كتابة</td>
  <td valign="top">.17</td>
  </tr>
  <tr>
    <td style="text-align: justify"><span dir="RTL"> </span><strong><span dir="RTL"><span dir="RTL"> </span>18</span></strong>. If recreational  facilities are provided in the premises, the tenant undertakes to obey the  rules and not to misuse these facilities. Due to unavoidable circumstances, if  the recreational facilities are under maintenance or are not functioning for  whatsoever may be the reason, the tenant shall not be entitled to claim  compensation for the same at any time.</td>
    <td align="right" valign="top" style="text-align: right">في حالة توفير مرافق للترفيه في العقار المستأجر يتعهد المستأجر بالإنصياع للقواعد المتبعة وأن لا يسيئ إستخدام تلك المرافق، في حالة كانت مرافق الترفيه تحت الصيانة أو لا تعمل لأي سبب من الأسباب فإنه لا يحق للمستأجر المطالبة في أي وقت بالتعويض عن ذلك</td>
  <td valign="top">.18</td>
  </tr>
  <tr>
    <td style="text-align: justify"><span dir="RTL"> </span><strong><span dir="RTL"><span dir="RTL"> </span>19</span>. </strong>The tenant shall give minimum 15 (fifteen) days&rsquo;  time period to the landlord/agent for the re<span dir="RTL"> </span><span dir="RTL"><span dir="RTL"> </span></span>imbursement (if any) of deposit and rent amount etc.</td>
    <td align="right" valign="top" style="text-align: right">يجب على المستأجر أن يمنح صاحب العقار/ الوكيل مهلة 15 يوم (خمسة عشر) يوماً على الأقل لإعادة مبلغ التأمين ، أو أي مبلغ آخر إن وجد</td>
  <td valign="top">.19</td>
  </tr>
  <tr>
    <td style="text-align: justify"><span dir="RTL"> </span><strong><span dir="RTL"><span dir="RTL"> </span>20</span></strong>. Tenant is allowed to keep  any pets in the premises.</td>

    <td align="right" valign="top" style="text-align: right">لا يسمح للمستأجر الإحتفاظ بالحيوانات الأليفة أو أي نوع آخر داخل العقار</td>
  <td valign="top">.20</td>
  </tr>
  
  <tr>
    <td style="text-align: justify"><span dir="RTL"> </span><strong><span dir="RTL"><span dir="RTL"> </span>21</span></strong>. Neither the landlord nor  the agent will be responsible for any injury or loss while using the swimming  pool or any other recreation facilities (if any) provided inside the building  premises.</td>
    <td align="right" valign="top" style="text-align: right">لا يتحمل صاحب العقار أو وكيله أية مسئولية عن الإصابة أو الخسائر أثناء إستخدام حوض السباحة أو أياً من مرافق الترفية الأخرى المتوفرة داخل المبني (إن وجدت)</td>
  <td valign="top">.21</td>
  </tr>
  <tr>
    <td style="text-align: justify"><span dir="RTL"> </span><strong><span dir="RTL"><span dir="RTL"> </span>22</span></strong>. The tenancy contract will  be handed over to the tenant once the cheque for the 1st rent  instalment has been cleared by the bank, and all documents required by the  landlord/agency have been submitted.</td>
    <td align="right" valign="top" style="text-align: right">لا يتم تسلم المستأجر نسخته من عقد الإيجار إلا بعد صرف شيك الدفعة الأولى للإيجار وقيام المستأجر بتسليم جميع الوثائق المطلوبة من طرف صاحب العقار/ الوكيل</td>
  <td valign="top">.22</td>
  </tr>
  <tr>
    <td style="text-align: justify"><span dir="RTL"> </span><strong><span dir="RTL"><span dir="RTL"> </span>23</span></strong>. The Arabic text shall  prevail in case of any difference in the text.</td>
    <td align="right" valign="top" style="text-align: right">إذا نشأ أي نزاع في النص فإن نص اللغة العربية هو السائد</td>
  <td valign="top">.23</td>
  </tr>
  <tr>
    <td style="text-align: justify"><span dir="RTL"> </span><strong><span dir="RTL"><span dir="RTL"> </span>24</span></strong>. The attached annex to  this tenancy contract contains additional terms and conditions which is  applicable to the tenant and shall become an integral part of tenancy contract.</td>
    <td align="right" valign="top" style="text-align: right">الملحق المرفق مععقد الإيجار يتضمن شروطوأحكام إضافية واجبة التطبيق على المستأجر وتعتبر جزء لا يتجزأ من عقد الإيجار</td>
  <td valign="top">.24</td>
  </tr>
  <tr>
    <td style="text-align: justify"><span dir="RTL"> </span><strong><span dir="RTL"><span dir="RTL"> </span>25</span></strong>. In the case that the  tenancy contract stipulates in its annexure that the tenant must pay a lump sum  amount for the electricity, and/or water, and/or chiller, it is solely the  property owner/agent decision to modified that amount at any time or ask the  tenant to contract, Dewa, and pay directly to them.</td>
    <td align="right" valign="top" style="text-align: right">في حالة نص عقد الإيجار على دفع المستأجر مبلغ مقطوع مقابل الكهرباء أو الماء أو التكييف فإنه يحق لصاحب العقار / الوكيل تعديل قيمة ذلك المبلغ المقطوع في أي وقت أو مطالبة المستأجر بالتعاقد مع ديوا ودفع قيمة إستهلاكه مباشرة لهم</td>
  <td valign="top">.25</td>
  </tr>
</table>
<div class="pagebreakdiv"></div>
<br/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="23" colspan="3"><b><u>Additional Conditions Mutually Agreed Upon as Under :</u></b></td>
  </tr>
  <tr>
    <td width="7%" valign="top">&nbsp;</td>
    <td width="4%" align="center" valign="top">•</td>
    <td valign="top" style="text-align: justify">Administration Charges: Tenant shall be responsible to pay the minimum services charges of AED 1,000/- OR 1% of the Annual Rent , whichever is higher, at each time of renewal of the Lease Agreement In favour of <b>“Al Hamar Real Estate” Branch of Shaikh Abdulla Bin Zayed Saqr Alnahyan Investment Group L.L.C.</b></td>
  </tr>
</table>
<br/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center">
    <table width="80%" border="1" cellspacing="0" cellpadding="0">
	  <tr style="background-color: #D8D8D8;">
	    <td width="9%" align="center" style="font-weight: bold"><b>Sr #</b></td>
	    <td width="59%" style="font-weight: bold"><b>Description</b></td>
	    <td width="32%" style="text-align: right; font-weight: bold;"><b>Amount (AED)</b></td>
	  </tr>
	  
	 <s:iterator var="stat" value='#request.contractdetails' >
	  <tr>
	  <%int i=0; %>
	  <s:iterator status="arr" value="#stat.split('::')" var="des">
	   <%if(i==2){%>
	    <td style="text-align: right"><s:property value="#des"/></td>
	   <%} else if(i==1){ %>
	    <td align="left"><s:property value="#des"/></td>
	    <%} else{ %>
	    <td align="center"><s:property value="#des"/></td>
		<%} i++;  %>
	  </s:iterator>
	  </tr>
	 </s:iterator>
</table></td>
  </tr>
</table>
<b>(Terms of contract)</b>
<br/><br/>
<div id="termsdiv">
  <span><b><u>General Terms & Conditions:</u></b></span>
  <ul><li>Request for adding a name in the Tenancy Contract or Transferring the Tenancy Contract to a new name will not be entertained.</li>
  <li>The tenant shall be responsible for insurance of belongings.</li>
  <li>Prior to the release of the Security Deposit, property inspection will be carried out by the maintenance team. Any repairs or damages inside the apartment should be repaired & painted by Tenant OR all shall be deducted from the Security Deposit.</li>
  <li>At time of vacating the property, the tenant shall produce the Original Final Bill (DEWA, Etisalat, Du, etc) along with all the apartment keys and access cards/remote (in any), in order to collect the security deposit.</li>
  </ul>
</div>
<b><u>Payment Details:</u></b><br/>
<table width="100%" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td width="20%" style="font-weight: bold">Description</td>
    <td width="10%" style="font-weight: bold">Date</td>
    <td width="15%" align="right" style="font-weight: bold;text-align:right;foat:right;">Amount (AED)</td>
	<td width="15%" style="font-weight: bold">Notes</td>
	<td width="10%" style="font-weight: bold">Cheque No.</td>
	<td width="10%" style="font-weight: bold">Paid To</td>
	<td width="10%" style="font-weight: bold">Payment</td>
	<td width="10%" style="font-weight: bold">Bank</td>
  </tr>
  <s:iterator var="stat" value='#request.details22' >
	  <tr>
	  <%int i=0;%>
	  <s:iterator status="arr" value="#stat.split('::')" var="des">
	   <%if(i==2){%>
	    <td style="text-align: right"><s:property value="#des"/></td>
	   <%} else{%>
	    <td align="left"><s:property value="#des"/></td>
	    <%}%>
	  </s:iterator>
	  </tr>
	 </s:iterator>
</table>
<br/><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="6" align="right">Undertake to act in accordance with this contract, and its conditions&ensp;&ensp;&ensp;</td>
  </tr>
  <tr>
    <td width="23%" height="48">&nbsp;</td>
    <td colspan="2">&nbsp;</td>
    <td colspan="2">&nbsp;</td>
    <td width="27%">&nbsp;</td>
  </tr>
  <tr>
    <td height="54" align="center" valign="top">Witness</td>
    <td colspan="2" align="center" valign="top">Witness</td>
    <td colspan="2" align="center" valign="top">Tenant&rsquo;s Signature</td>
    <td align="center" valign="top">Landlord&rsquo;s Signature </td>
  </tr>
  <tr>
    <td colspan="2" align="right">Tenant Name : _________</td>
    <td colspan="2" align="center">Building Name :&nbsp;________</td>
    <td colspan="2">Flat No : __________</td>
    </tr>
</table>

</div>
</body>
</html>

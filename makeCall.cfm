<cfquery name="loadCancel" datasource="Endeavor40">
	SELECT TOP 1  fname1, lname1, minimumAmount,  Convert(varchar, C.cancelledDate, 101) as cancelledDate, policyNum, VAP.policyID
	FROM  CancellationLog C, ViewAutoPolicy VAP 
	WHERE minimumAMount  > 0 
		AND cancelStatus = 0
		AND VAP.policyID = C.policyID
		---AND VAP.lname1 = 'EVANS'
	ORDER BY  C.CancelledDate 
</cfquery>
<cfinclude template="dollarAsString.cfm">
<cfinclude template="numberAsString.inc">

<CFHEADER NAME="Cache-Control" VALUE="no-cache">
<cfcontent Type="text/xml"><?xml version="1.0" encoding="UTF-8" ?>
<callxml version="3.0">
<call value="4787181272" maxtime="30s"/>
<on event="answer">
  <do label="B1">
<prompt value="helloMessage"/>

	
    <say voice="Spanish-Female1"><cfoutput query="loadCancel">
	#DollarAsString(minimumAmount)# before 
  
	#DayOfWeekAsString(DayOfWeek(cancelledDate))#,  #MonthAsString(datePart("M", cancelledDate))# 
	
	#datePart("D", cancelledDate)#</say>
	
	<goto value="##M_1"/>
  </do>
  
  <menu label="M_1" value="pressorsayone.wav"  choices="1, one,2, two" repeat="3">
	

  
 <on event="choice:1">
  <say> You Pressed 1 Thank you, #fname1# #lname1#  for your payment.</say>
	<wait value="5s"/>
	<hangup/>
 
 </on>
 
  <on event="choice:one">
  <say> You Said One. Thank you, #fname1# #lname1#  for your payment.</say>
	<wait value="5s"/>
	<hangup/>
 </on>
 
  <on event="choice:2">
  <say>  You Pressed 2, #fname1# #lname1#.  I think you are making a big mistake cancelling your insurance!</say>
	<wait value="5s"/>
	<hangup/>
 </on>
 
   <on event="choice:two">
  <say voice="Spanish-Female1"> You Said Two, #fname1# #lname1#.  I think you are making a big mistake cancelling your insurance!</say>
	<wait value="5s"/>
	<hangup/>
 </on>
    </menu>
  </cfoutput>
  </on>

  
</callxml>
</cfcontent>

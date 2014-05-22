<cfquery name="loadCancel" datasource="Endeavor40">
	SELECT TOP 100  fname1, lname1, minimumAmount,  Convert(varchar, C.cancelledDate, 101) as cancelledDate, policyNum, VAP.policyID
	FROM  CancellationLog C, ViewAutoPolicy VAP 
	WHERE minimumAMount  > 0 
		AND cancelStatus = 0
		AND VAP.policyID = C.policyID
	ORDER BY  C.CancelledDate DESC
</cfquery>
<cfinclude template="dollarAsString.cfm">
<cfinclude template="numberAsString.inc">


<cfoutput query="loadCancel">
    Hello #fname1# #lname1#! 
    
    This is a reminder from Endeavor General, your automobile insurance company.
    
    If we do not receive a payment of #DollarAsString(minimumAmount)# before 
  
	#DayOfWeekAsString(DayOfWeek(cancelledDate))#,  #MonthAsString(datePart("M", cancelledDate))# 
	
	#datePart("D", cancelledDate)# we will cancel your policy.
	
	If you would like to make a payment by credit card. Please press one.
	
	If you want to be a freaking loser and drive illegally press two.

    
    
    
    </cfoutput>
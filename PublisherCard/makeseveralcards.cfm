<cfparam name="asofYear" default="2012">

<cfquery name="loadPub" datasource="#application.DSN#">
	SELECT  *
FROM publisher
WHERE  EXISTS (SELECT * FROM ServiceReport SR2 WHERE sr2.publisherID = publisher.publisherID AND hours = 0 AND serviceYear=2012)
AND cardTransferedOut = 0
AND (SELECT sum(hours) FROM serviceReport SR WHERE sr.publisherID = publisher.publisherID AND serviceYear=2012) > 0
ORDER BY lname, fname
</cfquery>

	<cfset asofYear = datePart("yyyy", now())>
	<cfset yearList = "#evaluate(asofYear-1)#,#asOfYear#">
	
	<cfloop query="LoadPub">
		

			<cfinvoke component="#application.CFCPath#PublisherCard" 
					method="getCard"
					publisherID="#publisherID#"
					serviceYear="#asofYear#"
					flatten=1
					returnVariable="pdfPath">
			
				 
			<cfinvoke component="#application.CFCPath#PublisherCard" 
					method="flatten"
					source="#pdfPath#"
					returnVariable="pdfPath">
					
			<cfinvoke component="#application.CFCPath#PublisherCard" 
						method="makeImage"
						source="#pdfPath#"
						returnVariable="imagePath">
		
		<cfset imgURL = replacenocase(imagePath, "C:\Domains\timothyCunningham\", "http://beta.timothycunningham.com/")>				
		<cfoutput>
		<p style="page-break-before: always">
		In reviewing my records, I noticed there is at least one month where you have reported 0 hours.  If my records are incorrect, <i>please make <b>any</b> corrections on this card and return it the secretary.</I><br>
		Your Brother,<br>
		Timothy Cunningham<br>
		478-718-1272<br>
		<img src="#imgURL#"><hr>
		</p>
		</cfoutput>
					
	</cfloop>
				
	
			
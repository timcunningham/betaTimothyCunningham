<cfquery name="loadAll" datasource="#application.DSN#">
	SELECT publisherID
	FROM Publisher
	WHERE cardTransferedOut = 0
	ORDER BY servicegroupID, lname, fname
</cfquery>

<cfloop query="loadAll">
	<cfinclude template="publisherInformationForm.cfm">
</cfloop>

<cfpdf action="merge" directory="c:/domains/timothyCunningham/publisherCard/PDF_Form" destination="c:/domains/timothyCunningham/publisherCard/PDF_Form/pubSurvey.pdf" overwrite="yes">


<cfoutput>
	<a href="./pdf_form/pubsurvey.pdf">Publisher survey</a>
</cfoutput>
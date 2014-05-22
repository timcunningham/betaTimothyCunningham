<cfparam name="format" default="HTML">
<cfparam name="font" default="14px">
<cfparam name="width" default="80%">

<cfif format IS "PDF">
	<cfset width = "100%">
</cfif>

<cfquery name="loadPub" datasource="#application.DSN#">
	SELECT  *
	FROM Publisher P
	WHERE cardTransferedOut = 0
	ORDER BY lname, fname
</cfquery>


<cfsavecontent variable="directory" >
	
<table cellpadding="2" border="0" width="#width#" align="center">
<tr>
	<td colspan="6">
	<center><h2>Byron Congregation Publisher Directory
	</h2>
	</center>
	</td>
</tr>
<tr style="font-size:#font#">
	<td>Name</td>
	<td>Address</td>
	<td>Phone</td>
	<td>Mobile</td>
	<td>email</td>
	<td>&nbsp;</td>
</tr>
<cfoutput query="loadPub">
	<tr bgcolor="#iif(CurrentRow MOD(2) eq 1,de('ffffff'),de('dadada'))#" style="font-size:#font#">
	<td>#lname#, #fname#</td>
	<td>#address1# #city# #state# #zip#</td>
	<td>#telephone#</td>
	<td>#mobile#</td>
	<td><a href="mailto:#email#">#email#</a></td>
	<td>
		<cfif elder>Elder </cfif>
		<cfif Servant>Servant </cfif>
		<cfif Pioneer>Pioneer </cfif>
		<cfif specialPioneer>Sp Pioneer </cfif>
	</td>
</tr>
</cfoutput>
<cfif Format NEQ "PDF">
<cfoutput>
	<tr>
	<td colspan=5 style="text-align:center;"><br>List is confidential and not for general circulaton<br>
	#dateformat(now(), "mm/dd/yyyy")#</td>
	</tr>
</cfoutput>
</cfif>
</cfsavecontent>


<cfif format IS "HTML">
	<cfoutput>#directory#</cfoutput>
</cfif>

<cfif format IS "PDF">
	<cfdocument format="pdf" name="myPDF">
		<cfoutput>#directory#</cfoutput>
	</cfdocument>
	<cfpdf action="addfooter"  name="mypdf" source="mypdf" align="center" text="List is confidential and not for general circulaton. 
	#dateformat(now(), "mm/dd/yyyy")#" >
	<cfheader name="content-disposition" value="attachment; filename=""byron phone directoy.pdf"""/>
	<cfcontent type="application/pdf" variable="#toBinary(mypdf)#">
</cfif>
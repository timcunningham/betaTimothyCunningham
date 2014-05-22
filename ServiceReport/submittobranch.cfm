<cfif isdefined("action") and action IS "submit">
	
	<cfdump var="#form#">

	<cfinvoke component="#application.CFCPath#ServiceReport" 
					method="submitToBranch">

<cfoutput>All reports with more than 0 hours have been marked as submited to branch <br><br></cfoutput>
</cfif>

<!--- ******************************************************** --->


<cfoutput>
<cfform action="submitToBranch.cfm" method="post">
<input type=hidden name="action" value="submit">
<pre>
	Are you sure? <input type=submit value="yes">
</pre>
</cfform>
</cfoutput>
<cfif isdefined("action") and action IS "submit">
	
	<cfdump var="#form#">

	<cfinvoke component="#application.CFCPath#ServiceReport" 
					method="submitToBranch">

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
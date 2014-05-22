<cfif isdefined("action") and action IS "init">
	
	<cfdump var="#form#">

	<cfinvoke component="#application.CFCPath#ServiceReport" 
					method="initMonth"
					imonth="#trim(imonth)#"
					iYear="#iYear#"
					serviceYear="#serviceYear#">

</cfif>

<!--- ******************************************************** --->


<cfoutput>
<cfform action="initMonth.cfm" method="post">
<input type=hidden name="action" value="init">
<pre>
Month:			<cfinput type=text name="imonth" value="" required=true validate="integer"><br>
Year:			<cfinput type=text name="iYear" value="" required=true validate="integer"><br>
Service Year:		<cfinput type=text name="serviceYear" value="" required=true validate="integer"><br>
<input type=submit value="Init">
</pre>
</cfform>
</cfoutput>
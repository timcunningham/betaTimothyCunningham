<!doctype html>
<html>
 <body>

<cfparam name="publisherID" default =2>

<cfquery name="loadPub" datasource="#application.DSN#">
	SELECT TOP 1 *
	FROM Publisher P
	WHERE publisherID = #publisherID#
</cfquery>

<cfquery name="group" datasource="#application.DSN#">
	SELECT *
	FROM serviceGroup
</cfquery>

<cfoutput>
<form action="publisher_action.cfm" method=Post>
<table>
<tr>
	<td colspan="2">
	<center><h1>#loadPub.fname# #loadPub.lname#
	</h1>
	</center>
	</td>
</tr>

<cfloop query="loadPub">
<tr>
	<td>Group</td>
	<td>
		<select name="serviceGroupID">
			<cfloop query="group">
				<cfset value="">
				<cfif loadPub.serviceGroupID IS group.serviceGroupID>
					<cfset value="selected">
				</cfif>
				<option value="#serviceGroupID#" #value#>#groupName#</option>
			</cfloop>
			
		</select>
	</td>
</tr>	
<tr>
	<td>First</td>
	<td>
		<input type="textbox" name="fname" size=25 maxlength=25 value="#fname#">
	</td>
</tr>
<tr>
	<td>Last</td>
	<td>
		<input type="textbox" name="lname" size=25 maxlength=25 value="#lname#">
	</td>
</tr>
<tr>
	<td>Address</td>
	<td>
		<input type="textbox" name="address1" size=25 maxlength=25 value="#address1#">
	</td>
</tr>
<tr>
	<td>City</td>
	<td>
		<input type="textbox" name="City" size=25 maxlength=25 value="#City#">
	</td>
</tr>
<tr>
	<td>State</td>
	<td>
		<input type="textbox" name="state" size=25 maxlength=2 value="#state#">
	</td>
</tr>
<tr>
	<td>Zip</td>
	<td>
		<input type="textbox" name="Zip" size=25 maxlength=10 value="#Zip#">
	</td>
</tr>
<tr>
	<td>Home Phone</td>
	<td>
		<input type="textbox" name="telephone" size=25 maxlength=12 value="#telephone#"> </td>
</tr>
<tr>
	<td>Mobile Phone</td>
	<td>
		<input type="textbox" name="mobile" size=25 maxlength=12 value="#mobile#">
	</td>
</tr>
<tr>
	<td>DOB</td>
	<td>
		<input type="textbox" name="dob" size=25 maxlength=10 value="#dateformat(dob, "mm/dd/yyyy")#">
	</td>
</tr>
<tr>
	<td>Immersed</td>
	<td>
		<input type="textbox" name="dateimmersed" size=25 maxlength=10 value="#dateFormat(dateimmersed, "mm/dd/yyyy")#"> </td>
</tr>
<tr>
	<td>Email</td>
	<td>
		<input type="textbox" name="email" size=25 maxlength=50 value="#email#"> </td>
</tr>

<tr>
	<td>Anointed</td>
	<td>
		<cfset value =""><cfif anointed IS 1><cfset value ="checked"></cfif>
		<input type="checkbox" name="anointed" value=1 #value#></td>
</tr>
<tr>
	<td>Other Sheep</td>
	<td>
		<cfset value =""><cfif othersheep IS 1><cfset value ="checked"></cfif>
		<input type="checkbox" name="othersheep" value=1 #value#></td>
</tr>
<tr>
	<td>Elder</td>
	<td>
		<cfset value =""><cfif elder IS 1><cfset value ="checked"></cfif>
		<input type="checkbox" name="elder" value=1 #value#></td>
</tr>
<tr>
	<td>Servant</td>
	<td>
		<cfset value =""><cfif servant IS 1><cfset value ="checked"></cfif>
		<input type="checkbox" name="servant" value=1 #value#></td>
</tr>
</tr>
<tr>
	<td>Special Pioneer</td>
	<td>
		<cfset value =""><cfif SpecialPioneer IS 1><cfset value ="checked"></cfif>
		<input type="checkbox" name="SpecialPioneer" value=1 #value#></td>
</tr>
<tr>
	<td>Pioneer</td>
	<td>
		<cfset value =""><cfif Pioneer IS 1><cfset value ="checked"></cfif>
		<input type="checkbox" name="Pioneer" value=1 #value#></td>
</tr>
<tr>
	<td>Transferred</td>
	<td>
		<cfset value =""><cfif cardTransferedOut IS 1><cfset value ="checked"></cfif>
		<input type="checkbox" name="cardTransferedOut" value=1 #value#></td>
</tr>
<tr>
	<td>Gender</td>
	<td>
		<cfset value =""><cfif Gender IS "M"><cfset value ="checked"></cfif>
		<input type="radio" name="gender" value="M" #value#>Male &nbsp;
		&nbsp;
		&nbsp;
		<cfset value =""><cfif Gender IS "F"><cfset value ="checked"></cfif>
		<input type="radio" name="gender" value="F" #value#>Female 	
	
	</td>
</tr>
</cfloop>
<tr>
	<td colspan=2>
		<input type=submit value="submit">
		<input type=hidden name="publisherID" value="#publisherID#">
	</td>
</tr>
<tr>
	<td colspan=2>
		<a href="../publisherCard/publisherList.cfm">Publisher List</a>
	</td>
</tr>

</form>

</cfoutput>

</body>
</html>
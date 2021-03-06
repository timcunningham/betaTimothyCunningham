<cfparam name="serviceGroupID" default="16">
<cfquery name="loadGroup" datasource="#application.DSN#">
	SELECT *
	FROM serviceGroup
	WHERE serviceGroupID = #serviceGroupID#
</cfquery>


<cfquery name="load" datasource="#application.DSN#">
	SELECT iYear, iMonth, sum(hours) as totalHours, avg(convert(money,hours)) avgHours, count(*)  as publishersWithTime,
		avg(convert(money,mags)) as avgMags, avg(convert(money,rv)) as avgRV,  avg(Convert(money, bs))  as avgBS, sum(Convert(float, bs)) as totalBS
	FROM serviceReport
	WHERE serviceGroupID = #serviceGroupID#
		AND submittedToBranch = 1
		AND hours > 0
	GROUP BY iYear, iMonth
	ORDER BY iYear, iMonth
</cfquery>





<cfoutput>
<STYLE TYPE="text/css">
<!--
/* 
	Classy yet somehow fancy
	table style created by Radu Bilei
	for Chris Heilmann's CSS Table Gallery
	http://twitter.com/radubilei
	http://icant.co.uk/csstablegallery
*/

table,th,td	{	border:none;  border-collapse:collapse; font-family:corbel,'helvetica neue','trebuchet ms',arial,helvetica,sans-serif; font-size:1em; line-height:1.5em}
table		{	background:black; -webkit-border-radius:6px; -moz-border-radius:6px; border-radius:6px; -webkit-box-shadow:1px 1px 10px rgba(0,0,0,0.3); -moz-box-shadow:1px 1px 10px rgba(0,0,0,0.3)}
caption		{	text-align:left; text-transform:uppercase; font-size:150%; font-weight:bold; padding:1.5em 0; color:black}

thead, 
tfoot			{	color:white; }

thead th				{	padding:0.5em 1em; text-transform:uppercase; text-align:left; }
thead th:first-child	{	width:10em; text-align:right; }

tbody td,
tbody th				{	font-size:100%; padding:0.5em 1em; background-color:##e5e5e5; vertical-align:top}
tbody th				{	color:##222;	text-align:right; background-image:url(tabel.png); background-repeat:repeat-y; border-right:1px solid ##ccc}
tbody td:last-child		{	border-right:1px solid black}

tbody tr.odd th, 
tbody tr.odd td			{	background-color:##eee; color:##222}

tfoot td,
tfoot th				{	border:none; padding:0.5em 1em 2em; font-size:130%}
tfoot th				{	text-align:right}

table a:link	{	line-height:1em; color:black; display:inline-block; padding:3px 7px; margin:-3px -7px}
table a:visited	{	color:##555}
table a:hover	{	text-decoration:none; background:black; color:white; -webkit-border-radius:4px; -moz-border-radius:4px; border-radius:4px}

::-moz-selection{	background:##202020; color:white}
::selection		{	background:##202020; color:white}

thead ::-moz-selection, 
tfoot ::-moz-selection	{	background:white; color:##202020}
thead ::selection, 
tfoot ::selection		{	background:white; color:##202020}
-->
</STYLE>
</head>

<table>
<thead colspan=20>
	<td>#loadGroup.groupName# Group Averages</td>
</thead>
<thead>
	<td>Year</td>
	<td>Month</td>
	<td>Total Hours</td>
	<td>Avg Hours *</td>
	<td>Avg Mags</td>
	<td>Avg RV</td>
	<td>Avg BS</td>
	<td>Total BS</td>
	<td>Publisher<br>Count*</td>
</thead>

<cfloop query="load">
<tr>
	<td>#iYear#</td>
	<td>#iMonth#</td>
	<td>#totalHours#</td>
	<td>#avgHours#</td>
	<td>#avgMags#</td>
	<td>#avgRV#</td>
	<td>#AvgBS#</td>
	<td>#totalBs#</td>
	<td>#publishersWithTime#</td>
</tr>
</cfloop>
<tfoot>
<td colspan=20>
	* Numbers only include those who reported 1 hour or more.
</td>
</tfoot>
</table>




</cfoutput>
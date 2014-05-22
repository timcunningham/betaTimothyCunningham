<cfquery name="loadGroup" datasource="#application.DSN#">
	SELECT *
	FROM serviceGroup
	ORDER BY groupName
</cfquery>
<cfdump var="#loadGroup#">

 

<cfform format="html" action="default_action.cfm">
	First Name:<cfinput type="text" name="fname" label="First Name" size=15 maxlength=25 required="yes"><br>
	Last Name:<cfinput type="text" name="lname" label="Last Name" size=15 maxlength=25 required="yes"><br>
	address1:<cfinput type="text" name="address1" label="Address" size=15 maxlength=50><br>
	city:<cfinput type="text" name="city" label="city" size=15 maxlength=25><br>
	state:<cfinput type="text" name="state" label="state" size=15 maxlength=2><br>
	zip:<cfinput type="text" name="zip" label="zip" size=15 maxlength=10 validate="zipcode"><br>
	telephone:<cfinput type="text" name="telephone" label="telephone" size=15 maxlength=25 validate="telephone"><br>
	mobile:<cfinput type="text" name="mobile" label="mobile" size=15 maxlength=25 validate="telephone"><br>
	email:<cfinput type="text" name="email" label="email" size=15 maxlength=50 validate="email"><br>
	gender:<cfinput type="text" name="gender" label="Gender" size=15 maxlength=1><br>
	DOB:<cfinput type="text" name="DOB" label="DOB" size=15 maxlength=25 validate="date"><br>
	Date Immersed:<cfinput type="text" name="DateImmersed" label="Date Immersed" size=15 maxlength=25 validate="date"><br>
	
	
	Service Group:<cfselect name="serviceGroupID"
		size=1 required="yes" Message="Select a Service Group"
		query="loadGroup" display="GroupName" value="serviceGroupID"
		queryPosition="Below" width="125">
		<option value=1>Choose Group</option>
	</cfselect><br>
	<cfinput type="checkbox" name="anointed" label="anointed" value=1>anointed<br>
	<cfinput type="checkbox" name="othersheep" label="othersheep" value=1 checked>othersheep<br>
	<cfinput type="checkbox" name="servant" label="servant" value=1>servant<br>
	<cfinput type="checkbox" name="elder" label="elder" value=1>elder<br>
	<cfinput type="checkbox" name="pioneer" label="pioneer" value=1>pioneer<br>
	<cfinput type="checkbox" name="PioneerSchool" label="Pioneer School">pioneer school<br>
	<cfinput type="text" name="PioneerSchoolYear" label="Pioneer School Year" size=15 maxlength=4>Pioneer School Year<br>
	<cfinput type="checkbox" name="cardTransferedOut" label="cardTransferedOut">Card Transfered Out<br>
	<cfinput type="hidden" name="actionType" value="insert"><br>
	<cfinput type="submit" name="submit" label="Add Publisher" value="Add Publisher"><br>
	

</cfform>

<html>
<head>
<title>Custom Toolbars Example</title>

<script type="text/javascript" src="http://beta.timothycunningham.com/CFIDE/scripts/ajax/ext/package/toolbar/toolbar.js"></script>

<script type="text/javascript">
function init(){
      grid = ColdFusion.Grid.getGridObject("PubGrid");
      var gridFoot = grid.getView().getFooterPanel(true);
      var gridHead = grid.getView().getHeaderPanel(true);
      
      var bbar = new Ext.Toolbar(gridFoot);
      var tbar = new Ext.Toolbar(gridHead);
      
      bbar.add(new Ext.Toolbar.TextItem('Total Artists: ' + grid.getDataSource().totalLength));
      
      tbar.addButton({
       text:"Add New Artist",
       cls:"x-btn-text-icon",
       icon:"add.png",
       handler:onAdd
      });
      tbar.addSeparator()
      tbar.addButton({
       text:"Delete Artist",
       cls:"x-btn-text-icon",
       icon:"delete.png",
       handler:onDelete
      });
      
      console.log(tbar);
      console.log(bbar);

}

function onAdd(button,event){
alert("Row Added");

console.log(button);
console.log(event);
}
function onDelete(){ 
var grid = ColdFusion.Grid.getGridObject("PubGrid");
var record = grid.getSelections(); 
alert("Artist " + record[0].data.FIRSTNAME + " " + record[0].data.LASTNAME + " deleted");
}
</script>
</head>
<body>

<cfquery name="getPubs" datasource="#application.DSN#">
SELECT *
FROM Publisher
ORDER BY publisherID DESC
</cfquery>

<cfset args = structNew()>
<cfset args.name = "PubGrid">
<cfset args.format = "html">
<cfset args.query = "getPubs">
<cfset args.stripeRows = true>
<cfset args.selectMode = "Edit">
<cfset args.selectColor = "##D9E8FB">

<cfform action="test.cfm">
   <cfgrid attributeCollection="#args#">
      <cfgridcolumn name="publisherID" display="false">
      <cfgridcolumn name="fname" header="First Name">
      <cfgridcolumn name="lname" header="Last Name">
      <cfgridcolumn name="email" header="Email Address">
      <cfgridcolumn name="address1" header="Address"> 
      <cfgridcolumn name="city" header="City"> 
      <cfgridcolumn name="state" header="State"> 
      <cfgridcolumn name="zip" header="Zip"> 
	  <cfgridcolumn name="cardTransferedOut" header="cardTransferedOut"> 
   </cfgrid>
   <input type="submit">
</cfform>

<cfset ajaxOnLoad("init")>



<cfsavecontent variable="head">
<link href="/CFIDE/scripts/ajax/ext/resources/css/ytheme-aero.css" rel="stylesheet" type="text/css">
<link href="/CFIDE/scripts/ajax/ext/resources/css/menu.css" type="text/css" rel="stylesheet"/>
</cfsavecontent>

<cfhtmlhead text="#head#">

</body>
</html>
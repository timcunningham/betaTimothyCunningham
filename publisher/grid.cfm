<html>
<head>
<title>Custom Toolbars Example</title>

<script type="text/javascript" src="/CFIDE/scripts/ajax/ext/package/toolbar/toolbar.js"></script>

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
</cfquery>

<cfset args = structNew()>
<cfset args.name = "PubGrid">
<cfset args.format = "html">
<cfset args.query = "getPubs">
<cfset args.stripeRows = true>
<cfset args.selectColor = "##D9E8FB">

<cfform>
   <cfgrid attributeCollection="#args#">
      <cfgridcolumn name="publisherID" display="false">
      <cfgridcolumn name="fname" header="First Name">
      <cfgridcolumn name="lname" header="Last Name">
      <cfgridcolumn name="email" header="Email Address">
      <cfgridcolumn name="address1" header="Address"> 
      <cfgridcolumn name="city" header="City"> 
      <cfgridcolumn name="state" header="State"> 
      <cfgridcolumn name="zip" header="Zip"> 
   </cfgrid>
</cfform>

<cfset ajaxOnLoad("init")>



<cfsavecontent variable="head">
<link href="/CFIDE/scripts/ajax/ext/resources/css/ytheme-aero.css" rel="stylesheet" type="text/css">
<link href="/CFIDE/scripts/ajax/ext/resources/css/menu.css" type="text/css" rel="stylesheet"/>
</cfsavecontent>

<cfhtmlhead text="#head#">

</body>
</html>
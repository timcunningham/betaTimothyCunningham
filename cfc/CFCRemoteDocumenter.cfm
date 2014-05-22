<!--- 
CFCRemoteDocumenter

This file is designed to be included into a CFC to allow easy self-documentation.  It was inspired by a few people complaining that the CFC Explorer utility does not work right in multi-homed environments when requesting CFC documentation outside of the web root.

The primary function is getDocumentation() -- this is a remote function, so it can be called via a web browser with a URL like:

http://YOURDOMAIN/yourCFC.cfc?function=getDocumentation

By default, this will only document REMOTE functions -- to have it document other functions, create a variable in your constructor called instance.documentedAccessLevels and make it a comma delimited list of the access levels you want to document.  For instance, if you want to document both remote and public functions, you would put this in your CFC constructor:

<cfset instance.documentedAccessLevels = "remote,public">


Copyright 2003, Nathan Dintenfass (http://nathan.dintenfass.com).  All Rights Reserved.

You may use this code freely provided the copyright notice above, the copyright notice in the comments of the generated HTML, and the copyright notice displayed in the HTML remain intact.  If you use this for commercial purposes, you are not required to pay any royaltees, but I sure would appreciate it if you would!

USE OF THIS CODE IS AT YOUR OWN RISK.  NO WARRANTY IS EXPRESSED OR IMPLIED, AND NATHAN DINTENFASS ASSUMES NO LIABILITY FOR THE RESULT OF USING THIS CODE.  BY USING THIS CODE YOU AGREE TO INDEMNIFY AND HOLD NATHAN DINTENFASS HARMLESS FROM ANY LIABILITY, CLAIM OR DEMAND ARISING OUT OF YOUR USE OF THIS CODE.

Comments are welcomed at: nathan AT changemedia DOT com
 --->
 
<!--- this the function used by the outside world to generate the documentation --->
<cffunction name="getDocumentation" access="remote" output="yes" hint="Returns an HTML string of documentation">
<!--- grab the data for this component --->
<cfset var data = cfcDocumenter_getAllData()>
<!--- for looping, etc. --->
<cfset var ii = 0>
<cfset var jj = 0>
<cfset var kk = 0>
<cfset var thisThing = "">
<cfset var otherAttributes = structNew()>
<cfset var accessLevelLookup = structNew()>
<cfset var accessLevelsToShow = structNew()>
<cfset var methodsToShow = structNew()>
<!--- param the list of accessLevels to show --->
<cfparam name="instance.documentedAccessLevels" default="remote">
<!--- build a lookup struct for functions based on accessLevels --->
<cfscript>
	accessLevelsToShow = listToArray(instance.documentedAccessLevels);
	accessLevelLookup.remote = structNew();
	accessLevelLookup.public = structNew();
	accessLevelLookup.package = structNew();
	accessLevelLookup.private = structNew();
	for(ii in data.functions){
		accessLevelLookup[data.functions[ii].method.access][ii] = data.functions[ii].method.name;
	}
</cfscript>
<!-- Documentation created by CFCRemoteDocumenter, a script by Nathan Dintenfass (http://nathan.dintenfass.com) -->
<!-- The look and feel and underlying code is Copyright 2003, Nathan Dintenfass, All Rights Reserved -->
<!-- The information about the web service and/or ColdFusion Component is copyright the author of that service -->
<!-- Comments about CFCRemoteDocumenter are welcomed at: nathan AT changemedia DOT com -->
<!--- don't show debugging output --->
<cfsetting showdebugoutput="No">
<!--- THE START OF THE HTML PAGE --->
<html>
	<head>
		<title>Documentation for: #data.name#</title>
		<!--- THE CSS WE USE TO MAKE IT ALL PRETTY --->
		<style type="text/css">
			body{
				font-family: verdana,arial,helvetica,sans-serif;
				font-size: xx-small;
				margin: 0px;
				padding-left: 15px;
				padding-right: 15px;
				padding-top: 15px;
				padding-bottom: 15px;				
			}
			table.box{
				font-family: verdana,arial,helvetica,sans-serif;
				font-size: xx-small;			
				border: 2px solid ##333333;
				width: 100%;
				border-collapse: collapse;
				margin-bottom: 15px;
			}
			table.arguments{
				font-family: verdana,arial,helvetica,sans-serif;
				font-size: xx-small;			
				border: 1px solid ##CCCCCC;
				width: 100%;
				border-collapse: collapse;
				margin: 0px;
			}			
			td.header{
				background: ##326363;
				color: ##FFFFFF;
				font-weight: bold;
				border: 1px solid ##003333;
				padding: 3px;
				white-space: nowrap;
			}
			td.subheader{
				background: ##dee7cb;
				color: ##000000;
				font-weight: bold;
				border: 1px solid ##666666;
				padding: 3px;
				white-space: nowrap;
			}			
			td.label{
				background: ##EEEEEE;
				border: 1px solid ##CCCCCC;
				padding: 3px;
				width: auto; 
				white-space: nowrap; 
			}
			td.text{
				border: 1px solid ##CCCCCC;
				padding: 3px;
			}
			td.argument{
				background: ##CCCCCC;
				color: ##000000;
				font-weight: bold;
				border: 1px solid ##CCCCCC;
				padding: 3px;
				white-space: nowrap;
			}				
			.prominent{
				font-weight: bold;
				color: ##000099;
			}
			.subdued{
				color: ##666666;
				font-weight: lighter;
			}
			.hint{
				font-style: italic;
			}
			a:link{
				color: ##990033;
			}		
			a:visited{
				color: ##990033;
			}	
			a:active{
				color: ##990033;
			}	
			a:hover{
				color: ##cc3300;
			} 
		</style>
	</head>
	<body>
	
		<a name="top"></a>
		<!--- START WITH SOME BASIC INFORMATION SUCH AS NAME, LAST UPDATED, ETC. --->
		<table class="box">
			<colgroup>
				<col style="width: auto; white-space: nowrap;">
				<col style="width: 99%;">
			</colgroup>
			<tr>
				<td class="header" colspan="2">
					BASIC INFORMATION
				</td>
			</tr>
			<tr>
				<td class="subheader" colspan="2">
					STANDARD INFORMATION
				</td>
			</tr>
			<tr>
				<td class="label">Name:</td>
				<td class="text">
					#data.name#
					<cfif data.fullName NEQ data.name>
						(#data.fullName#)
					</cfif>
				</td>
			</tr>
			<tr>
				<td class="label">Hint:</td>
				<td class="text">#data.hint#&nbsp;</td>
			</tr>
			<tr>
				<td class="label">WSDL:</td>
				<td class="text"><a href="#data.wsdlURL#">#data.wsdlURL#</a></td>
			</tr>
			<tr>
				<td class="label">Last Modified:</td>
				<td class="text">#dateFormat(data.CFCDOCUMETER_DATELASTMODIFIED,"long")# #timeFormat(data.CFCDOCUMETER_DATELASTMODIFIED,"HH:mm:ss")# UTC</td>
			</tr>			
			<!--- SHOW ANY EXTRA ATTRIBUTES OF THE CFCOMPONENT TAG --->
			<cfscript>
				//a struct to hold any additional attributes of CFCOMPONENT
				otherAttributes = structCopy(data);
				structDelete(otherAttributes,"name");
				structDelete(otherAttributes,"fullname");
				structDelete(otherAttributes,"hint");
				structDelete(otherAttributes,"wsdlURL");
				structDelete(otherAttributes,"properties");
				structDelete(otherAttributes,"functions");
				structDelete(otherAttributes,"CFCDOCUMETER_DATELASTMODIFIED");	
			</cfscript>
			<cfif structCount(otherAttributes)>
				<tr>
					<td class="subheader" colspan="2">
						OTHER INFORMATION
					</td>
				</tr>	
				<cfloop collection="#otherAttributes#" item="ii">
					<tr>
						<td class="label">#ii#:</td>
						<td class="text">#otherAttributes[ii]#</td>
					</tr>						
				</cfloop>
			</cfif>
		</table>
		<!--- SHOW THE PROPERTIES --->
		<table class="box">
			<tr>
				<td class="header" colspan="6">
					PROPERTIES
				</td>
			</tr>
			<tr>
				<td class="subheader">NAME</td>
				<td class="subheader">TYPE</td>
				<td class="subheader">REQUIRED</td>
				<td class="subheader">DEFAULT</td>
				<td class="subheader">IMPLEMENTED IN</td>
				<td class="subheader">OTHER ATTRIBUTES</td>
			</tr>
			<cfloop collection="#data.properties#" item="ii">
				<cfscript>
					//make a struct that will hold any additional attributes
					otherAttributes = duplicate(data.properties[ii].property);
					structDelete(otherAttributes,"name");
					structDelete(otherAttributes,"hint");
					structDelete(otherAttributes,"type");
					structDelete(otherAttributes,"required");
					structDelete(otherAttributes,"default");
				</cfscript>
				<tr>
					<td class="text">
						<span class="prominent">#data.properties[ii].property.name#</span>
						<cfif len(trim(data.properties[ii].property.hint))>
							<br />
							<span class="hint">#data.properties[ii].property.hint#</span>
						</cfif>
					</td>
					<td class="text">#data.properties[ii].property.type#</td>
					<td class="text">#data.properties[ii].property.required#&nbsp;</td>
					<td class="text">#data.properties[ii].property.default#&nbsp;</td>
					<td class="text">#data.properties[ii].implementedIn#</td>
					<td class="text">
						<cfset count = 0>
						<cfloop collection="#otherAttributes#" item="jj">
							<cfset count = count + 1>
							<span style="font-weight:bold">#lcase(jj)#</span> = #otherAttributes[jj]#
							<cfif count LT structCount(otherAttributes)>
								<br />
							</cfif>
						</cfloop>
						&nbsp;
					</td>
				</tr>
			</cfloop>
		</table>
		<!--- SHOW A SUMMARY OF ALL THE METHODS IN THIS COMPONENT THAT ARE IN THE ACCESS LEVELS WE ARE DISPLAYING --->
		<table class="box">
			<tr>
				<td class="header">
					METHOD SUMMARY
				</td>
			</tr>
			<cfloop from="1" to="#arrayLen(accessLevelsToShow)#" index="ii">
				<tr>
					<td class="subheader">
						#uCase(accessLevelsToShow[ii])# METHODS
					</td>
				</tr>
				<cfloop collection="#accessLevelLookup[accessLevelsToShow[ii]]#" item="jj">
					<cfset thisThing = data.functions[accessLevelLookup[accessLevelsToShow[ii]][jj]]>
					<cfset methodsToShow[thisThing.method.name] = thisThing.method.name>
					<tr>
						<td class="text">
							<span class="prominent">#thisThing.method.name#(</span>
							<cfloop from="1" to="#arrayLen(thisThing.method.parameters)#" index="kk">
								#cfcDocumenter_parameterSummaryFormat(thisThing.method.parameters[kk],kk IS 1)#
							</cfloop>
							<span class="prominent">)</span>
							<cfif len(trim(thisThing.method.hint))>
								<br />
								<span class="hint">#thisThing.method.hint#</span>
							</cfif>							
							<br />&nbsp;&nbsp;&nbsp;&nbsp;<span class="subdued">return type:</span> <span style="font-style:italic;">#thisThing.method.returnType#</span>					
							

							<br />&nbsp;&nbsp;&nbsp;&nbsp;[<a href="###thisThing.method.name#">detail on: #thisThing.method.name#()</a>]
						</td>
					</tr>
				</cfloop>
			</cfloop>
		</table>
		<!--- show details for all methods --->
		<table class="box">
			<colgroup>
				<col style="width: auto; white-space: nowrap;">
				<col style="width: 99%">
			</colgroup>				
			<tr>
				<td class="header" colspan="2">
					METHOD DETAILS
				</td>
			</tr>
			
			<cfloop collection="#methodsToShow#" item="ii">
				<cfset thisThing = data.functions[ii]>
				<tr>
					<td class="subheader" colspan="2">
						<a name="#thisThing.method.name#" id="#thisThing.method.name#">#thisThing.method.name#</a>&nbsp;&nbsp;&nbsp;&nbsp;<span class="subdued">[<a href="##top">top</a>]</span>
					</td>
				</tr>
				<tr>
					<td class="label">Hint:</td>
					<td class="text"><span class="hint">#thisThing.method.hint#</span></td>
				</tr>
				<tr>
					<td class="label">Access:</td>
					<td class="text">#thisThing.method.access#</td>
				</tr>
				<tr>
					<td class="label">Return&nbsp;Type:</td>
					<td class="text">#thisThing.method.returnType#</td>
				</tr>
				<tr>
					<td class="label">Output:</td>
					<td class="text">#thisThing.method.output#</td>
				</tr>				
				<tr>
					<td class="label">Implemented&nbsp;In:</td>
					<td class="text">#thisThing.implementedIn#</td>
				</tr>					
				
				<tr>
					<td class="label" valign="top">
						Arguments:
					</td>
					<td class="text">
						<cfif arrayLen(thisThing.method.parameters)>
							<table class="arguments">
								<colgroup>
									<col style="width: auto; white-space: nowrap;">
									<col style="width: 99%">
								</colgroup>									
								<cfloop from="1" to="#arrayLen(thisThing.method.parameters)#" index="jj">	
									<tr>
										<td class="argument" colspan="2">
											#thisThing.method.parameters[jj].name#
										</td>
									</tr>
									<tr>
										<td class="label">Hint:</td>
										<td class="text"><span class="hint">#thisThing.method.parameters[jj].hint#</span></td>
									</tr>									
									<tr>
										<td class="label">Type:</td>
										<td class="text">#thisThing.method.parameters[jj].type#</td>
									</tr>
									<tr>
										<td class="label">Required:</td>
										<td class="text">#yesNoFormat(thisThing.method.parameters[jj].required)#</td>
									</tr>
									<cfif structKeyExists(thisThing.method.parameters[jj],"default")>
										<tr>
											<td class="label">Default:</td>
											<td class="text">#thisThing.method.parameters[jj].default#</td>
										</tr>										
									</cfif>							
									<cfscript>
										//make a struct that will hold any additional attributes
										otherAttributes = duplicate(thisThing.method.parameters[jj]);
										structDelete(otherAttributes,"name");
										structDelete(otherAttributes,"hint");
										structDelete(otherAttributes,"type");
										structDelete(otherAttributes,"required");
										structDelete(otherAttributes,"default");
									</cfscript>								
									<!--- if there are other attributes to show, show them --->
									<cfif structCount(otherAttributes)>
										<tr>
											<td class="label" valign="top">Other&nbsp;Attributes:</td>
											<td class="text">
												<cfset count = 0>
												<cfloop collection="#otherAttributes#" item="kk">
													<cfset count = count + 1>
													<span style="font-weight:bold">#lcase(kk)#</span> = #otherAttributes[kk]#
													<cfif count LT structCount(otherAttributes)>
														<br />
													</cfif>
												</cfloop>
											</td>
										</tr>
									</cfif>		
								</cfloop>			
							</table>
						</cfif>
					</td>
				</tr>
				<!--- now, let's see if there are any extra attributes for this method --->
				<cfscript>
					//make a struct that will hold any additional attributes
					otherAttributes = duplicate(thisThing.method);
					structDelete(otherAttributes,"name");
					structDelete(otherAttributes,"hint");
					structDelete(otherAttributes,"access");
					structDelete(otherAttributes,"output");
					structDelete(otherAttributes,"parameters");
					structDelete(otherAttributes,"returnType");
				</cfscript>
				<!--- if there are other attributes to show, show them --->
				<cfif structCount(otherAttributes)>
					<tr>
						<td class="label" valign="top">Other&nbsp;Attributes:</td>
						<td class="text">
							<cfset count = 0>
							<cfloop collection="#otherAttributes#" item="kk">
								<cfset count = count + 1>
								<span style="font-weight:bold">#lcase(kk)#</span> = #otherAttributes[kk]#
								<cfif count LT structCount(otherAttributes)>
									<br />
								</cfif>
							</cfloop>
						</td>
					</tr>
				</cfif>		
			</cfloop>			
		</table>
		<div class="subdued" style="text-align:center">
			This Document Created With <a href="http://www.changemedia.org/cfcremotedocumenter">CFCRemoteDocumenter</a> by <a href="http://nathan.dintenfass.com">Nathan Dintenfass</a>.<br />
			Unauthorized use of the content on this page is strictly prohibited.
			
		</div>
		
		<!-- THESE LINE BREAKS ARE HERE SO THE ANCHOR LINKS WORK ALL THE WAY TO THE BOTTOM-->
		#repeatString("<br />",400)#
	</body>	
</html>
</cffunction> 
<!--- this function provides a data structure with all the properties, functions, name and path --->
<cffunction name="cfcDocumenter_getAllData" access="private" output="yes" returnType="struct" hint="a function that gets a data struct of all the information for this component in a nice, usable fashion">
	<!--- grab the hierarchy of inheritance --->
	<cfset var hierarchy = cfcDocumenter_getHierarchy()>
	<!--- for looping --->
	<cfset var ii = 0>
	<!--- structs to hold the information -- starting with the keys to the current component --->
	<cfset var allData = structNew()>
	<cfset var otherComponentMeta = structNew()>
	<!--- do a CFDIRECTORY lookup to get the dateLastModified on this file --->
	<cfset var fileInfo = "">
	<cfdirectory action="list" name="fileInfo" directory="#getDirectoryFromPath(hierarchy[1].path)#" filter="#getFileFromPath(hierarchy[1].path)#">
	<cfscript>
		//set up default values in the data struct
		allData.hint = "";
		//since we can't duplicate() metaData AND since changes to meta data persist on the server, we need to do the brute-force method of getting a copy of the meta data
		for(ii in hierarchy[1]){
			allData[ii] = hierarchy[1][ii];
		}
		//set the dateLastModified
		allData.CFCDocumeter_dateLastModified = dateAdd("s",getTimeZoneInfo().utcTotalOffset,fileInfo.dateLastModified[1]);
		//clean up the allData struct by removing the extraneous keys
		structDelete(allData,"extends");
		structDelete(allData,"type");
		structDelete(allData,"path");
		//massage the name
		allData.fullName = allData.name;
		allData.name = listLast(allData.name,".");
		allData.wsdlURL = "http://" & cgi.http_host & cgi.script_name & "?wsdl";
		//set up some structs to hold the data
		allData.properties = structNew();
		allData.functions = structNew();
		//loop through the ancestor hierarchy, populating the data structures
		//we loop backwards, so that we can override functions and properties with the "younger" components
		for(ii = arrayLen(hierarchy); ii GTE 1; ii = ii - 1){
			structAppend(allData.properties,cfcDocumenter_getProperties(hierarchy[ii]),true);
			structAppend(allData.functions,cfcDocumenter_getFunctions(hierarchy[ii]),true);
		}
	</cfscript>
	<!--- return the data --->
	<cfreturn allData>
</cffunction>
<!--- get an array of the ancestor hierarchy, starting with "this" --->
<cffunction name="cfcDocumenter_getHierarchy" access="private" output="no" returnType="array" hint="gives an array of meta data structs in the order of the ancestor hierarchy">
	<cfset var ii = 0>
	<cfset var hierarchy = arrayNew(1)>
	<cfset var thisMeta = getMetaData(this)>
	<cfscript>
		//traverse the meta data, appending the array of meta data structs as we move up the inheritance hierarchy
		while(structKeyExists(thisMeta,"extends")){
			arrayAppend(hierarchy,thisMeta);
			thisMeta = thisMeta.extends;
		}
	</cfscript>
	<cfreturn hierarchy>
</cffunction>
<!--- get the properties from a specific meta data or component instance (by default, this) --->
<cffunction name="cfcDocumenter_getProperties" access="private" output="no" returnType="struct" hint="get the properties from a specific meta data or component instance (by default, this)">
	<cfargument name="metaDataToCheck" required="no" default="#getMetaData(this)#">
	<cfset var ii = 1>
	<cfset var theseProperties = structnew()>
	<cfset var thisProperty = structNew()>	
	<cfscript>
		//if this metaData has properties, loop through them, populating a struct of properties
		if(structKeyExists(arguments.metaDataToCheck,"properties")){
			for(ii = 1; ii LTE arrayLen(arguments.metaDataToCheck.properties); ii = ii + 1){
				thisProperty = structNew();
				//set up the defaults for thisProperty
				thisProperty.name = "";
				thisProperty.type = "";
				thisProperty.required = "";
				thisProperty.default = "";
				thisProperty.hint = "";				
				//now override with the actual values
				structAppend(thisProperty,arguments.metaDataToCheck.properties[ii],true);
				//stick this property in the theseProperties struct
				theseProperties[thisProperty.name] = structNew();
				theseProperties[thisProperty.name].implementedIn = arguments.metaDataToCheck.name;
				theseProperties[thisProperty.name].property = thisProperty;
			}
		}
	</cfscript>
	<!--- return the struct of properties collected --->
	<cfreturn theseProperties>
</cffunction> 
<!--- get the functions from a specific meta data or component instance (by default, this) --->
<cffunction name="cfcDocumenter_getFunctions" access="private" output="no" returnType="struct" hint="get the functions from a specific meta data or component instance (by default, this)">
	<cfargument name="metaDataToCheck" required="no" default="#getMetaData(this)#">
	<cfset var ii = 1>
	<cfset var jj = 1>
	<cfset var kk = 1>
	<cfset var thisParameter = structNew()>
	<cfset var theseFunctions = structnew()>
	<cfset var thisFunction = structNew()>	
	<cfset var defaultArgument = structNew()>
	<cfscript>
		//here are the default keys for a function argument
		defaultArgument.type = "any";
		defaultArgument.required = false;
		defaultArgument.hint = "";
		
		//if this metaData has functions, loop through them, populating a struct of functions
		if(structKeyExists(arguments.metaDataToCheck,"functions")){
			for(ii = 1; ii LTE arrayLen(arguments.metaDataToCheck.functions); ii = ii + 1){
				thisFunction = structNew();
				//set up the defaults for this method
				thisFunction.access = "public";
				thisFunction.returnType = "any";
				thisFunction.output = "default";
				thisFunction.hint = "";
				//override with the real ones
				structAppend(thisFunction,arguments.metaDataToCheck.functions[ii],true);
				//now, we need to manually replace the parameters, so we don't mess up the meta data and to put in the defaults!
				thisFunction.parameters = arrayNew(1);
				for(jj = 1; jj LTE arrayLen(arguments.metaDataToCheck.functions[ii].parameters); jj = jj + 1){
					thisParameter = arguments.metaDataToCheck.functions[ii].parameters[jj];
					thisFunction.parameters[jj] = structNew();
					for(kk in thisParameter){
						thisFunction.parameters[jj][kk] = thisParameter[kk];
					}
					structAppend(thisFunction.parameters[jj],defaultArgument,false);
				}
				theseFunctions[thisFunction.name] = structNew();
				theseFunctions[thisFunction.name].implementedIn = arguments.metaDataToCheck.name;
				theseFunctions[thisFunction.name].method = thisFunction;
			}
		}
	</cfscript>
	<!--- return the struct of functions collected --->
	<cfreturn theseFunctions>
</cffunction> 
<!--- a function that formats a parameter the proper way for summary output --->
<cffunction name="cfcDocumenter_parameterSummaryFormat" access="private" returnType="string" output="no" hint="Given a parameter, and whether it's the first one, returns a string formatted for summary output">
	<cfargument name="parameter" type="struct" required="yes" hint="The parameter struct to format">
	<cfargument name="isFirst" type="boolean" required="no" default="true" hint="Whether this is the first parameter -- which matters for whether to put the comma in">
	<cfset var string = "">
	<cfset var starter = "">
	<cfset var ender = "">
	<cfscript>
		//if it's not required, we'll wrap it in brackets
		if(NOT arguments.parameter.required){
			starter = "[";
			ender = "]";
		}
		//if it's NOT the first one, add a comma
		if(NOT arguments.isFirst){
			starter = starter & ", ";
		}	
		//build the string
		string = starter & "<span class=""subdued"" style=""font-style:italic;"">";
		string = string & arguments.parameter.type;
		string = string & "</span> ";
		string = string & arguments.parameter.name;
		//if it has a default
		if(structKeyExists(arguments.parameter,"default"))
			string = string & "<span class=""subdued"">=" & arguments.parameter.default & "</span>";
		string = string & ender;
	</cfscript>
	<cfreturn string>
</cffunction>
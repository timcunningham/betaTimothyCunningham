<cffunction
name="GetJarClasses"
access="public"
returntype="array"
output="true"
hint="I return an array of classes in the given JAR file (expanded path).">
 

<!--- Define arguments. --->
<cfargument
name="JarFilePath"
type="string"
required="true"
hint="I am the expanded path of the JAR file."
/>
 

<!--- Define the local scope. --->
<cfset var LOCAL = {} />
 

<!--- Create a default array of classes. --->
<cfset LOCAL.Classes = [] />
 

<!--- Get all of the .class files out of the JAR file. --->
<cfzip
action="list"
file="#ARGUMENTS.JarFilePath#"
recurse="true"
filter="*.class"
name="LOCAL.JarEntry"
/>
 

<!---
Now that we have the .CLASS entries, let's loop over
them, clean them up, and add them to our results array.
--->
<cfloop query="LOCAL.JarEntry">
 

<!--- Clean up path structure. --->
<cfset LOCAL.ClassName = REReplace(
LOCAL.JarEntry.Name,
"[\\/]",
".",
"all"
) />
 

<!--- Strip off the ".class" path item. --->
<cfset LOCAL.ClassName = REReplaceNoCase(
LOCAL.ClassName,
"\.class$",
"",
"one"
) />
 

<!--- Add the formatted class name. --->
<cfset ArrayAppend(
LOCAL.Classes,
LOCAL.ClassName
) />
 

</cfloop>
 
<!--- Return the array of classes. --->
<cfreturn LOCAL.Classes />
</cffunction>
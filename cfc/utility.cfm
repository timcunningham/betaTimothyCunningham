	<cfinvoke component="#application.CFCPath#utility" 
				method="GetJarClasses"
				JarFilePath="C:\ColdFusion9\lib\PDF_Image_Doc.jar"
				returnVariable="jarClasses">
				
				<cfdump var="#jarClasses#">
				
							
<cfset jardir = expandPath("../freetts-1.2.2-bin/freetts-1.2/lib")>

 <cfset jars = []>

  <cfdirectory name="jarList" directory="#jardir#">

 <cfloop query="jarList">

    <cfset arrayAppend(jars, jardir & "/" & name)>

 </cfloop>

 
  <cfset loader = createObject("component", "javaloader.JavaLoader").init(jars)>

			
<cfscript>
	paths = arrayNew(1);
	paths[1] = "C:\ColdFusion9\lib\PDF_Image_Doc.jar";
	loader = CreateObject("component", "javaloader.JavaLoader").init(paths);
	comIR = loader.create("pdf2image.imageRender");
	objP2I = comIR.init();
	//objP2I.convert2Image("C:/domains/timothyCunningham/PublisherCard/PDF/ENG380_Web_Design_Syllabus.pdf");
</cfscript>
<cfdump var="#objP2I#" />





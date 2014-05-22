<cfset dqt = chr(34)>
<cfset source= "#Application.RootPath#PublisherCard\PDF\Colbert_Ireatha_2009.pdf">
<cfset target = "#Application.RootPath#PublisherCard\image\Colbert_Ireatha_2009.jpg">
<cfset executablePath ="C:\PDF-IMAGE\ConvertPDFtoImage.exe">
<cfset strCmd = " /S #dqt##source##dqt# /C1 /T #dqt##target##dqt# /1 * /4 100 /5 200">

<cfexecute name = "#executablePath#"
	arguments = "#strCmd#"
   timeout = "20">
</cfexecute>


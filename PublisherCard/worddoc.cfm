<!---
<cfdocument 
	format="PDF"
	srcfile="c:\domains\timothycunningham\publisherCard\postcard.doc"
	filename="c:\domains\timothycunningham\publisherCard\postcard.pdf">
	</cfdocument>
	--->


<cfx_image action="IML"
	File = "c:\domains\timothycunningham\publisherCard\image\west_gail_2009.jpg"
	commands="
		setjpegdpi 300
		resize 1800, 1200
		write #ExpandPath('.\tmpCard1.jpg')#">
		
<cfx_image action="IML"
	File = "c:\domains\timothycunningham\publisherCard\image\west_gail_2010.jpg"
	commands="
		setjpegdpi 300
		resize 1800, 1200
		write #ExpandPath('.\tmpCard2.jpg')#">
		


<cfx_image action="paste"
	file="c:\domains\timothycunningham\publisherCard\tmpCard1.jpg"
	to_file="c:\domains\timothycunningham\publisherCard\doctemplate.jpg"
	output="c:\domains\timothycunningham\publisherCard\image\combined.jpg"
	x="1245"
	y="1050">
	
<cfx_image action="paste"
	file="c:\domains\timothycunningham\publisherCard\tmpCard2.jpg"
	to_file="c:\domains\timothycunningham\publisherCard\image\combined.jpg"
	output="c:\domains\timothycunningham\publisherCard\image\combinedFinished.jpg"
	x="1245"
	y="2250">
	
<cfdocument 
	format="PDF"
	srcfile="c:\domains\timothycunningham\publisherCard\image\combinedFinished.jpg"
	filename="c:\domains\timothycunningham\publisherCard\postcard.pdf"
	overwrite="true">
	</cfdocument>
	
	
	<!---
<cfpdf action="addwatermark" source="c:\domains\timothycunningham\publisherCard\postcard.pdf"
	image="c:\domains\timothycunningham\publisherCard\image\combinedFinished.jpg" 
	destination="combined.pdf" 
	overwrite="yes"
	FOREGROUND="yes"
	opacity=5
	showonPrint="yes"
	position="10,10"> --->
	
	<a href="../publishercard/image/combinedFinished.jpg">Image</a>

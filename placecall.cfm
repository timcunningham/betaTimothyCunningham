<cfoutput>
<title>Demonstration Session Trigger Application</title>
<form name="SampleForm"
  action="http://api.voxeo.net/SessionControl/CallXML.start"  method="get">
  <input type="hidden" name="tokenid" value="7b384bc2a6c46d499ff792695f01b5151a88edd7440c7b0f9ee71eacdf0fa0fa30dcec63bacc808342d5dc89">

  Phone number to call:<br>
  <input type="text" name="Phone" size="20" maxlength="20" value=""><br><br>
  Enter your text to say here:<br>
  <input type="text" name="TTS" size="100" value=""><br><br>
  <input type="reset" value="Clear">

  <input type="submit" name="submit" value="Give me a call!">
</form>
</cfoutput>
<html>
<head>
<title>Intuit PayPage redirect</title>
</head>
<body bgcolor="white" text="black">
	<%

	IntuitPayPageSaleQuick("10")

        '================
        ' THIS IS A SANITIZED VERSION OF THIS FILE
        ' Client-specific data has been removed/replaced in this version of the file.  This process will NOT FUNCTION correctly without
        ' replacing the sanitized data with the original values (or new values for a valid Intuit customer)
'=========================
' MAIN FUNCTIONS

	'===============
	'FUNCTION:	IntuitPayPageSaleQuick(StrCost)
	'
	'Executes the complete process of accessing the  Ticket Generation Page, parsing the data returned,
	'and then redirecting the user to the  Checkout Terminal page.
	'
	'This is the most simple function for this process, and makes a number of assumptions:
	'	- 	The Intuit URLs and their capabilities will not change
	'	- 	We want to process sales only and not authorizations).
	'	- 	The MLH application login and authentication will not change and it's acceptable to leave this
	'		information in the ASP module.
	'
	'Input(s):
	'StrCost	=	String.  The dollar amount of the transaction.  Should be in the format "xxxx.yy" or similar -- the Intuit site will
	'
	'Returns:
	'No return.
	Function IntuitPayPageSaleQuick(StrCost) 'StrCost should be a float cast as a string

		If TestStringWithRegEx(StrCost,"^[0-9]+\.?[0-9]*$") = 0 Then 'CheckFormat(StrCost,"Cost") = 0 then
			Response.Write "ERROR:  Input data from server was improperly formatted."

			Exit Function
		End If


		Dim PrimaryAppLogin
		Dim PrimaryAuthTicket
		Dim SecondaryDisplayShipping
		PrimaryAppLogin="host.com" 'SANITIZED VALUE FOR PORTFOLIO
		PrimaryAuthTicket="TGT-999-FOOBAR" 'SANITIZED VALUE FOR PORTFOLIO
		SecondaryDisplayShipping=0
		Dim PayPageProcess
		PayPageProcess=IntuitPayPageSale(PrimaryAppLogin,PrimaryAuthTicket,StrCost,SecondaryDisplayShipping)
		IntuitPayPageSaleQuick=StrCost
	End Function
	'===============

	'===============
	'FUNCTION:	IntuitPayPageSale(PrimaryAppLogin,PrimaryAuthTicket,PrimaryAmount,SecondaryDisplayShipping)
	'
	'Executes the complete process of accessing the  Ticket Generation Page, parsing the data returned,
	'and then redirecting the user to the  Checkout Terminal page.
	'
	'This is a more simple function for this process, and makes a number of assumptions (ie, that the Intuit
	'URLs and their capabilities will not change and that we want to process sales only and not authorizations).
	'
	'Input(s):
	'PrimaryAppLogin			=	String.  The application login our application is registered under.
	'PrimaryAuthTicket			=	String.  The connection ticket created when linking our merchant account to our application.
	'PrimaryAmount				=	String.  The dollar amount of the transaction.  Should be in the format "xxxx.yy" or similar -- the Intuit site will
	'								accept any number here.
	'SecondaryDisplayShipping	=	String or integer.  Determines whether to show shipping options in the Checkout Terminal.  If this string
	'								is a "0" no shipping options will be shown; if this string is a "1" then shipping options will be shown.
	'
	'Returns:
	'No return.
	Function IntuitPayPageSale(PrimaryAppLogin,PrimaryAuthTicket,PrimaryAmount,SecondaryDisplayShipping)
		Dim PrimaryBaseUrl
		Dim PrimaryAuthModel
		Dim PrimaryTxnType
		Dim SecondaryBaseUrl
		Dim SecondaryAction

		PrimaryBaseUrl="https://paymentservices.intuit.com/paypage/ticket/create"
		PrimaryAuthModel="desktop"
		PrimaryTxnType="Sale"
		SecondaryBaseUrl="https://paymentservices.intuit.com/checkout/terminal"
		SecondaryAction="checkout"

		Dim PayPageProcess

		'Execute the verbose paypage process
		PayPageProcess=IntuitPayPageVerbose(PrimaryBaseUrl,PrimaryAuthModel,PrimaryAppLogin,PrimaryAuthTicket,PrimaryTxnType,PrimaryAmount,SecondaryBaseUrl,SecondaryAction,SecondaryDisplayShipping)
	End Function
	'===============

	'===============
	'FUNCTION: 	IntuitPayPageVerbose(PrimaryBaseUrl,PrimaryAuthModel,PrimaryAppLogin,PrimaryAuthTicket,
	'			PrimaryTxnType,PrimaryAmount,SecondaryBaseUrl,SecondaryAction,SecondaryDisplayShipping)
	'
	'Executes the complete process of accessing the  Ticket Generation Page, parsing the data returned,
	'and then redirecting the user to the  Checkout Terminal page.
	'
	'Input(s):
	'PrimaryBaseUrl				=	String.  The beginning of the URL used to launch the Ticket Generation page.  See GeneratePrimaryURL()
	'PrimaryAuthModel			=	String.  The authentication model we use with Intuit.  Can be either "desktop" or "session"; as of the time of
	'								this writing this is always "desktop".
	'PrimaryAppLogin			=	String.  The application login our application is registered under.
	'PrimaryAuthTicket			=	String.  The connection ticket created when linking our merchant account to our application.
	'PrimaryTxnType				=	String.  The type of transation to process.  Can either be "Sale" (a sale transaction) or "Auth" (an authorization
	'								transaction).
	'PrimaryAmount				=	String.  The dollar amount of the transaction.  Should be in the format "xxxx.yy" or similar -- the Intuit site will
	'								accept any number here.
	'SecondaryBaseUrl			=	String.  The beginning of the URL used to launch the Checkout Terminal.  See GenerateSecondaryURL()
	'SecondaryAction			=	String.  The action to be executed by the Intuit Checkout Terminal.  Currently this can only be "checkout"
	'SecondaryDisplayShipping	=	String or integer.  Determines whether to show shipping options in the Checkout Terminal.  If this string
	'								is a "0" no shipping options will be shown; if this string is a "1" then shipping options will be shown.
	'
	'Returns:
	'"1"
	Function IntuitPayPageVerbose(PrimaryBaseUrl,PrimaryAuthModel,PrimaryAppLogin,PrimaryAuthTicket,PrimaryTxnType,PrimaryAmount,SecondaryBaseUrl,SecondaryAction,SecondaryDisplayShipping)

		dim PrimaryURL
		dim SecondaryURL
		dim ServerCheck

		'====
		'Generate the URL for the PayPage Ticket Generation page
		PrimaryURL=GeneratePrimaryURL(PrimaryBaseUrl,PrimaryAuthModel,PrimaryAppLogin,PrimaryAuthTicket,PrimaryTxnType,PrimaryAmount)

		'====
		'Verify that the Intuit server is up and we can reach the Ticket Generation page
		ServerCheck=IsServerUp(PrimaryURL)

		If ServerCheck<>0 then
			Response.Write "Connection to Intuit's paypage server failed."
			Exit Function
		elseif ServerCheck=0 then
			'Open the Ticket Generation page and attempt to generate the URL for the Checkout Terminal

			SecondaryURL=GetSecondaryURL(PrimaryUrl,SecondaryBaseUrl,SecondaryAction,SecondaryDisplayShipping)

			If SecondaryURL=-1 then
				Exit Function
			End If

			'====
			'Verify that the Intuit server is up and we can reach the Checkout Terminal page
			ServerCheck=IsServerUp(PrimaryUrl) 	'This MUST be the PrimaryUrl, NOT the SecondaryUrl!  If we hit just the header of the SecondaryURL
												'(which the IsServerUp function does), the Intuit servers will flag our page as already viewed and
												'we won't be able to get to it with a web browser!
			If ServerCheck<>0 then
				Response.Write "Connection to Intuit's paypage server failed."
				'Exit Function
			elseif ServerCheck=0 then
				'====
				'Write the URL generated for the Checkout Terminal (used for testing only)
				'Response.write "<pre>" & vbcrlf & PrimaryURL & vbcrlf & "</pre>"
				'Response.Write "<pre>" & SecondaryURL & "</pre>"

				'Redirect the user to the Checkout Terminal (production)
				Response.redirect SecondaryURL
			End if
		End If
		IntuitPayPageVerbose=1
	End Function
	'===============

'=========================

'=========================
' SUBSIDIARY FUNCTIONS

	'===============
	'FUNCTION:  GetSecondaryURL(PrimaryUrl,StrSecondaryBaseUrl,StrAction,StrDisplayShipping)
	'Accesses the Intuit PayPage Ticket Generation page, extracts information from it, and returns a URL which
	'can be used to launch the Checkout Terminal for this transaction.
	'
	'Below is an example of the format of the Checkout Terminal URL:
		'https://paymentservices.ptcfe.intuit.com/checkout/terminal?Ticket=TICKETFOOBAR&OpId=OPIDFOOBAR--&action=checkout&DisplayShipping=0 'SANITIZED VALUE FOR PORTFOLIO // note that sanitizing here doesn't show the HTML character escapes which are key to making this work
'
	'Note that when an invalid or expired URL request is sent to the Intuit Checkout Terminal, the error message
	'returned is misleading -- it simply states:
	'"Transaction Not Processed - Our system is currently facing some intermittent problems. Please try again in few minutes."
	'=====
	'
	'Input(s):
	'PrimaryUrl				-	The complete URL for the Ticket Generation page.  See GeneratePrimaryURL()
	'StrSecondaryBaseUrl	-	The beginning of the URL used to launch the Checkout Terminal -- this should include the entire address
	'							up to the beginning of the variables which can be passed to the Checkout Terminal, and discluding any characters
	'							which indicate the start of the set of variables.  For the sample Checkout Terminal URL above, this string would be:
	'							"https://paymentservices.ptcfe.intuit.com/checkout/terminal"
	'StrAction				-	A string giving the action to be executed by the Intuit Checkout Terminal.  Currently this can only be "checkout"
	'StrDisplayShipping		-	A string or integer determining whether to show shipping options.  If this string is a "0" no shipping options will
	'							be shown; if this string is a "1" then shipping options will be shown.
	'
	'Returns:
	'0 if successfully able to access the destination URL
	'1 if unable to access the destination URL
	Function GetSecondaryURL(PrimaryUrl,StrSecondaryBaseUrl,StrAction,StrDisplayShipping)	'as string'
		'=====
		'Open the PrimaryURL on the remote server and save the data returned into TicketString
		'
		'This data should be plain text in the following format:
		'<--begin data-->
		'Status Code=0
		'Status Message=OK
		'Ticket=TICKETFOOBAR
		'<--end data-->
		'
		'The secondary URL that should be loaded from this return would be:
		'
		'https://paymentservices.ptcfe.intuit.com/checkout/terminal?Ticket=TICKETFOOBAR&OpId=OPIDFOOBAR&action=checkout&DisplayShipping=0 'SANITIZED VALUE FOR PORTFOLIO // note that sanitizing here doesn't show the HTML character escapes which are key to making this work
		'
		'
		'The values needed to launch the Checkout Terminal are the Ticket and OpId codes.
		'IMPORTANT!  Note that both of these codes contain characters which are reserved characters
		'in URLs (ie, "/", "+", etc), so we'll need to URL encode these strings.
		set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP")
		xmlhttp.open "GET", PrimaryUrl, false
		xmlhttp.send ""
		Dim TicketString
		TicketString=xmlhttp.responseText

		'=====
		'Test for successful processing by Intuit.  If the data from the remote server does not include "StatusCode=0" and "StatusMessage=OK"
		'(which indicates successful processing), or if the Ticket or OpID codes don't appear, show an error to the user and exit.
		If TestStringWithRegEx(TicketString,"StatusCode=0") = 0  or TestStringWithRegEx(TicketString,"Ticket=")=0 or TestStringWithRegEx(TicketString,"OpId=")=0 or TestStringWithRegEx(TicketString,"StatusMessage=OK") = 0 Then
			GetSecondaryURL=-1
			Response.write "<pre>" & "Intuit PayPage server returned an error when attempting to process this request.  Server message follows." & VbCrLf
			Response.write TicketString & "</pre>"
			Exit Function
		End If

		'=====
		'Extract strings containing the TicketCode and OpIDCode values.  We use regexps to do this,
		'first extracting the line containing each value, then extracting the value itself from
		'each line.
		Dim ExtractedOpIdLine,	ExtractedOpIdCode,	ExtractedTicketLine, ExtractedTicketCode
		ExtractedTicketLine=ExtractStringWithRegEx(TicketString,"Ticket=.*[\r\n]")


		ExtractedTicketCode=ExtractStringWithRegEx(ExtractedTicketLine,"[^=]*[\r\n]")

		ExtractedTicketCode=ExtractStringWithRegEx(ExtractedTicketCode,"[^\r\n]*")

		ExtractedOpIdLine=ExtractStringWithRegEx(TicketString,"OpId=.*[\r\n]")
		ExtractedOpIdCode=ExtractStringWithRegEx(ExtractedOpIdLine,"[^=]*[\r\n]")
		ExtractedOpIdCode=ExtractStringWithRegEx(ExtractedOpIdCode,"[^\r\n]*")

		'If we can't find either the TicketCode or OpIDCode values, show an error to the user and exit.
		If ExtractedTicketCode=false OR ExtractedOpIdCode=false then
			GetSecondaryURL=-1
			Response.write "<pre>" & "Intuit PayPage server returned invalid data error when attempting to process this request.  Server message follows." & VbCrLf
			Response.write TicketString & "</pre>"
			exit function
		end if

		'=====
		'URL Encode the code values we received and then generate and return the URL to the Checkout Terminal.
'Response.write "<pre>" & "PreURLEncode" & vbcrlf & GenerateSecondaryURL(StrSecondaryBaseUrl,ExtractedTicketCode,ExtractedOpIdCode,StrAction,StrDisplayShipping) & vbcrlf & "</pre>"

		ExtractedTicketCode=Server.URLEncode(ExtractedTicketCode)
		ExtractedOpIdCode=Server.URLEncode(ExtractedOpIdCode)
		GetSecondaryURL=GenerateSecondaryURL(StrSecondaryBaseUrl,ExtractedTicketCode,ExtractedOpIdCode,StrAction,StrDisplayShipping)

		set xmlhttp = nothing
	End Function
	'===============


	'===============
	'FUNCTION:  GeneratePrimaryURL(StrBaseURL,StrAuthModel,StrAppLogin,StrAuthTicket,StrTxnType,StrAmount)
	'Generates a URL for the Intuit SecurePayPage Ticket Generation page.  Details on generating this page
	'can be found on Intuit's website.  Sample ticket generation URL follows:
	'			https://paymentservices.ptcfe.intuit.com/paypage/ticket/create?AuthModel=desktop&AppLogin=trialapp.qbms.intuit.com&AuthTicket=AUTHTICKETFOOBAR&TxnType=Sale&Amount=10.50 'SANITIZED VALUE FOR PORTFOLIO // note that sanitizing here doesn't show the HTML character escapes which are key to making this work // note that sanitization here deleted a ticket value which should be a "test" ticket provided by Intuit
	'
	'Note that this ticket can be generated with many additional options which are not used in this function.
	'(They are described on the Intuit website.)  If needed, add additional parameters to this function and to the
	'concatenation scheme below to accomodate new options as desired.
	'
	'Input(s):
	'StrBaseURL			-	The base URL pointing at the Ticket Generation page, NOT including any of the variables.  As of the time
	'						of this writing this is always:
	'						"https://paymentservices.ptcfe.intuit.com/paypage/ticket/create"
	'						Note the absence of a trailing "?" in this string.  This is left as a variable in case Intuit
	'						changes this URL at any point.
	'StrAuthModel		-	The authentication model we use with Intuit.  Can be either "desktop" or "session"; as of the time of
	'						this writing this is always "desktop".
	'StrAppLogin		-	The application login our application is registered under.
	'StrAuthTicket		-	The connection ticket created when linking our merchant account to our application.
	'StrTxnType			-	The type of transation to process.  Can either be "Sale" (a sale transaction) or "Auth" (an authorization
	'						transaction).
	'StrAmount			-	The dollar amount of the transaction.  Should be in the format "xxxx.yy" or similar -- the Intuit site will
	'						accept any number here.
	'
	'Returns:
	'A string containing the concatenated URL for the Ticket Generation page.
	Function GeneratePrimaryURL(StrBaseURL,StrAuthModel,StrAppLogin,StrAuthTicket,StrTxnType,StrAmount)
		GeneratePrimaryURL=StrBaseURL & "?AuthModel=" & StrAuthModel & "&AppLogin=" & StrAppLogin & "&AuthTicket=" & StrAuthTicket & "&TxnType=" & StrTxnType & "&Amount=" & StrAmount
	End Function
	'===============


	'===============
	'FUNCTION:  GenerateSecondaryURL(StrBaseURL,StrTicketCode,StrOpIdCode,StrAction,StrDisplayShipping)
	'Generates a URL for the Intuit SecurePayPage Checkout Terminal page.  Details on generating this page
	'can be found on Intuit's website.  Sample ticket generation URL follows:
	'
	'https://paymentservices.ptcfe.intuit.com/checkout/terminal?Ticket=TICKETFOOBAR&OpId=OPIDFOOBAR&action=checkout&DisplayShipping=0 'SANITIZED VALUE FOR PORTFOLIO // note that sanitizing here doesn't show the HTML character escapes which are key to making this work // note that sanitization here deleted a ticket/opID value which should be a "test" ticket provided by Intuit
	'
	'
	'Input(s):
	'StrBaseURL			-	The base URL pointing at the Checkout Terminal, NOT including any of the variables.  As of the time
	'						of this writing this is always:
	'						"https://paymentservices.ptcfe.intuit.com/checkout/terminal"
	'						Note the absence of a trailing "?" in this string.  This is left as a variable in case Intuit
	'						changes this URL at any point.
	'StrTicketCode		-	A string containing the TicketCode provided by the Ticket Generation page.  THIS STRING MUST BE URL ENCODED!
	'StrOpIdCode		-	A string containing the OpIdCode provided by the Ticket Generation page.  THIS STRING MUST BE URL ENCODED!
	'StrAction			-	A string giving the action to be executed by the Intuit Checkout Terminal.  Currently this can only be "checkout"
	'StrDisplayShipping	-	A string or integer determining whether to show shipping options.  If this string is a "0" no shipping options will
	'							be shown; if this string is a "1" then shipping options will be shown.
	Function GenerateSecondaryURL(StrBaseURL,StrTicketCode,StrOpIdCode,StrAction,StrDisplayShipping)
		GenerateSecondaryURL=StrBaseURL & "?Ticket=" & StrTicketCode & "&OpId=" & StrOpIdCode & "&action=" & StrAction & "&DisplayShipping=" & StrDisplayShipping
	End Function
	'===============


'=========================


'=========================
' AUXILLIARY FUNCTIONS

	'===============
	'FUNCTION:  IsServerUp(url)
	'Checks to verify that this URL can be accessed.  If unsuccessful, attempts to show a single-line error message to the
	'user.
	'
	'Input(s):
	'url	- 	a string containing the URL to a destination
	'
	'Returns:
	'0 if successfully able to access the destination URL
	'1 if unable to access the destination URL

	Function IsServerUp(url)
		set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP")
		on error resume next
		xmlhttp.open "HEAD", url, false  'Returns only the header of the resource -- so we can check to make sure we can get to the destination URL
		xmlhttp.send ""
		status = xmlhttp.status
		if err.number <> 0 or status <> 200 then
			if status = 404 then
				Response.Write "Page does not exist (404)."
			elseif status >= 401 and status < 402 then
				Response.Write "Access denied (401)."
			elseif status >= 500 and status <= 600 then
				Response.Write "500 Internal Server Error on remote site."
			else
				Response.write "Server is down or does not exist."
			end if
			IsServerUp=-1
		else
			'Response.Write "Server is up and URL is available."
			IsServerUp=0
		end if
		set xmlhttp = nothing
	End Function
	'===============


	'===============
	'FUNCTION:  TestStringWithRegEx(TestString,TestRegexPattern)
	'Tests a string to see if a regexp pattern matches it
	'
	'Input(s):
	'TestString			-	a string containing the string to be tested
	'TestRegexPattern	-	a string containing a regex pattern
	'
	'Returns:
	'0 if a match IS NOT found
	'1 if a match IS found
	Function TestStringWithRegEx(TestString,TestRegexPattern)
		Set regex=New Regexp
		Regex.Pattern=TestRegexPattern
		If Regex.Test(TestString) then
			TestStringWithRegEx=1
		else
			TestStringWithRegEx=0
		end if
	End Function
	'===============


	'===============
	'FUNCTION:  ExtractStringWithRegEx(TestString,TestRegexPattern)
	'Extracts a substring matching a regexp pattern from a string
	'
	'Input(s):
	'TestString			-	a string containing the string to be tested
	'TestRegexPattern	-	a string containing a regex pattern
	'
	'Returns:
	'FALSE if a match IS NOT found
	'A substring if a match IS found
	Function ExtractStringWithRegEx(TestString,TestRegexPattern)
		If TestStringWithRegex(TestString,TestRegexPattern)=0 then
			ExtractStringWithRegEx=false
			Exit Function
		end if
		Set regex=New Regexp
		Regex.Pattern=TestRegexPattern
		Set ExtractionCollection = Regex.Execute(TestString)
		ExtractStringWithRegEx=ExtractionCollection(0)
	End Function
	'===============

'=========================
	%>
   	</body>
</html>
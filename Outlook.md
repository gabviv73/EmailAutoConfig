# Webserver Setup

* Setup https access to EmailAutoConfig at:

    https://autodiscover.example.com

# DNS Setup
* Setup DNS SRV record:

    _autodiscover._tcp.example.com. 3600 IN SRV 10 10 443 autodiscover.example.com.

* Test with

    host -t SRV _autodiscover._tcp.example.com

    _autodiscover._tcp.example.com has SRV record 10 10 443 autodiscover.example.com.

# Testing

Create CURL POST test datafile:

    vi @xml_post.txt

```
<Autodiscover xmlns="http://schemas.microsoft.com/exchange/autodiscover/outlook/requestschema/2006">;
	<Request>
		<EMailAddress>USER@DOMAIN.TLD</EMailAddress>
		<AcceptableResponseSchema>http://schemas.microsoft.com/exchange/autodiscover/outlook/responseschema/2006a</AcceptableResponseSchema>;
	</Request>
</Autodiscover>
```

Test with:

```
cURL -ki --basic -u USERNAME:PASSWORD \
	-H "Content-Type: text/xml" \
	-d @xml_post.txt \
	--url https://autodiscover.example.com/autodiscover/autodiscover.xml
```

You should get your template xml back filled in with your data.

# References
* https://docs.directadmin.com/other-hosting-services/email/autodiscover.html
* https://www.zoho.com/mail/help/adminconsole/autodiscovery-settings.html
* https://portal.smartertools.com/community/a94258/why-no-access-to-autodiscover_xml.aspx

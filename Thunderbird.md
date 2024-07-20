## Webserver Setup

* Setup https access to EmailAutoConfig at:

    https://autoconfig.example.com


# Email account autoconfig

* Test with 
    curl -q http://autoconfig.example.com/mail/config-v1.1.xml?emailaddress=user.name@example.com 

* You should get your template xml back filled in with your data.

# Calendar and Addressbook autoconfig

* Be sure to have a caldav/carddav that answers at
        https://myapp.example.com/.well-known/caldav
        https://myapp.example.com/.well-known/carddav

## DNS Setup
* Setup DNS SRV record:

    _caldavs._tcp.example.com.   23887   IN      SRV     10 10 443 cloud.example.com
    _carddavs._tcp.example.com.   23887   IN      SRV     10 10 443 cloud.example.com

* Test with

    host -t SRV _caldavs._tcp.example.com.
    host -t SRV _carddavs._tcp.example.com.

# References

* https://help.nextcloud.com/t/advanced-dns-configuration-srv-records-for-carddavs-caldavs/43939
* https://whynothugo.nl/journal/2023/04/30/dns-based-discovery-for-caldav-and-carddav/
* https://docs.kolab.org/administrator-guide/dav-autodiscovery.html

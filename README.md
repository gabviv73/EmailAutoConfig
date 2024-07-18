# Email AutoConfig

A simple solution to provide email client autoconfiguration.

Tested with Thunderbird 115 for IMAP and SMTP only.

# Setup
* Setup an HTTPS server at https://autoconfig.example.com that point to your docker container.
* Clone thsis repo:

        git clone https://github.com/gabviv73/EmailAutoConfig.git`
        cd EmailAutoConfig`

* Copy docker-compose and customize env vars
  
        cp docker-compose-production.yml docker-compose.yml
        vi docker-compose.yml
* Respect capitalization in env vars !
* Start container
  
        docker compose up
* Test the generated XML at https://autoconfig.example.com/mail/config-v1.1.xml?emailaddress=name.surname@example.com
* Configure yout email client with an account at name.surname@example.com
* It shold work ...

# Todo
After receiving some feedback, I'll push a ready made image to DockerHub

# References
* https://www.ietf.org/id/draft-bucksch-autoconfig-02.html
* https://benbucksch.github.io/autoconfig-spec/draft-autoconfig-1.html
* https://wiki.mozilla.org/Thunderbird:Autoconfiguration:ConfigFileFormat#Multiple_servers
* https://www.bucksch.org/1/projects/thunderbird/autoconfiguration/how-to-create-your-own-config-file.html
* https://github.com/Mailu/Mailu/issues/498

# Credits 
* Ben "benbucksch" Bucksch for the Specs https://github.com/benbucksch/autoconfig-spec
* https://github.com/smartlyway/email-autoconfig-php

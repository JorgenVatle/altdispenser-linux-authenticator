#!/usr/bin/env bash

if [ -f $JAVA_HOME/lib/security/cacerts ]
then
    keytool -import -trustcacerts -alias authserver.mojang.com -file certs/authserver_mojang_com.crt -storepass changeit  -keystore $JAVA_HOME/lib/security/cacerts;
    keytool -import -trustcacerts -alias sessionserver.mojang.com -file certs/sessionserver_mojang_com.crt -storepass changeit  -keystore $JAVA_HOME/lib/security/cacerts;

    AUTHSERVER=`curl -L -s https://api.altdispenser.net/authserver`;
    SESSIONSERVER=`curl -L -s https://api.altdispenser.net/sessionserver`;

    if [[ $AUTHSERVER =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] && [[ $SESSIONSERVER =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        sed -i.bak -E '/^\\s*$/d' /etc/hosts
        sed -i.bak -E '/.mojang.com/d' /etc/hosts

        printf \\n$AUTHSERVER\\tauthserver.mojang.com >> /etc/hosts
        printf \\n$SESSIONSERVER\\tsessionserver.mojang.com >> /etc/hosts
        echo "Minecraft will now use Alt Dispenser's authentication servers for alt authentication."
    else
        echo "Unable to get server credentials from api.altdispenser.net. Are you connected to the internet?"
    fi
else
    echo "We couldn't find your certificate directory. Please ensure that your JAVA_HOME environment variable is properly set.";
    echo "If you are having trouble figuring out how to do this, please contact us at support@altdispenser.net";
fi
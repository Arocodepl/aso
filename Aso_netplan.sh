#!/bin/bash

#Zadanie aso Pozdrawiamy panie Arku:) Arkadiusz Kacper 2tei
#Versionn: 1.0
#Program od netplan podmieni pliki automatycznie


echo "Cześć, zadam ci kilka pytań dotyczących konfiguracji twojego netplanu"
echo "czy chcesz włączyć dhcp4? (no/yesBETA)"
read dhcp4
echo "teraz określ adres IP i maskę, które mają być uwzględnione w adresach. Chesz aby twój adres ip uzupełnił sie automatycznie (y/n)"
read n
if [ $n = "n" ]
then
echo nie uzupełniono ip automatycznie uzupełnij go samodzielnie
read ipadress
else 
echo zczytałem adres 
ipadress=`ip -br a | grep UP | awk '{print $3}'`
fi

#read addresses
echo "określ bramę domyślną. Chcesz aby brama uzupełniła sie automatycznie> (y/n)"
read n
if [ $n = "n" ]
then
echo nie uzupełniono ip automatycznie uzupełnij samodzielnie
read gateway
else 
echo zczytałem bramę
gateway=`ip r | grep defa | awk '{print $3}'`
fi

#read gateway
echo "Teraz wprowadź DNS"
read dns1




echo "network:
  ethernets:
    enp0s3:
      dhcp4: $dhcp4
      addresses: [$ipadress]
      routes:
        - to: default
          via: $gateway
      nameservers:
       addresses: [$dns1]
    version: 2" > 00-installer-config.yaml


cp /aso/00-installer-config.yaml/etc/netplan/00-installer-config.yaml 

echo Dziękujemy za korzystanie z naszego kreatora 

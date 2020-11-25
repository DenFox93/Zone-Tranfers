#!/bin/bash
#AUTHOR: Daniele Volpe

echo > domainsAXFR2.txt
while IFS= read -r line; do
	dig -t ns $line +short | tee nameservers.txt
	if dig -t ns $line | grep -q 'CNAME'; then
		continue
	fi
	while IFS= read -r i; do
		dig -t AXFR $line @$i +short | tee -a domainsAXFR2.txt
	done < nameservers.txt	
done < domains2.txt


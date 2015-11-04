#!/bin/bash
#We need readings and sensors files in one directory with our script
readings=./readings
sensors=./sensors
awk -F "/" '{print $2 " " $3}' $readings | \
awk '{
for (i=0; i<5; i++)
{
	if ( $1 == i )
	{
		sum[i] = sum[i] + $2
		count[i]++
	}
}
    }
END {
for (i=1; i<=5; i++){
	average[i] = sum[i]\count[i]
	printf "%d %.0f\n",i,average[i]
	}
}' > tmp
join $sensors tmp | awk '{ print $2"\t"$3 | "sort -k2"}'

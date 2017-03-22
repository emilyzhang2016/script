
#!bin/sh
for year in all/*
do
  		echo -ne `basename ${year} .gz`"\t"
  		gunzip -c ${year}|\
  		  awk `{temperature = substr($0,88,5)+0;
  		  		quality = substr($0, 93, 1);
  		  		if (temp != 9999 && q ~/[01459]/ && temp > max) max= temp}
  		  	   END {print max}`
done

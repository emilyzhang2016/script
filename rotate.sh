
#!/bin/sh
source ~/.bashrc
#awk 'BEGIN{FS=",";OFS=","}{for(i=1;i<=NF;i++) a[i,NR]=$i}END{for(i=1;i<=NF;i++) {for(j=1;j<=NR;j++) printf a[i,j]",";print ""}}'
if  [ $# -lt 1 ]
then 
echo Usage : must input one file
exit 1
fi
if [ $# -gt 1 ]
then 
echo Usage : only one file is needed
exit 1
fi
lines=$(head -n 1 $1| awk -F "," '{print NF}')
name=$(basename $1 .csv)  #或者name=`basename $1 .csv`
#echo $name
for ((i=1;i<=${lines};i++))
do 
   awk -v tmp="$i" 'BEGIN{FS=","}{print $tmp}' $1 |sed ':a;N;$!ba;s/\n/,/g' >>${name}_rotation.csv
 done;
echo rotation succeed


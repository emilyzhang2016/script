
if [ $# -ne 1 ];
then
   echo 'please at least input one filename...'
   exit -1
fi

filename=$1

totalnum=`wc -l $1|awk '{print $1}'`
getnum=$[totalnum*10/11]

awk '{OFS="\t";print $1,rand()}' $filename > zjn_sfc  
sort -k 2,2 zjn_sfc > sort_zjn_sfc 
rm guoqing_sfc

awk -v snum="$getnum" -v tnum="$totalnum" -v fname="$filename" '{if(NR<=snum){print $1>>"use_"fname}else if(NR<=tnum){print $1>>"sample_"fname}else{exit 0}}' sort_zjn_sfc  

rm sort_zjn_sfc

echo "success, use_xxx is data file, sample_xxx is sample data file..."


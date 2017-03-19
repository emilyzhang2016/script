
#!/bin/sh
source /etc/profile
source ~/.bashrc

if [ $# == 2 ]; then
        run_file=$1
        run_day=$2
        start_day=`echo ${run_day}|cut -d '-' -f 1|xargs -i date -d {} +%s`
        end_day=`echo ${run_day}|cut -d '-' -f 2|xargs -i date -d {} +%s` 
        section=`echo $((end_day-start_day))/86400+1|bc`
        echo 'the number of tasks is: '$section

        if [ $section -lt 0 ]
        then
                echo 'date param is error, please check it...'
                exit -1
        fi

        if [ $section -gt 20 ]
        then
                echo 'the number of tasks can not be more than 15, please modify date param....'
                exit -1
        fi

        for((i=$start_day;i<= $end_day;i+=86400))
        do
                echo "nohup sh $run_file" `date -d @${i} +%Y%m%d` "> mul.log 2>&1 &"
                echo "nohup sh $run_file" `date -d @${i} +%Y%m%d` "> mul.log 2>&1 &"|bash
        done
else
        echo 'please input filename and date,like: multask xxx.sh 20160101-20160105'
fi


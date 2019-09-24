#!/usr/bin/env bash
set -e
# 参数
DAY=${1-`date +%Y%m%d`}  # 查询节假日,默认今天

# 系统参数
AUTO_UPDATE_DATA=${AUTO_UPDATE_DATA-"true"} # 是否自动更新节假日数据
AUTO_UPDATE_DATA_URL=${AUTO_UPDATE_DATA_URL-"https://raw.githubusercontent.com/zgfh/holidays_china/master/data.json"} # 数据获取地址
DATA_FILE="data.json"   # 数据存储文件
DEBUG="false"

#  全局变量
DAYS=""


debug_log(){
if [[ "$DEBUG" == "true" ]];then
  echo $@
fi
return
}
check_day(){
local d=$1
if cat data.json|grep "$d" 2>&1 >/dev/null ;then
    result=`cat data.json|grep "$d" |grep -E -o  ":[0-9]"  |grep -E -o  "[0-9]"`
    echo $result
    return

fi
# TODO should check weekday
echo 0
}

update_day(){
if [[ "$AUTO_UPDATE_DATA" == "true" ]];then
curl -s -o $DATA_FILE $AUTO_UPDATE_DATA_URL
fi

}

get_day(){
local year=${DAY:0:4}
local m=${DAY:4:2}
local d=${DAY:6:2}

# DAY format: 20191001
if [[ "$d" != "" ]] ;then
    DAYS=$DAY
    return
fi

# DAY format: 201910
if [[ "$m" != "" ]] ;then
    DAYS=`cat data.json|grep "$DAY" |grep -E -o  "\"[0-9]{8,8}\":"|grep -E -o "[0-9]{8,8}"`
    return
fi

# DAY format: 2019
DAYS=`cat data.json|grep "$DAY" |grep -E -o  "\"[0-9]{8,8}\":"|grep -E -o "[0-9]{8,8}"`

}
print_result(){
result="{"
flag="false"
for d in $DAYS
do
  if [[ "$flag" == "true" ]];then
    result+=","
  else
    flag="true"
  fi
  result+="\"$d\":`check_day $d`"
done
result+="}"
echo $result

}
main(){
debug_log "param $DAY"
update_day

get_day
print_result
}
main $@
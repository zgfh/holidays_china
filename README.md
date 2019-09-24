# holidays_china

查询今天是不是节假日



### api
参数：
1. d: 查询的日期。   格式支持 2018(获取整年),201801(获取某个月),20180101(获取某天) 
例如:
返回结果
{ 
  "20190101" : "2", 
  "20190103" : "0", 
  "20190105" : "0", 
  "20191201" : "1" 
}

其中 
1. key : 是日期
1. value : 0工作日 1 假日 2节日


### client 

#### script
```bash
test -f holidays_china.sh || curl -o holidays_china.sh https://raw.githubusercontent.com/zgfh/holidays_china/master/sdk/script/holidays_china.sh 

if [[ "$(bash holidays_china.sh|grep -E -o  \":[0-9]\"  |grep -E -o  \"[0-9]\")" != "0" ]]  ;then
echo "holidays day"
else
echo "normal days"
fi
```


#### api
TODO
#### python
TODO


参考：
http://tool.bitefu.net/showdoc/web/#/2

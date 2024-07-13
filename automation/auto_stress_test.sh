#!/usr/bin/env bash

# 压测脚本模板中设定的压测循环2次
export jmx_filename="newbee_stress_auto.jmx"

# 需要在系统变量中定义jmeter根目录的位置，如下
# export jmeter_path="/your jmeter path/"

echo "自动化压测开始"

rm -f *.jtl
rm -rf web_*

# 压测并发数列表
thread_number_array=(10 20 30)
for num in "${thread_number_array[@]}"
do
    # 生成对应压测线程的jmx文件
    export jtl_filename="test_${num}.jtl"
    export web_report_path_name="web_${num}"

    # JMeter 静默压测
    ${jmeter_path}/bin/jmeter -n -t ${jmx_filename} -l ${jtl_filename} -Jthread=${num}

    # 生成Web压测报告
    ${jmeter_path}/bin/jmeter -g ${jtl_filename} -e -o ${web_report_path_name}

done
echo "自动化压测全部结束"
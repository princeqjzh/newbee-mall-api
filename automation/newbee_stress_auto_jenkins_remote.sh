#!/usr/bin/env bash

# 压测脚本中设定的压测时间，并发数队列，每组并发压测之间的等待时间，远程节点数，均需要从Jenkins任务参数中传入。
# 参数名称：
#   thread_number_list
#   duration
#   polling
#   nodes_num
# 生成的压测报告入口文件为 ./index.html
export jmx_filename="newbee_stress_complex.jmx"

# 需要在系统变量中定义jmeter根目录的位置，如下
# export jmeter_path="/your jmeter path/"

echo "自动化压测开始"

rm -f index.html
echo "" > index.html

rm -f *.jtl
rm -rf web_*
# 压测并发数列表
thread_number_array=($thread_number_list)
for num in "${thread_number_array[@]}"
do
    echo "单节点压测并发数 ${num}"
    # 定义jtl结果文件名与压测报告路径
    export total_threads=$((${num}*${nodes_num}))
    export jtl_filename="test_${total_threads}.jtl"
    export web_report_path_name="web_${total_threads}"

    # JMeter 远程静默压测 + 生成html压测报告
    ${jmeter_path}/bin/jmeter -n -t ${jmx_filename} -l ${jtl_filename} -r -Jthread=${num} -Jduration=${duration} -e -o ${web_report_path_name}
    echo "结束压测单节点并发数 ${num}"
    echo "<a href='${web_report_path_name}'>${web_report_path_name}</a><br><br>" >> index.html

    sleep ${polling}
done
echo "自动化压测全部结束"


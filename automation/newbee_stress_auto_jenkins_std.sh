#!/usr/bin/env bash

# 压测脚本中设定的压测时间，并发数队列，每组并发压测之间的等待时间，均需要从Jenkins任务参数中传入。
# 参数名称：
#   thread_number_list
#   duration
#   polling
# 生成的压测报告入口文件为 ./index.html
export jmx_template="newbee_stress_complex_std"
export suffix=".jmx"
export jmx_template_filename="${jmx_template}${suffix}"
export os_type=`uname`

# 需要在系统变量中定义jmeter根目录的位置，如下
# export jmeter_path="/your jmeter path/"

echo "自动化压测开始"

rm -f index.html
echo "" > index.html

# 压测并发数列表
thread_number_array=($thread_number_list)
for num in "${thread_number_array[@]}"
do
    echo "压测并发数 ${num}"
    # 定义jtl结果文件名与压测报告路径
    export jmx_filename="${jmx_template}_${num}${suffix}"
    export jtl_filename="test_${num}.jtl"
    export web_report_path_name="web_${num}"

    rm -f ${jmx_filename} ${jtl_filename}
    rm -rf ${web_report_path_name}

    cp ${jmx_template_filename} ${jmx_filename}
    echo "生成jmx压测脚本 ${jmx_filename}"

    # 配置并发数
    if [[ "${os_type}" == "Darwin" ]]; then
        sed -i "" "s/thread_num/${num}/g" ${jmx_filename}
    else
        sed -i "s/thread_num/${num}/g" ${jmx_filename}
    fi

    # 配置运行时间，单位：秒
    if [[ "${os_type}" == "Darwin" ]]; then
        sed -i "" "s/stress_duration/${duration}/g" ${jmx_filename}
    else
        sed -i "s/stress_duration/${duration}/g" ${jmx_filename}
    fi

    # JMeter 远程静默压测 + 生成html压测报告
    ${jmeter_path}/bin/jmeter -n -t ${jmx_filename} -l ${jtl_filename} -e -o ${web_report_path_name}
    echo "结束压测单节点并发数 ${num}"
    echo "<a href='${web_report_path_name}'>${web_report_path_name}</a><br><br>" >> index.html

    sleep ${polling}
done
echo "自动化压测全部结束"


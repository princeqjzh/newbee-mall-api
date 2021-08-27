# 需要事先配置 jmeter_path 环境变量，指向JMeter的根目录
# 环境清理
rm -f ./remote.jtl
rm -rf ./web_report

# 远程静默压测
$jmeter_path/bin/jmeter -n -r -t ../jmx/newbee_stress_complex.jmx -l ./remote.jtl

# 生成web report
$jmeter_path/bin/jmeter -g ./remote.jtl -e -o ./web_report


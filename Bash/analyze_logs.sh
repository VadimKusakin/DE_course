#!/bin/bash

# awk '{print }' access.log

# 1
logs_number=$(awk '{row = NR} END { print row }' access.log)

# 2
unique_ips=$(awk '{ip[$1]++} END {print length(ip)}' access.log)

# 3
methods_number=$(awk '{count[$6]++} END {for (method in count) print count[method], substr(method, 2)}' access.log)

# 4
popular_url=$(awk '{count[$7]++} END {for (url in count) if (count[url] > max) {max = count[url]; popular = url} print max, substr(popular, 2)}' access.log)

cat <<EOL > report.txt
Отчет о логе веб-сервера
========================
Общее количество запросов: $logs_number
Количество уникальных IP-адресов: $unique_ips

Количество запросов по методам:
$methods_number

Самый популярный URL: $popular_url
EOL

echo "Отчет сохранен в файл report.txt"

#./analyze_logs.sh
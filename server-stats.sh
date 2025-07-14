#!/bin/bash

echo "==============================="
echo "📊 SERVER PERFORMANCE STATS"
echo "==============================="

# OS Version
echo -e "\n🖥️ OS Version:"
uname -a

# Uptime
echo -e "\n⏱️ Uptime:"
uptime -p

# Load Average
echo -e "\n📈 Load Average (1, 5, 15 mins):"
uptime | awk -F'load average: ' '{ print $2 }'

# Logged-in Users
echo -e "\n👥 Logged-in Users:"
who

# CPU Usage
echo -e "\n🧠 Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}'

# Memory Usage
echo -e "\n📦 Memory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB / %sMB (%.2f%%)\n", $3, $2, $3*100/$2 }'

# Disk Usage
echo -e "\n💾 Disk Usage:"
df -h --total | grep total | awk '{printf "Used: %s / %s (%s used)\n", $3, $2, $5}'

# Top 5 Processes by CPU
echo -e "\n🔥 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 Processes by Memory
echo -e "\n💡 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Failed Login Attempts
if [ -f /var/log/auth.log ]; then
    echo -e "\n🚫 Failed Login Attempts:"
    grep "Failed password" /var/log/auth.log | wc -l
else
    echo -e "\n🚫 Failed Login Attempts: Log file not found or inaccessible."
fi

echo -e "\n✅ Stats collection complete!"

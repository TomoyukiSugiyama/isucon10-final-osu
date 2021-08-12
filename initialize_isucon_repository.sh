#!/bin/bash
set -x

cd /home/isucon

# システム構成の確認用
system_info_file="system_info.txt"

uptime >> $system_info_file 2>&1
echo "==========" >> $system_info_file

iptables -nv -L >> $system_info_file 2>&1
echo "==========" >> $system_info_file

df -h >> $system_info_file 2>&1
echo "==========" >> $system_info_file

top -b -d 5 -n 5 >> $system_info_file 2>&1
echo "==========" >> $system_info_file

ss -lnp >> $system_info_file 2>&1
echo "==========" >> $system_info_file

netstat -lnp >> $system_info_file 2>&1
echo "==========" >> $system_info_file

systemctl list-unit-files --type=service >> $system_info_file 2>&1
echo "==========" >> $system_info_file

ps aufx --sort -%cpu | head -50 >> $system_info_file 2>&1
echo "==========" >> $system_info_file

ps aufx | grep nginx >> $system_info_file 2>&1
echo "==========" >> $system_info_file

ps aufx | grep mysql >> $system_info_file 2>&1
echo "==========" >> $system_info_file

ps aufx | grep go >> $system_info_file 2>&1
echo "==========" >> $system_info_file

# 各種設定ファイルをとってくる
mkdir org_configs

mkdir org_configs/nginx
cp -r /etc/nginx/ ./org_configs/nginx/

mkdir org_configs/mysql
cp -r /etc/mysql/ ./org_configs/mysql/

mkdir org_configs/systemd
cp -r /etc/systemd/ ./org_configs/systemd/

cp /etc/sysctl.c* ./org_configs/
cp /etc/hosts ./org_configs/

set -eu # こっからは厳しくエラーチェックする
git init

# dummy user
git config user.name "TomoyukiSugiyama"
git config user.email "s_tomoyuki07@yahoo.co.jp" # See: https://github.com/settings/emails of sensuikan1973

git add .
git commit -m "initial commit"
git branch -M main

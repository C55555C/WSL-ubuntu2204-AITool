#!/bin/bash
source ../common.sh
clear
info "拉取 Ollama 模型"
read -p "请输入模型名称（默认 llama3）: " model
model=${model:-llama3}
ollama pull $model
ok "模型 $model 拉取完成"
read -p "按回车键返回菜单..." _
bash ../../wsl-ultimate-deploy.sh

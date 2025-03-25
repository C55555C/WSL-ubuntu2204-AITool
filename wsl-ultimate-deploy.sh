#!/bin/bash
clear
source ./scripts/common.sh

print_info "===== WSL AI 部署工具 ====="

# 系统管理模块
print_info "系统管理:" 
echo " 1. 系统信息查询"
echo " 2. 更新系统软件"
echo " 3. 安装基础组件"
echo " 4. 设置主机名"
echo " 5. 设置密码"
echo " 6. API 检查"
echo " 7. 端口检查/设置"
echo " 8. 进程检查/设置"
echo " 9. 自启动设置"

# Docker 管理模块
print_info "Docker 管理:"
echo " 10. 安装更新环境"
echo " 11. 查看全局状态"
echo " 12. 容器管理"
echo " 13. 镜像管理"
echo " 14. 网络管理"
echo " 15. 卷管理"
echo " 16. 更换 Docker 源"
echo " 17. 清理无用资源"
echo " 18. 卸载 Docker"

# Tailscale 模块
print_info "Tailscale 管理:"
echo " 19. 安装部署"
echo " 20. 登录账号"
echo " 21. 解除冲突占用"
echo " 22. 设置保活（适配 WSL）"
echo " 23. 启用 systemd 自启动"
echo " 24. Funnel 公网映射"
echo " 25. 运行状态检查"
echo " 26. 卸载 Tailscale"

# Ollama 模型模块
print_info "Ollama 管理:"
echo " 27. 安装部署"
echo " 28. 安装模型"
echo " 29. 启动服务"
echo " 30. 启动 GPU 加速"
echo " 31. 运行状态检查"
echo " 32. 卸载 Ollama"

# AnythingLLM 模块
print_info "AnythingLLM 管理:"
echo " 33. 安装部署"
echo " 34. 配置 .env 环境变量"
echo " 35. 启动服务"
echo " 36. 运行状态检查"
echo " 37. 卸载 AnythingLLM"

# Open WebUI 模块
print_info "Open WebUI 管理:"
echo " 38. 安装部署"
echo " 39. 启动服务"
echo " 40. 运行状态检查"
echo " 41. 卸载 Open WebUI"

echo " 0. 退出脚本"

read -p "请输入功能编号 [0-41]: " choice

case $choice in
  1) bash ./scripts/system/info.sh;;
  2) bash ./scripts/system/update.sh;;
  3) bash ./scripts/system/essential.sh;;
  4) bash ./scripts/system/hostname.sh;;
  5) bash ./scripts/system/password.sh;;
  6) bash ./scripts/system/api-check.sh;;
  7) bash ./scripts/system/port-check.sh;;
  8) bash ./scripts/system/process-check.sh;;
  9) bash ./scripts/system/autostart.sh;;

  10) bash ./scripts/docker/install.sh;;
  11) bash ./scripts/docker/status.sh;;
  12) bash ./scripts/docker/containers.sh;;
  13) bash ./scripts/docker/images.sh;;
  14) bash ./scripts/docker/networks.sh;;
  15) bash ./scripts/docker/volumes.sh;;
  16) bash ./scripts/docker/mirror.sh;;
  17) bash ./scripts/docker/clean.sh;;
  18) bash ./scripts/docker/uninstall.sh;;

  19) bash ./scripts/tailscale/install.sh;;
  20) bash ./scripts/tailscale/login.sh;;
  21) bash ./scripts/tailscale/unlock.sh;;
  22) bash ./scripts/tailscale/keepalive.sh;;
  23) bash ./scripts/tailscale/systemd.sh;;
  24) bash ./scripts/tailscale/funnel.sh;;
  25) bash ./scripts/tailscale/status.sh;;
  26) bash ./scripts/tailscale/uninstall.sh;;

  27) bash ./scripts/ollama/install.sh;;
  28) bash ./scripts/ollama/pull-model.sh;;
  29) bash ./scripts/ollama/start.sh;;
  30) bash ./scripts/ollama/start-gpu.sh;;
  31) bash ./scripts/ollama/status.sh;;
  32) bash ./scripts/ollama/uninstall.sh;;

  33) bash ./scripts/anythingllm/install.sh;;
  34) bash ./scripts/anythingllm/config.sh;;
  35) bash ./scripts/anythingllm/start.sh;;
  36) bash ./scripts/anythingllm/status.sh;;
  37) bash ./scripts/anythingllm/uninstall.sh;;

  38) bash ./scripts/openwebui/install.sh;;
  39) bash ./scripts/openwebui/start.sh;;
  40) bash ./scripts/openwebui/status.sh;;
  41) bash ./scripts/openwebui/uninstall.sh;;

  0) echo "👋 再见！"; exit 0;;
  *) echo "❗ 无效输入，请重试。";;
esac

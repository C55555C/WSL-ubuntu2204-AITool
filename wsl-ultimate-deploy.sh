#!/bin/bash
clear
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts"
source $SCRIPT_DIR/common.sh

while true; do
  echo "===== [1;36mWSL AI 部署工具菜单[0m ====="
  echo "Tailscale 管理:"
  echo "  1. 安装 Tailscale"
  echo "  2. 登录账号"
  echo "  3. 启用 systemd 自启动"
  echo "  4. 设置保活机制（适配 WSL）"
  echo
  echo "Ollama 管理:"
  echo "  5. 安装 Ollama"
  echo "  6. 下载模型"
  echo "  7. 启动服务"
  echo
  echo "AnythingLLM 管理:"
  echo "  8. 安装 AnythingLLM"
  echo "  9. 启动服务"
  echo
  echo "Open WebUI 管理:"
  echo " 10. 安装 Open WebUI"
  echo
  echo "  0. 退出脚本"
  echo "=================================="
  read -p "请输入选项 [0-10]: " opt

  case "$opt" in
    1) bash $SCRIPT_DIR/tailscale/install.sh ;;
    2) bash $SCRIPT_DIR/tailscale/login.sh ;;
    3) bash $SCRIPT_DIR/tailscale/enable-systemd.sh ;;
    4) bash $SCRIPT_DIR/tailscale/keepalive.sh ;;
    5) bash $SCRIPT_DIR/ollama/install.sh ;;
    6) bash $SCRIPT_DIR/ollama/pull-model.sh ;;
    7) bash $SCRIPT_DIR/ollama/start.sh ;;
    8) bash $SCRIPT_DIR/anythingllm/install.sh ;;
    9) bash $SCRIPT_DIR/anythingllm/start.sh ;;
   10) bash $SCRIPT_DIR/openwebui/install.sh ;;
    0) echo "👋 再见！"; exit 0 ;;
    *) echo "❗ 无效选项，请重新输入。" ;;
  esac
done

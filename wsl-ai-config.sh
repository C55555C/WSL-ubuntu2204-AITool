#!/bin/bash

CONFIG_FILE="$HOME/.wsl-ai-config"

set_start_shortcut() {
  echo "🎯 当前未设置快捷键，请输入你希望的快捷键组合（例如 ctrl+alt+a）："
  read -p "请输入快捷键：" shortcut
  echo "shortcut=\"$shortcut\"" >> "$CONFIG_FILE"
  echo "✅ 快捷键设置完成：$shortcut"
}

if [ ! -f "$CONFIG_FILE" ]; then
  echo "=============================="
  echo "🟡 第一次运行检测到"
  echo "✅ 请先设置 [工具启动快捷键]"
  echo "=============================="
  echo ""
  set_start_shortcut
  echo "first_run=false" > "$CONFIG_FILE"
fi

main_menu() {
  while true; do
    clear
    echo "===== 🧠 WSL AI 管理工具 ====="
    echo ""
    echo "# 系统管理模块"
    echo " 1. 系统信息"
    echo " 2. 更新系统"
    echo " 3. 安装基础组件"
    echo " 4. 安装常用工具"
    echo " 5. 设置用户名"
    echo " 6. 设置密码"
    echo " 7. 应用管理"
    echo " 8. 显卡信息"
    echo ""
    echo " 99. 修改启动快捷键"
    echo " 0. 退出"
    echo ""
    read -p "请选择操作编号: " choice
    case "$choice" in
      1) source modules/sysinfo.sh; show_sysinfo ;;
      2) source modules/update.sh; update_system ;;
      3) source modules/base.sh; install_base ;;
      4) source modules/tools.sh; install_tools ;;
      5) source modules/username.sh; set_username ;;
      6) source modules/password.sh; set_password ;;
      7) app_menu ;;
      8) source modules/gpu.sh; gpu_info ;;
      99) set_start_shortcut ;;
      0) exit 0 ;;
      *) echo "❌ 无效选择，按回车重试..."; read ;;
    esac
  done
}

app_menu() {
  while true; do
    clear
    echo "===== 应用管理 ====="
    echo " 1. 安装 Docker + NVIDIA"
    echo " 2. 安装 Tailscale"
    echo " 3. 安装 OpenWebUI"
    echo " 4. 安装 Ollama"
    echo " 5. 安装 AnythingLLM"
    echo " 6. 进入 Tailscale 管理"
    echo " 7. 进入 Open WebUI 管理"
    echo " 8. 进入 Ollama 管理"
    echo " 9. 进入 AnythingLLM 管理"
    echo " 0. 返回"
    echo ""
    read -p "请选择操作编号: " choice
    case "$choice" in
      1) source modules/install-docker-nvidia.sh; install_docker_nvidia ;;
      2) echo "🟢 安装 Tailscale（待接入）"; read ;;
      3) echo "🌐 安装 OpenWebUI（待接入）"; read ;;
      4) echo "🦙 安装 Ollama（待接入）"; read ;;
      5) echo "📚 安装 AnythingLLM（待接入）"; read ;;
      6) echo "📡 Tailscale 管理（待接入）"; read ;;
      7) echo "🌐 OpenWebUI 管理（待接入）"; read ;;
      8) echo "🦙 Ollama 管理（待接入）"; read ;;
      9) echo "📚 AnythingLLM 管理（待接入）"; read ;;
      0) break ;;
      *) echo "❌ 无效选择，按回车重试..."; read ;;
    esac
  done
}

main_menu

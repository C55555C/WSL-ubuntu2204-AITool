#!/bin/bash

CONFIG_FILE="$HOME/.wsl-ai-config"

# === 初始化：首次启动提示 ===
if [ ! -f "$CONFIG_FILE" ]; then
  echo "=============================="
  echo "🟡 第一次运行检测到"
  echo "✅ 请先设置 [工具启动快捷键]"
  echo "=============================="
  echo ""
  set_start_shortcut
  echo "first_run=false" > "$CONFIG_FILE"
fi

# === 快捷键设置函数 ===
set_start_shortcut() {
  echo "🎯 当前未设置快捷键，请输入你希望的快捷键组合（例如 ctrl+alt+a）："
  read -p "请输入快捷键：" shortcut
  echo "shortcut=\"$shortcut\"" >> "$CONFIG_FILE"
  echo "✅ 快捷键设置完成：$shortcut"
}

# === 主菜单 ===
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
      1) show_sysinfo ;;
      2) update_system ;;
      3) install_base ;;
      4) install_tools ;;
      5) set_username ;;
      6) set_password ;;
      7) app_menu ;;
      8) gpu_info ;;
      99) set_start_shortcut ;;
      0) exit 0 ;;
      *) echo "❌ 无效选择，按回车重试..." && read ;;
    esac
  done
}

# === 应用管理菜单 ===
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
      1) install_docker ;;
      2) install_tailscale ;;
      3) install_openwebui ;;
      4) install_ollama ;;
      5) install_anythingllm ;;
      6) tailscale_menu ;;
      7) openwebui_menu ;;
      8) ollama_menu ;;
      9) anythingllm_menu ;;
      0) break ;;
      *) echo "❌ 无效选择，按回车重试..." && read ;;
    esac
  done
}

# === 子模块菜单函数 (占位) ===
tailscale_menu() {
  echo "📡 Tailscale 管理功能待开发..."
  read -p "按回车返回"
}

openwebui_menu() {
  echo "🌐 Open WebUI 管理功能待开发..."
  read -p "按回车返回"
}

ollama_menu() {
  echo "🦙 Ollama 管理功能待开发..."
  read -p "按回车返回"
}

anythingllm_menu() {
  echo "📚 AnythingLLM 管理功能待开发..."
  read -p "按回车返回"
}

# === 系统管理占位函数 ===
show_sysinfo() {
  clear
  echo "===== 🖥️ 系统信息 ====="
  echo ""

  echo "👤 当前用户:         $(whoami)"
  echo "📦 系统发行版:       $(lsb_release -ds 2>/dev/null || grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"
  echo "🧠 内核版本:         $(uname -r)"
  echo "🧮 CPU:              $(lscpu | grep 'Model name' | awk -F ':' '{print $2}' | sed 's/^ *//') ($(nproc) cores)"
  echo "💾 内存总量:         $(free -h | awk '/^Mem:/ {print $2}')"

  if grep -qi microsoft /proc/version; then
    echo "🖥️ 是否为 WSL:       是"
  else
    echo "🖥️ 是否为 WSL:       否"
  fi

  echo ""
  echo "🎮 显卡信息:"
  if command -v nvidia-smi >/dev/null 2>&1; then
    nvidia-smi
  else
    echo "⚠️  未检测到 NVIDIA GPU 或未安装驱动"
  fi

  echo ""
  read -p "按回车返回主菜单..."
}

update_system()     { echo "📦 系统更新中（示意）..."; sudo apt update && sudo apt upgrade -y; read -p "按回车返回"; }
install_base()      { echo "🛠️ 安装基础组件（示意）..."; read -p "按回车返回"; }
install_tools()     { echo "🔧 安装常用工具（示意）..."; read -p "按回车返回"; }
set_username()      { echo "👤 设置用户名（示意）..."; read -p "按回车返回"; }
set_password()      { echo "🔒 设置密码（示意）..."; read -p "按回车返回"; }
gpu_info()          { echo "🎮 显卡信息："; nvidia-smi || echo "未检测到 NVIDIA 驱动"; read -p "按回车返回"; }

install_docker()        { echo "🐳 安装 Docker + NVIDIA 工具（待接入脚本）"; read -p "按回车返回"; }
install_tailscale()     { echo "🟢 安装 Tailscale（待接入脚本）"; read -p "按回车返回"; }
install_openwebui()     { echo "🌐 安装 Open WebUI（待接入脚本）"; read -p "按回车返回"; }
install_ollama()        { echo "🦙 安装 Ollama（待接入脚本）"; read -p "按回车返回"; }
install_anythingllm()   { echo "📚 安装 AnythingLLM（待接入脚本）"; read -p "按回车返回"; }

# === 运行入口 ===
main_menu

#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts"

function menu() {
  clear
  echo "🧠 WSL Ultimate Deploy Utility"
  echo "=============================="
  echo " 1. 安装 WSL 软件"
  echo " 2. 检查 Ubuntu 镜像源可用性"
  echo " 3. 下载 Ubuntu 22.04 镜像"
  echo " 4. 导入并创建 WSL 实例"
  echo " 5. 初始化主机名、密码、常用组件"
  echo " 6. 安装 Tailscale 并配置开机自启"
  echo " 7. 安装 Docker"
  echo " 8. 安装 Ollama（可选）"
  echo " 9. 安装 AnythingLLM（可选）"
  echo "10. 安装 Open WebUI（可选）"
  echo " 0. 退出"
  echo "=============================="
  read -p "请输入选项 [0-10]: " option
  echo

  case $option in
    1) install_wsl ;;
    2) check_mirror ;;
    3) download_image ;;
    4) import_instance ;;
    5) bash "$SCRIPT_DIR/system_init.sh" ;;
    6) bash "$SCRIPT_DIR/install_tailscale.sh" ;;
    7) bash "$SCRIPT_DIR/install_docker.sh" ;;
    8) bash "$SCRIPT_DIR/install_ollama.sh" ;;
    9) bash "$SCRIPT_DIR/install_anythingllm.sh" ;;
   10) bash "$SCRIPT_DIR/install_openwebui.sh" ;;
    0) echo "👋 再见！"; exit 0 ;;
    *) echo "❗ 无效选项，请输入 0-10。" ;;
  esac

  read -n 1 -s -r -p $'\n按任意键返回菜单...'
  menu
}

function install_wsl() {
  echo "📦 尝试通过 PowerShell 安装 WSL（需要管理员权限）..."
  powershell.exe -Command "wsl --install"
}

function check_mirror() {
  echo "🔍 正在检查 Ubuntu 镜像源："
  curl -Is https://cloud-images.ubuntu.com/wsl/ | head -n 1
}

function download_image() {
  read -p "请输入保存的文件名（如 ubuntu-22.04lts.tar.gz）: " filename
  url="https://cloud-images.ubuntu.com/wsl/jammy/20250318/ubuntu-jammy-wsl-amd64-ubuntu22.04lts.rootfs.tar.gz"
  echo "⬇️ 开始下载 Ubuntu 22.04 镜像..."
  curl -Lo "$filename" "$url"
  echo "✅ 下载完成: $filename"
}

function import_instance() {
  read -p "请输入实例名称（如 Ubuntu-LLM）: " INSTANCE_NAME
  read -p "请输入安装路径（如 D:\\WSL\\Ubuntu-LLM）: " INSTANCE_PATH
  read -p "请输入镜像文件名（如 ubuntu-22.04lts.tar.gz）: " TARBALL

  echo "📦 导入实例..."
  powershell.exe -Command "wsl --import $INSTANCE_NAME $INSTANCE_PATH $(wslpath -w "$(pwd)/$TARBALL") --version 2"
  echo "✅ 已成功导入 WSL 实例：$INSTANCE_NAME"
}

menu

#!/bin/bash

source modules/sysinfo.sh
source modules/tools.sh
source modules/username.sh
source modules/password.sh
source modules/gpu.sh
source modules/update.sh

source modules/menu-tailscale.sh
source modules/menu-openwebui.sh
source modules/menu-ollama.sh
source modules/menu-anythingllm.sh

main_menu() {
  while true; do
    clear
    echo "===== 🤖 WSL AI 管理工具 ====="
    echo "系统管理:"
    echo " 1. 系统信息"
    echo " 2. 更新系统"
    echo " 3. 安装基础组件"
    echo " 4. 安装常用工具"
    echo " 5. 设置用户名"
    echo " 6. 设置密码"
    echo " 7. 显卡信息"
    echo ""
    echo "应用管理:"
    echo " 11. 安装 Docker + NVIDIA"
    echo " 12. 安装 Tailscale"
    echo " 13. 安装 OpenWebUI"
    echo " 14. 安装 Ollama"
    echo " 15. 安装 AnythingLLM"
    echo ""
    echo "进入管理界面:"
    echo " 21. 进入 Tailscale 管理"
    echo " 22. 进入 OpenWebUI 管理"
    echo " 23. 进入 Ollama 管理"
    echo " 24. 进入 AnythingLLM 管理"
    echo ""
    echo " 0. 退出"
    echo "================================="
    read -p "请选择操作编号: " choice
    case "$choice" in
      1)  sysinfo ;;
      2)  update_system ;;
      3)  install_base_packages ;;
      4)  install_common_tools ;;
      5)  set_username ;;
      6)  set_password ;;
      7)  show_gpu_info ;;

      11) bash modules/install-docker-nvidia.sh ;;
      12) bash modules/install-tailscale.sh ;;
      13) bash modules/install-openwebui.sh ;;
      14) bash modules/install-ollama.sh ;;
      15) bash modules/install-anythingllm.sh ;;

      21) submenu_tailscale ;;
      22) submenu_openwebui ;;
      23) submenu_ollama ;;
      24) submenu_anythingllm ;;

      0)  echo "👋 再见！"; exit 0 ;;
      *)  echo "❌ 无效选项，请重试"; sleep 1 ;;
    esac
  done
}

main_menu

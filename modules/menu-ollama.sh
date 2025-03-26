#!/bin/bash

submenu_ollama() {
  while true; do
    clear
    echo "===== 🦙 Ollama 管理菜单 ====="
    echo " 1. 查看服务状态"
    echo " 2. 启动服务 (systemd)"
    echo " 3. 停止服务 (systemd)"
    echo " 4. 拉取模型"
    echo " 5. 删除所有模型"
    echo " 6. 查看接口状态"
    echo " 7. 查看日志"
    echo " 99. 卸载 Ollama"
    echo " 0. 返回上级菜单"
    echo ""
    read -p "请选择操作编号: " choice
    case "$choice" in
      1)
        systemctl status ollama
        read -p "\n按回车继续..." ;;
      2)
        sudo systemctl start ollama
        echo "✅ 已启动 ollama"
        read -p "\n按回车继续..." ;;
      3)
        sudo systemctl stop ollama
        echo "✅ 已停止 ollama"
        read -p "\n按回车继续..." ;;
      4)
        read -p "请输入模型名称（如 llama3）: " model
        ollama pull "$model"
        read -p "\n按回车继续..." ;;
      5)
        ollama rm -a
        echo "✅ 已删除所有模型"
        read -p "\n按回车继续..." ;;
      6)
        curl http://localhost:11434/api/tags && echo "✅ 接口可访问"
        read -p "\n按回车继续..." ;;
      7)
        journalctl -u ollama -e -f ;;
      99)
        read -p "⚠️ 确认要卸载 Ollama 吗？(y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
          sudo systemctl stop ollama
          sudo rm -f /etc/systemd/system/ollama.service
          sudo systemctl daemon-reload
          sudo rm -rf ~/.ollama /usr/local/bin/ollama
          echo "✅ Ollama 已卸载"
        else
          echo "❎ 已取消卸载"
        fi
        read -p "\n按回车继续..." ;;
      0)
        break ;;
      *)
        echo "❌ 无效选项"; read -p "按回车重试..." ;;
    esac
  done
}

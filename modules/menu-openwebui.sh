#!/bin/bash

submenu_openwebui() {
  while true; do
    clear
    echo "===== 🌐 Open WebUI 管理菜单 ====="
    echo " 1. 启动服务"
    echo " 2. 停止服务"
    echo " 3. 查看日志"
    echo " 4. 重启服务"
    echo " 5. 查看容器状态"
    echo " 99. 卸载 Open WebUI"
    echo " 0. 返回上级菜单"
    echo ""
    read -p "请选择操作编号: " choice
    case "$choice" in
      1)
        docker start openwebui
        echo "✅ 已启动 Open WebUI"
        read -p "\n按回车继续..." ;;
      2)
        docker stop openwebui
        echo "✅ 已停止 Open WebUI"
        read -p "\n按回车继续..." ;;
      3)
        docker logs -f openwebui ;;
      4)
        docker restart openwebui
        echo "✅ 已重启 Open WebUI"
        read -p "\n按回车继续..." ;;
      5)
        docker ps -a | grep openwebui
        read -p "\n按回车继续..." ;;
      99)
        read -p "⚠️ 确认卸载 Open WebUI 吗？(y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
          docker rm -f openwebui
          rm -rf ~/openwebui-data
          echo "✅ Open WebUI 已卸载"
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

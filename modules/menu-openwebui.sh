#!/bin/bash

submenu_openwebui() {
  CONTAINER_NAME="openwebui"
  DATA_DIR="$HOME/openwebui-data"
  IMAGE_NAME="ghcr.io/open-webui/open-webui:main"

  while true; do
    clear
    echo "===== 🌐 Open WebUI 管理菜单 (Docker) ====="
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
        if docker ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
          docker start "$CONTAINER_NAME"
        else
          echo "📦 正在首次运行 Open WebUI 容器..."
          docker run -d \
            --name "$CONTAINER_NAME" \
            -p 3000:3000 \
            -v "$DATA_DIR:/app/backend/data" \
            "$IMAGE_NAME"
        fi
        echo "✅ 已启动 Open WebUI"
        read -p "按回车继续..." ;;
      2)
        docker stop "$CONTAINER_NAME" && echo "✅ 已停止 Open WebUI"
        read -p "按回车继续..." ;;
      3)
        if docker ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
          docker logs -f "$CONTAINER_NAME"
        else
          echo "❌ 容器尚未创建，无法查看日志"
          read -p "按回车继续..." 
        fi ;;
      4)
        docker restart "$CONTAINER_NAME" && echo "✅ 已重启 Open WebUI"
        read -p "按回车继续..." ;;
      5)
        docker ps -a | grep "$CONTAINER_NAME"
        read -p "按回车继续..." ;;
      99)
        read -p "⚠️ 确认要卸载 Open WebUI 吗？(y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
          docker rm -f "$CONTAINER_NAME"
          docker rmi "$IMAGE_NAME"
          rm -rf "$DATA_DIR"
          echo "✅ Open WebUI 已卸载"
        else
          echo "❎ 已取消卸载"
        fi
        read -p "按回车继续..." ;;
      0)
        break ;;
      *)
        echo "❌ 无效选项"; read -p "按回车重试..." ;;
    esac
  done
}

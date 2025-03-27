#!/bin/bash

submenu_tailscale() {
  CONTAINER_NAME="tailscale"
  FUNNEL_PORT=11434  # 可修改为你的服务端口，例如 Ollama

  while true; do
    clear
    echo "===== 🌐 Tailscale 管理菜单 (Docker) ====="
    echo " 1. 查看连接状态"
    echo " 2. 查看当前 IP 地址"
    echo " 3. 登录 (authkey 模式)"
    echo " 4. 断开连接 (logout)"
    echo " 5. 启用 Funnel 公网映射"
    echo " 6. 关闭 Funnel 公网映射"
    echo " 7. API 联通性测试"
    echo " 8. 进入容器交互终端"
    echo " 99. 卸载 Tailscale"
    echo " 0. 返回上级菜单"
    echo ""
    read -p "请选择操作编号: " choice
    case "$choice" in
      1)
        docker exec -it $CONTAINER_NAME tailscale status
        read -p "按回车返回菜单..." ;;
      2)
        docker exec -it $CONTAINER_NAME tailscale ip -4
        read -p "按回车返回菜单..." ;;
      3)
        read -p "请输入 Auth Key: " key
        read -p "请输入机器名称 (hostname): " host
        docker exec -it $CONTAINER_NAME tailscale up --authkey="$key" --hostname="$host"
        read -p "按回车返回菜单..." ;;
      4)
        docker exec -it $CONTAINER_NAME tailscale logout
        echo "✅ 已注销登录"
        read -p "按回车返回菜单..." ;;
      5)
        docker exec -it $CONTAINER_NAME tailscale funnel enable "$FUNNEL_PORT"
        echo "✅ 已启用 funnel 映射端口：$FUNNEL_PORT"
        read -p "按回车返回菜单..." ;;
      6)
        docker exec -it $CONTAINER_NAME tailscale funnel disable "$FUNNEL_PORT"
        echo "✅ 已关闭 funnel 映射端口：$FUNNEL_PORT"
        read -p "按回车返回菜单..." ;;
      7)
        echo "📡 正在测试 API 接口连接（curl localhost:$FUNNEL_PORT/api/tags）..."
        curl -s http://localhost:$FUNNEL_PORT/api/tags && echo -e "\n✅ 接口正常"
        read -p "按回车返回菜单..." ;;
      8)
        docker exec -it $CONTAINER_NAME sh ;;
      99)
        read -p "⚠️ 确认要卸载 Tailscale 吗？(y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
          docker rm -f $CONTAINER_NAME && rm -rf ~/tailscale-docker
          echo "✅ 已卸载 Tailscale 容器与数据目录"
        else
          echo "❎ 已取消卸载"
        fi
        read -p "按回车返回菜单..." ;;
      0)
        break ;;
      *)
        echo "❌ 无效选项"; read -p "按回车重试..." ;;
    esac
  done
}

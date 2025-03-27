#!/bin/bash

submenu_tailscale() {
  CONTAINER_NAME="tailscale"

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
        read -p "请输入要公开的服务端口 (例如 11434): " funnel_port
        funnel_path="/"
        if [[ -z "$funnel_port" ]]; then
          echo "❌ 端口不能为空"
        else
          docker exec -it $CONTAINER_NAME tailscale funnel --set-path "$funnel_path" "$funnel_port"
          if [ $? -eq 0 ]; then
            echo "✅ 已启用 Funnel 公网映射：$funnel_path => $funnel_port"
            docker exec -it $CONTAINER_NAME tailscale ip -4 | while read ip; do
              echo "🌐 公网访问地址：https://$ip.ts.net$funnel_path"
            done
          else
            echo "❌ 启用失败，请检查路径或端口是否已被占用"
          fi
        fi
        read -p "按回车返回菜单..." ;;
      6)
        echo "📋 正在列出当前 Funnel 路径映射..."
        docker exec -it $CONTAINER_NAME tailscale funnel list
        read -p "请输入要关闭的路径 (例如 /): " funnel_path
        read -p "请输入对应的端口 (例如 11434): " funnel_port
        if [[ -z "$funnel_path" || -z "$funnel_port" ]]; then
          echo "❌ 路径或端口不能为空"
        else
          docker exec -it $CONTAINER_NAME tailscale funnel --set-path "$funnel_path" "$funnel_port" off
          if [ $? -eq 0 ]; then
            echo "✅ 已关闭 Funnel 映射：$funnel_path"
          else
            echo "❌ 关闭失败，请确认路径和端口是否正确"
          fi
        fi
        read -p "按回车返回菜单..." ;;
      7)
        read -p "请输入要测试的本地端口 (例如 11434): " test_port
        echo "📡 正在测试 API 接口连接（curl localhost:$test_port/api/tags）..."
        curl -s http://localhost:$test_port/api/tags && echo -e "\n✅ 接口正常" || echo -e "\n❌ 连接失败"
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

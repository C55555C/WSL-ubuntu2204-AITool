#!/bin/bash

submenu_tailscale() {
  while true; do
    clear
    echo "===== 🌐 Tailscale 管理菜单 ====="
    echo " 1. 查看连接状态"
    echo " 2. 查看当前 IP 地址"
    echo " 3. 登录 (authkey 模式)"
    echo " 4. 断开连接 (logout)"
    echo " 5. 查看公网映射 (funnel)"
    echo " 6. 进入容器交互终端"
    echo " 99. 卸载 Tailscale"
    echo " 0. 返回上级菜单"
    echo ""
    read -p "请选择操作编号: " choice
    case "$choice" in
      1)
        docker exec -it tailscale tailscale status
        read -p "\n按回车返回菜单..." ;;
      2)
        docker exec -it tailscale tailscale ip -4
        read -p "\n按回车返回菜单..." ;;
      3)
        read -p "请输入 Auth Key: " key
        read -p "请输入机器名称 (hostname): " host
        docker exec -it tailscale tailscale up --authkey="$key" --hostname="$host"
        read -p "\n按回车返回菜单..." ;;
      4)
        docker exec -it tailscale tailscale logout
        echo "✅ 已注销登录"
        read -p "\n按回车返回菜单..." ;;
      5)
        docker exec -it tailscale tailscale funnel list
        read -p "\n按回车返回菜单..." ;;
      6)
        docker exec -it tailscale sh
        ;;
      99)
        read -p "⚠️ 确认要卸载 Tailscale 吗？(y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
          docker rm -f tailscale && rm -rf ~/tailscale-docker
          echo "✅ 已卸载 Tailscale 容器与数据目录"
        else
          echo "❎ 已取消卸载"
        fi
        read -p "\n按回车返回菜单..." ;;
      0)
        break ;;
      *)
        echo "❌ 无效选项"; read -p "按回车重试..." ;;
    esac
  done
}

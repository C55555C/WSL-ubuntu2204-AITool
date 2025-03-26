#!/bin/bash

submenu_anythingllm() {
  while true; do
    clear
    echo "===== 📚 AnythingLLM 管理菜单 ====="
    echo " 1. 启动服务"
    echo " 2. 停止服务"
    echo " 3. 查看日志"
    echo " 4. 修改配置 (.env)"
    echo " 5. 更新源代码"
    echo " 6. 清除缓存镜像"
    echo " 99. 卸载 AnythingLLM"
    echo " 0. 返回上级菜单"
    echo ""
    read -p "请选择操作编号: " choice
    case "$choice" in
      1)
        cd ~/anything-llm && docker compose up -d
        echo "✅ 服务已启动"
        read -p "按回车继续..." ;;
      2)
        cd ~/anything-llm && docker compose down
        echo "✅ 服务已停止"
        read -p "按回车继续..." ;;
      3)
        cd ~/anything-llm && docker compose logs -f ;;
      4)
        nano ~/anything-llm/.env ;;
      5)
        cd ~/anything-llm && git pull
        echo "✅ 已更新代码"
        read -p "按回车继续..." ;;
      6)
        docker system prune -af
        echo "✅ Docker 缓存已清理"
        read -p "按回车继续..." ;;
      99)
        read -p "⚠️ 确认要卸载 AnythingLLM 吗？(y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
          docker compose down
          rm -rf ~/anything-llm
          echo "✅ AnythingLLM 已卸载"
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

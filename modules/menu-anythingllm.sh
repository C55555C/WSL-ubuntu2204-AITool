#!/bin/bash

submenu_anythingllm() {
  PROJECT_DIR="$HOME/anything-llm"

  while true; do
    clear
    echo "===== 📚 AnythingLLM 管理菜单 (Docker) ====="
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
        if [ -f "$PROJECT_DIR/docker-compose.yml" ]; then
          cd "$PROJECT_DIR" && docker compose up -d
          echo "✅ 服务已启动"
        else
          echo "❌ 未找到 docker-compose.yml，请检查目录：$PROJECT_DIR"
        fi
        read -p "按回车继续..." ;;
      2)
        if [ -f "$PROJECT_DIR/docker-compose.yml" ]; then
          cd "$PROJECT_DIR" && docker compose down
          echo "✅ 服务已停止"
        else
          echo "❌ 未找到 docker-compose.yml，请检查目录：$PROJECT_DIR"
        fi
        read -p "按回车继续..." ;;
      3)
        if [ -f "$PROJECT_DIR/docker-compose.yml" ]; then
          cd "$PROJECT_DIR" && docker compose logs -f
        else
          echo "❌ 未找到 docker-compose.yml"
          read -p "按回车继续..." 
        fi ;;
      4)
        nano "$PROJECT_DIR/.env" ;;
      5)
        if [ -d "$PROJECT_DIR/.git" ]; then
          cd "$PROJECT_DIR" && git pull
          echo "✅ 已更新代码"
        else
          echo "❌ 未初始化 Git 仓库"
        fi
        read -p "按回车继续..." ;;
      6)
        echo "⚠️ 即将清理 Docker 无用镜像和缓存..."
        docker image prune -af
        docker builder prune -af
        echo "✅ Docker 缓存已清理"
        read -p "按回车继续..." ;;
      99)
        read -p "⚠️ 确认要卸载 AnythingLLM 吗？(y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
          if [ -f "$PROJECT_DIR/docker-compose.yml" ]; then
            cd "$PROJECT_DIR" && docker compose down
          fi
          rm -rf "$PROJECT_DIR"
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

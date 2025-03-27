#!/bin/bash

submenu_ollama() {
  while true; do
    clear
    echo "===== 🐳 Ollama (Docker) 管理菜单 ====="
    echo " 1. 查看容器状态"
    echo " 2. 启动容器"
    echo " 3. 停止容器"
    echo " 4. 拉取模型"
    echo " 5. 删除所有模型"
    echo " 6. 查看接口状态"
    echo " 7. 查看日志"
    echo " 99. 卸载 Ollama（Docker）"
    echo " 0. 返回上级菜单"
    echo ""
    read -p "请选择操作编号: " choice
    case "$choice" in
      1)
        docker ps -a | grep ollama
        read -p "按回车继续..." ;;
      2)
        docker start ollama 2>/dev/null || \
        docker run -d --name ollama \
          -p 11434:11434 \
          -v ollama:/root/.ollama \
          ollama/ollama
        echo "✅ 已启动 Docker Ollama 容器"
        read -p "按回车继续..." ;;
      3)
        docker stop ollama && echo "✅ 已停止 ollama 容器"
        read -p "按回车继续..." ;;
      4)
        read -p "请输入模型名称（如 llama3）: " model
        curl -X POST http://localhost:11434/api/pull -d "{\"name\": \"$model\"}"
        read -p "按回车继续..." ;;
      5)
        docker exec ollama ollama rm -a
        echo "✅ 已删除所有模型"
        read -p "按回车继续..." ;;
      6)
        curl http://localhost:11434/api/tags && echo "✅ 接口可访问"
        read -p "按回车继续..." ;;
      7)
        docker logs -f ollama ;;
      99)
        read -p "⚠️ 确认要卸载 Docker Ollama 吗？(y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
          docker stop ollama
          docker rm ollama
          docker volume rm ollama
          echo "✅ 已卸载 Docker Ollama 容器及数据"
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

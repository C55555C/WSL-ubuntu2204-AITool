install_tools() {
  clear
  echo "===== 🔧 安装常用工具 ====="
  TOOLS=(htop neofetch ncdu tmux tree jq)

  echo "将安装以下工具："
  echo "${TOOLS[*]}"
  echo ""
  read -p "是否继续安装？(y/n): " confirm
  [[ "$confirm" != "y" ]] && echo "❎ 已取消安装" && read -p "按回车返回..." && return

  sudo apt update
  sudo apt install -y "${TOOLS[@]}"
  echo ""
  echo "✅ 常用工具安装完成！"
  read -p "按回车返回主菜单..."
}

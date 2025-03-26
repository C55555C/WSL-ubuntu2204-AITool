update_system() {
  clear
  echo "===== 📦 更新系统 ====="
  echo ""
  echo "将执行以下操作："
  echo " 1. sudo apt update"
  echo " 2. sudo apt upgrade -y"
  echo " 3. sudo apt autoremove -y && sudo apt clean"
  echo ""
  read -p "是否继续？(y/n): " confirm
  [[ "$confirm" != "y" ]] && echo "❎ 已取消操作" && read -p "按回车返回..." && return

  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y
  sudo apt clean

  echo ""
  echo "✅ 系统更新完成！"
  read -p "按回车返回主菜单..."
}

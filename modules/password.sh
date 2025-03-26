set_password() {
  clear
  echo "===== 🔒 设置用户密码 ====="
  echo ""
  echo "输入 q 可取消设置"
  echo ""
  read -p "请输入要修改密码的用户名（当前用户为 $(whoami)）: " user
  [[ "$user" == "q" || "$user" == "Q" ]] && echo "❎ 已取消操作" && read -p "按回车返回..." && return

  sudo passwd "$user"
  echo ""
  echo "✅ 密码设置完成（如无报错）"
  read -p "按回车返回主菜单..."
}

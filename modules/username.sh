set_username() {
  clear
  echo "===== 👤 设置新用户名 ====="
  echo ""
  echo "提示：创建的新用户将拥有 sudo 权限"
  echo "输入 q 可取消操作并返回主菜单"
  echo ""

  read -p "请输入新用户名（或输入 q 返回）: " new_user
  [[ "$new_user" == "q" || "$new_user" == "Q" ]] && echo "❎ 已取消创建新用户" && read -p "按回车返回..." && return

  if id "$new_user" >/dev/null 2>&1; then
    echo "⚠️ 用户 $new_user 已存在"
  else
    sudo adduser "$new_user"
    sudo usermod -aG sudo "$new_user"
    echo "✅ 用户 $new_user 已创建并已加入 sudo 组"
  fi

  echo ""
  read -p "按回车返回主菜单..."
}

install_base() {
  clear
  echo "===== ⚙️ 安装基础组件 ====="
  echo ""

  BASE_PACKAGES=(
    curl wget git vim
    build-essential lsb-release
    net-tools dnsutils
    zip unzip tar
    software-properties-common
    ca-certificates gnupg
  )

  echo "将安装以下软件包："
  echo "${BASE_PACKAGES[*]}"
  echo ""
  read -p "是否继续安装？(y/n): " confirm
  [[ "$confirm" != "y" ]] && echo "❎ 已取消安装" && read -p "按回车返回..." && return

  sudo apt update
  sudo apt install -y "${BASE_PACKAGES[@]}"

  echo ""
  echo "✅ 基础组件安装完成！"
  read -p "按回车返回主菜单..."
}

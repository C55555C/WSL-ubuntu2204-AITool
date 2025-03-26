show_sysinfo() {
  clear
  echo "===== 🖥️ 系统信息 ====="
  echo ""

  echo "👤 当前用户:         $(whoami)"
  echo "📦 系统发行版:       $(lsb_release -ds 2>/dev/null || grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"
  echo "🧠 内核版本:         $(uname -r)"
  echo "🧮 CPU:              $(lscpu | grep 'Model name' | awk -F ':' '{print $2}' | sed 's/^ *//') ($(nproc) cores)"
  echo "💾 内存总量:         $(free -h | awk '/^Mem:/ {print $2}')"

  if grep -qi microsoft /proc/version; then
    echo "🖥️ 是否为 WSL:       是"
  else
    echo "🖥️ 是否为 WSL:       否"
  fi

  echo ""
  echo "🎮 显卡信息:"
  if command -v nvidia-smi >/dev/null 2>&1; then
    nvidia-smi
  else
    echo "⚠️  未检测到 NVIDIA GPU 或未安装驱动"
  fi

  echo ""
  read -p "按回车返回主菜单..."
}

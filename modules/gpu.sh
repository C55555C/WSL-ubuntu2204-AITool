gpu_info() {
  clear
  echo "===== 🎮 显卡信息 ====="
  echo ""

  if command -v nvidia-smi >/dev/null 2>&1; then
    nvidia-smi
  else
    echo "⚠️ 未检测到 NVIDIA 驱动或未安装 nvidia-smi"
    echo ""
    echo "🧪 使用 lspci 检测显卡信息："
    lspci | grep -i vga || echo "未找到 VGA 设备"
  fi

  echo ""
  read -p "按回车返回主菜单..."
}

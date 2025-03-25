# WSL-ubuntu2204-AITool

一个基于 Windows WSL 的 AI 工具本地部署脚本工具集，支持：

- Ubuntu 22.04 多实例手动部署
- Tailscale 网络连接（支持 Systemd 自启动）
- Docker 环境初始化
- Ollama / AnythingLLM / Open WebUI 模块化安装（按需选择）

## 快速开始

```bash
git clone git@github.com:C55555C/WSL-ubuntu2204-AITool.git
cd WSL-ubuntu2204-AITool
bash wsl-ultimate-deploy.sh

## WSL AI 部署工具

本工具为 Windows + WSL Ubuntu 用户设计的一站式 AI 服务部署终端

## WSL Ubuntu-2204 一键极速安装

 - 下载 Install-WSL-Ubuntu.ps1 

 - 打开 PowerShell（以管理员身份）执行以下代码
Set-ExecutionPolicy Bypass -Scope Process -Force
.\Install-WSL-Ubuntu.ps1

 - 安装后建议用以下命令进入：
wsl -d Ubuntu-2204

## WSL Ubuntu-2204 手动安装

 - 常用 WSL 命令
wsl --list --online				          //查看可安装的 Linux 发行版列表
wsl --list --installed		          //查看已安装的发行版
wsl --list --verbose		          	//列出已安装的发行版
wsl --set-version <Distro> 2	      //将指定发行版设置为使用 WSL2
wsl --set-default-version 2		      //将默认 WSL 版本设置为 WSL2
wsl -d <Distro>				            	//启动指定的 Linux 发行版
wsl --update				              	//更新 WSL 内核
wsl --unregister Ubuntu			        //销毁 会完全清除该 Linux 发行版的文件系统和数据
wsl --install -d Ubuntu --name Ubuntu2    	//安装多个可以指定不同名称
-- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- --
修改wslconfig后记得执行：  wsl --shutdown
-- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
## 官方 WSL（自动安装 Ubuntu 最新 LTS）
wsl --install
-- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
## 官方安装特定版本的 Linux（例如 Ubuntu 20.04）
wsl --install -d Ubuntu-20.04
-- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
## 镜像下载
https://cloud-images.ubuntu.com/wsl/  
-- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
## 指定目录安装
mkdir D:\WSL\Ubuntu
wsl --import Ubuntu D:\WSL\Ubuntu D:\WSL\ubuntu-jammy-wsl-amd64-ubuntu22.04lts.rootfs.tar.gz --version 2
-- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
## 安装 WSL-ubuntu2204-AITool 工具脚本
首次使用前建议操作
chmod +x wsl-ultimate-deploy.sh
chmod +x scripts/**/*.sh

你也可以添加别名到 .bashrc
echo "alias ai-deploy='bash ~/WSL-ubuntu2204-AITool/wsl-ultimate-deploy.sh'" >> ~/.bashrc
source ~/.bashrc

以后只需输入
ai-deploy
即可进入你的部署控制台

## 包含内容
- wsl-ultimate-deploy.sh 主控菜单脚本（含完整 case 结构 1-41）
- scripts/ 目录中细分所有模块子功能：
- system/：系统管理（9 项）
- docker/：Docker 管理（9 项）
- tailscale/：Tailscale 管理（8 项）
- ollama/：Ollama 管理（6 项）
- anythingllm/：AnythingLLM（5 项）
- openwebui/：Open WebUI（4 项）
- common.sh：命令输出美化函数库

## 系统管理模块
  系统管理:  
1. 系统信息查询 
2. 更新系统软件 
3. 安装基础组件 
4. 设置主机名 
5. 设置密码 
6. API 检查 
7. 端口检查/设置 
8. 进程检查/设置 
9. 自启动设置 

## Docker 管理模块
  Docker 管理: 
10. 安装更新环境 
11. 查看全局状态 
12. 容器管理 
13. 镜像管理 
14. 网络管理 
15. 卷管理 
16. 更换 Docker 源 
17. 清理无用资源 
18. 卸载 Docker 

## Tailscale 模块
 Tailscale 管理: 
19. 安装部署 
20. 登录账号 
21. 解除冲突占用 
22. 设置保活（适配 WSL） 
23. 启用 systemd 自启动 
24. Funnel 公网映射 
25. 运行状态检查 
26. 卸载 Tailscale 

## Ollama 模型模块
 Ollama 管理: 
27. 安装部署 
28. 安装模型 
29. 启动服务 
30. 启动 GPU 加速 
31. 运行状态检查 
32. 卸载 Ollama 

## AnythingLLM 模块
 AnythingLLM 管理: 
33. 安装部署 
34. 配置 .env 环境变量 
35. 启动服务 
36. 运行状态检查 
37. 卸载 AnythingLLM 

## Open WebUI 模块
 Open WebUI 管理: 
38. 安装部署 
39. 启动服务 
40. 运行状态检查 
41. 卸载 Open WebUI 

0. 退出脚本

scripts/
├── system/                # 系统管理工具
│   ├── info.sh            # 查看系统信息
│   ├── update.sh          # 系统更新（apt update & upgrade）
│   ├── essential.sh       # 安装基础依赖（curl, git 等）
│   ├── hostname.sh        # 修改主机名
│   ├── password.sh        # 修改用户密码
│   ├── api-check.sh       # API 通信状态检查
│   ├── port-check.sh      # 检查端口占用情况
│   ├── process-check.sh   # 检查进程运行状态
│   └── autostart.sh       # systemd 自动启动配置
│
├── docker/                # Docker 管理模块
│   ├── install.sh         # 安装 Docker & Docker Compose
│   ├── status.sh          # 查看 Docker 运行状态
│   ├── containers.sh      # 列出容器
│   ├── images.sh          # 列出镜像
│   ├── networks.sh        # 管理网络
│   ├── volumes.sh         # 管理卷
│   ├── mirror.sh          # 设置国内镜像源
│   ├── clean.sh           # 清理无用资源
│   ├── uninstall.sh       # 卸载 Docker
│   └── common.sh          # 公共函数（供其他脚本调用）
│
├── tailscale/             # Tailscale 模块
│   ├── install.sh         # 安装 Tailscale
│   ├── login.sh           # 登录 Tailscale
│   ├── unlock.sh          # 解锁后台访问（authkey 或 browser-less 模式）
│   ├── keepalive.sh       # 保活机制（防断连）
│   ├── systemd.sh         # 设置 tailscaled 为 systemd 自启动
│   ├── funnel.sh          # 启用 Tailscale Funnel（公网入口）
│   ├── status.sh          # 查看状态
│   └── uninstall.sh       # 卸载 Tailscale
│
├── ollama/                # Ollama 模型服务管理
│   ├── install.sh         # 安装 Ollama
│   ├── pull-model.sh      # 拉取模型（如 llama3）
│   ├── start.sh           # 启动服务（默认CPU）
│   ├── start-gpu.sh       # 启动服务（GPU加速）
│   ├── status.sh          # 查看运行状态
│   └── uninstall.sh       # 卸载 Ollama
│
├── anythingllm/           # AnythingLLM 管理模块
│   ├── install.sh         # 安装 AnythingLLM
│   ├── config.sh          # 配置参数
│   ├── start.sh           # 启动服务
│   ├── status.sh          # 查看运行状态
│   └── uninstall.sh       # 卸载 AnythingLLM
│
└── openwebui/             # Open WebUI 管理模块
    ├── install.sh         # 安装 Open WebUI
    ├── start.sh           # 启动服务
    ├── status.sh          # 查看运行状态
    └── uninstall.sh       # 卸载 Open WebUI


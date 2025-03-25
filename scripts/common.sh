# 更新 common.sh 文件
cat > ./scripts/common.sh << 'EOF'
#!/bin/bash
function print_info()  { echo -e "\033[1;34m[INFO]\033[0m $1"; }
function print_warn()  { echo -e "\033[1;33m[WARN]\033[0m $1"; }
function print_error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; }
function print_ok()    { echo -e "\033[1;32m[OK]\033[0m $1"; }

# 添加公共返回菜单函数
function return_to_menu() {
    read -p "按回车键返回菜单..." _
    bash $(dirname "$(dirname "$(realpath "$0")")")/wsl-ultimate-deploy.sh
}

# 添加通用模块执行函数
function run_module() {
    local module=$1
    local action=$2
    local module_upper=$(echo "$module" | tr '[:lower:]' '[:upper:]')
    local action_upper=$(echo "$action" | tr '-' ' ' | tr '[:lower:]' '[:upper:]')
    
    clear
    print_info "$module_upper - $action_upper"
    
    # 根据模块和操作执行不同的操作逻辑
    case "$module/$action" in
        "system/info")
            echo "系统信息："
            uname -a
            lsb_release -a 2>/dev/null || cat /etc/os-release
            echo "CPU 信息："
            grep "model name" /proc/cpuinfo | head -1
            echo "内存信息："
            free -h
            echo "磁盘信息："
            df -h
            ;;
            
        "system/update")
            echo "更新系统软件包..."
            apt update && apt upgrade -y
            print_ok "系统更新完成"
            ;;
            
        "docker/install")
            echo "安装 Docker..."
            apt update
            apt install -y apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
            add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
            apt update
            apt install -y docker-ce docker-ce-cli containerd.io
            
            # 添加当前用户到docker组
            usermod -aG docker $USER
            
            print_ok "Docker 安装完成"
            ;;
            
        # 可以根据需要添加更多的条件分支来实现其他模块和功能
            
        *)
            echo "执行 $module 模块中 $action 功能..."
            echo "此功能尚未实现，等待开发..."
            ;;
    esac
    
    return_to_menu
}
EOF

# 更新 wsl-ultimate-deploy.sh 文件
cat > ./wsl-ultimate-deploy.sh << 'EOF'
#!/bin/bash
clear
source ./scripts/common.sh

print_info "===== WSL AI 部署工具 ====="

# 使用数组定义菜单项，格式：[模块]=[功能1,功能2,...]
declare -A MODULES
MODULES["system"]="info,update,essential,hostname,password,api-check,port-check,process-check,autostart"
MODULES["docker"]="install,status,containers,images,networks,volumes,mirror,clean,uninstall"
MODULES["tailscale"]="install,login,unlock,keepalive,systemd,funnel,status,uninstall"
MODULES["ollama"]="install,pull-model,start,start-gpu,status,uninstall"
MODULES["anythingllm"]="install,config,start,status,uninstall"
MODULES["openwebui"]="install,start,status,uninstall"

# 模块标题映射
declare -A MODULE_TITLES
MODULE_TITLES["system"]="系统管理"
MODULE_TITLES["docker"]="Docker 管理"
MODULE_TITLES["tailscale"]="Tailscale 管理"
MODULE_TITLES["ollama"]="Ollama 管理"
MODULE_TITLES["anythingllm"]="AnythingLLM 管理"
MODULE_TITLES["openwebui"]="Open WebUI 管理"

# 功能名称映射
declare -A ACTION_TITLES
ACTION_TITLES["info"]="系统信息查询"
ACTION_TITLES["update"]="更新系统软件"
ACTION_TITLES["essential"]="安装基础组件"
ACTION_TITLES["hostname"]="设置主机名"
ACTION_TITLES["password"]="设置密码"
ACTION_TITLES["api-check"]="API 检查"
ACTION_TITLES["port-check"]="端口检查/设置"
ACTION_TITLES["process-check"]="进程检查/设置"
ACTION_TITLES["autostart"]="自启动设置"

ACTION_TITLES["install"]="安装更新环境"
ACTION_TITLES["status"]="查看全局状态"
ACTION_TITLES["containers"]="容器管理"
ACTION_TITLES["images"]="镜像管理"
ACTION_TITLES["networks"]="网络管理"
ACTION_TITLES["volumes"]="卷管理"
ACTION_TITLES["mirror"]="更换 Docker 源"
ACTION_TITLES["clean"]="清理无用资源"
ACTION_TITLES["uninstall"]="卸载服务"

ACTION_TITLES["login"]="登录账号"
ACTION_TITLES["unlock"]="解除冲突占用"
ACTION_TITLES["keepalive"]="设置保活（适配 WSL）"
ACTION_TITLES["systemd"]="启用 systemd 自启动"
ACTION_TITLES["funnel"]="Funnel 公网映射"

ACTION_TITLES["pull-model"]="安装模型"
ACTION_TITLES["start"]="启动服务"
ACTION_TITLES["start-gpu"]="启动 GPU 加速"
ACTION_TITLES["config"]="配置 .env 环境变量"

# 生成菜单
menu_id=1
declare -A MENU_MAP

for module in "${!MODULES[@]}"; do
    IFS=',' read -r -a actions <<< "${MODULES[$module]}"
    
    print_info "${MODULE_TITLES[$module]}:"
    
    for action in "${actions[@]}"; do
        title="${ACTION_TITLES[$action]}"
        # 如果没有为此操作定义标题，使用默认格式
        if [ -z "$title" ]; then
            title="${action^}"
        fi
        
        echo " $menu_id. $title"
        MENU_MAP[$menu_id]="$module/$action"
        ((menu_id++))
    done
    
    echo
done

echo " 0. 退出脚本"

# 获取菜单最大编号
max_id=$((menu_id-1))

read -p "请输入功能编号 [0-$max_id]: " choice

if [ "$choice" == "0" ]; then
    echo "👋 再见！"
    exit 0
fi

if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -le "$max_id" ]; then
    selection="${MENU_MAP[$choice]}"
    IFS='/' read -r module action <<< "$selection"
    script_path="./scripts/$module/$action.sh"
    
    if [ -f "$script_path" ]; then
        bash "$script_path"
    else
        print_error "脚本文件不存在: $script_path"
        sleep 2
        exec "$0"
    fi
else
    print_error "❗ 无效输入，请重试。"
    sleep 2
    exec "$0"
fi
EOF

# 创建脚本生成工具
cat > ./generate-all-scripts.sh << 'EOF'
#!/bin/bash
# 生成所有模块的脚本文件

# 定义模块和功能
declare -A MODULES
MODULES["system"]="info,update,essential,hostname,password,api-check,port-check,process-check,autostart"
MODULES["docker"]="install,status,containers,images,networks,volumes,mirror,clean,uninstall"
MODULES["tailscale"]="install,login,unlock,keepalive,systemd,funnel,status,uninstall"
MODULES["ollama"]="install,pull-model,start,start-gpu,status,uninstall"
MODULES["anythingllm"]="install,config,start,status,uninstall"
MODULES["openwebui"]="install,start,status,uninstall"

# 生成所有脚本
for module in "${!MODULES[@]}"; do
    echo "处理模块: $module"
    mkdir -p "./scripts/$module"
    
    IFS=',' read -r -a actions <<< "${MODULES[$module]}"
    for action in "${actions[@]}"; do
        script_path="./scripts/$module/$action.sh"
        echo "  创建脚本: $script_path"
        
        # 生成脚本内容
        cat > "$script_path" << EOF2
#!/bin/bash
source ../common.sh
run_module "$module" "$action"
EOF2
        
        # 添加执行权限
        chmod +x "$script_path"
    done
done

echo "所有脚本生成完成"
EOF

# 添加执行权限
chmod +x ./wsl-ultimate-deploy.sh
chmod +x ./generate-all-scripts.sh
chmod +x ./scripts/common.sh

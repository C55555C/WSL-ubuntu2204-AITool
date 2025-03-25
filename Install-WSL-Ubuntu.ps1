# 设置变量
$DistroName = "Ubuntu-2204"
$InstallDir = "D:\WSL\$DistroName"
$AppDataDir = "D:\WSL\data"
$ImageUrl = "https://cloud-images.ubuntu.com/wsl/jammy/current/ubuntu-jammy-wsl-amd64-ubuntu22.04lts.rootfs.tar.gz"
$ImageFile = "$env:TEMP\ubuntu-2204.tar.gz"

# 确保创建目标目录
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir | Out-Null
}
if (!(Test-Path $AppDataDir)) {
    New-Item -ItemType Directory -Path $AppDataDir | Out-Null
}

# 配置 .wslconfig 让 WSL2 默认虚拟磁盘在 D 盘

$WSLConfigPath = "$env:USERPROFILE\.wslconfig"
@"
[wsl2]
appdata = $AppDataDir
"@ | Out-File -Encoding UTF8 -FilePath $WSLConfigPath

Write-Host " 🔄 设置默认 WSL2 虚拟磁盘路径到：$AppDataDir" -ForegroundColor Cyan

# 下载 Ubuntu 22.04 镜像
Write-Host " ⬇️  下载 Ubuntu 22.04 官方镜像中..." -ForegroundColor Yellow
Write-Host " 🈲  此不要强制关闭 会导致磁盘损坏" -ForegroundColor Yellow
Invoke-WebRequest -Uri $ImageUrl -OutFile $ImageFile

# 导入镜像为新的 WSL 发行版
Write-Host " 📦 正在导入 Ubuntu 到 D 盘..." -ForegroundColor Green
wsl --import $DistroName $InstallDir $ImageFile --version 2

# 启动并配置基本环境
Write-Host " 🚀 启动新系统..." -ForegroundColor Green
wsl -d $DistroName -- bash -c "echo -e '[boot]\nsystemd=false' > /etc/wsl.conf"

Write-Host " ✅ Ubuntu 22.04 已成功安装到：$InstallDir" -ForegroundColor Green
Write-Host "📌 你可以通过下面命令进入：     wsl -d $DistroName" -ForegroundColor Cyan
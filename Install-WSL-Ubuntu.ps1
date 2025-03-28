# 默认值设置
$DefaultDistro = "Ubuntu-OLM"
$DefaultUser = "ubuntu"
$DefaultImageFile = "$env:TEMP\ubuntu22.04lts.rootfs.tar.gz"

# 获取用户输入
$DistroName = Read-Host "请输入你希望创建的 WSL 发行版名称（默认: $DefaultDistro）"
if ([string]::IsNullOrWhiteSpace($DistroName)) {
    $DistroName = $DefaultDistro
}

$Username = Read-Host "请输入预设的用户名（默认: $DefaultUser）"
if ([string]::IsNullOrWhiteSpace($Username)) {
    $Username = $DefaultUser
}

$ImageFile = Read-Host "请输入 Ubuntu 镜像文件路径（默认: $DefaultImageFile）"
if ([string]::IsNullOrWhiteSpace($ImageFile)) {
    $ImageFile = $DefaultImageFile
}

# 安全获取用户密码
$SecurePassword = Read-Host "请输入该用户的密码" -AsSecureString
$PlainPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
)

# 设置路径变量
$InstallDir = "D:\WSL\$DistroName"
$AppDataDir = "D:\WSL\data"

# 创建目标目录
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir | Out-Null
}
if (!(Test-Path $AppDataDir)) {
    New-Item -ItemType Directory -Path $AppDataDir | Out-Null
}

# 导入为新的 WSL 发行版
Write-Host " 📦 正在导入 Ubuntu 到 D 盘..." -ForegroundColor Green
wsl --import $DistroName $InstallDir $ImageFile --version 2

# 配置 systemd（可选）
Write-Host " 🚀 启动新系统..." -ForegroundColor Green
wsl -d $DistroName -- bash -c "echo -e '[boot]\nsystemd=false' > /etc/wsl.conf"

# 创建指定用户名（如不存在）
Write-Host " 👤 创建默认用户 $Username..." -ForegroundColor Cyan
wsl -d $DistroName -- bash -c "adduser --disabled-password --gecos '' $Username && usermod -aG sudo $Username"

# 设置用户密码
Write-Host " 🔐 设置用户密码..." -ForegroundColor Cyan
$passwdCommand = "echo '${Username}:${PlainPassword}' | chpasswd"
wsl -d $DistroName -- bash -c "$passwdCommand"

# 设置默认用户（通过修改 /etc/wsl.conf）
Write-Host " ⚙️ 设置默认用户为 $Username..." -ForegroundColor Cyan
wsl -d $DistroName -- bash -c "echo -e '[user]\ndefault=$Username' >> /etc/wsl.conf"

Write-Host "`n✅ Ubuntu 22.04 已成功安装到：$InstallDir" -ForegroundColor Green
Write-Host "📌 你可以通过下面命令进入系统：" -ForegroundColor Cyan
Write-Host "    wsl -d $DistroName -u $Username" -ForegroundColor Yellow

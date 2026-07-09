# Script tự động cấu hình và deploy website Hugo lên GitHub Pages
# Cách chạy: Mở PowerShell tại thư mục này và gõ: .\deploy.ps1

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "   HUGO TO GITHUB PAGES DEPLOYMENT TOOL   " -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# 1. Yêu cầu nhập thông tin GitHub
$username = Read-Host "1. Nhập tên tài khoản GitHub của bạn (ví dụ: lenguyennhathuy)"
$repo = Read-Host "2. Nhập tên Repository đã tạo trên GitHub (ví dụ: my-blog)"
$token = Read-Host "3. Nhập/Paste mã truy cập cá nhân GitHub PAT (ghp_...)"

if ([string]::IsNullOrWhiteSpace($username) -or [string]::IsNullOrWhiteSpace($repo) -or [string]::IsNullOrWhiteSpace($token)) {
    Write-Error "Các thông tin không được để trống!"
    exit 1
}

# Chuẩn hóa đầu vào (xóa khoảng trắng thừa)
$username = $username.Trim()
$repo = $repo.Trim()
$token = $token.Trim()

Write-Host "`n[1/3] Đang cấu hình baseURL trong config.toml..." -ForegroundColor Green
$configPath = "config.toml"
if (Test-Path $configPath) {
    $content = Get-Content $configPath -Raw
    # Sửa dòng baseURL
    $pattern = '(?m)^baseURL\s*=\s*".*"'
    $replacement = 'baseURL = "https://' + $username + '.github.io/' + $repo + '/"'
    if ($content -match $pattern) {
        $content = $content -replace $pattern, $replacement
        [System.IO.File]::WriteAllText($configPath, $content, (New-Object System.Text.UTF8Encoding($false)))
        Write-Host "-> Đã cập nhật baseURL thành https://$username.github.io/$repo/" -ForegroundColor Cyan
    } else {
        Write-Warning "-> Không tìm thấy cấu hình baseURL trong config.toml!"
    }
} else {
    Write-Error "-> Không tìm thấy file config.toml!"
    exit 1
}

Write-Host "`n[2/3] Đang chuẩn bị Git..." -ForegroundColor Green
# Thêm file vào staging
git add .

# Commit
git commit -m "Cấu hình deployment GitHub Pages"

# Đổi tên nhánh thành main
git branch -M main

# Xóa remote cũ nếu có
git remote remove origin 2>$null

# Thêm remote mới với Token để tự động đăng nhập khi push
$remoteUrlWithToken = "https://${username}:${token}@github.com/${username}/${repo}.git"
git remote add origin $remoteUrlWithToken

Write-Host "`n[3/3] Đang đẩy code lên GitHub..." -ForegroundColor Green
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n[THÀNH CÔNG] Đã đẩy code lên GitHub thành công!" -ForegroundColor Green
    
    # Khôi phục remote URL chuẩn (không chứa token) để đảm bảo bảo mật cho file .git/config
    $remoteUrlStandard = "https://github.com/${username}/${repo}.git"
    git remote set-url origin $remoteUrlStandard
    Write-Host "-> Đã ẩn mã token khỏi Git Remote URL để bảo mật tài khoản." -ForegroundColor Cyan
    
    Write-Host "`n=============================================" -ForegroundColor Yellow
    Write-Host "   CÁC BƯỚC TIẾP THEO TRÊN GIAO DIỆN GITHUB  " -ForegroundColor Yellow
    Write-Host "=============================================" -ForegroundColor Yellow
    Write-Host "1. Truy cập vào Repo của bạn: https://github.com/$username/$repo/settings/pages"
    Write-Host "2. Tại mục 'Build and deployment':"
    Write-Host "   - Source: Chọn 'Deploy from a branch'"
    Write-Host "   - Branch: Chọn nhánh 'gh-pages' và thư mục '/ (root)'"
    Write-Host "   - Nhấn nút 'Save'"
    Write-Host "3. Chờ khoảng 1 phút và tải lại trang để nhận link trực tiếp!"
    Write-Host "=============================================" -ForegroundColor Yellow
} else {
    # Khôi phục remote URL chuẩn ngay cả khi lỗi để bảo vệ token
    git remote remove origin 2>$null
    Write-Error "Đã xảy ra lỗi khi đẩy code lên GitHub. Vui lòng kiểm tra lại token hoặc tên tài khoản/repo!"
}

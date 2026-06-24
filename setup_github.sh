#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  GitHub Pages 部署脚本 - 初始化配置
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
#  用途：
#    1. 初始化 Git 仓库
#    2. 创建基本文件（README.md, index.html）
#    3. 推送到 GitHub
#    4. 启用 GitHub Pages
#
#  使用前提：
#    ✓ GitHub 账号（无需实名认证）
#    ✓ SSH 密钥已添加到 GitHub（ssh -T git@github.com 测试通过）
#
#  优势：
#    • 免费 HTTPS（自动证书）
#    • 无需实名认证
#    • 自定义域名支持
#    • 访问速度较快
#    • 仓库可以是私有的（Pro 账户）或公开的（免费账户）
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

# ────────────────────────────────────────────────────────────────────────────
#  配置区 - 请根据实际情况修改
# ────────────────────────────────────────────────────────────────────────────

GITHUB_USERNAME="ruyanc"        # 您的 GitHub 用户名
REPO_NAME="tc-forecast"            # 仓库名称（自定义）
REPO_URL="git@github.com:${GITHUB_USERNAME}/${REPO_NAME}.git"

# ────────────────────────────────────────────────────────────────────────────

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🚀 GitHub Pages 部署初始化"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "仓库信息："
echo "  用户名: $GITHUB_USERNAME"
echo "  仓库名: $REPO_NAME"
echo "  SSH URL: $REPO_URL"
echo ""

# 检查 SSH 密钥
echo "→ 检查 GitHub SSH 连接..."
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "  ✓ SSH 认证成功"
else
    echo "  ✗ SSH 认证失败"
    echo ""
    echo "请先配置 SSH 密钥："
    echo "  1. 生成密钥: ssh-keygen -t ed25519 -C 'your_email@example.com'"
    echo "  2. 复制公钥: cat ~/.ssh/id_ed25519.pub"
    echo "  3. 添加到 GitHub: https://github.com/settings/ssh/new"
    echo "  4. 测试连接: ssh -T git@github.com"
    exit 1
fi

# 初始化 Git 仓库
if [ ! -d .git ]; then
    echo ""
    echo "→ 初始化 Git 仓库..."
    git init
    git config user.name "${GITHUB_USERNAME}"
    git config user.email "${GITHUB_USERNAME}@users.noreply.github.com"
    echo "  ✓ Git 仓库已初始化"
else
    echo ""
    echo "→ Git 仓库已存在"
fi

# 创建 README.md
echo ""
echo "→ 创建 README.md..."
cat > README.md << 'EOF'
# WRF 台风预报可视化

实时台风路径预报和强度分析。

## 最新预报

访问 [预报页面](https://ruyanc.github.io/tc-forecast/) 查看最新结果。

## 数据来源

- 模式：WRF-ARW v4.6
- 分辨率：3 km
- 初始场：GFS / GDAS
- 数据同化：GSI + FGAT

## 更新频率

每日 00Z / 12Z 自动更新

---

*Powered by WRF Forecast System*
EOF
echo "  ✓ README.md 已创建"

# 确保 index.html 存在
if [ ! -f index.html ]; then
    echo ""
    echo "→ 创建默认 index.html..."
    cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WRF 台风预报</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #f5f5f5;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 { color: #333; border-bottom: 3px solid #0366d6; padding-bottom: 10px; }
        .status { color: #666; margin: 20px 0; }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background: #0366d6;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }
        .btn:hover { background: #0256c4; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🌀 WRF 台风预报系统</h1>
        <p class="status">预报数据准备中...</p>
        <p>请稍后访问或联系管理员获取最新预报链接。</p>
        <a href="https://github.com/ruyanc/tc-forecast" class="btn">访问 GitHub 仓库</a>
    </div>
</body>
</html>
EOF
    echo "  ✓ index.html 已创建"
else
    echo ""
    echo "→ index.html 已存在（当前指向: $(readlink -f index.html 2>/dev/null || echo 'track_2026062212_nrt_1.html')）"
fi

# 添加 .gitignore
echo ""
echo "→ 创建 .gitignore..."
cat > .gitignore << 'EOF'
# 临时文件
*.tmp
*.swp
*~

# 部署脚本（可选）
# setup_*.sh
# update_*.sh
EOF
echo "  ✓ .gitignore 已创建"

# 添加所有文件
echo ""
echo "→ 添加文件到 Git..."
git add .
echo "  ✓ 文件已暂存"

# 提交
echo ""
echo "→ 提交到本地仓库..."
git commit -m "初始化 WRF 台风预报网站" || echo "  (无新更改或已提交)"

# 设置远程仓库
echo ""
echo "→ 配置远程仓库..."
if git remote | grep -q "^origin$"; then
    echo "  → 远程仓库已存在，更新 URL..."
    git remote set-url origin "$REPO_URL"
else
    git remote add origin "$REPO_URL"
fi
echo "  ✓ 远程仓库: $REPO_URL"

# 推送到 GitHub
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📤 推送到 GitHub"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "注意：首次推送前，请先在 GitHub 创建仓库："
echo "  1. 访问: https://github.com/new"
echo "  2. 仓库名: $REPO_NAME"
echo "  3. 可见性: Public（免费账户）或 Private（Pro 账户）"
echo "  4. 不要勾选 'Initialize this repository with a README'"
echo ""
read -p "仓库已创建？按回车继续推送... " dummy

git branch -M main
git push -u origin main

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ 部署成功"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "下一步：启用 GitHub Pages"
echo ""
echo "  1. 访问仓库设置页面："
echo "     https://github.com/$GITHUB_USERNAME/$REPO_NAME/settings/pages"
echo ""
echo "  2. 在 'Build and deployment' 部分："
echo "     - Source: Deploy from a branch"
echo "     - Branch: main"
echo "     - Folder: / (root)"
echo ""
echo "  3. 点击 Save 保存"
echo ""
echo "  4. 等待 1-2 分钟，页面会显示访问地址："
echo "     https://$GITHUB_USERNAME.github.io/$REPO_NAME/"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "后续更新使用: bash update_github.sh"
echo ""


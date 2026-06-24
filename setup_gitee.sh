#!/bin/bash
# =============================================================================
# Gitee Pages 快速部署脚本
# =============================================================================

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Gitee Pages 部署脚本"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 检查是否已是 git 仓库
if [ -d ".git" ]; then
    echo "✓ 已存在 Git 仓库"
else
    echo "→ 初始化 Git 仓库..."
    git init
    echo "✓ Git 仓库初始化完成"
fi

# 创建 .gitignore（如果不存在）
if [ ! -f ".gitignore" ]; then
    cat > .gitignore << 'GITIGNORE'
# 临时文件
*.tmp
*.log
.DS_Store

# 大文件（超过 100MB 的 HTML 请压缩）
# *.html
GITIGNORE
    echo "✓ 创建 .gitignore"
fi

# 创建 README
cat > README.md << 'README'
# WRF 预报可视化

WRF 台风预报路径交互式可视化页面。

## 功能

- 🌍 Leaflet 地图底图（CartoDB Dark）
- 🌀 台风路径与风圈半径（34/50/64kt）
- 🌊 SST（海表温度）叠加
- 🌧️ 降水场可视化
- 💨 动态粒子风场
- 📊 Plotly 强度时序图（中国气象局热带气旋等级）
- 📍 TCvitals 实况路径与预报轨迹对比

## 访问

在线访问：[点击查看](https://你的用户名.gitee.io/wrf-forecast/)

## 更新日志

- 2026-06-24: 初始发布
README
    echo "✓ 创建 README.md"

# 创建首页（index.html）
if [ ! -f "index.html" ]; then
    LATEST_HTML=$(ls -t track_*.html 2>/dev/null | head -1)
    if [ -n "$LATEST_HTML" ]; then
        ln -sf "$LATEST_HTML" index.html
        echo "✓ 创建 index.html → $LATEST_HTML"
    else
        cat > index.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>WRF 预报可视化</title>
    <style>
        body { font-family: sans-serif; padding: 40px; background: #1a1a1a; color: #fff; }
        h1 { color: #29B6F6; }
        ul { list-style: none; }
        a { color: #66BB6A; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h1>🌀 WRF 台风预报可视化</h1>
    <h2>可用预报：</h2>
    <ul id="file-list"></ul>
    <script>
        fetch(window.location.href)
            .then(r => r.text())
            .then(html => {
                const files = html.match(/track_\d+.*?\.html/g) || [];
                const ul = document.getElementById('file-list');
                [...new Set(files)].forEach(f => {
                    const li = document.createElement('li');
                    li.innerHTML = `<a href="${f}">📊 ${f}</a>`;
                    ul.appendChild(li);
                });
            });
    </script>
</body>
</html>
HTML
        echo "✓ 创建 index.html（目录页）"
    fi
fi

# 添加所有文件
echo ""
echo "→ 添加文件到 Git..."
git add .
echo "✓ 文件已添加"

# 提交
echo ""
echo "→ 提交到本地仓库..."
git commit -m "WRF forecast visualization - $(date +%Y%m%d)" || echo "  (无新变更)"
echo "✓ 提交完成"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  下一步："
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1. 在 Gitee 创建仓库（如果还没有）:"
echo "   https://gitee.com/projects/new"
echo ""
echo "2. 添加远程仓库并推送:"
echo "   git remote add origin https://gitee.com/你的用户名/wrf-forecast.git"
echo "   git push -u origin master"
echo ""
echo "3. 启用 Gitee Pages:"
echo "   • 进入仓库 → 服务 → Gitee Pages"
echo "   • 点击「启动」"
echo ""
echo "4. 访问你的网站:"
echo "   https://你的用户名.gitee.io/wrf-forecast/"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

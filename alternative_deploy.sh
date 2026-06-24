#!/bin/bash

cat << 'GUIDE'
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  如果 Gitee Pages 不可用，替代方案
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

方案一：GitHub Pages（推荐 - 无需认证）
────────────────────────────────────────────

1. 创建 GitHub 仓库
   https://github.com/new
   仓库名：tc-tracker
   公开/私有均可（公开才能用 Pages）

2. 添加 GitHub 远程仓库
   cd /home/chenry/WORK/push-html
   git remote add github https://github.com/你的用户名/tc-tracker.git
   
   或使用 SSH：
   git remote add github git@github.com:你的用户名/tc-tracker.git

3. 推送到 GitHub
   git push github master

4. 启用 GitHub Pages
   Settings → Pages → Source: Deploy from a branch
   Branch: master / (root)
   
5. 访问地址（约 1 分钟后生效）
   https://你的用户名.github.io/tc-tracker/

优点：
  ✓ 无需实名认证
  ✓ 免费 HTTPS 证书
  ✓ 全球 CDN
  ✗ 国内访问可能较慢

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

方案二：Vercel（最简单 - 拖拽部署）
────────────────────────────────────────────

1. 访问 https://vercel.com
   使用 GitHub 账号登录

2. 点击 "Add New..." → "Project"

3. 导入仓库
   • 选择刚才推送的 GitHub 仓库
   • 或直接上传 /home/chenry/WORK/push-html 文件夹

4. 部署设置
   Framework Preset: Other
   Build Command: （留空）
   Output Directory: ./

5. 点击 Deploy
   约 30 秒后部署完成

6. 访问地址
   https://tc-tracker-xxx.vercel.app

优点：
  ✓ 全球 CDN（包含中国节点）
  ✓ 自动 HTTPS
  ✓ 部署速度快
  ✓ 支持自定义域名

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

方案三：Netlify（拖拽即部署）
────────────────────────────────────────────

1. 访问 https://app.netlify.com

2. 直接拖拽部署
   将 /home/chenry/WORK/push-html 文件夹
   拖入浏览器窗口

3. 部署完成
   获得随机域名：https://random-name.netlify.app

4. 后续更新
   可绑定 Git 仓库自动部署
   或继续拖拽新文件夹更新

优点：
  ✓ 最简单（无需 Git）
  ✓ 自动 HTTPS
  ✓ 全球 CDN

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

方案四：本地快速预览（临时测试）
────────────────────────────────────────────

如果只是想快速查看效果：

cd /home/chenry/WORK/push-html
python3 -m http.server 8080

然后在浏览器访问：
  http://服务器IP:8080/track_2026062212_nrt_1.html

注意：
  • 需要服务器防火墙开放 8080 端口
  • 仅适合临时测试，不适合长期使用
  • Ctrl+C 停止服务

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 推荐顺序：

无需认证、最快上线：
  → Netlify（拖拽部署）

需要自定义域名、稳定服务：
  → GitHub Pages 或 Vercel

只是测试查看效果：
  → 本地 HTTP 服务器

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

快速操作：GitHub Pages 部署
────────────────────────────────────────────

# 1. 添加 GitHub 远程仓库（使用 SSH）
cd /home/chenry/WORK/push-html
git remote add github git@github.com:你的用户名/tc-tracker.git

# 2. 推送
git push github master

# 3. 在 GitHub 仓库页面启用 Pages
# Settings → Pages → Source: master → Save

# 4. 访问
# https://你的用户名.github.io/tc-tracker/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
GUIDE

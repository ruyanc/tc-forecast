#!/bin/bash

cat << 'GUIDE'
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  自定义域名发布指南
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

当前方案对比：

┌─────────────────────────────────────────────────────────┐
│ 方案          │ 默认域名                │ 自定义域名      │
├───────────────┼─────────────────────────┼─────────────────┤
│ Gitee Pages   │ user.gitee.io/repo      │ ✓ 支持         │
│ GitHub Pages  │ user.github.io/repo     │ ✓ 支持（免费）  │
│ Vercel        │ xxx.vercel.app          │ ✓ 支持（免费）  │
│ Netlify       │ xxx.netlify.app         │ ✓ 支持（免费）  │
│ 自建服务器     │ IP 地址                 │ ✓ 完全自由      │
└─────────────────────────────────────────────────────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📍 方案一：Gitee Pages + 自定义域名
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

【前提条件】
  1. ✓ 已购买域名（例如：forecast.example.com）
  2. ✓ 域名已备案（中国大陆要求，约 20 天）
  3. ✓ 已启用 Gitee Pages

【配置步骤】

① DNS 解析设置（在域名服务商控制台）

   记录类型  主机记录     记录值
   ────────────────────────────────────────
   CNAME    forecast     你的用户名.gitee.io
   
   示例：
   - 主机记录：forecast
   - 记录类型：CNAME
   - 记录值：chenry.gitee.io
   - TTL：600（10分钟）

② Gitee Pages 绑定域名

   进入 Gitee 仓库：
   服务 → Gitee Pages → 自定义域名
   
   输入：forecast.example.com
   点击「保存」

③ 验证生效（约 10 分钟后）

   ping forecast.example.com
   # 应解析到 Gitee Pages IP

   curl -I https://forecast.example.com
   # 应返回 200 OK

【访问地址】
  https://forecast.example.com/track_2026062212_nrt_1.html

【注意】
  ⚠️  Gitee Pages 免费版不提供 HTTPS 证书
  ⚠️  需要升级到 Gitee Pages Pro（付费）才能使用 HTTPS

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌐 方案二：GitHub Pages + 自定义域名（推荐 - 免费 HTTPS）
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

【前提条件】
  1. ✓ 已购买域名
  2. ✗ 无需备案（国外服务）
  3. ✓ 已启用 GitHub Pages

【配置步骤】

① DNS 解析设置

   记录类型  主机记录     记录值
   ────────────────────────────────────────
   CNAME    forecast     你的用户名.github.io

② GitHub Pages 绑定域名

   仓库 Settings → Pages → Custom domain
   输入：forecast.example.com
   ✓ 勾选 "Enforce HTTPS"（自动申请免费证书）

③ 等待证书生效（约 1-24 小时）

【访问地址】
  https://forecast.example.com  （✓ 免费 HTTPS）

【优势】
  ✓ 免费 Let's Encrypt HTTPS 证书
  ✓ 无需备案（国外服务器）
  ✓ 全球 CDN 加速
  ✗ 国内访问速度可能较慢

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ 方案三：Vercel/Netlify + 自定义域名（最简单）
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

【Vercel 配置】

① 部署到 Vercel
   https://vercel.com
   导入仓库或拖拽 push-html 文件夹

② 添加域名
   Settings → Domains → Add
   输入：forecast.example.com
   
③ 在 DNS 服务商添加 CNAME 记录
   记录类型：CNAME
   主机记录：forecast
   记录值：cname.vercel-dns.com

④ 等待验证（约 1 分钟）
   Vercel 自动配置 HTTPS 证书

【Netlify 配置】

① 拖拽部署
   https://netlify.com → Drop
   拖入 push-html 文件夹

② 设置自定义域名
   Domain settings → Add custom domain
   输入：forecast.example.com

③ 配置 DNS
   按照 Netlify 提示添加 CNAME 记录

【访问地址】
  https://forecast.example.com  （✓ 免费 HTTPS）

【优势】
  ✓ 全自动 HTTPS 证书
  ✓ 全球 CDN（包含中国节点）
  ✓ 部署速度快（秒级）
  ✓ 无需备案（境外服务）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔧 方案四：自建服务器 + Nginx（完全控制）
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

【前提条件】
  1. ✓ 有公网服务器（VPS/云主机）
  2. ✓ 域名已备案（如在中国大陆）
  3. ✓ 服务器已安装 Nginx

【配置步骤】

① 上传网页文件
   scp -r /home/chenry/WORK/push-html \
       user@your-server:/var/www/forecast

② Nginx 配置（/etc/nginx/sites-available/forecast）

   server {
       listen 80;
       server_name forecast.example.com;
       root /var/www/forecast;
       
       location / {
           index index.html track_2026062212_nrt_1.html;
           try_files $uri $uri/ =404;
       }
       
       # Gzip 压缩
       gzip on;
       gzip_types text/html application/javascript text/css;
   }

③ 启用站点
   sudo ln -s /etc/nginx/sites-available/forecast \
              /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl reload nginx

④ 配置 HTTPS（使用 Let's Encrypt）
   sudo apt install certbot python3-certbot-nginx
   sudo certbot --nginx -d forecast.example.com
   # 自动配置 HTTPS，证书 90 天自动续期

⑤ DNS 解析
   记录类型：A
   主机记录：forecast
   记录值：你的服务器公网 IP

【访问地址】
  https://forecast.example.com

【优势】
  ✓ 完全控制
  ✓ 无流量限制
  ✓ 可配置访问控制（HTTP Basic Auth）
  ✗ 需要服务器维护

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 推荐方案总结
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

场景                    推荐方案
────────────────────────────────────────────────────
国内用户访问             Gitee Pages（需备案）
                        或 Vercel（有中国 CDN）

国际访问                 GitHub Pages 或 Vercel

最快部署                 Netlify（拖拽即用）

需要 HTTPS              GitHub/Vercel/Netlify（免费）
                        或自建服务器 + Let's Encrypt

完全控制/内网部署        自建 Nginx 服务器

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 域名购买渠道
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

国内：
  • 阿里云万网：https://wanwang.aliyun.com
  • 腾讯云 DNSPod：https://dnspod.cloud.tencent.com
  • 华为云：https://www.huaweicloud.com/product/domain.html

国际：
  • Cloudflare：https://www.cloudflare.com/zh-cn/
  • Namecheap：https://www.namecheap.com
  • GoDaddy：https://www.godaddy.com

价格参考：
  .com  约 60-80 元/年
  .cn   约 30-50 元/年
  .org  约 70-100 元/年

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
GUIDE

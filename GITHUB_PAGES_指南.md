# GitHub Pages 部署指南

本指南帮助您将 WRF 台风预报可视化页面部署到 GitHub Pages。

---

## ✨ GitHub Pages 优势

相比 Gitee Pages，GitHub Pages 具有以下优势：

| 特性 | GitHub Pages | Gitee Pages |
|------|--------------|-------------|
| 实名认证 | ❌ **不需要** | ✅ 需要 |
| HTTPS 支持 | ✅ 免费自动证书 | ✅ 支持 |
| 自定义域名 | ✅ 免费 | ✅ 付费会员 |
| 访问速度 | 🌍 国际较快 | 🇨🇳 国内较快 |
| 仓库可见性 | 公开/私有均可 | 公开 |
| 部署速度 | ⚡ 1-2 分钟 | ⚡ 1-2 分钟 |

**推荐使用 GitHub Pages**（无需实名认证，更便捷）

---

## 📋 前置要求

### 1️⃣ GitHub 账号

- 访问 https://github.com/signup 注册
- **无需实名认证**

### 2️⃣ SSH 密钥配置

检查是否已有 SSH 密钥：

```bash
ls -la ~/.ssh/id_*.pub
```

如果没有，生成新密钥：

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

查看公钥：

```bash
cat ~/.ssh/id_ed25519.pub
```

添加到 GitHub：

1. 访问 https://github.com/settings/ssh/new
2. 粘贴公钥内容
3. 点击 "Add SSH key"

测试连接：

```bash
ssh -T git@github.com
```

成功输出：`Hi username! You've successfully authenticated...`

---

## 🚀 快速部署（3 步）

### 步骤 1：创建 GitHub 仓库

1. 访问 https://github.com/new
2. 填写信息：
   - **Repository name**: `tc-forecast`（或自定义名称）
   - **Visibility**: 
     - **Public** - 免费账户推荐
     - Private - 需要 GitHub Pro
   - ❌ **不要勾选** "Initialize this repository with a README"
3. 点击 **Create repository**

### 步骤 2：运行初始化脚本

```bash
cd /home/chenry/WORK/push-html
bash setup_github.sh
```

脚本会：
- ✅ 检查 SSH 连接
- ✅ 初始化 Git 仓库
- ✅ 创建 README.md 和 index.html
- ✅ 推送到 GitHub

### 步骤 3：启用 GitHub Pages

1. 访问仓库设置页面：
   ```
   https://github.com/ruyanc/tc-forecast/settings/pages
   ```

2. 在 **Build and deployment** 部分：
   - **Source**: Deploy from a branch
   - **Branch**: `main`
   - **Folder**: `/ (root)`

3. 点击 **Save**

4. 等待 1-2 分钟，页面顶部会显示：
   ```
   ✅ Your site is live at https://ruyanc.github.io/tc-forecast/
   ```

---

## 🔄 更新预报文件

每次有新的预报文件，运行：

```bash
cd /home/chenry/WORK/push-html
bash update_github.sh "更新 2026062312 预报"
```

或使用默认提交信息：

```bash
bash update_github.sh
```

网站会在 1-2 分钟内自动更新。

---

## 📝 自定义配置

### 修改仓库名称

编辑 `setup_github.sh`：

```bash
REPO_NAME="tc-forecast"     # 改为您想要的名称
```

### 修改 GitHub 用户名

编辑 `setup_github.sh`：

```bash
GITHUB_USERNAME="ruyanc"  # 改为您的 GitHub 用户名
```

---

## 🌐 自定义域名（可选）

### 1️⃣ 准备域名

假设您有域名 `tc.example.com`

### 2️⃣ 配置 DNS

在您的域名服务商（阿里云、腾讯云等）添加 DNS 记录：

**方式 A - CNAME（推荐）**

| 类型 | 名称 | 值 |
|------|------|-----|
| CNAME | tc | ruyanc.github.io |

**方式 B - A 记录**

| 类型 | 名称 | 值 |
|------|------|-----|
| A | tc | 185.199.108.153 |
| A | tc | 185.199.109.153 |
| A | tc | 185.199.110.153 |
| A | tc | 185.199.111.153 |

### 3️⃣ 配置 GitHub Pages

1. 访问仓库设置页面：
   ```
   https://github.com/ruyanc/tc-forecast/settings/pages
   ```

2. 在 **Custom domain** 输入：
   ```
   tc.example.com
   ```

3. 点击 **Save**

4. 勾选 **Enforce HTTPS**（等待 DNS 验证通过后）

### 4️⃣ 验证

等待 5-10 分钟后，访问：
```
https://tc.example.com
```

---

## 🛠️ 常见问题

### Q1: `git push` 提示权限错误

**错误信息**：
```
Permission denied (publickey).
```

**解决方法**：
检查 SSH 密钥是否已添加到 GitHub：

```bash
ssh -T git@github.com
```

如果失败，重新生成并添加 SSH 密钥（参考前置要求部分）。

### Q2: Pages 显示 404

**可能原因**：
1. 未启用 GitHub Pages
2. Branch 选择错误（应为 `main`）
3. 部署尚未完成

**解决方法**：
1. 确认 Settings → Pages 配置正确
2. 查看部署状态：
   ```
   https://github.com/ruyanc/tc-forecast/actions
   ```
3. 等待部署完成（通常 1-2 分钟）

### Q3: 页面内容未更新

**可能原因**：
浏览器缓存

**解决方法**：
- 硬刷新：`Ctrl + F5`（Windows）或 `Cmd + Shift + R`（Mac）
- 或清除浏览器缓存

### Q4: 文件太大无法推送

**错误信息**：
```
remote: error: File track_*.html is 100.00 MB; this exceeds GitHub's file size limit of 100 MB
```

**解决方法**：

GitHub 单文件限制 100 MB，但您的 HTML 文件仅 4.4 MB，不会遇到此问题。

如果未来有大文件，可以：
1. 压缩 HTML（删除不必要的数据）
2. 使用 Git LFS（大文件存储）
3. 将数据分离到 JSON 文件

### Q5: 私有仓库能用 GitHub Pages 吗？

**回答**：
- **GitHub Pro / Team / Enterprise**：✅ 支持
- **免费账户**：❌ 仅支持公开仓库

推荐使用公开仓库（预报数据通常可公开）。

---

## 📊 部署状态监控

### 查看部署历史

访问 Actions 页面：
```
https://github.com/ruyanc/tc-forecast/actions
```

### 查看部署日志

1. 点击最新的 workflow run
2. 点击 `pages build and deployment`
3. 查看详细日志

### 部署失败通知

GitHub 会通过邮件通知部署失败（如果启用了通知）。

---

## 🎯 完整工作流示例

### 场景：发布新的预报

```bash
# 1. 切换到 push-html 目录
cd /home/chenry/WORK/push-html

# 2. 复制新的预报文件（如果需要）
cp /path/to/new/track_2026062412_nrt.html .

# 3. 更新 index.html 链接（如果需要）
ln -sf track_2026062412_nrt.html index.html

# 4. 推送更新
bash update_github.sh "更新 2026-06-24 12Z 预报"

# 5. 等待 1-2 分钟后访问网站
# https://ruyanc.github.io/tc-forecast/
```

---

## 📚 相关链接

- **GitHub Pages 官方文档**：https://docs.github.com/pages
- **自定义域名配置**：https://docs.github.com/pages/configuring-a-custom-domain-for-your-github-pages-site
- **SSH 密钥管理**：https://docs.github.com/authentication/connecting-to-github-with-ssh

---

## 💡 最佳实践

### 1. 自动化部署

可以在 WRF 预报完成后自动部署：

```bash
# 在 scripts/run_tracker.sh 末尾添加
if [ -f "${TRACKER_OUTPUT}/track_${TAG}.html" ]; then
    cp "${TRACKER_OUTPUT}/track_${TAG}.html" /home/chenry/WORK/push-html/
    cd /home/chenry/WORK/push-html
    ln -sf "track_${TAG}.html" index.html
    bash update_github.sh "自动更新预报 ${TAG}"
fi
```

### 2. 保留历史预报

```bash
# 不删除旧文件，让用户可以查看历史预报
# index.html 始终指向最新预报
# 旧预报可通过直接链接访问
```

### 3. 添加预报列表页

创建一个 `forecasts.html` 列出所有历史预报：

```html
<!DOCTYPE html>
<html>
<head><title>预报列表</title></head>
<body>
  <h1>历史预报</h1>
  <ul>
    <li><a href="track_2026062412_nrt.html">2026-06-24 12Z</a></li>
    <li><a href="track_2026062312_nrt.html">2026-06-23 12Z</a></li>
    <!-- 自动生成 -->
  </ul>
</body>
</html>
```

---

**祝部署顺利！** 🎉


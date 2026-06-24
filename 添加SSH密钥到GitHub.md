# 添加 SSH 密钥到 GitHub

您已有 SSH 密钥，只需添加到 GitHub 即可使用。

---

## 🔑 您的 SSH 公钥

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIh+4C8nqPVQHRf8mHKo1rWs88waD8MhEGbNDQPuVAFx chenry@gitee
```

---

## ⚡ 快速添加步骤

### 1️⃣ 复制公钥

在终端运行（自动复制到剪贴板）：

```bash
cat ~/.ssh/id_ed25519.pub
```

然后复制输出的内容。

### 2️⃣ 添加到 GitHub

1. **访问 GitHub SSH 设置页面**：
   
   https://github.com/settings/ssh/new

2. **填写表单**：
   - **Title**: `NX-DH-login` 或 `WRF Server`（便于识别）
   - **Key**: 粘贴刚才复制的公钥

3. **点击 "Add SSH key"**

4. **输入 GitHub 密码确认**

### 3️⃣ 验证

在终端运行：

```bash
ssh -T git@github.com
```

**成功输出示例**：
```
Hi ruyanc! You've successfully authenticated, but GitHub does not provide shell access.
```

如果看到这个消息，说明配置成功！✅

---

## 🚀 下一步：部署网站

SSH 密钥添加成功后，运行：

```bash
cd /home/chenry/WORK/push-html
bash setup_github.sh
```

---

## 🔧 故障排查

### 问题：Permission denied (publickey)

**原因**：SSH 密钥未添加到 GitHub

**解决**：重新检查步骤 2，确保：
- 公钥完整复制（从 `ssh-ed25519` 开始到 `chenry@gitee` 结束）
- 粘贴时没有多余的空格或换行
- 点击了 "Add SSH key" 按钮

### 问题：WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED

**原因**：GitHub 主机密钥变更

**解决**：
```bash
ssh-keygen -R github.com
ssh -T git@github.com  # 输入 yes 接受新指纹
```

---

## 📖 参考链接

- GitHub SSH 文档：https://docs.github.com/authentication/connecting-to-github-with-ssh
- SSH 密钥管理：https://github.com/settings/keys


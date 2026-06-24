# DNS 配置示例

## 域名示例：forecast.example.com

### 方案一：GitHub Pages

```
记录类型：CNAME
主机记录：forecast
记录值：你的用户名.github.io
TTL：600（或自动）
```

**完成后访问：** `https://forecast.example.com`

### 方案二：Vercel

```
记录类型：CNAME
主机记录：forecast
记录值：cname.vercel-dns.com
TTL：600
```

**完成后访问：** `https://forecast.example.com`

### 方案三：Netlify

```
记录类型：CNAME
主机记录：forecast
记录值：[Netlify提供的专属地址]
TTL：600
```

### 方案四：自建服务器

```
记录类型：A
主机记录：forecast
记录值：你的服务器IP（如 123.45.67.89）
TTL：600
```

## 常见 DNS 服务商控制台

- **阿里云**：控制台 → 云解析 DNS → 解析设置
- **腾讯云**：控制台 → DNSPod → 我的域名
- **Cloudflare**：Dashboard → DNS → Records
- **华为云**：控制台 → 云解析服务 → 公网域名

## 验证解析是否生效

```bash
# Linux/Mac
nslookup forecast.example.com
dig forecast.example.com

# Windows
nslookup forecast.example.com
```

预期结果：
- CNAME 记录：应指向对应平台域名
- A 记录：应返回服务器 IP

## 注意事项

1. DNS 解析生效时间：通常 10 分钟 - 24 小时
2. 可使用 https://dnschecker.org 检查全球解析状态
3. HTTPS 证书签发时间：1-24 小时（自动）

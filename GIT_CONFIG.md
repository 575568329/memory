# Git 推送配置说明

> 记忆系统的Git推送配置

---

## ✅ 当前配置：SSH密钥认证

**配置时间**：2026-03-26

**认证方式**：SSH密钥（id_ed25519）

**远程仓库**：
```bash
origin  git@github.com:575568329/memory.git
```

**优势**：
- ✅ 安全：使用公钥加密认证
- ✅ 便捷：无需输入密码或令牌
- ✅ 稳定：不依赖代理服务
- ✅ 推荐：GitHub官方推荐方式

---

## 🚀 使用方法

### 日常推送

```bash
cd ~/.adaptive-memory

# 添加更改
git add .

# 提交
git commit -m "描述信息"

# 推送（自动使用SSH密钥）
git push origin master
```

### 从其他设备推送

```bash
# 如果其他设备也配置了同样的SSH密钥
git push origin master

# 无需额外配置
```

---

## 🔑 SSH密钥信息

**密钥类型**：ed25519

**密钥位置**：
- 私钥：`~/.ssh/id_ed25519`
- 公钥：`~/.ssh/id_ed25519.pub`

**GitHub配置**：
- 已添加到：https://github.com/settings/keys
- 标题：`Claude Code Memory`

---

## 📝 配置历史

### 2026-03-26：切换到SSH认证

**原因**：
- HTTPS连接超时
- 需要更稳定的推送方式

**操作**：
1. 验证SSH密钥存在 ✅
2. 测试SSH连接成功 ✅
3. 移除HTTP代理配置 ✅
4. 切换远程仓库为SSH协议 ✅
5. 成功推送到GitHub ✅

**结果**：
- 推送速度更快
- 连接更稳定
- 无需额外配置

---

## ⚙️ 其他设备配置

### 在新设备上使用相同的SSH密钥

**步骤**：

1. **复制私钥到新设备**
   ```bash
   # 从当前设备复制私钥
   scp ~/.ssh/id_ed25519 user@new-device:~/.ssh/
   scp ~/.ssh/id_ed25519.pub user@new-device:~/.ssh/
   ```

2. **设置权限**
   ```bash
   # 在新设备上
   chmod 600 ~/.ssh/id_ed25519
   chmod 644 ~/.ssh/id_ed25519.pub
   ```

3. **测试连接**
   ```bash
   ssh -T git@github.com
   ```

4. **克隆仓库**
   ```bash
   git clone git@github.com:575568329/memory.git ~/.adaptive-memory
   ```

### 或者在新设备上生成新的SSH密钥

```bash
# 1. 生成新密钥
ssh-keygen -t ed25519 -C "your_email@example.com"

# 2. 显示公钥
cat ~/.ssh/id_ed25519.pub

# 3. 添加到GitHub
# 访问：https://github.com/settings/keys

# 4. 测试连接
ssh -T git@github.com

# 5. 克隆仓库
git clone git@github.com:575568329/memory.git ~/.adaptive-memory
```

---

## 🔧 故障排查

### 问题1：SSH连接失败

**症状**：
```bash
ssh: connect to host github.com port 22: Connection refused
```

**解决**：
```bash
# 检查网络
ping github.com

# 检查防火墙
# 确保允许SSH连接（端口22）

# 或使用HTTPS over SSH（端口443）
# 修改 ~/.ssh/config：
# Host github.com
#   Hostname ssh.github.com
#   Port 443
```

### 问题2：权限被拒绝

**症状**：
```bash
Permission denied (publickey)
```

**解决**：
```bash
# 检查密钥权限
chmod 600 ~/.ssh/id_ed25519

# 检查密钥是否存在
ls -la ~/.ssh/id_ed25519*

# 测试SSH连接
ssh -Tv git@github.com
```

### 问题3：仍然需要密码

**解决**：
```bash
# 确保GitHub上有正确的公钥
# 访问：https://github.com/settings/keys

# 如果没有，添加公钥
cat ~/.ssh/id_ed25519.pub
# 复制并添加到GitHub
```

---

## 📚 相关资源

### 官方文档
- [GitHub SSH密钥](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [SSH密钥生成](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

### 记忆系统文档
- [快速开始](QUICK_START.md)
- [组合策略](SYNC_STRATEGY.md)
- [维护指南](docs/MAINTENANCE.md)

---

## ✅ 配置检查清单

- [x] SSH密钥已生成
- [x] 公钥已添加到GitHub
- [x] SSH连接测试成功
- [x] 远程仓库使用SSH协议
- [x] 推送测试成功
- [x] 移除HTTP代理配置
- [x] 文档已更新

---

**最后更新**：2026-03-26
**认证方式**：SSH密钥（ed25519）
**状态**：✅ 已配置并验证

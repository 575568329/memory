#!/bin/bash
# 快速手动推送脚本 - 重要记忆立即推送

set -euo pipefail

MEMORY_DIR="${MEMORY_DIR:-$HOME/.adaptive-memory}"
cd "$MEMORY_DIR"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== 快速手动推送 ===${NC}"
echo ""

# 检查是否有更改
if [ -z "$(git status --porcelain)" ]; then
    echo -e "${GREEN}✅ 没有未提交的更改${NC}"
    exit 0
fi

# 显示未提交的更改
echo -e "${BLUE}📝 未提交的更改：${NC}"
git status --short
echo ""

# 询问是否提交
read -p "是否提交并推送这些更改？(Y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${YELLOW}❌ 取消推送${NC}"
    exit 0
fi

# 添加所有更改
echo -e "${BLUE}📦 提交更改...${NC}"
git add .

# 生成提交信息
COMMIT_MSG="manual: $(date '+%Y-%m-%d %H:%M:%S') 手动推送"

# 提交
git commit -m "$COMMIT_MSG"

# 立即推送
echo -e "${BLUE}📤 立即推送到远程...${NC}"
if git push origin main; then
    echo -e "${GREEN}✅ 推送成功！${NC}"
    echo ""
    echo "📊 推送统计："
    echo "  提交：$(git log -1 --format='%h')"
    echo "  时间：$(git log -1 --format='%ci')"
    echo "  信息：$COMMIT_MSG"
else
    echo -e "${RED}❌ 推送失败，请检查网络连接${NC}"
    exit 1
fi

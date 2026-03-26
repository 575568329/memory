#!/bin/bash
# 每日定时推送脚本 - 每天晚上10点执行

set -euo pipefail

MEMORY_DIR="${MEMORY_DIR:-$HOME/.adaptive-memory}"
cd "$MEMORY_DIR"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=== 每日记忆同步 ===${NC}"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# 1. 拉取远程更新
echo -e "${BLUE}📥 拉取远程更新...${NC}"
if git pull origin main --no-edit; then
    echo -e "${GREEN}✅ 拉取成功${NC}"
else
    echo -e "${RED}❌ 拉取失败，请检查网络${NC}"
    exit 1
fi

# 2. 检查是否有推送队列
if [ -f .push_queue ]; then
    QUEUE_COUNT=$(wc -l < .push_queue)
    if [ "$QUEUE_COUNT" -gt 0 ]; then
        echo -e "${YELLOW}📋 发现 $QUEUE_COUNT 个待推送任务${NC}"
        echo -e "${BLUE}📤 处理推送队列...${NC}"
        rm -f .push_queue
    fi
fi

# 3. 推送本地更新
echo -e "${BLUE}📤 推送本地更新...${NC}"
UNPUSHED=$(git log origin/main..HEAD --oneline | wc -l)
if [ "$UNPUSHED" -gt 0 ]; then
    echo -e "${BLUE}发现 $UNPUSHED 个未推送的提交${NC}"
    git push origin main
    echo -e "${GREEN}✅ 推送成功${NC}"
else
    echo -e "${GREEN}✅ 没有需要推送的更新${NC}"
fi

# 4. 生成每日报告
echo ""
echo -e "${BLUE}📊 每日统计${NC}"
MEMORY_COUNT=$(find memory/ -type f | wc -l)
LAST_UPDATE=$(git log -1 --format='%ci' | cut -d' ' -f1,2)
echo "记忆总数：$MEMORY_COUNT"
echo "最后更新：$LAST_UPDATE"
echo "仓库大小：$(du -sh . | cut -f1)"

# 5. 清理临时文件
echo ""
echo -e "${BLUE}🧹 清理临时文件...${NC}"
find . -name "*.tmp" -delete 2>/dev/null || true
find . -name "*.bak" -delete 2>/dev/null || true
echo -e "${GREEN}✅ 清理完成${NC}"

echo ""
echo -e "${GREEN}=== 每日同步完成 ===${NC}"
echo -e "${GREEN}晚安！🌙${NC}"

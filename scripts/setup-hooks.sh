#!/bin/bash
# Git Hooks 配置脚本
# 设置会话结束时自动推送

set -euo pipefail

MEMORY_DIR="${MEMORY_DIR:-$HOME/.adaptive-memory}"
HOOKS_DIR="$MEMORY_DIR/.git/hooks"

echo "=== 配置 Git Hooks ==="
echo ""

# 创建 post-commit hook
cat > "$HOOKS_DIR/post-commit" << 'EOF'
#!/bin/bash
# 提交后自动触发智能推送

MEMORY_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$MEMORY_DIR"

# 异步执行智能推送，不阻塞提交
bash scripts/smart-push.sh > /dev/null 2>&1 &
EOF

chmod +x "$HOOKS_DIR/post-commit"
echo "✅ post-commit hook 已配置"

# 创建 post-merge hook
cat > "$HOOKS_DIR/post-merge" << 'EOF'
#!/bin/bash
# 拉取合并后显示更新信息

MEMORY_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$MEMORY_DIR"

echo "📥 记忆库已更新"
echo "最后更新：$(git log -1 --format='%ci')"
echo "提交信息：$(git log -1 --format='%s')"
EOF

chmod +x "$HOOKS_DIR/post-merge"
echo "✅ post-merge hook 已配置"

echo ""
echo "=== Git Hooks 配置完成 ==="
echo ""
echo "📝 已配置的钩子："
echo "  - post-commit: 提交后自动推送"
echo "  - post-merge: 拉取后显示信息"
echo ""
echo "🚀 现在每次提交后都会自动触发智能推送！"

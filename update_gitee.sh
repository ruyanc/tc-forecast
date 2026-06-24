#!/bin/bash
# =============================================================================
# Gitee Pages 自动更新脚本
# =============================================================================

cd /home/chenry/WORK/push-html || exit 1

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  推送更新到 Gitee Pages"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 检查是否有变更
if [[ -z $(git status -s) ]]; then
    echo "⚠️  无文件变更，跳过推送"
    exit 0
fi

# 添加所有 HTML 文件
echo "→ 添加文件..."
git add *.html *.md *.sh 2>/dev/null
git status -s

# 提交
echo ""
echo "→ 提交变更..."
COMMIT_MSG="Update forecast $(date +%Y%m%d_%H%M)"
git commit -m "$COMMIT_MSG"

# 推送
echo ""
echo "→ 推送到 Gitee..."
git push

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ 完成！"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "访问地址："
echo "  https://ruyanchen.gitee.io/tc-tracker/"
echo ""
echo "注意：Gitee Pages 更新可能需要 1-2 分钟生效"
echo "      可在仓库页面手动点击「更新」加速"
echo ""

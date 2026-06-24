#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  GitHub Pages 更新脚本
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
#  用途：自动更新 index.html 指向、提交并推送到 GitHub Pages
#
#  使用方法：
#    bash update_github.sh [--tag TAG] [commit_message]
#
#  示例：
#    bash update_github.sh --tag 2026062312_nrt "更新 2026062312 预报"
#    bash update_github.sh --tag 2026062312_nrt   # 自动生成提交信息
#    bash update_github.sh "仅提交当前改动"        # 不更新 index.html
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

# 解析参数
TAG=""
POSITIONAL=()
while [[ $# -gt 0 ]]; do
    case "$1" in
        --tag)
            TAG="$2"; shift 2 ;;
        *)
            POSITIONAL+=("$1"); shift ;;
    esac
done

COMMIT_MSG="${POSITIONAL[0]:-自动更新 $(date '+%Y-%m-%d %H:%M:%S')}"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📤 更新 GitHub Pages"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 检查是否在 Git 仓库中
if [ ! -d .git ]; then
    echo "✗ 错误：当前目录不是 Git 仓库"
    echo ""
    echo "请先运行初始化脚本："
    echo "  bash setup_github.sh"
    exit 1
fi

# 检查是否有远程仓库
if ! git remote | grep -q "^origin$"; then
    echo "✗ 错误：未配置远程仓库"
    echo ""
    echo "请先运行初始化脚本："
    echo "  bash setup_github.sh"
    exit 1
fi

# 更新 index.html 软链接
if [ -n "$TAG" ]; then
    TARGET="track_${TAG}.html"
    if [ ! -f "$TARGET" ]; then
        echo "✗ 错误：找不到文件 $TARGET"
        exit 1
    fi
    ln -sf "$TARGET" index.html
    echo "→ index.html → $TARGET"
fi

# 显示当前状态
echo "→ 当前文件状态："
git status --short

# 添加所有更改
echo ""
echo "→ 添加文件到暂存区..."
git add .

# 检查是否有更改
if git diff --cached --quiet; then
    echo ""
    echo "ℹ️  没有新的更改需要提交"
    exit 0
fi

# 显示将要提交的文件
echo ""
echo "→ 将要提交的文件："
git diff --cached --name-status

# 提交
echo ""
echo "→ 提交到本地仓库..."
echo "  提交信息: $COMMIT_MSG"
git commit -m "$COMMIT_MSG"

# 推送
echo ""
echo "→ 推送到 GitHub..."
git push origin main

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ 更新成功"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 获取远程 URL
REMOTE_URL=$(git remote get-url origin)
REPO_INFO=$(echo "$REMOTE_URL" | sed -E 's/.*github\.com[:/](.+)\.git/\1/')

echo "页面将在 1-2 分钟内更新："
echo "  https://$(echo $REPO_INFO | sed 's/\//.github.io\//')"
echo ""
echo "查看部署状态："
echo "  https://github.com/$REPO_INFO/actions"
echo ""

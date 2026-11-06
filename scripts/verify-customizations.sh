#!/usr/bin/env bash
# 定制断言脚本：官方同步合并后必须全过（SOP 见 CUSTOMIZATIONS.md「同步合并流程」第 3 步）
# 用法：bash scripts/verify-customizations.sh （任意目录可执行，自动定位仓库根）
# 规则：每落地一个定制点，在此追加对应断言；断言清单与 CUSTOMIZATIONS.md 状态列同步
set -u
cd "$(dirname "$0")/.." || exit 1

fail=0
check() { # check <文件> <固定串> <说明>
  local file="$1" pattern="$2" desc="$3"
  if grep -qF -- "$pattern" "$file" 2>/dev/null; then
    echo "PASS  $desc"
  else
    echo "FAIL  $desc （缺失于 $file）"
    fail=1
  fi
}

# ── 版本标识 ──
check .claude-plugin/plugin.json      '-hcj.' '定制版本后缀（plugin.json）'
check .claude-plugin/marketplace.json '-hcj.' '定制版本后缀（marketplace.json）'

# ── L1：test-scoping 分级表（与 ZCode AGENTS.md 双事实源，逐字下沉）──
check skills/test-scoping/SKILL.md 'S0 禁止测试' 'test-scoping：S0 行'
check skills/test-scoping/SKILL.md 'S1 必须测试' 'test-scoping：S1 行'
check skills/test-scoping/SKILL.md 'S2 酌情'     'test-scoping：S2 行'
check skills/test-scoping/SKILL.md 'MapStruct'   'test-scoping：S0 明细（MapStruct）'
check skills/test-scoping/SKILL.md '@SpringBootTest' 'test-scoping：测试形态行'

# ── L2：TDD Step 0 闸门 ──
check skills/test-driven-development/SKILL.md 'superpowers:test-scoping' 'TDD：Step 0 指向 test-scoping'
check skills/test-driven-development/SKILL.md 'Verdict S0'               'TDD：S0 豁免声明'

# ── L2：verification diff 自查 ──
check skills/verification-before-completion/SKILL.md 'Diff Audit'       '验证：diff 自查节'
check skills/verification-before-completion/SKILL.md 'hardcoded secrets' '验证：密钥残留检查'
check skills/verification-before-completion/SKILL.md 'AI slop'           '验证：slop 审计'

exit $fail

---
name: disciplined-commit
description: Use before any git commit, to enforce atomic commit discipline - one logical change per commit, type:Chinese-description message format, and a pre-commit safety audit for debug residue and hardcoded secrets. 原子提交纪律，任何提交动作的前置闸门。
---

# 原子提交纪律（Disciplined Commit）

## Overview

提交是审查与回滚的最小单位：一个逻辑变更一个 commit，message 说清「改了哪个环节、为什么」。混合提交是欠下的审查债——审查者被迫在一个 diff 里同时审两件事，回滚时被迫连带回滚不该动的部分。

本 skill 是提交动作的前置闸门：`git commit` 之前过一遍，不达标不提交。与 `superpowers:verification-before-completion` 的分工：后者管「完成声明」（验证先于完成），本 skill 管「提交边界」（每次提交的原子性与卫生）。

## Message 规范：`type:中文描述`

- 格式统一 `type:中文描述`，type 取 feat/fix/refactor/docs/test/chore 等项目惯用词表，全项目一致
- 描述用中文说清改动内容；跨环节的大改动拆成多个 commit，每个 message 说明该 commit 改的是哪个环节、为什么（例：`feat:TDD 流程接入 test-scoping Step 0 定级闸门`）
- 不写「update」「修改」「调整」这类零信息 message——说不出 type 与描述，说明还没想清这个 commit 的边界

## 原子性

- **一个逻辑变更一个 commit**：修复一个 bug、落地一个功能点、新增一个模块，各自独立成 commit
- 无关改动不搭车：顺手发现的无关问题单独开 commit（或留给后续任务），不混进当前提交
- 拆分判据：回滚时会不会连带回滚不该动的部分？会，就还没拆干净

## 提交前安全检查

`git commit` 前对暂存区过一遍（`git diff --staged`）：

- **无无关改动**：每个 hunk 都能追溯到本 commit 的逻辑变更
- **无调试残留**：`System.out`/`console.log`/print 调试、被注释掉的代码
- **无硬编码密钥**：API key、密码、token、内网地址等敏感值
- 残留进了 commit = 工作没做完。清掉再提交，不要找借口

## Common Rationalizations

| 借口 | 现实 |
|---|---|
| "改动很小，搭个车没关系" | 小改动独立成 commit 的成本是零，混合提交的成本由审查者和回滚者付 |
| "调试输出回头再清" | "回头"就是提交之后，而提交之后没人会再看这个 diff |
| "项目里 message 本来就乱" | 全项目一致正是从下一个 commit 开始的；跟随项目现有 type 词表，不发明新词 |

## 双事实源

本 skill 是 ZCode 侧 `~/.zcode/AGENTS.md`「提交规范」（工程细节节）与核心规则底线①内 diff 自查（无无关改动/调试残留/硬编码密钥）的**展开版**：ZCode 侧保留浓缩原文独立生效（ZCode 无 superpowers），本侧展开为可执行闸门——**改纪律实质内容时两边同步**。登记表见仓库根 `CUSTOMIZATIONS.md`。

## Final Rule

```
one logical change = one commit
message: type:中文描述（改哪个环节，为什么）
staged diff clean: no unrelated hunks, no debug residue, no hardcoded secrets
fail any → do not commit
```

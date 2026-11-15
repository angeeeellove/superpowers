---
name: task-sizing
description: Use when a task's size is unclear, or before entering any full process flow, to classify L1/L2/L3 and pick the matching process depth. 任务规模分级闸门，决定流程深度。
---

# 任务规模分级（L1/L2/L3）

## Overview

流程深度跟着任务规模走，不跟着任务措辞走：小事进仪式是流程税，大事跳流程是返工税。本 skill 是流程入口的分级闸门——`superpowers:brainstorming` 等流程 skill 的 Step 0 引用本表定级。

## 分级表

- **L1 琐碎**：单点改动（typo、配置值、单行修复）、纯只读探索 → 直接改
- **L2 常规**：单文件多处明确改动 / 有现成模式可循的小功能 → 动手前一句话说清改哪、怎么改
- **L3 复杂**：跨文件、新功能、改架构、有设计取舍、外部协调 → 完整流程（brainstorming → writing-plans → TDD → verification），**仅此级产出计划文件**

## 分级规则

1. **判级看改动范围，不看描述长短**——一句话描述的活也可能是 L3（一行代码跨三个模块）
2. **拿不准按上一级走**：误判成本不对称——L3 当 L1 做会返工，L1 当 L3 做只多花几分钟
3. **动手后发现实际更复杂 → 立即升级**，已做的部分不推倒，从对应层级流程继续

## 分级后走向

| 级别 | 走向 |
|---|---|
| L1 | 直接做 → `superpowers:verification-before-completion` 收尾。不进提问仪式，不产出文档 |
| L2 | 一句话方案（改哪、怎么改）→ 做 → 验证收尾。**不产出计划文件** |
| L3 | `superpowers:brainstorming` 完整流程 → `superpowers:writing-plans` → 执行 → 验证。**计划文件仅此级产出** |

## Common Rationalizations

| 借口 | 现实 |
|---|---|
| "这是个新功能，怎么也算 L3 吧" | 有现成模式可循的小功能就是 L2——判断依据是改动范围与设计取舍，不是「功能」两个字 |
| "走个流程显得严谨" | 流程是成本。L1/L2 走 L3 流程不产出任何额外正确性，只产出仪式性文档 |
| "先做着看，规模后面再说" | 可以——但升级要显式（说一句「这升级为 L3 了」），不能默默滑进更深的流程 |

## 双事实源

本分级表与 ZCode 侧 `~/.zcode/AGENTS.md`「superpowers 流程分级」各存全文——**改一处必过另一处**；Claude 侧 CLAUDE.md 同条目在定制版实际安装后收缩为指针，以本表为权威文本。

## Final Rule

```
L1 → do it, verify, done
L2 → one-line plan, do, verify
L3 → full flow, plan file only here
拿不准 → 升一级
```

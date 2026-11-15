---
name: spike
description: Use when a design decision needs evidence before commitment - isolated throwaway experiments in a worktree, structured strategy comparison, and convergence to a decision record. 技术验证与策略比选，L3 设计取舍的前置环节。
---

# 技术验证与策略比选（Spike）

## Overview

Spike 是为回答**具体问题**而写的抛弃式代码——产出是结论，不是代码。

官方 `superpowers:brainstorming` 已有「Spike to feel things out」的轻量形态（会话中随手验证、结论带回对话）。本 skill 管**重一档**的场景：L3 设计取舍需要证据支撑时，补上官方轻量形态没有的三样——**隔离纪律、结构化比选、收敛熔断**。被 brainstorming 引用执行，结论回填 brainstorming 或 `superpowers:writing-plans`。

## 流程

1. **立题**：写下 spike 要回答的问题 + 判定标准（什么结果算 A 胜 / B 胜 / 都不可行）。没有问题与标准的 spike 不值得写
2. **隔离**：用 `superpowers:using-git-worktrees` 开独立 worktree；spike 代码**不进主分支、不进提交历史**——结论进笔记/决策记录，代码本身用完即弃
3. **比选**：每个候选策略各自最小验证一轮，用**同一组**判定标准对比；比的是证据，不是感觉
4. **收敛熔断**：最多 3 轮。3 轮仍分不出胜负 → 停止验证，基于已有证据做决策并写明残余风险；继续加轮次是沉没成本谬误——分不出胜负通常说明判定标准有问题，回头修标准
5. **决策记录**：写清「选了什么 / 为什么 / 舍弃了什么 / 残余风险」，回填需求或计划文档；随后丢弃 spike worktree

## Common Rationalizations

| 借口 | 现实 |
|---|---|
| "spike 代码写得不错，顺手提交了吧" | spike 的价值在结论不在代码。提交抛弃式代码 = 把未经验证的设计当成了事实源 |
| "再跑一轮就分胜负了" | 3 轮熔断就是为这句话设的。修判定标准，不加轮次 |
| "直接在主分支试一下就行" | 污染工作区，且容易「试完忘了删」。隔离是纪律，不是仪式 |

## Final Rule

```
spike = question + criteria + worktree + ≤3 rounds + decision record
没有问题或标准 → 不配写 spike
```

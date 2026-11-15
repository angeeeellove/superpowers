# CUSTOMIZATIONS.md — superpowers 定制线登记表

> 本文件是 fork 定制线的唯一登记入口：每个定制点的位置、内容摘要、来源与状态。
> 纪律：每次官方同步合并前后各过一遍本表；合并后运行 `scripts/verify-customizations.sh` 断言全过才算交付。
> 分支：`feature/v7.0.2-hcj`（基于官方 v7.0.2）｜基线 tag：`v7.0.2-hcj.0`｜定制 tag：`v7.0.2-hcj.N` 递进

## 设计原则

1. **三层归属**：L0 全局 CLAUDE.md（零冲突，偏好收窄）＜ L1 新增文件（近零冲突）＜ L2 修改官方文件（薄改）
2. **薄改 + 新文件**：官方 SKILL.md 只留 ≤3 行 hook 指向自有 skill，正文放新文件——官方更新时冲突面最小
3. **一个定制点一个 commit**，message 说明改哪个 skill 的哪个环节、为什么
4. **反哺优先**：通用性强的定制优先 PR 回 obra/superpowers，被采纳即消除分叉

## L1 新增文件（零冲突）

| # | 路径 | 内容 | 来源 | 状态 |
|---|---|---|---|---|
| 1 | `skills/test-scoping/SKILL.md` | S0/S1/S2 测试必要性分级表（Java 企业栈特化：S0 纯 POJO/MapStruct/常量/枚举禁测；S1 Service 分支/算法/框架扩展点必测；S2 透传 Controller 不测；优先 Mockito 纯 Mock） | 自有 CLAUDE.md 测试铁律（全文下沉） | ✅ 已实施（v7.0.2-hcj.2） |
| 2 | `skills/disciplined-commit/SKILL.md` | 原子提交纪律：`type:中文描述` 规范、提交前安全检查（无调试残留/硬编码密钥） | tony/skills `commit` × 自有提交规范 | ✅ 已实施（v7.0.2-hcj.4） |
| 3 | `skills/spike/SKILL.md` | worktree 中无提交技术验证 / 策略比选 / 多轮收敛 | tony/skills `spike` | ✅（v7.0.2-hcj.5）：与官方 brainstorming 轻量 spike 分工——官方管会话内随手验证，本 skill 管 L3 重档（隔离纪律/结构化比选/3 轮收敛熔断/决策记录） |
| 4 | `scripts/verify-customizations.sh` | 定制断言脚本：grep 校验各 hook 行与关键表存在，合并后必跑 | 自有（tony evals 思想最小版） | ✅ 已实施（v7.0.2-hcj.2） |

## L2 薄改（每处 ≤3 行 hook）

| # | 文件 | hook 内容 | 来源 | 状态 |
|---|---|---|---|---|
| 1 | `skills/test-driven-development/SKILL.md` | RED 之前加 Step 0：先跑 test-scoping 分级，S0 直接跳过 TDD 走实现+验证 | 自有核心规则 2 | ✅（v7.0.2-hcj.2） |
| 2 | `skills/systematic-debugging/SKILL.md` | 根因确认后：先把 bug 固化为失败测试再修 | tony `tdd-fix` | ⛔ 取消：官方 7.0.2 已原生覆盖（Phase 4.1 Create Failing Test Case），试金石——插件已修不重复约束 |
| 3 | `skills/verification-before-completion/SKILL.md` | diff 自查清单（无无关改动、System.out/注释代码/硬编码密钥）+ AI slop 审计 + 验证=重新执行而非对照记忆 | 自有核心规则 3 × tony `slop`/`double-check` | ✅（v7.0.2-hcj.3）：diff 自查节 3 行内嵌（固定短清单，独立 skill 无价值，形态偏差已记录）；double-check 官方已原生覆盖（Iron Law fresh evidence），未重复 |
| 4 | `skills/receiving-code-review/SKILL.md` | 反馈甄别：先辨人/机器、是否有效发现，有效发现转原子提交 | tony `respond` | ✅（v7.0.2-hcj.4）：Feedback Triage 节内嵌，有效发现链到 disciplined-commit |
| 5 | `skills/subagent-driven-development/SKILL.md` | model 档位必填（机械=轻量档，终审与架构=最强档）；fix→re-review ≤2 轮熔断；briefing 必含精确接口签名；终审 subagent 不省 | 自有成本纪律（措辞去环境化） | ⛔ 取消（批次 3 复核）：官方原生覆盖第 1/3/4 项（Model Selection 强制显式档位、brief 必含接口签名、final review 强制最强档）；第 2 项熔断由官方 5 轮上限+cap 裁决机制结构性覆盖，硬改轮次数与 `references/fix-loop.md` 内部机制冲突，冲突面大于收益；熔断后去向由「升级人工」换为官方「cap 后 controller 裁决+final review 复核 parked 项」 |
| 6 | `skills/dispatching-parallel-agents/SKILL.md` | 并行度上限 3；文件互斥才并行，有共享文件/接口耦合降级串行 | 自有成本纪律 | ✅（v7.0.2-hcj.4）：Parallelism Cap 节内嵌 |
| 7 | `skills/executing-plans/SKILL.md` | 开头加态势盘点：当前分支/worktree/相关工单/项目约定 | tony `situate` | ✅（v7.0.2-hcj.4）：Situate 段落入 Setup，盘点结论入 ledger（分支/worktree 官方已有，hook 补工单关联+项目约定） |
| 8 | `skills/brainstorming/SKILL.md` | 顶部规模分级门：L1 直接做、L2 一句话方案、仅 L3 进全流程且仅 L3 产出计划文件 | 自有核心规则 1 | ✅（v7.0.2-hcj.6）：Task Sizing Step 0 闸门内嵌，分级表由 L1 `task-sizing` skill 承载（brainstorming 为官方最高频改动文件，严格薄改） |

## 留守 L0（不进 fork）

主会话 token 纪律、变更与验证最小化、/clear 会话治理、文档治理体系——跨所有活动生效，不绑 skill 触发点，ZCode AGENTS.md 与 Claude CLAUDE.md 各自保留全文。

## 不移植清单（防膨胀）

tony/skills 的依赖升级类（ruff/terraform/package-updater，非 Maven 体系）、写作商业类（lean/voice/business）、实验类（weave/model-cli/agent-messaging）、工单类（ticket/goal-planner，YAGNI）。

## 双事实源约定

- S0/S1/S2 等下沉内容：**fork skill 与 ZCode AGENTS.md 各存全文**，改一处必过另一处（ZCode 无 superpowers，必须独立成立）
- 全部 L2 落地后，Claude CLAUDE.md 对应条目收缩为一句指针（沿用文件内「已由 X 内置」注记模式）

## 安装指向说明

- `marketplace.json` 的 `source: "./"`：插件内容 = 检出工作区本身
- 本地路径安装：本地 clone 停在本分支即可（推荐，契合 `~/git/superpowers` 固定路径约定）
- fork 远端安装：需把 GitHub 仓库默认分支切到本分支（Settings → General → Default branch）
- **快照刷新（2026-11-15 实测教训）**：目录源安装按 `plugin.json` 版本号快照复制到 cache——定制批次落地后必须同步 bump 版本号（与当批 tag 对齐），再在 Claude Code 执行 marketplace update + plugin update 才会刷新；版本号不动则快照停留在旧批

## 同步合并流程（官方发版时）

1. `git checkout main && git pull upstream main && git push origin main`
2. `git checkout feature/v7.0.2-hcj && git merge main`（merge 不 rebase；`rerere.enabled=true`）
3. 冲突对照本表逐条解决 → 跑 `scripts/verify-customizations.sh`
4. `plugin.json`/`marketplace.json` 版本号 = 官方新版 + `-hcj.N` 后缀；打 tag `v<官方版>-hcj.N` 推送
5. CLAUDE.md / ZCode AGENTS.md 版本注记随动

## 更新记录

- 2026-11-06 初版：登记表建立；基线 `v7.0.2-hcj.0`；版本标识 `7.0.2-hcj.1`；全部定制点待实施
- 2026-11-06 批次 1（`v7.0.2-hcj.2`）：`test-scoping` skill、TDD Step 0 闸门、`verify-customizations.sh`（9 断言）落地
- 2026-11-06 批次 2（`v7.0.2-hcj.3`）：验证 skill diff 自查节落地（3 行内嵌）；systematic-debugging 定制点取消（官方原生覆盖）；断言扩至 12 项
- 2026-11-06 批次 3（`v7.0.2-hcj.4`）：`disciplined-commit` skill、receiving-code-review 反馈甄别、dispatching-parallel-agents 并行度约束、executing-plans 态势盘点落地；subagent-driven-development 成本纪律定制点取消（官方原生覆盖+机制冲突）；断言扩至 21 项。至此除 `spike`（候选）与 `brainstorming`（观察中）外全部定制点收口；「全部 L2 落地→CLAUDE.md 收缩为指针」待 #8 brainstorming 出观察结论后一并执行
- 2026-11-06 批次 3 终审修复：disciplined-commit 双事实源锚点 ②→①（diff 自查在底线①）、「两处全文」收敛为「展开版」表述；#5 取消理由编号指代修正（覆盖的是第 1/3/4 项）、熔断去向语义替换点明
- 2026-11-15 批次 4（`v7.0.2-hcj.5`）：`spike` skill 落地（与官方轻量形态分工：隔离纪律/结构化比选/3 轮收敛熔断/决策记录）；断言扩至 24 项；批次 3 曾于另一会话完成、本会话核查断言后补推送 hcj.4。**定制线仅剩 #8 brainstorming 规模门（⏸ 等观察结论）**
- 2026-11-15 规模门（`v7.0.2-hcj.6`）：实测确认 7.0.2 对 L2 仍有仪式感 → brainstorming Task Sizing Step 0 + `task-sizing` skill 落地；断言扩至 29 项。**12 个定制点全部收口：9 落地 + 3 取消（官方原生覆盖）**。后续顺序：①安装切换（卸官方版 → fork marketplace）→ ②CLAUDE.md 指针化收缩（**必须先装后缩**，避免约束真空）→ ③Actions 自动同步 workflow

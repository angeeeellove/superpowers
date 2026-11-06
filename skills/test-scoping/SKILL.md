---
name: test-scoping
description: Use before writing any test or starting TDD, to classify the target S0/S1/S2 and decide whether tests are required at all (S0 = no test). 测试必要性分级闸门，TDD 的前置步骤。
---

# 测试必要性分级（S0/S1/S2）

## Overview

TDD 要求先写测试再写实现，**不等于**给每个类配测试；纯数据载体写测试纯属噪音——拖慢本地与 CI，一个 bug 都测不出。

本 skill 是 `superpowers:test-driven-development` 的**前置闸门**：先定级，再决定走不走 TDD。判级结论要落进当前任务说明（级别 + 一句理由），拿不准按上一级走——误判成本不对称。

## 分级表

- **🚫 S0 禁止测试**：纯 POJO（VO/DTO/Entity/Request/Response/Param，含 Lombok 生成）、MapStruct 声明式映射、常量类、纯声明枚举
- **✅ S1 必须测试**（覆盖分支与边界，不写只走 happy path 的过场）：Service 业务方法（分支/计算/状态流转/异常路径）、非平凡工具算法、策略/责任链/规则引擎等模式实现、AOP 切面/自定义注解/TypeHandler 等框架扩展点、Convert 手写转换逻辑
- **⚠️ S2 酌情**：纯透传 Controller 不写（集成测覆盖）；一行表达式不测

## 分级后走向

| 级别 | 走向 |
|---|---|
| S0 | **不写测试**。直接实现 → `superpowers:verification-before-completion` 收尾。这是范围裁剪，不是逃避 TDD |
| S1 | 走 `superpowers:test-driven-development` 完整 RED-GREEN-REFACTOR |
| S2 | 默认不测；仅当该逻辑出现过真实 bug、或承载资损/安全语义时，按 S1 处理 |

## 测试形态（S1 适用）

优先纯 Mock 单测（Mockito + 反射注入依赖），避免重量级 `@SpringBootTest`。

## Common Rationalizations

| 借口 | 现实 |
|---|---|
| "S0 也补个测试更保险" | 纯数据载体的 getter/setter 测不出 bug，只有维护成本。测的是行为，不是字段 |
| "分不准，先测了再说" | 拿不准按上一级走（误判成本不对称），但结论仍要落一句理由 |
| "S2 感觉挺重要的" | 重要与否的判据是「真实 bug 史 / 资损安全语义」，不是感觉；觉得重要就写出那条具体语义，按 S1 测 |

## 双事实源

本分级表与 ZCode 侧 `~/.zcode/AGENTS.md`「单元测试铁律」为同一内容两处全文——**改一处必过另一处**（ZCode 无 superpowers，须独立成立）。登记表见仓库根 `CUSTOMIZATIONS.md`。

## Final Rule

```
S0 → no test, implement + verify
S1 → full TDD, branches & boundaries covered
S2 → default skip; upgrade to S1 only with real-bug/critical-semantic justification
```

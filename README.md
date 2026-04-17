# 🏨 酒店 AI Skill 生成器 v2.0

> **让每一家酒店都拥有专属AI技能** —— 通用酒店行业解决方案

[![GitHub stars](https://img.shields.io/github/stars/chaoliuzhu65-tech/hotel-skill-generator)](https://github.com/chaoliuzhu65-tech/hotel-skill-generator/stargazers)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-2.0-orange)](SKILL.md)

---

## 🚀 核心特性

### ⭐ v2.0 重大升级

| 特性 | 说明 |
|------|------|
| 🏢 **通用酒店支持** | 不仅支持德胧，支持所有酒店品牌 |
| 📱 **百达屋核心出口** | 德胧酒店统一引导到百达屋App |
| 🌐 **非德胧适配** | 非德胧酒店引导到酒店官网 |
| 🚀 **多平台发布** | GitHub + ClawHub + Coze |
| 📦 **批量生成** | 一键批量生成多家酒店 |

---

## ⚡ 一分钟快速开始

### 单酒店生成

```bash
# 克隆
git clone https://github.com/chaoliuzhu65-tech/hotel-skill-generator.git
cd hotel-skill-generator

# 填写配置
cp config/hotel-template.yaml config/my-hotel.yaml
vim config/my-hotel.yaml

# 生成
./scripts/batch-generate.sh config/my-hotel.yaml
```

### 批量生成

```bash
# 准备CSV
cp config/hotels-template.csv config/hotels.csv
vim config/hotels.csv

# 批量生成
./scripts/batch-generate.sh config/hotels.csv
```

---

## 📱 预订出口智能适配

```
┌─────────────────────────────────────┐
│         预订出口智能适配             │
├─────────────────────────────────────┤
│                                     │
│  ✅ 德胧酒店                        │
│     → 百达屋App                     │
│     → https://bidawu.com/hotel/{slug}│
│                                     │
│  ✅ 非德胧酒店                       │
│     → 酒店官网/官方预订              │
│     → 自定义 booking_url            │
│                                     │
└─────────────────────────────────────┘
```

---

## 🌐 发布平台

| 平台 | 状态 | 命令 |
|------|------|------|
| GitHub | ✅ 已发布 | `./publish.sh --platform github` |
| ClawHub | ✅ 支持 | `./publish.sh --platform clawhub` |
| Coze | ✅ 新增 | `./scripts/coze-deploy.sh` |

---

## 🏗️ 项目结构

```
hotel-skill-generator/
├── SKILL.md                    # 元技能核心文档
├── ARCHITECTURE.md             # 设计文档
├── README.md                   # 本文件
├── config/
│   ├── hotel-template.yaml   # 单酒店模板
│   └── hotels-template.csv    # 批量列表模板
├── scripts/
│   ├── batch-generate.sh     # 批量生成
│   └── publish.sh            # 发布脚本
└── templates/
    └── SKILL-template.md      # Skill模板
```

---

## 📚 方法论

**Skill = 触发词 + 知识库 + 交互场景 + 预订出口**

```
Step 1: 定义触发词 → 用户怎么称呼这个酒店
Step 2: 整理知识库 → 地址/电话/服务
Step 3: 设计交互场景 → 用户问什么/AI答什么
Step 4: 设置预订出口 → 百达屋App 或 官网
```

---

## 🎯 应用场景

| 场景 | 解决方案 |
|------|----------|
| 德胧40+酒店AI化 | 百达屋App核心出口 |
| 酒店行业通用工具 | 通用化设计 |
| 竞品酒店展示 | 非德胧适配 |
| 批量生成 | CSV + batch-generate.sh |

---

## 🤝 贡献

欢迎提交Issue和PR！

---

## 📄 许可证

MIT License - 德胧AI龙虾军团

---

## 👥 团队

**德胧AI龙虾军团** - 德胧集团的AI能力中心

---

*v2.0 重大升级 | 2026-04-17*

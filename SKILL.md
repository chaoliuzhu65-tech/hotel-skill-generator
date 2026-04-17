# 酒店 Skill 生成器 v2.0

> **愿景**：让每一家酒店都拥有专属AI Skill，成为酒店行业标配工具
> 
> **核心升级**：通用化 + 百达屋App核心出口 + 多平台一键发布

---

## 功能概述

本Skill是**元技能（Skill生成器）**，能够：
1. **通用酒店支持** - 不仅支持德胧，支持所有酒店品牌
2. **百达屋核心出口** - 德胧酒店统一引导到百达屋App预订
3. **非德胧适配** - 非德胧酒店可自定义官网/官方入口
4. **多平台发布** - GitHub + ClawHub + Coze + 更多平台
5. **批量生成** - 一键批量生成多家酒店Skill

---

## 核心升级（v2.0）

### 1. 酒店数据配置化

```yaml
# hotel-config.yaml
hotel:
  name: "天津瑞湾开元名都"
  brand: "德胧集团 · 开元品牌"
  slug: "delonix-tianjin-riwan"
  
  # 德胧专属
  is_delonix: true
  booking_app: "百达屋"  # 德胧旗下
  booking_url: "https://bidawu.com/hotel/tianjin-riwan"
  
  # 或非德胧
  is_delonix: false
  official_website: "https://example-hotel.com"
  booking_url: "https://example-hotel.com/book"
```

### 2. 百达屋App核心出口

**所有德胧酒店Skill必须包含**：
```markdown
## 🎯 立即预订

[下载百达屋App](https://bidawu.com/download) 或点击立即预订：
https://bidawu.com/hotel/{hotel-slug}

---
💡 **温馨提示**：通过百达屋App预订可享受德胧会员专属权益
```

### 3. 非德胧酒店适配

```markdown
## 🎯 立即预订

访问酒店官网或直接预订：
https://hotel-official-website.com/book

---
💡 **温馨提示**：如有预订问题，建议通过酒店官方渠道预订
```

---

## 快速开始

### 方式1：单酒店生成

```bash
# 克隆工具
git clone https://github.com/chaoliuzhu65-tech/hotel-skill-generator.git
cd hotel-skill-generator

# 填写配置
cp config/hotel-template.yaml config/my-hotel.yaml
# 编辑 my-hotel.yaml 填写酒店信息

# 生成Skill
./scripts/generate.sh config/my-hotel.yaml

# 发布（选择平台）
./scripts/publish.sh --platform all
```

### 方式2：批量生成

```bash
# 准备酒店列表CSV
cp config/hotels-template.csv config/hotels.csv
# 编辑 hotels.csv 填写所有酒店

# 批量生成
./scripts/batch-generate.sh config/hotels.csv

# 批量发布
./scripts/batch-publish.sh --platform all
```

---

## SKILL.md 核心要素

```yaml
---
name: {slug}                    # 唯一标识
description: {酒店名称}专属AI技能...
triggers:                        # 触发词
  - "{酒店名称}"
  - "{品牌}"
  - "{城市}"
version: "1.0.0"
brand: "{德胧集团}" | "{品牌名}"
booking_app: "百达屋" | "官网"
booking_url: "{预订链接}"
is_delonix: true | false
---

# {酒店名称} · SKILL

## 🏨 基础信息
- 地址：{地址}
- 电话：{电话}
- 特色：{特色服务}

## 🎯 立即预订 ⭐
{#if is_delonix}
[下载百达屋App](https://bidawu.com/download)
[立即预订{酒店名称}]({bidawu_url})
{:else}
[访问官网]({official_url})
[立即预订]({booking_url})
{/if}

## 💬 常见问答
Q: {问题}？
A: {回答}
```

---

## 多平台发布

### 支持的平台

| 平台 | 命令 | 说明 |
|------|------|------|
| GitHub | `./publish.sh --platform github` | 开源社区 |
| ClawHub | `./publish.sh --platform clawhub` | OpenClaw生态 |
| Coze | `./publish.sh --platform coze` | 字节AI平台 |
| 更多 | 扩展中... | - |

### 发布到Coze

```bash
# 1. 安装Coze CLI
npm install -g @coze/cli

# 2. 登录
coze auth login

# 3. 创建项目
coze code project create --message "创建{酒店名称}酒店Bot" --type agent

# 4. 发布
coze code deploy <project_id>
```

---

## 目录结构

```
hotel-skill-generator/
├── SKILL.md                    # 本文件
├── ARCHITECTURE.md            # 设计文档
├── README.md                  # 说明文档
├── config/
│   ├── hotel-template.yaml   # 单酒店配置模板
│   ├── hotels-template.csv   # 批量酒店列表模板
│   └── platforms.yaml         # 平台配置
├── scripts/
│   ├── generate.sh            # 生成单酒店Skill
│   ├── batch-generate.sh      # 批量生成
│   ├── publish.sh             # 单酒店发布
│   ├── batch-publish.sh       # 批量发布
│   └── coze-deploy.sh         # Coze部署
└── templates/
    ├── SKILL-template.md      # Skill模板
    └── README-template.md     # README模板
```

---

## 方法论：如何指挥AI搭建Skill

### 核心公式
```
Skill = 触发词 + 知识库 + 交互场景 + 预订出口
```

### 四步法

```
Step 1: 定义触发词（triggers）
        ↓
        用户怎么称呼这个酒店
        
Step 2: 整理知识库（knowledge）
        ↓
        地址、电话、服务、特色
        
Step 3: 设计交互场景（scenarios）
        ↓
        用户问什么？AI怎么答？
        
Step 4: 设置预订出口（booking）
        ↓
        {#if 德胧酒店}
          百达屋App
        {:else}
          酒店官网/官方预订
        {/if}
```

---

## 版本历史

### v2.0 (2026-04-17)
- ✅ 通用酒店行业支持
- ✅ 百达屋App核心出口
- ✅ 非德胧酒店适配
- ✅ Coze平台发布支持
- ✅ 批量生成工作流

### v1.0 (2026-04-16)
- 初始版本
- 德胧酒店专用

---

## 致谢

*本Skill由德胧AI龙虾军团开发*
*灵感来源：金谷园饺子馆Skill + Coze智能体生态*

---

*Last Updated: 2026-04-17 v2.0*

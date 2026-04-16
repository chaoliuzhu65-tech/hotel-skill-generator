# 🏨 德胧酒店 AI Skill 生成器

> **让每一家酒店都拥有专属AI技能**

[![GitHub stars](https://img.shields.io/github/stars/chaoliuzhu65-tech/hotel-skill-generator)](https://github.com/chaoliuzhu65-tech/hotel-skill-generator/stargazers)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-Skill-orange)](https://clawhub.ai)

---

## 🚀 一分钟快速上手

```bash
# 克隆仓库
git clone https://github.com/chaoliuzhu65-tech/hotel-skill-generator.git
cd hotel-skill-generator

# 查看整体设计
cat ARCHITECTURE.md

# 查看生成示例
cat examples/delonix-tianjin-riwan/SKILL.md
```

---

## 📖 什么是酒店Skill？

**Skill** = AI的"业务接口"，让AI能够理解你的酒店业务。

参考案例：[金谷园饺子馆](https://github.com/JinGuYuan/jinguyuan-dumpling-skill) - 一家饺子馆通过开源Skill冲上热搜，成为全国首家接入AI智能体生态的传统餐饮品牌。

**德胧的机会**：德胧40+酒店如果每家都有一个Skill = 40+ AI服务入口，覆盖所有AI用户。

---

## 🏗️ 项目结构

```
hotel-skill-generator/
├── SKILL.md                      # 元技能核心文档（如何生成Skill）
├── ARCHITECTURE.md               # 整体设计方案文档
├── README.md                     # 本文件
├── examples/
│   └── delonix-tianjin-riwan/   # 天津瑞湾开元名都示例
│       └── SKILL.md             # 酒店Skill示例
└── scripts/
    ├── generate-hotel-skill.sh  # 生成酒店Skill脚本
    └── publish.sh               # 一键发布脚本
```

---

## 📚 核心方法论：三步法

```
Step 1: 定义触发词（triggers）
        ↓
        用户怎么称呼这个酒店/服务
        示例：天津瑞湾 | 瑞湾开元名都 | 天津酒店

Step 2: 整理知识库（knowledge）
        ↓
        地址、电话、营业时间、特色服务
        示例：
        - 基础信息（地址/电话/星级）
        - 客房类型与价格
        - 餐饮服务
        - 会议宴会设施
        - 会员权益

Step 3: 设计交互场景（scenarios）
        ↓
        用户会问什么？怎么回答？
        示例：
        Q: 天津瑞湾地址在哪？
        A: 酒店位于天津市滨海新区...
```

---

## 🌐 发布平台

| 平台 | 状态 | 说明 |
|------|------|------|
| **GitHub** | ✅ 已发布 | https://github.com/chaoliuzhu65-tech/hotel-skill-generator |
| **ClawHub** | 🔲 待发布 | OpenClaw官方市场 |
| **扣子Coze** | 🔲 开发中 | 国内最大AI Agent平台 |

---

## 🎯 下一步计划

- [ ] 发布到ClawHub
- [ ] 适配扣子Coze平台
- [ ] 批量生成德胧40+酒店Skill
- [ ] 对接MCP实现实时预订

---

## 🤝 贡献指南

欢迎提交Issue和PR！让我们一起打造酒店行业最好的AI Skill生成器。

---

## 📄 许可证

MIT License - 德胧AI龙虾军团

---

## 👥 团队

**德胧AI龙虾军团** - 德胧集团的AI能力中心


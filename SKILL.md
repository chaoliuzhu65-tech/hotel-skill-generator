# 酒店Skill生成器 v1.0

> **愿景**：让德胧集团每一家酒店都能一键生成专属AI Skill并发布到全球主流Skill市场
> 
> **核心价值**：把"如何指挥AI搭建Skill"的方法论固化到工具里，实现德胧酒店集群的AI技能生态

---

## 功能概述

本Skill是**元技能（Skill生成器）**，能够：
1. **学习研究**：深入分析金谷园饺子馆Skill结构，掌握Skill设计精髓
2. **框架生成**：为德胧旗下任意酒店生成符合规范的Skill包
3. **多平台发布**：一键发布到GitHub、ClawHub及国内主流平台
4. **方法论传承**：内置Skill构建方法论，供德胧所有"龙虾"学习

---

## 核心功能

### F1: 学习金谷园饺子馆Skill

**使用场景**：晁总要求研究竞品Skill时使用

**执行方式**：
```bash
# 方式1: 直接让AI学习金谷园Skill
请研究金谷园饺子馆Skill，地址：https://github.com/JinGuYuan/jinguyuan-dumpling-skill

# 方式2: 分析本地已下载的Skill包
cat /path/to/jinguyuan-dumpling-skill/SKILL.md
```

**金谷园Skill核心结构**：
```
jinguyuan-dumpling-skill/
├── SKILL.md              # 核心：元数据 + Agent指令（必须）
├── README.md              # 人类可读说明
├── src/
│   ├── index.ts          # MCP服务入口（可选，复杂逻辑用）
│   └── tools/             # 工具函数
├── package.json          # 依赖管理
└── CLAWHUB.md           # 发布说明（可选）
```

**SKILL.md核心要素**（必须）：
```markdown
---
name: jinguyuan-dumpling-skill
description: 金谷园饺子馆专属技能...
triggers:
  - "金谷园"
  - "饺子"
  - "排队"
---

# 金谷园饺子馆 · SKILL

## 基础信息
- 地址：北京海淀区学院南路15号（北邮东门往北200米）
- 营业时间：周一至周日 10:00-21:00
- 电话：010-6225-8888
- Wi-Fi：JinGuYuan_5G / 密码：jgy2026

## 核心功能
1. **店铺查询** - 地址、营业时间、电话
2. **排队取号** - 调用MCP接口连接美团
3. **外卖服务** - 支持美团外卖下单
4. **生饺子打包** - 可提前电话预约
...

## 对话示例
- "金谷园几点开门？"
- "现在排队要等多久？"
- "韭菜鸡蛋馅还有吗？"
```

---

### F2: 生成德胧酒店Skill

**使用场景**：为德胧旗下酒店生成专属Skill

**前置准备**：
- 酒店基础信息（名称、地址、电话、营业时间）
- 特色服务描述
- 会员权益说明
- 酒店品牌调性（开元名都/开元名庭/曼居等）

**生成流程**：
```
1. 输入酒店名称/关键词
2. 自动从飞书知识库/外网检索酒店资料
3. 生成SKILL.md框架
4. 用户确认后生成完整Skill包
5. 提供发布脚本
```

**生成示例（天津瑞湾开元名都）**：
```markdown
---
name: delonix-tianjin-riwan
description: 天津瑞湾开元名都酒店专属技能...
triggers:
  - "天津瑞湾"
  - "瑞湾开元名都"
  - "天津酒店"
---

# 天津瑞湾开元名都 · SKILL

## 基础信息
- 地址：天津市滨海新区中心商务区响螺湾迎宾大道1号
- 电话：022-6625-8888
- 开业时间：2019年
- 星级：五星级
- 特色：海河景观、商务会议、婚宴专家

## 核心服务
1. **客房预订** - 豪华海景房/行政楼层
2. **会议宴会** - 1200㎡无柱宴会厅
3. **餐饮美食** - 中西餐厅/大堂吧
4. **会员权益** - 开元商祺会籍通用
...

## 对话示例
- "天津瑞湾酒店地址在哪？"
- "酒店有什么会议场地？"
- "海景房多少钱？"
```

---

### F3: 多平台发布

**支持的发布平台**：

| 平台 | 地址 | 注册要求 | 发布方式 |
|------|------|----------|----------|
| GitHub | github.com | 需要GitHub账号 | git push + GitHub Actions |
| ClawHub | clawhub.ai | 需要账号+CLI | `clawhub publish` |
|  |  |  |  |

**一键发布到GitHub**：
```bash
# 方式1: GitHub CLI
gh auth login
gh repo create delonix-tianjin-riwan-skill --public --push
gh release create v1.0.0 --notes "天津瑞湾开元名都Skill v1.0"

# 方式2: 手动
# 1. 在GitHub创建空仓库
# 2. git init && git remote add origin
# 3. git add . && git commit -m "feat: init hotel skill"
# 4. git push -u origin main
```

**一键发布到ClawHub**：
```bash
# 1. 安装CLI
npm i -g clawhub

# 2. 登录
clawhub login

# 3. 发布
clawhub publish ./delonix-tianjin-riwan --slug delonix-tianjin-riwan --name "天津瑞湾开元名都" --version 1.0.0
```

---

### F4: 批量生成德胧全品牌Skill

**使用场景**：为德胧所有酒店批量生成Skill

**执行方式**：
```bash
# 需要提供酒店清单（Excel/飞书多维表格）
# 格式：酒店名称 | 品牌 | 城市 | 地址 | 电话

# 然后执行批量生成脚本
./batch-generate.sh hotels.csv
```

**输出结构**：
```
delonix-skills/
├── tianjin-riwan/
│   ├── SKILL.md
│   ├── README.md
│   └── package.json
├── hangzhou-nodica/
│   └── ...
├── shanghai-plaza/
│   └── ...
└── publish-all.sh   # 一键全量发布
```

---

## 使用限制与注意事项

1. **授权合规**：发布前确保获得酒店运营方授权
2. **信息准确性**：生成的Skill内容需人工审核
3. **更新机制**：建议设置定时同步最新信息
4. **敏感数据**：不要在Skill中暴露内部系统接口

---

## 方法论：如何指挥AI搭建Skill

### 核心心法
```
Skill = 业务知识 + 对话能力 + 工具接口
```

### 三步法
```
Step 1: 定义触发词（triggers）
        → 用户怎么称呼这个酒店/服务
        
Step 2: 整理知识库（knowledge）
        → 地址、电话、营业时间、特色服务
        
Step 3: 设计交互场景（scenarios）
        → 用户会问什么？怎么回答？
```

### 指令模板
```
你是一个Skill架构师，请帮我为[酒店名称]创建一个OpenClaw Skill：
1. 酒店基础信息：[填写]
2. 核心服务：[填写]
3. 特色亮点：[填写]
4. 目标用户：[填写]
5. 预期交互场景：[填写]

请生成完整的SKILL.md文件，并提供GitHub/ClawHub发布命令。
```

---

## 未来扩展方向

- [ ] MCP接口对接德胧自有预订系统
- [ ] 自动从飞书多维表格同步酒店数据
- [ ] 支持语音交互
- [ ] 对接美团/携程实时房态
- [ ] 批量发布到国内平台（扣子Coze等）

---

*Last Updated: 2026-04-17*
*Author: 晁留柱的助手（德胧AI龙虾军团）*

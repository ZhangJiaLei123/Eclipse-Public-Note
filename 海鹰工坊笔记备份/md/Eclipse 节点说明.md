---
title: eclipse插件开发节点说明
author: zjl
date: 2018-10-08T00:00:00.000Z
output:
  word_document:
    path: ./doc/Eclipse节点说明.docx
    reference_doc: style.docx
export_on_save:
  pandoc: true
---  

# 项目说明

* 插件项目结构说明

插件项目主要有三个文件夹和文件：src、icons、plugin.xml,如下图所示。

:::{custom-style="图"}
 
@import "./image/插件项目目录结构.PNG" {title="插件项目目录结构"}

:::

* plugin.xml 说明

Eclipse 插件 都是通过 节点 拓展的，通过节点 id 关联对应的 类 ， 以实现设计的插件功能。所有节点定义都在plugin.xml中，

:::{custom-style="图"}
 
@import "./image/plugin说明.PNG" {title="插件项目目录结构"}

:::

* 添加扩展点

:::{custom-style="图"}
 
@import "./image/plugin说明-扩展.PNG" {title="扩展说明"}

:::
点击Add后，会弹出新建扩展点导航，帮助快速新建扩展点，扩展点属性中，标记 * 的，都是必填项目，标记 ！的是不推荐填写项目，无标记的是选填项目。

扩展信息在plugin.xml中保存，一般不建议手动修改xml，容易出错。

:::{custom-style="图"}
 
@import "./image/plugin说明-xml.PNG" {title="xml实例"}

:::

# IDE启动

@import "IDE启动.md"

# 系统菜单、工具条和弹出菜单

@import "系统菜单、工具条和弹出菜单.md"

***********************************************

# 工作台视图

@import "工作台视图相关节点说明.md"
***********************************************

# 工程文件的新建和导入导出

@import "新建工程.md"
***********************************************


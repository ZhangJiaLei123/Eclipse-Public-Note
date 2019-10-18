
## IDE启动相关

通过此部分节点说明,可简单定义你的IDE外观和欢迎页等简单功能。

:::{custom-style="表"}

- 节点概览

| 节点 | 关键节点 | 说明 |
|----| ----| -------|
|  org.eclipse.core.runtime.products  |    |   产品定义    |
|  org.eclipse.ui.startup  |  | 启动前操作   |
| org.eclipse.ui.themes | | 产品主题（颜色、字体） |
|  org.eclipse.ui.intro |  | 简介 |
|  org.eclipse.ui.intro.config | | 简介配置 |
|  org.eclipse.ui.decorators | | 资源文件图标更新 |

:::

### IDE启动画面和名称 org.eclipse.core.runtime.products

此扩展可自定义启动欢迎界面和标题、名称等。

- 主节点示意图

:::{custom-style="图"}
 
@import "./image/org.eclipse.core.runtime.products关键.PNG"

:::

上图红框中的标识是必填的，系统会根据此标识来查找你的产品定义。

- 节点关系图

:::{custom-style="图"}
 
@import "./image/org.eclipse.core.runtime.products.PNG"

:::

- 节点说明

这是一个比较特殊的扩展点，他有且只有一个product节点，并且product的子节点都是通过key-value来和IDE配置意义对应的。如下图

- 参数截图

:::{custom-style="图"}
 
@import "./image/products.property.PNG"

:::

- 参数说明

:::{custom-style="表"}
 
| 参数 | 说明 |
|---- |-------|
| name* |  key值，需要自定义的控件名 |
| value* | 自定义控件参数 |

:::

例如：appName表示IDE名称，在value填写内容就ok。

- 运行方式 

如果想要用自定义产品配置启动Eclipse，需要到 运行->运行配置->要运行的程序中选择你的配置。

:::{custom-style="图"}
 
@import "./image/选择运行程序.PNG"

:::

选择的程序就是你的插件名称.products的标识

### 启动 org.eclipse.ui.startup
此扩展点用来注册想要在启动时激活的插件。作为 startup 元素的属性给定的类必须实现 org.eclipse.ui.IStartup 接口。一旦启动了工作台，就会从独立的线程中调用 earlyStartup() 方法。如果 startup 元素具有 class 属性，则将把该类实例化并对结果调用 earlyStartup() 方法。

* 节点关系图

:::{custom-style="图"}
 
@import "./image/org.eclipse.ui.startup.PNG"

:::


* 此扩展点结构比较简单，暂做简要说明

#### startup 启动

ide启动时调用

* 参数截图

:::{custom-style="图"}
 
@import "./image/startup.Startup.PNG"

:::

* 参数说明

:::{custom-style="表"}

| 参数 | 说明 |
|---- |-------|
| class* |  启动类，此类需实现 *IStartup* 接口，系统会在独立线程中调用 earlyStartup() 方法。 |

:::


* demo

:::{custom-style="代码"}
 
@import "./src/DemoStartup.md"

:::

### 资源文件图标更新 org.eclipse.ui.decorators

此扩展点用来将修饰符添加到遵从修饰符管理器的视图。对于 2.1，存在轻量级修饰符的概念，它用来处理修饰符的图像管理。还有可能声明启用时只覆盖图标不需要插件中的实现的轻量级修饰符。 
操作的启用和/或可视性分别可使用元素 enablement 和 visibility 定义。这两个元素包含进行求值来确定启用和/或可视性的布尔表达式。

* 节点关系图

:::{custom-style="图"}
 
@import "./image/org.eclipse.ui.decorators.PNG"

:::

其中我们需要了解的是 decorator 子节点参数。
* 参数截图

:::{custom-style="图"}
 
@import "./image/decorators.decorator.PNG"

:::

* 参数说明

:::{custom-style="表"}

| 参数 | 说明 |
|---- |-------|
| id* | 节点id，建议和class一致 |
| lable* | 操作名称  |
| objectClass(!)  | (**不推荐**)此修饰符将应用于的类的标准名称  |
| class* |  启动类，此类需实现 *IStartup* 接口，系统会在独立线程中调用 earlyStartup() 方法。 |
| state | 它指示在缺省情况下修饰符是否是打开的 |
| lightweight | 标志指示修饰符是可声明的或者实现 |
| adaptable  | 它指示可以适应除其 objectClass 以外的对象的类型是否应该使用此对象添加项,对于轻量级修饰符来说，只要通过适配器管理器定义适应性，就支持对任何 objectClass 的适应性 （请参阅类 org.eclipse.runtime.IAdapterManager）。|
| icon  | 如果修饰符为 lightweight 并且未指定 class，则这是要应用的覆盖图像的路径 |
|location  | 如果修饰符为 lightweight，则这是将修饰符应用于的位置。缺省值为 BOTTOM_RIGHT |

:::

一般情况下，后几个参数不用设置，如图所示即可。

* demo

:::{custom-style="代码"}

@import "./src/DemoMakefileDecorator.md"

:::

### 产品简介（欢迎页） org.eclipse.ui.intro

此扩展点用来注册负责向新用户介绍产品的特殊工作台部分（称为简介部分）的实现。简介部分通常会在第一次启动产品时显示。还通过此扩展点提供了将简介部分实现与特定产品相关联的规则
因近来前端搭UI是趋势，故此处以配置web页做Demo。

- ui样例：

:::{custom-style="图"}
 
@import "./image/欢迎页.PNG"

:::

- 节点关系图

:::{custom-style="图"}
 
@import "./image/org.eclipse.ui.intro.PNG"

:::


#### (简介声明) intro

指定简介。简介是特定于产品的表示，会在产品启动时显示给第一次使用的用户

参数截图：

:::{custom-style="图"}
 
@import "./image/org.eclipse.ui.intro.intro.PNG"

:::

:::{custom-style="表"}
 
| 参数 | 说明 |
|---| ---|
| id* | 节点id  |
| class* | 系统类 org.eclipse.ui.intro.config.CustomizableIntroPart|
| icon |图标路径 |
| contentDetector | 欢迎页检查者，一个继承IntroContentDetector的实现类，可以不写 | 
| 说明标题 |  一般为 “欢迎使用”  |

:::

#### (简介与产品绑定) introProductBinding

指定产品与简介之间的绑定。这些绑定确定哪个简介适用于当前产品

:::{custom-style="表"}
 
| 参数 | 说明 |
|------------------------| ----------------------|
| productId*             | 绑定的产品id           |
| introId*               | 绑定的简介ID           |

:::

### 简介配置（欢迎页实现方式） org.eclipse.ui.intro.config

节点关系图

:::{custom-style="图"}
 
@import "./image/org.eclipse.ui.intro.config.PNG"

:::

通过config配置欢迎页实现方式

- 节点说明

#### config

指定欢迎页实现方式

- 参数截图

:::{custom-style="图"}
 
@import "./image/org.eclipse.ui.intro.config.config.PNG"

:::

- 参数说明

:::{custom-style="表"}
 
| 参数 | 说明 |
|---| ---|
| introId* | 配置的简介ID |
| id* | 此节点ID |
| content* | 欢迎页内容，如果是html实现，则填写web配置文件路径 |
|  configurer | 标准类的名称，此类支持简介配置的动态方面。此类可以提供替换变量的值和动态组的子代，并可以解析不完整的目标路径。此类必须扩展 org.eclipse.ui.intro.IntroConfigurer。此处未使用，不做说明 | 

:::
 
- introcontent.xml 样例：

:::{custom-style="图"}
 
@import "./image/introcontent.PNG"

:::


#### presentation

定义简介部分的表示的所有可能实现的表示元素。它可能定义了一个或多个实现。根据实现的 os/ws 属性，启动时只会有一个实现被选中。否则，没有定义 os/ws 属性的第一项将会被选中。

* 参数截图

:::{custom-style="图"}
 
@import "./image/org.eclipse.ui.intro.config.presentation.PNG"

:::

* 参数说明

:::{custom-style="表"}
 
| 参数 | 说明 |
|---| ---|
| home-page-id |  主（根）页的标识，主页即简介的第一页。此页面可用作构成简介的其他主页面的入口点。| 
| standby-page-id |  用来定义备用页面的标识的可选属性。备用页面将在简介设置为备用时显示给用户。|

:::

#### implementation

有两个实现。其中一项是基于 SWT 浏览器的，而另一项是基于 UI 表单的。可配置可定制简介部分以便根据当前操作系统和窗口系统选择这两个表示的其中一个。实现的类型可以是 SWT 或 HTML。

:::{custom-style="图"}
 
- 参数截图

@import "./image/org.eclipse.ui.intro.config.implementation.PNG"

:::

- 参数说明

:::{custom-style="表"}
 
| 参数 | 说明 |
|---| ---|
|kind | 指定此实现的类型。SWT 种类指示基于用户 UI 表单的实现，而 HTML 种类指示基于 SWT 浏览器的实现 |
|style | 将应用于此简介表示实现表示的所有页面的共享样式。 |
|os | 在选择表示的实现时使用的可选操作系统规范。它可以是 Eclipse 定义的任何操作系统标识，例如，win32 和 linux 等等（请参阅 org.eclipse.core.runtime.Platform 的 Javadoc）。 |
|ws | 在选择表示的实现时使用的可选窗口系统规范。它可以是 Eclipse 定义的任何窗口系统标识 |

:::

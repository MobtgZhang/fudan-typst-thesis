# 复旦大学硕博士毕业设计论文Typst模板
## 编译预览
<table>
  <tr>
    <td><img src="imgs/page1.png"></td>
    <td><img src="imgs/page2.png"></td>
    <td><img src="imgs/page3.png"></td>
  </tr>
</table>

## 什么是Typst模板
`Typst`是一个具有现代语法标记的排版系统和编程语言，被设计用于来创建美观、精确的文档。与传统文档排版系统，例如`LaTeX`，`ConTeXt`等并不相同，`Typst`采用了更加直观的语法，并且具有毫秒级别的编译速度，实现了所见即所得的排版系统，对于新手更加友好。

`Typst`语法更加接近于`Markdown`语法，但是比它功能更多，语法更加全面，能够非常灵活有效地进行排版工作。

`Typst`社区和官方可能会提供各种各样的模板，用户可以根据自己需要选择合适的`Typst`模板来使用，这些模板可以通过`Typst`在线编辑器或者类似于`VSCode`等一类编辑器进行文档排版处理。
## 目前计划线路图/进度
+ **说明文档**
    - [ ] 针对本校模板的特点，编写详细的说明文档；
    - [x] 类似于`LaTeX`当中的`documentclass`设置，进行全局信息的配置，在`config.typ`中定义自己的信息；
    - [ ] **盲审模式**，可以将所有的个人信息替换成小黑条，并且隐藏致谢页面，以便于在提交论文的阶段使用；
    - [x] **双页模式**，在论文需要的部分添加空白页，以方便论文的打印；
    - [x] **自定义字体配置**，可以配置宋体、黑体、楷体等字体，用于文档中的字体变换；
    - [x] **数学字体配置**，可以设置`#show math.equation: set text(font: "Fira Math")`进行更改；
+ **模板情况**
    - [ ] 本科生模板
    - [x] 硕士生模板
    - [x] 博士生模板
+ **其他文件**
    - [ ] 本科生开题报告
    - [ ] 研究生开题报告
    - [ ] 博士研究计划书
## 使用方法
1. 安装最新版本的[Typst](https://typst.app/)软件;
2. 下载并且解压到对应的文件目录当中；
3. 修改并且将自己的文章写到`thesis.typ`文件中；
4. 运行`typst compile thesis.typ --font-path fonts_path`

## FAQs

### 不会LaTeX可以使用这个模板写论文吗？

这是可以的，大部分`Typst`语言特性和`LaTeX`大不相同，而且对于数学公式等方面页相较于`LaTeX`实现了非常多，可以胜任很多工作。

### 不会这个编程语言可以使用这个模板写论文吗？

这个模板的学习成本仅仅类似于`Markdown`语法的模板，该模板为的就是简便，高效，从而构建自己漂亮的论文，相信比`Word`编写更好，比`LaTeX`更容易入门。

### 无法找到宋体、黑体、楷体等文字字体文件
对于MacOS系统来说，注意将对应的字体文件名称进行修改

+ `SimSun`修改为`STSongti-SC-Regular`
+ `SimHei`修改为`STHeiti-SC-Regular`

对于Linux用户来说，缺少Windows字体文件，可以通过以下的方式将Windows字体文件库导入到Linux系统当中：
```bash
sudo mkdir -p /usr/share/fonts/winfonts # 共享文件夹下创建Windows字体库
sudo cp Windows/Fonts/* /usr/share/fonts/winfonts/ # 将Windows字体复制到对应的文件夹下面，注意将标定的文件夹替换为Windows所在的目录
sudo mkfontdir
sudo mkfontscale  # 创建字体比率
sudo fc-cache -fv  # 刷新字体库
```


### 参与此小项目的方法

可以提交PR，若没问题则将修改的代码合并起来。

## 参考项目

+ [北京大学博士论文Typst模板](https://github.com/pku-typst/pkuthss-typst)

+ [南京大学本硕论文Typst模板](https://github.com/nju-lug/modern-nju-thesis)
+ [中山大学本科论文Typst模板](https://github.com/howardlau1999/sysu-thesis-typst)

## 遵循的开源协议

本项目遵循GPL Version 3.0 开源协议

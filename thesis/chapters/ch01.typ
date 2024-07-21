= 绪论

在本模板编写指出，并没有可以找到的复旦大学Typst论文模板，所以在此本项目可以找到的Typst模板项目有以下的一些内容：

- #link("https://github.com/pku-typst/pkuthss-typst","北京大学博士Typst学位论文模板")；
- #link("https://github.com/nju-lug/modern-nju-thesis","南京大学本硕Typst学位论文模板")；
- #link("https://github.com/howardlau1999/sysu-thesis-typst","中山大学本科Typst论文模板")。

但是这些模板中也存在着较多的问题，所以本模板是将上述模板中存在的问题进行改进和深入编写，同时进行探索性论文模板的创新。

相比之下，Typst模板在国内用户更加寥寥无几，尽管LaTeX模板已经在各大高效以及科研机构进行大力的推广，但是用户主体仍旧较少。目前也出现了Typst社区对Typst进行维护。考虑到开发的持续性，所以本项目中也集成了较多的封装函数。

== 什么是Typst？
首先，介绍一下什么是Typst排版系统。Typst是用`rust`语言开发的、用于书籍、论文以及PPT等排版操作的排版语言，它以直观、强大并且现代化的方式处理文本布局和设计。它的语法更类似于`Markdown`语法，但是比`Markdown`语法更加强大。与传统的排版系统相比较，`LaTeX`，`ConTeXt`等排版语言，以及图形设计软件InDesign，Word等，Typst提供了一种全新的编程语言和工具集，使得用户能够直接地控制页面上的元素布局。

Typst排版系统具有以下多个优势：

+ 直观的语法：Typst使用一种接近于`Markdown`语法，`LaTeX`语法经常使用一些标记语言进行排版，同时LaTeX2e存在着冗长的宏定义命令，LaTeX3也并不符合现代排版语言，而Typst则类似于Rust，Markdown等现代语法，更加符合现代编程思维。
+ 定制化强：提供了灵活的函数和脚本系统，用户可以对排版进行精细控制，适合高级用户自定义需求，通过定义样式规则和脚本来定制文档元素的外观，实现高度个性化的设计需求；
+ 高效的编译和错误处理：具有即见即所得的排版，大大提高了大型文档的编译速度，同时提供友好的错误信息，帮助排版作者快速定位并解决排版过程中的问题。
+ 较为丰富的开源生态：Typst 拥有一个活跃的开源社区，提供了丰富的模板、工具和资源。

== Typst安装

Typst可以在官网的#link("https://typst.app","在线排版")上进行写作，写作结束之后，直接导出PDF即可。另外一种就是VSCode+Typst方式进行文档编辑，首先在Typst的#link("https://github.com/typst/typst","Github项目页面")中下载Typst的安装包，解压到对应的位置并添加到环境变量中即可（Linux&Windows均为类似的操作）。

VSCode的设置，在插件市场下载Tinymist Typst即可，随之就可以建立项目进行编辑了。

== 关于本文档




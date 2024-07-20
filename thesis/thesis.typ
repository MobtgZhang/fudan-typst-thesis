#import "template.typ":*
#show: doc => fudan_thesis(doc)

// 中文封面
#include "covers/cover.typ"
// 目录
#tableofcontents(
    depth: outlinedepth,
    indent: true)
//#frontmatter()
// 中文摘要
#include "chapters/cn-abstract.typ"
// 英文摘要
#include "chapters/en-abstract.typ"
// 引言
#include "chapters/preference.typ"
// 符号说明
#include "chapters/symbols.typ"
//#mainmatter()
// 正文
#include "chapters/ch01.typ" // 绪论
#include "chapters/ch02.typ" // 公式、图片、表格、代码等插入方法
#include "chapters/ch03.typ" // 算法、定理示例
#include "chapters/ch04.typ" // 引用、交叉引用以及参考文献
#include "chapters/ch05.typ" // 总结
#include "chapters/appendix.typ" // 附录
#bibliography(("bibs/example01.bib","bibs/example02.bib"),style: "gb-7714-2015-numeric")  // 参考文献
//#backmatter()
#include "chapters/thanks.typ"  // 致谢
#include "covers/original.typ" // 作者原创声明等


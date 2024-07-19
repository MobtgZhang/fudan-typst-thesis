#import "template.typ":*
#show: doc => fudan_thesis(
    zh_author: "张三",
    en_author: "San Zhang",
    student_id: "23000xxxxx",
    doc
)

// 中文封面
#include "covers/chinese.typ"
// 英文封面
#include "covers/english.typ"
// 符号说明
#include "covers/symbols.typ"
// 正文
#include "chapters/ch01.typ" // 绪论
#include "chapters/ch02.typ" // 公式、图片、表格、代码等插入方法
#include "chapters/ch03.typ" // 算法、定理示例
#include "chapters/ch04.typ" // 引用、交叉引用以及参考文献
#include "chapters/ch05.typ" // 总结
#include "chapters/appendix.typ" // 附录
#bibliography(("bibs/example01.bib","bibs/example02.bib"),style: "gb-7714-2015-numeric")  // 参考文献
#include "chapters/thanks.typ"  // 致谢
#include "covers/original.typ" // 作者原创声明等


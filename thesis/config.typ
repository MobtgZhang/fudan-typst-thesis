// 这里是文档的配置文件，主要是定义了一些文章中涉及到的内容信息
#let cn_author = "张三"
#let en_author = "San Zhang"
#let student_id = "24000240000"
#let cn_instructor = "李四" // 指导教师
#let cn_instructor_type = "教授"  // 指导教师职称
#let cn_title = "复旦大学硕博学位论文Typst模板"
#let en_title = "Typst Template for Fudan University"
#let school_name = "计算机科学技术学院"
#let linespacing = 20pt // 20磅的行距
#let degree_type = "硕士" // 硕士还是博士
#let major_type = "专业学位" // 专业学位还是学术学位
#let auto_fake_blod = 0.5pt
#let major_cn_name = "计算机科学与技术"
#let student_type = "" // 同等学力人员或英文项目
#let secret_years = none // 如果非秘密项目，可以设置为none，秘密项目直接设置为XXX数字
#let double_covers = false // 是否添加空页码，设置为打印时候的页码
#let outlinedepth = 3 // 目录的深度
// 中图分类号
#let clc_number = "TP391.1"
// 完成日期
#let display_year = str(datetime.today().year())
#let display_month = str(datetime.today().month())
#let display_day = str(datetime.today().day())
#let finish_day = display_year+"年"+display_month+"月"+display_day+"日"
// 是否列举出某些目录
// 列出图片
#let is_listofimage = true
// 列出表格
#let is_listoftable = true
// 列出代码
#let is_listofcode = true

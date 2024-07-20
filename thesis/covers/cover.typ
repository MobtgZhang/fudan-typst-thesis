//论文第一页
#import "../template.typ":font_size_dict,font_type_dict,chinesenumber,smartpagebreak
#import "../config.typ":*
// 定义一些工具函数
#let fieldname(name) = [
    #set align(right + top)
    #name
  ]

#let fieldvalue(value) = [
    #set align(left + horizon)
    #set text(font: font_type_dict.宋体)
    #grid(
      rows: (auto, auto),
      row-gutter: 0.2em,
      h(1em)+value
    )
  ]
#align(right + top)[
  #set text(font:font_type_dict.宋体,weight: "semibold",size:font_size_dict.五号)
  #table(
    stroke:none,
    align: (right,left,center,right,left),
    columns: (auto,50pt,160pt,auto,100pt),
    [],[],[],[#if secret_years!= none{
      [#strong("密"+h(2em)+"级：")]
    }],[#if secret_years!= none{
      "秘密"+$star.filled$+chinesenumber(secret_years)+"年"
    }],
    [],[],[],[#strong("学校代码：")],
[10246],
    [],[],[],[#strong("学"+h(2em)+"号：")],[#student_id],
    [],[],[],[],[#text(student_type)],
  )
  #v(2em)
  #figure(
    image("../fudan-name.png",width: 3.02in,height: 1.13in)
  )
  #v(1em)
]
#align(center + top)[
  #(if degree_type=="博士" {
      text("博"+ h(1em) + "士"+ h(1em) + "学"+ h(1em) + "位"+ h(1em) + "论"+ h(1em) + "文",font:font_type_dict.宋体,size:font_size_dict.二号)
    }else{
      text("硕"+ h(1em) + "士"+ h(1em) + "学"+ h(1em) + "位"+ h(1em) + "论"+ h(1em) + "文",font:font_type_dict.宋体,size:font_size_dict.二号)
  })

  #text("（"+major_type +"）",font:font_type_dict.宋体,size:font_size_dict.小三)
  #v(1em)
  #text(cn_title,font:font_type_dict.宋体,size:font_size_dict.小二,stroke: auto_fake_blod)

  #text(en_title,font:font_type_dict.宋体,size:font_size_dict.小三)
]
#v(3em)

#align(center)[
  #set text(font:font_type_dict.宋体,size:font_size_dict.四号)
  #grid(
      columns: (150pt, 150pt),
      row-gutter: 1em,
      fieldname("院" + h(3.5em) + "系："),
      fieldvalue(school_name),
      fieldname("专" + h(3.5em) + "业："),
      fieldvalue(major_cn_name),
      fieldname("姓" + h(3.5em) + "名："),
      fieldvalue(cn_author),
      fieldname("指" + h(0.5em) + "导" + h(0.5em) + "教" + h(0.5em) + "师："),
      fieldvalue(cn_instructor+h(0.5em)+cn_instructor_type),
      fieldname("完" + h(0.5em) + "成" + h(0.5em) + "日" + h(0.5em) + "期："),
      fieldvalue(finish_day),
    )
]
#smartpagebreak()

// 指导小组成员扉页
#align(center + top)[
  #text("指"+h(1em)+"导"+h(1em)+"小"+h(1em)+"组"+h(1em)+"成"+h(1em)+"员", font: font_type_dict.黑体, size: font_size_dict.二号)
  
  #text(font: font_type_dict.宋体,font_size_dict.三号)[
    #set align(center+top)
    // 姓名和职称按照下面的格式写即可
    #grid(
      columns: (8em,1em,8em),
      row-gutter: 1em,
      align: (right,center,left),
      [张 #h(1.2em) 三],[],[教 #h(1.2em) 授],
      [李 #h(1.2em) 四],[],[副 教 授],
      [王 五 六],[],[副 教 授],
    )
  ]
]
#smartpagebreak()

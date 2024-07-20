#import "../template.typ":smartpagebreak,font_size_dict,font_type_dict
#import "../config.typ":auto_fake_blod
#smartpagebreak()
#v(5em)
#text()[
  #set align(center+top)
  #set text(font: font_type_dict.宋体, size: font_size_dict.二号, stroke: auto_fake_blod)
  复旦大学
  #v(-0.5em)
  学位论文独创性声明
]
本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得的成果。论文中除特别标注的内容外，不包含任何其他个人或机构已经发表或撰写过的研究成果。对本研究做出重要贡献的个人和集体，均已在论文中作了明确的声明并表示了谢意。本声明的法律结果由本人承担。
#v(2em)
#text()[
  #set align(right)
  #grid(
      columns: (5em,5em,2em,3em,5em,6em),
      row-gutter: 0.2em,
      stroke: (),
      align: (right,left+bottom,right,right,left+bottom,right),
      [作者签名：],[#line(length:6em)],[],[日期：],[#line(length:6em)],[]
  )  
]       

#text()[
  #set align(center+bottom)
  #set text(font: font_type_dict.宋体, size: font_size_dict.二号, stroke: auto_fake_blod)
  复旦大学
  #v(-0.5em)
  学位论文使用授权声明
]

本人完全了解复旦大学有关收藏和利用博士、硕士学位论文的规定，即：学校有权收藏、使用并向国家有关部门或机构送交论文的印刷本和电子版本；允许论文被查阅和借阅；学校可以公布论文的全部或部分内容，可以采用影印、缩印或其它复制手段保存论文。涉密学位论文在解密后遵守此规定。
#v(2em)
#set align(right)
  #grid(
      columns: (5em,6em,2em,5em,6em,2em,3em,6em,2em),
      row-gutter: 0.2em,
      stroke: (),
      align: (right,left+bottom,right,right,left+bottom,right),
      [作者签名：],[#line(length:6em)],[],[导师签名：],[#line(length:6em)],[],[日期：],[#line(length:6em)],[]
)        
#v(5em)

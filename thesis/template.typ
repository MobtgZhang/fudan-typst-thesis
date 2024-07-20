#import "config.typ":*
// 定义相关字体、字号信息等
#let font_size_dict = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)

#let font_type_dict = (
  仿宋: ("Times New Roman", "FangSong"),
  宋体: ("Times New Roman", "Simsun (Founder Extended)"),
  黑体: ("Times New Roman", "SimHei"),
  楷体: ("Times New Roman", "KaiTi"),
  代码: ("New Computer Modern Mono", "Times New Roman", "SimSun"),
)

#let lengthceil(len, unit: font_size_dict.小四) = calc.ceil(len / unit) * unit
// 定义计数器
#let partcounter = counter("part")  // 章
#let chaptercounter = counter("chapter")  // 节
#let appendixcounter = counter("appendix")  // 附录
#let footnotecounter = counter(footnote) // 脚注
#let rawcounter = counter(figure.where(kind: "code"))  // 代码
#let imagecounter = counter(figure.where(kind: image)) // 图片
#let tablecounter = counter(figure.where(kind: table)) // 表格
#let equationcounter = counter(math.equation) // 方程
// 文章达到附录的时候，将计数器置为0
#let appendix() = {
  appendixcounter.update(10)
  chaptercounter.update(0)
  counter(heading).update(0)
}
//
//
#let skippedstate = state("skipped", false)
//-------------------------------------------------------------
// 定义一些工具函数
// 定义中文数字
#let chinesenumber(num, standalone: false) = if num < 11 {
  ("零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十").at(num)
} else if num < 100 {
  if calc.rem(num, 10) == 0 {
    chinesenumber(calc.floor(num / 10)) + "十"
  } else if num < 20 and standalone {
    "十" + chinesenumber(calc.rem(num, 10))
  } else {
    chinesenumber(calc.floor(num / 10)) + "十" + chinesenumber(calc.rem(num, 10))
  }
} else if num < 1000 {
  let left = chinesenumber(calc.floor(num / 100)) + "百"
  if calc.rem(num, 100) == 0 {
    left
  } else if calc.rem(num, 100) < 10 {
    left + "零" + chinesenumber(calc.rem(num, 100))
  } else {
    left + chinesenumber(calc.rem(num, 100))
  }
} else {
  let left = chinesenumber(calc.floor(num / 1000)) + "千"
  if calc.rem(num, 1000) == 0 {
    left
  } else if calc.rem(num, 1000) < 10 {
    left + "零" + chinesenumber(calc.rem(num, 1000))
  } else if calc.rem(num, 1000) < 100 {
    left + "零" + chinesenumber(calc.rem(num, 1000))
  } else {
    left + chinesenumber(calc.rem(num, 1000))
  }
}
// 定义中文计数，主要作用于章节的计数
#let chinesenumbering(..nums, location: none, brackets: false) = locate(loc => {
  let actual_loc = if location == none { loc } else { location }
  if appendixcounter.at(actual_loc).first() < 10 {
    if nums.pos().len() == 1 {
      "第" + chinesenumber(nums.pos().first(), standalone: true) + "章"
    } else {
      numbering(if brackets { "(1.1)" } else { "1.1" }, ..nums)
    }
  } else {
    if nums.pos().len() == 1 {
      "附录 " + numbering("A.1", ..nums)
    } else {
      numbering(if brackets { "(A.1)" } else { "A.1" }, ..nums)
    }
  }
})

// 中文下划线
#let chineseunderline(s, width: 300pt, bold: false) = {
  let chars = s.clusters()
  let n = chars.len()
  style(styles => {
    let i = 0
    let now = ""
    let ret = ()

    while i < n {
      let c = chars.at(i)
      let nxt = now + c

      if measure(nxt, styles).width > width or c == "\n" {
        if bold {
          ret.push(strong(now))
        } else {
          ret.push(now)
        }
        ret.push(v(-1em))
        ret.push(line(length: 100%))
        if c == "\n" {
          now = ""
        } else {
          now = c
        }
      } else {
        now = nxt
      }

      i = i + 1
    }

    if now.len() > 0 {
      if bold {
        ret.push(strong(now))
      } else {
        ret.push(now)
      }
      ret.push(v(-0.9em))
      ret.push(line(length: 100%))
    }

    ret.join()
  })
}

// 中文目录
#let chineseoutline(title: "目录", depth: none, indent: false) = {
  heading(title, numbering: none, outlined: false)
  locate(it => {
    let elements = query(heading.where(outlined: true).after(it), it)

    for el in elements {
      // Skip list of images and list of tables
      if partcounter.at(el.location()).first() < 20 and el.numbering == none { continue }

      // Skip headings that are too deep
      if depth != none and el.level > depth { continue }

      let maybe_number = if el.numbering != none {
        if el.numbering == chinesenumbering {
          chinesenumbering(..counter(heading).at(el.location()), location: el.location())
        } else {
          numbering(el.numbering, ..counter(heading).at(el.location()))
        }
        h(0.5em)
      }

      let line = {
        if indent {
          h(1em * (el.level - 1 ))
        }

        if el.level == 1 {
          v(0.5em, weak: true)
        }

        if maybe_number != none {
          style(styles => {
            let width = measure(maybe_number, styles).width
            box(
              width: lengthceil(width),
              link(el.location(), if el.level == 1 {
                strong(maybe_number)
              } else {
                maybe_number
              })
            )
          })
        }

        link(el.location(), if el.level == 1 {
          strong(el.body)
        } else {
          el.body
        })

        // Filler dots
        if el.level == 1 {
          box(width: 1fr, h(10pt) + box(width: 1fr) + h(10pt))
        } else {
          box(width: 1fr, h(10pt) + box(width: 1fr, repeat[.]) + h(10pt))
        }

        // Page number
        let footer = query(selector(<__footer__>).after(el.location()), el.location())
        let page_number = if footer == () {
          0
        } else {
          counter(page).at(footer.first().location()).first()
        }
        
        link(el.location(), if el.level == 1 {
          strong(str(page_number))
        } else {
          str(page_number)
        })

        linebreak()
        v(-0.2em)
      }

      line
    }
  })
}

// 插图目录
#let listoffigures(title: "插图", kind: image) = {
  heading(title, numbering: none, outlined: false)
  locate(it => {
    let elements = query(figure.where(kind: kind).after(it), it)

    for el in elements {
      let maybe_number = {
        let el_loc = el.location()
        chinesenumbering(chaptercounter.at(el_loc).first(), counter(figure.where(kind: kind)).at(el_loc).first(), location: el_loc)
        h(0.5em)
      }
      let line = {
        style(styles => {
          let width = measure(maybe_number, styles).width
          box(
            width: lengthceil(width),
            link(el.location(), maybe_number)
          )
        })

        link(el.location(), el.caption.body)

        // Filler dots
        box(width: 1fr, h(10pt) + box(width: 1fr, repeat[.]) + h(10pt))

        // Page number
        let footers = query(selector(<__footer__>).after(el.location()), el.location())
        let page_number = if footers == () {
          0
        } else {
          counter(page).at(footers.first().location()).first()
        }
        link(el.location(), str(page_number))
        linebreak()
        v(-0.2em)
      }

      line
    }
  })
}

// 代码块
#let codeblock(raw, caption: none, outline: false) = {
  figure(
    if outline {
      rect(width: 100%)[
        #set align(left)
        #raw
      ]
    } else {
      set align(left)
      raw
    },
    caption: caption, kind: "code", supplement: ""
  )
}

// 表格部分
#let booktab(columns: (), aligns: (), width: auto, caption: none, ..cells) = {
  let headers = cells.pos().slice(0, columns.len())
  let contents = cells.pos().slice(columns.len(), cells.pos().len())
  set align(center)

  if aligns == () {
    for i in range(0, columns.len()) {
      aligns.push(center)
    }
  }

  let content_aligns = ()
  for i in range(0, contents.len()) {
    content_aligns.push(aligns.at(calc.rem(i, aligns.len())))
  }

  return figure(
    block(
      width: width,
      grid(
        columns: (auto),
        row-gutter: 1em,
        line(length: 100%),
        [
          #set align(center)
          #box(
            width: 100% - 1em,
            grid(
              columns: columns,
              ..headers.zip(aligns).map(it => [
                #set align(it.last())
                #strong(it.first())
              ])
            )
          )
        ],
        line(length: 100%),
        [
          #set align(center)
          #box(
            width: 100% - 1em,
            grid(
              columns: columns,
              row-gutter: 1em,
              ..contents.zip(content_aligns).map(it => [
                #set align(it.last())
                #it.first()
              ])
            )
          )
        ],
        line(length: 100%),
      ),
    ),
    caption: caption,
    kind: table
  )
}
// 用于分页操作
#let smartpagebreak = () => {
  if double_covers {
    skippedstate.update(true)
    pagebreak(to: "odd", weak: true)
    skippedstate.update(false)
  } else {
    pagebreak(weak: true)
  }
}

// 定义目录
#let tableofcontents(depth: none, indent: false) = {
  set align(center)
  set text(font:font_type_dict.黑体, size: font_size_dict.三号)
  heading("目   录", numbering: none, outlined: false)
  locate(it => {
    let elements = query(heading.where(outlined: true).after(it), it)

    for el in elements {
      // Skip list of images and list of tables
      if partcounter.at(el.location()).first() < 20 and el.numbering == none { continue }

      // Skip headings that are too deep
      if depth != none and el.level > depth { continue }

      let maybe_number = if el.numbering != none {
        if el.numbering == chinesenumbering {
          chinesenumbering(..counter(heading).at(el.location()), location: el.location())
        } else {
          numbering(el.numbering, ..counter(heading).at(el.location()))
        }
        h(0.5em)
      }

      let line = {
        if indent {
          h(1em * (el.level - 1 ))
        }

        if el.level == 1 {
          v(0.5em, weak: true)
        }

        if maybe_number != none {
          style(styles => {
            let width = measure(maybe_number, styles).width
            box(
              width: lengthceil(width),
              link(el.location(), if el.level == 1 {
                strong(maybe_number)
              } else {
                maybe_number
              })
            )
          })
        }

        link(el.location(), if el.level == 1 {
          strong(el.body)
        } else {
          el.body
        })

        // Filler dots
        if el.level == 1 {
          box(width: 1fr, h(10pt) + box(width: 1fr) + h(10pt))
        } else {
          box(width: 1fr, h(10pt) + box(width: 1fr, repeat[.]) + h(10pt))
        }

        // Page number
        let footer = query(selector(<__footer__>).after(el.location()), el.location())
        let page_number = if footer == () {
          0
        } else {
          counter(page).at(footer.first().location()).first()
        }
        
        link(el.location(), if el.level == 1 {
          strong(str(page_number))
        } else {
          str(page_number)
        })

        linebreak()
        v(-0.2em)
      }
      line
    }
  })
  smartpagebreak()
}

// 显示英文摘要
#let show_en_abstract(loaded_filename) = {
  set align(center+top)
  text("Abstract", font: font_type_dict.黑体,size:font_size_dict.二号)
  set align(left+top)
  par(justify: true, first-line-indent: 2em, leading: linespacing)[
      #include loaded_filename
      #import loaded_filename: en_key_words
      #linebreak()
      #set align(bottom+left)
      #set par(first-line-indent: 0em)
      #text("Keywords: ", weight: "bold")
      #en_key_words.join("; ")
      
      #text("CLC Code: ", stroke: auto_fake_blod)
      #clc_number
      #v(5em)
  ]
  smartpagebreak()
}
// 显示中文摘要
#let show_cn_abstract(loaded_filename) = {
  set align(center+top)
  text("摘"+h(1em)+"要", font: font_type_dict.黑体,size:font_size_dict.二号)
  set par(justify: true, first-line-indent: 2em, leading: linespacing)
  set align(left+top)
  par(justify: true, first-line-indent: 2em, leading: linespacing)[
      #include loaded_filename
      #import loaded_filename: cn_key_words
      #linebreak()
      #set align(bottom+left)
      #set par(first-line-indent: 0em)
      #text("关键字： ", stroke: auto_fake_blod)
      #cn_key_words.join("； ")
      
      #text("中图分类号： ", stroke: auto_fake_blod)
      #clc_number
      #v(5em)
  ]
  smartpagebreak()
}






// 定义文章的主体部分
#let fudan_thesis(
    doc,
) = {
  set page("a4",
    header: locate(loc => {
      if skippedstate.at(loc) and calc.even(loc.page()) { return }
      [
        #set text(font_size_dict.五号)
        #set align(center)
        #if partcounter.at(loc).at(0) < 10 {
          let headings = query(selector(heading).after(loc), loc)
          let next_heading = if headings == () {
            ()
          } else {
            headings.first().body.text
          }

          // [HARDCODED] Handle the first page of Chinese abstract specailly
          if next_heading == "摘要" and calc.odd(loc.page()) {
            [
              #next_heading
              #v(-1em)
              #line(length: 100%)
            ]
          }
        } else if partcounter.at(loc).at(0) <= 20 {
          if calc.even(loc.page()) {
            [
              #let cheader= "复旦大学"+degree_type+"学位论文"
              #align(center, cheader)
              #v(-1em)
              #line(length: 100%)
            ]
          } else {
            let footers = query(selector(<__footer__>).after(loc), loc)
            if footers != () {
              let elems = query(
                heading.where(level: 1).before(footers.first().location()), footers.first().location()
              )

              // [HARDCODED] Handle the last page of Chinese abstract specailly
              let el = if elems.last().body.text == "摘要" or not skippedstate.at(footers.first().location()) {
                elems.last()
              } else {
                elems.at(-2)
              }
              [
                #let numbering = if el.numbering == chinesenumbering {
                  chinesenumbering(..counter(heading).at(el.location()), location: el.location())
                } else if el.numbering != none {
                  numbering(el.numbering, ..counter(heading).at(el.location()))
                }
                #if numbering != none {
                  numbering
                  h(0.5em)
                }
                #el.body
                #v(-1em)
                #line(length: 100%)
              ]
            }
          }
      }]}),
    footer: locate(loc => {
      if skippedstate.at(loc) and calc.even(loc.page()) { return }
      [
        #set text(font_size_dict.五号)
        #set align(center)
        #if query(selector(heading).before(loc), loc).len() < 2 or query(selector(heading).after(loc), loc).len() == 0 {
          // Skip cover, copyright and origin pages
        } else {
          let headers = query(selector(heading).before(loc), loc)
          let part = partcounter.at(headers.last().location()).first()
          [
            #if part < 20 {
              numbering("I", counter(page).at(loc).first())
            } else {
              str(counter(page).at(loc).first())
            }
          ]
        }
        #label("__footer__")
      ]
    }),
  )
  set text(font_size_dict.一号, font: font_type_dict.宋体, lang: "zh")
  set align(center + horizon)
  set heading(numbering: chinesenumbering)

  //设置文章中主体样式
  set align(left + top)
  // 设置文章字体
  // 正文内容，字体：宋体、字号：小四号、字符间距：标准
  set text(size: font_size_dict.小四, font: font_type_dict.宋体, lang: "zh")
  // 设置字体加粗和斜体样式
  show strong: it => text(stroke:auto_fake_blod,it.body)
  show emph: it => text(style: "italic", it.body)
  

  // 设置章节标题格式
  show heading: it => [
    // Cancel indentation for headings
    #set par(first-line-indent: 0em)

    #let sizedheading(it, size) = [
      #set text(size)
      #v(2em)
      #if it.numbering != none {
        strong(counter(heading).display())
        h(0.5em)
      }
      #strong(it.body)
      #v(1em)
    ]

    #if it.level == 1 {
      if not it.body.text in ("Abstract", "学位论文使用授权说明", "版权声明")  {
        smartpagebreak()
      }
      locate(loc => {
        if it.body.text == "摘要" {
          partcounter.update(10)
          counter(page).update(1)
        } else if it.numbering != none and partcounter.at(loc).first() < 20 {
          partcounter.update(20)
          counter(page).update(1)
        }
      })
      if it.numbering != none {
        chaptercounter.step()
      }
      footnotecounter.update(())
      imagecounter.update(())
      tablecounter.update(())
      rawcounter.update(())
      equationcounter.update(())

      set align(center)
      sizedheading(it, font_size_dict.三号)
    } else {
      if it.level == 2 {
        sizedheading(it, font_size_dict.四号)
      } else if it.level == 3 {
        sizedheading(it, font_size_dict.中四)
      } else {
        sizedheading(it, font_size_dict.小四)
      }
    }
  ]
  // 设置插入图片的格式
  set figure(
    numbering: (..nums) => locate(loc => {
      if appendixcounter.at(loc).first() < 10 {
        numbering("1.1", chaptercounter.at(loc).first(), ..nums)
      } else {
        numbering("A.1", chaptercounter.at(loc).first(), ..nums)
      }
    })
  )
  // 设置插入方程的格式
  set math.equation(
    numbering: (..nums) => locate(loc => {
      set text(font: 字体.宋体)
      if appendixcounter.at(loc).first() < 10 {
        numbering("(1.1)", chaptercounter.at(loc).first(), ..nums)
      } else {
        numbering("(A.1)", chaptercounter.at(loc).first(), ..nums)
      }
    })
  )
  // 设置列表格式
  set list(indent: 2em)
  set enum(indent: 2em)

  par(justify: true, first-line-indent: 2em, leading: linespacing)[
    #doc
  ]
}


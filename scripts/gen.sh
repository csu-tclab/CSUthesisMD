#!/bin/bash

# 目标文件
content_file=content.tex

rm -rf ./content/content.md
# 综合各章节
cat ./content/content_*.md >> ./content/content.md
# 生成 .tex 文件
pandoc --biblatex --wrap=none ./content/content.md -o ./content/${content_file}

# citess 引用呈现在右上角
sed -i "s/textcite/cite/g" ./content/${content_file}
sed -i "s/autocite/cite/g" ./content/${content_file}
sed -i "s/,height=\\\textheight//g" ./content/${content_file}

# 处理章节标题引用
# MD 转 latex 形如 {[}fig:tzasc{]}
sed -i "s/{\[}\(fig:[^{]*\){\]}/\\\ref{\1}/g" ./content/${content_file}
# 图引用
sed -i "s/{\[}\(head:[^{]*\){\]}/\\\ref{\1}/g" ./content/${content_file}
# 表格引用
sed -i "s/{\[}\(table:[^{]*\){\]}/\\\ref{\1}/g" ./content/${content_file}

# 图片浮动
sed -i "1s/begin{figure}/begin{figure}[htb]/g" ./content/${content_file}

# 处理无序列表
sed -i "/tightlist/d" ./content/${content_file}

# 输出字数
texcount content/${content_file}  | grep Words


if [ "$1" == "clean" ];then
    # 不太优雅，用正则来匹配
    rm csuthesis_main.aux
    rm csuthesis_main.lof
    rm csuthesis_main.log
    rm csuthesis_main.lot
    rm csuthesis_main.out
    rm csuthesis_main.thm
    rm csuthesis_main.toc
    rm csuthesis_main.bbl
fi

if [ "$1" = "test" ];then
    xelatex csuthesis_main.tex 
fi

if [ "$1" = "pdf" ];then
    xelatex csuthesis_main.tex 
    bibtex csuthesis_main
    xelatex csuthesis_main.tex
    xelatex csuthesis_main.tex
fi
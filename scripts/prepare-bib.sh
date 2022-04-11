#!/bin/bash

# 移除没必要的部分
sed -i '/file =/d' ref.bib
sed -i '/doi =/d' ref.bib
sed -i '/annote =/d' ref.bib
sed -i '/month =/d' ref.bib
sed -i '/issn =/d' ref.bib
sed -i '/isbn =/d' ref.bib
sed -i '/address =/d' ref.bib
sed -i '/abstract =/d' ref.bib

# 移除DOI和URL
sed -i '/doi.org/d' ref.bib
sed -i '/acm.org/d' ref.bib
sed -i '/arxiv.org/d' ref.bib
sed -i '/usenix.org/d' ref.bib
sed -i '/ieee.org/d' ref.bib
sed -i '/computer.org/d' ref.bib
sed -i '/.html/d' ref.bib

# 替换缩写
sed -i "s/Association for Computing Machinery/ACM/g" ref.bib
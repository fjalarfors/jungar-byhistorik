texts := $(shell cat index.txt)

all: historik.pdf

%.pdf: %.tex
	@xelatex -halt-on-error $< && \
		xelatex -halt-on-error $<

historik.pdf: historik.tex

historik.tex: pre.tex post.tex $(texts) index.txt
	@cat pre.tex > $@
	@for text in $(basename $(texts)); do \
		echo "\n\\input{$$text}\n" >> $@; \
	done
	@cat post.tex >> $@

test.pdf: test.tex pre.tex post.tex

clean:
	rm -f *.aux *.log *.out *.toc historik.pdf historik.tex

.PHONY: clean

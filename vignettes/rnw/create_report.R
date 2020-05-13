f <- list.files()
try({
  Sweave("bert-embedder-original.Rnw")
  tools::texi2pdf("bert-embedder-original.tex", texi2dvi="pdflatex")
  tools::texi2pdf("bert-embedder-original.tex", texi2dvi="pdflatex")
  tools::compactPDF("bert-embedder-original.pdf", gs_quality="ebook")
  invisible(file.copy(from = "bert-embedder-original.pdf", to = "../pdf/bert-embedder-original.pdf", overwrite = TRUE))
})
invisible(file.remove(setdiff(list.files(), f)))

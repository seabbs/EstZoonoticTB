

default: all


all: build_data package docs man/figures/logo.png README.md git_commit

#Update data
.PHONY: build_data
build_data:
		cd data-raw && make


#build update documents and build package
.PHONY: package
package:
		 R CMD INSTALL --no-multiarch --with-keep.source .

.PHONY: docs		 
docs:
     Rscript -e 'devtools::document(roclets=c('rd', 'collate', 'namespace'))'

#update logo
man/figures/logo.png: inst/scripts/generate_hex_sticker.R
		Rscript inst/scripts/generate_hex_sticker.R
		
#update readme
README.md: README.Rmd
		Rscript -e 'rmarkdown::render("README.Rmd")' && \
		rm README.html
		
#Commit updates
.PHONY: git_commit
git_commit:
		git add --all
		git commit -m "$(message)"
		git push
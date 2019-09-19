default: all
RDIR = .

all: 


all: demographics_cleaned.csv zoonotic_tb_animals_cleaned.csv

## Import and clean demographic data
demographics_cleaned.csv: demographics.R
			Rscript demographics.R
			
## Import and clean zoonotic TB present in animals data
zoonotic_tb_animals_cleaned.csv: zoonotic_tb_animals.R
			Rscript zoonotic_tb_animals.R
			
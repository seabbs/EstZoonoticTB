default: all
RDIR = .

all: 


all: zoonotic_tb_animals_clean.csv demographics_clean.csv animal_demographics_clean.csv


## Import and clean zoonotic TB present in animals data
zoonotic_tb_animals_clean.csv: zoonotic_tb_animals.R
			Rscript zoonotic_tb_animals.R
		
## Import and clean demographic data
demographics_clean.csv: demographics.R
			Rscript demographics.R
			

## Import and clean animal demographic data
animal_demographics_clean.csv: animal_demographics.R
			Rscript animal_demographics.R
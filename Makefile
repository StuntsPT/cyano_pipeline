.PHONY: all clean

FILE_1 := $(basename $(shell ls rawReads | head -1))

TRIM_LEFT := 17
TRIM_RIGHT = -5

MIN_QUALITY := 33
MIN_GC := 0.23
MAX_GC := 0.63

SHELL := /bin/bash
CONDAROOT := /home/dbalata/miniconda3

all: rawReads/$(FILE_1).fastq outputs/fastqcOut/rawReads/$(FILE_1)_fastqc.html outputs/readsTrimmed/$(FILE_1)_trimmed.fastq \
	outputs/readsFiltered/$(FILE_1)_trimmed_filtered.fastq outputs/fastqcOut/finalReads/$(FILE_1)_trimmed_filtered_fastqc.html outputs/spadesOut/$(FILE_1)/scaffolds.fasta \
	outputs/spadesOut/$(FILE_1)/contigs.fasta outputs/quastOut/$(FILE_1)/report.pdf

#rawReads/%_1.fq: bash_scripts/rename.sh rawReads/%_R1_001.fastq rawReads/%_R2_001.fastq
#	./bash_scripts/rename.sh

# uses FastQC
outputs/fastqcOut/rawReads/%_fastqc.html: bash_scripts/auto_fastqc_raw.sh rawReads/%.fastq
	./bash_scripts/auto_fastqc_raw.sh

# uses CutAdapt
outputs/readsTrimmed/%_trimmed.fastq: ./bash_scripts/auto_trim.sh rawReads/%.fastq
	./bash_scripts/auto_trim.sh $(TRIM_LEFT) $(TRIM_RIGHT)

# uses BBDuk
outputs/readsFiltered/%_filtered.fastq: ./bash_scripts/auto_filter.sh outputs/readsTrimmed/%.fastq
	./bash_scripts/auto_filter.sh $(MIN_QUALITY) $(MIN_GC) $(MAX_GC)

# uses FastQC
outputs/fastqcOut/finalReads/%_fastqc.html: ./bash_scripts/auto_fastqc_final.sh outputs/readsFiltered/%.fastq
	./bash_scripts/auto_fastqc_final.sh

# uses Spades
outputs/spadesOut/%/scaffolds.fasta: ./bash_scripts/auto_spades.sh outputs/readsFiltered/%_trimmed_filtered.fastq
	./bash_scripts/auto_spades.sh

# uses Quast
outputs/quastOut/%/report.pdf: ./bash_scripts/auto_quast.sh outputs/spadesOut/%/scaffolds.fasta
	./bash_scripts/auto_quast.sh

# uses BBDuk
#.coverage: ./bash_scripts/auto_cov.sh outputs/spadesOut/*/contigs.fasta
#	./bash_scripts/auto_cov.sh

clean:
	rm -r outputs

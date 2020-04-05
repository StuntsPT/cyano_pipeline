# Pipeline to recover cyanobacteria genomes from metageme sequences
## From raw metagenomic fastq read files to individual assembled bacteria genomes, with read filtering and quality checking

**Requirements:**
- Docker (https://docs.docker.com/install/)

**Usage:**

1. Clone this repository to your machine and move into its directory \
```git clone https://github.com/Duartb/cyano_pipeline``` \
```cd path/to/cyano_pipeline```
2. Move your datasets and reference genomes into /myData (Illumina read datasets must be put into separate directories. Create output directories as you wish inside the /outputs dir) e.g. \
```mkdir -p myData/Dataset1 && mkdir -p myData/refGenomes && mkdir -p outputs/Outputs1``` \
```cp /path/to/reads.fastq myData/Dataset1 && cp /path/to/reference.fasta myData/refGenomes```
3. Build docker image \
```docker build -f Dockerfile . -t cyanopipe:1.0```
4. Run CyanoPipeline GUI (choose an output dir inside the `outputs` volume to have access to results on the host system)\
```docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/outputs:/home/qtuser/outputs -e DISPLAY=$DISPLAY -u qtuser cyanopipe:1.0 python3 /home/qtuser/CyanoPipeline/CyanoPipeline.py```

![Pipeline](/resources/pipeline_flow.png?raw=true "CyanoPipe")

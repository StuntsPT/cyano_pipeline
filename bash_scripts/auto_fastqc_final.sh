mkdir -p ./outputs/fastqcOut/finalReads

source /home/dbalata/miniconda3/bin/activate fastqc_env

for f in ./outputs/readsFiltered/*.fq;
do
 fastqc $f --outdir=./outputs/fastqcOut/finalReads/
done

conda deactivate
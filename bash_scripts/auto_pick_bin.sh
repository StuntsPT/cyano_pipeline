#!/usr/bin/env bash
set -e

mkdir -p $1/finalGenomes

source ~/miniconda3/etc/profile.d/conda.sh
conda activate base_env

echo ""; printf "\nFinding cyanobacterial bins..."

ref_dir=$(dirname $2)

echo -e "$(date) [PICK_BIN.PY] python3 ./python_scripts/pick_bin.py $1/binned/ $2 $ref_dir/stats.txt" >> $1/commands.log

python3 ./python_scripts/pick_bin.py $1/binned/ $2 $ref_dir/stats.txt >> $1/console.log 2>> $1/console.log;

cat $1/binned/best_bins.txt | while read line
do
   cp $1/binned/${line} $1/finalGenomes/
done

conda deactivate

echo ""; printf "\nBest bins selected!\n"

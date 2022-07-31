#!/bin/zsh
echo "Language,# Datasets, # Hours,# Corpora,# Words, Last update"
for f in languages/csv/asr-*.csv;
do
	lang=$(echo $f | grep -o -P '(?<=s-).*(?=.c)');
	clang=$(echo ${(C)lang})
	link=$(echo "\`$clang <./languages/${lang}.html>\`_");
	ndatasets=$(tail -n+2 $f | wc -l);
	nhours=$(cat $f | awk -F "," '{s+=$4} END {print s}');
	lu=$(git log -1 --pretty="format:%ci" languages/english.rst | awk -F " " '{print $1}') #$(date '+%Y-%m-%d');
	ncorpora=0
	nwords=0
	if [ -f "languages/csv/corpora-$lang.csv" ]; then
		ncorpora=$(tail -n+2 "languages/csv/corpora-$lang.csv" | wc -l);
		nwords=$(cat "languages/csv/corpora-$lang.csv" | awk -F "," '{s+=$3} END {print s}')
	fi
	echo $link,$ndatasets,$nhours,$ncorpora,$nwords,$lu;
done;

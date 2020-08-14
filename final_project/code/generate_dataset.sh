
date

source $1

for (( INDEX=1; INDEX<=$NBATCH; INDEX++ ))
do
        FNAME=$DIRDATA/Simulations$INDEX
        echo $FNAME
        mkdir -p $FNAME

	for RHO in $RHORANGE
	do
    		java -jar $DIRMSMS -N $NREF -ms $NCHROMS $NREPL -t $THETA -r $RHO $LEN -Sp 0.5 -SI 0.5 1 0.1 -SAA 0 -SAa 0 -Saa 0 -Smark $DEMO -threads $NTHREADS | gzip > $FNAME/msms..$RHO..txt.gz
	done
done

date




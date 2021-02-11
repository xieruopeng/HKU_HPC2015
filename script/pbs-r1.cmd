###  Job name
#PBS -N r1

###  Declare job non-rerunable
#PBS -r n
#PBS -k oe

###  Queue name (debug, parallel, fourday or gpu) 
#PBS -q gpu

### Wall time required. This example is 336 hours
#PBS -l walltime=336:00:00

###  Number of nodes (CPU)
#PBS -l nodes=1:ppn=20

### two GPU
#PBS -W x=GRES:gpu@2

### running

echo ===========================================================
echo "Job Start  Time is `date "+%Y/%m/%d -- %H:%M:%S"`"

### load module
module load gcc/8.2.0
module load cuda/10.2
module load autoconf/2.69
module load binutils/2.25.1

echo "beast -beagle_info"
beast -beagle_info

JID=`echo ${PBS_JOBID}| sed "s/.hpc2015-mgt.hku.hk//"`

echo "beast -seed 1231 -beagle_gpu -overwrite /home/ruopeng/workspace/Cov-sars2-HK/B.1.1.63/hk_case_B.1.1.63.afa.r1.xml"
beast -seed 1231 -beagle_gpu  -overwrite /home/ruopeng/workspace/Cov-sars2-HK/B.1.1.63/hk_case_B.1.1.63.afa.r1.xml

echo "Job Finish Time is `date "+%Y/%m/%d -- %H:%M:%S"`"
echo "mv $HOME/${PBS_JOBNAME}.e${JID} $HOME/${PBS_JOBNAME}.o${JID} $PBS_O_WORKDIR"
mv $HOME/${PBS_JOBNAME}.e${JID} $HOME/${PBS_JOBNAME}.o${JID} $PBS_O_WORKDIR

exit 0

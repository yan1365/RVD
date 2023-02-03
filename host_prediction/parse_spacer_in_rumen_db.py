import os
os.chdir('/fs/scratch/PAS0439/Ming/results/minced/rumen')

whole_genomes = []
whole_spacers = {}
with open('rumen_spacers.txt','r') as spacer:
    content = spacer.readlines()
    for line in content:
        genome = line[1:].split('_')[0]
        if genome not in whole_genomes:
           whole_genomes.append(genome)
           whole_spacers[genome]=1
        else:
            whole_spacers[genome]+=1
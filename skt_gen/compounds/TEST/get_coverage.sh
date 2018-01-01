# $1: This is the output of the gold_examples.sh
# $2: temporary storage
perl extract_ex.pl < $1 | sort > jnk
perl add_sUwra_examples.pl jnk Compound.txt_implemented A > $2
perl get_sUwras_without_examples.pl < $2 
#| grep '^\*\*' | wc

#!/usr/bin/env bash
#
# verify.sh
#
# lukem1
# 14 February 2020
#

# Bash script to compare saved checksums with current checksums

STORE='sums.db' # File to store checksums in
# Files to watch
FILES=("/etc/sudoers" "/etc/passwd" "/etc/shadow")
if [[ -e $STORE ]]; then
	echo "Verifying Checksums..."
	changes=0
	while read line; do
		read sSum f <<< "$line"
		if [[ -e $f ]]; then
			read nSum nf <<< "$(md5sum $f)"
			if [ "$sSum" != "$nSum" ]; then
				echo "$f Has Been Tampered With!"
				((changes += 1))
			fi
		else
			echo "$f No Longer Exists!"
			((changes += 1))
		fi
	done < $STORE
	echo "$changes file(s) have been modified."
else
	echo "Building sums.db in $(pwd)"
	touch $STORE
	for i in "${FILES[@]}"; do
		if [[ -e $i ]]; then
			echo "$(md5sum $i)" >> $STORE
		else
			echo "$i Does Not Exist!"
		fi		
	done
fi



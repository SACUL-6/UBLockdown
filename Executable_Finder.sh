#!/usr/bin/bash
shopt -s globstar
echo "" > allExecutables
searchDir(){
	for file in /**; do
		if [ -f "$file" ] && [ -x "$file" ]; then
			if [[ "${file,,}" != *"/proc/"* ]]
			then
				echo "$file" >> allExecutables
			fi
		fi
	done
}
searchDir
#diff baseline allExecutables > uniqueExecutables
#Better diff (doesn't include files that are in the baseline but not our actual program)
comm -23 <(sort allExecutables ) <(sort baseline ) > uniqueExecutables

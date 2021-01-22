#!/bin/bash

#Author: Amir Mirzaei

SCRIPT_DIR=`dirname $0`

cat "$SCRIPT_DIR/Samcode.txt"

ABS_PATH=`pwd`
SCRIPT_DIR="$ABS_PATH/$SCRIPT_DIR"

cd $1

declare -i index
declare -i compile_successful

folders=`ls -1 .`

IFS=$'\n'
for folder in $folders
do
	if [ -d "$folder" ]
	then
		result=`grep "judge score:" "./$folder/result.txt" | cut -d ' ' -f 3`

		if [ $result == 100 ]
		then
			code=`ls "$folder" -I result.txt`
			# ext=${code##*.}
			# lang=$ext
			lang=`grep "Language:" "./$folder/result.txt" | cut -d ' ' -f 2`
			team_name=`basename $folder`
			# team_name can also be found inside result.txt

			echo "-----> $team_name"

			if [[ $lang == py ]] || [[ $lang == py3 ]]
			then
				echo "------------------------- Python"
				echo "Testing"
				
				index=1
				for input_file in `ls "$SCRIPT_DIR/in/"`
				do
					echo -e "\n$team_name" >> "$SCRIPT_DIR/out/$input_file-results"
					python3 "$folder/$code" < "$SCRIPT_DIR/in/$input_file" | \
						"$SCRIPT_DIR/p2_result.out" "$SCRIPT_DIR/in/$input_file" \
						>> "$SCRIPT_DIR/out/$input_file-results" && echo -n "*" \
						|| echo -e "\nError at test no. $index: $input_file"

					index=$index+1
				done
				echo
			elif [[ $lang == cpp ]]
			then
				echo "------------------------- C++"
				echo "Compiling"

				g++ "$folder/$code" -o "$folder/compiled.out" && \
					compile_successful=1 ||
					compile_successful=0

				if [[ compile_successful -eq 1 ]]
				then
					echo "Testing"

					index=1
					for input_file in `ls "$SCRIPT_DIR/in/"`
					do
						echo -e "\n$team_name" >> "$SCRIPT_DIR/out/$input_file-results"
						"./$folder/compiled.out" < "$SCRIPT_DIR/in/$input_file" | \
							"$SCRIPT_DIR/p2_result.out" \
							"$SCRIPT_DIR/in/$input_file" \
							>> "$SCRIPT_DIR/out/$input_file-results" && \
							echo -n "*" || \
							echo -e "\nError at test no. $index: $input_file"

						index=$index+1
					done
					echo

					rm "$folder/compiled.out"
				else
					echo "Compile Failed!"
				fi
			elif [[ $lang == cs ]]
			then
				echo "------------------------ C#"
				echo "Compiling"

				csc "$folder/$code" >/dev/null 2>/dev/null && \
					compile_successful=1 || compile_successful=0

				if [[ compile_successful -eq 1 ]]
				then	
					program_name=`cut -d '.' -f 1 <<<$code `
					program_name="$program_name.exe"

					mv "$program_name" "$folder/$program_name"

					echo "Testing"

					index=1
					for input_file in `ls "$SCRIPT_DIR/in/"`
					do
						echo -e "\n$team_name" >> "$SCRIPT_DIR/out/$input_file-results"
						mono "$folder/$program_name" \
							< "$SCRIPT_DIR/in/$input_file" | \
							"$SCRIPT_DIR/p2_result.out" \
							"$SCRIPT_DIR/in/$input_file" \
							>> "$SCRIPT_DIR/out/$input_file-results" && \
							echo -n "*" || \
							echo -e "\nError at test no. $index: $input_file"
						
						index=$index+1
					done
					echo

					rm "$folder/$program_name"
				else
					echo "Compile Failed!"
				fi
			elif [[ $lang == java ]]
			then
				echo "------------------------- Java"
				echo "Compiling"

				javac "$folder/$code" >/dev/null 2>/dev/null && \
					compile_successful=1 || compile_successful=0

				if [[ compile_successful -eq 1 ]]
				then	
					program_name=`cut -d '.' -f 1 <<<$code `

					mv "*.class" "$folder/"

					echo "Testing"

					index=1
					for input_file in `ls "$SCRIPT_DIR/in/"`
					do
						echo -e "\n$team_name" >> "$SCRIPT_DIR/out/$input_file-results"
						java "$folder/$program_name" \
							< "$SCRIPT_DIR/in/$input_file" | \
							"$SCRIPT_DIR/p2_result.out" \
							"$SCRIPT_DIR/in/$input_file" \
							>> "$SCRIPT_DIR/out/$input_file-results" && \
							echo -n "*" || \
							echo -e "\nError at test no. $index: $input_file"
						
						index=$index+1
					done
					echo

					rm "$folder/$program_name"
				else
					echo "Compile Failed!"
				fi
			else
				echo "------------------------- Unknown: $lang"
				echo "Folder: $folder"
				echo "Error"
			fi

			echo ""
		fi
	fi
done

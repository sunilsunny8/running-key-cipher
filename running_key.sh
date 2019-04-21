function runkeye {
	echo "Running key encryption"
	echo -n "Enter text: "; read text
	echo -n "Enter key: "; read key
	text=$(echo $text | tr -d [:space:] | tr [:lower:] [:upper:])
	key=$(echo $key | tr -d [:space:] | tr [:lower:] [:upper:])
	let num=$(echo ${#text})
	abc=ABCDEFGHIJKLMNOPQRSTUVWXYZ
	n=0
	echo -n "Ciphertext: "
	while [[ $n -lt $num ]]
	do
		char=$(echo "${text:$n:1}")
		k=$(echo "${key:$n:1}")
		ran=$(grep -E "^$char" tabula_recta.txt)
		s=${abc%%"$k"*}; sn=$(echo ${#s})
		enc=$(echo "${ran:$sn:1}"); echo -n "$enc"
		let n=$n+1
	done
	echo ""
}

function runkeyd {
        echo "Running key decryption"
        echo -n "Enter ciphertext: "; read cipher
        echo -n "Enter key: "; read key
        cipher=$(echo $cipher | tr -d [:space:] | tr [:lower:] [:upper:])
        key=$(echo $key | tr -d [:space:] | tr [:lower:] [:upper:])
        let num=$(echo ${#cipher})
        abc=ABCDEFGHIJKLMNOPQRSTUVWXYZ
        n=0
        echo -n "Text: "
        while [[ $n -lt $num ]]
        do
                char=$(echo "${cipher:$n:1}")
                k=$(echo "${key:$n:1}")
                ran=$(grep -E "^$char" tabula_recta.txt)
                s=${abc%%"$k"*}; sn=$((0 - $(echo ${#s})))
                dec=$(echo "${ran:$sn:1}"); echo -n "$dec"
                let n=$n+1
        done
        echo ""
}

echo -n "Enter 1 for encryption and 2 for decryption: "; read response
while [[ -z "$response" ]] || [[ "$response" =~ $(echo "$response" | grep -E "\D") ]] || [[ "$response" -lt 1 ]] || [[ "$response" -gt 2 ]]
do
	echo "Invalid or no input"
	echo -n "Enter 1 for encryption and 2 for decryption: "; read response
done
if [[ "$response" = 1 ]]
then
	runkeye
elif [[ "$response" = 2 ]]
then
	runkeyd
fi

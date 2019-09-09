#!/bin/bash
dirs=( az ml sq mt am mk en mi ar mr hy mhr af mn eu de ba ne be no bn pa my pap bg fa bs pl cy pt \
	   hu ro vi ru ht ceb gl sr nl si mrj sk el sl ka sw gu suda tg he th yi tl id ta ga tt it te is \
	   tr es udm kk uz kn uk ca ur ky fi zh fr ko hi xh hr km cs lo sv la gd lv et lt eo lb jv mg ja ms
 )
input="$1"
locale="$2"
getFormattedInput=${input//[ ]/+}
Key=trnsl.1.1.20190909T115250Z.f84f934af29d6b9b.20304b2aa378628b929a65872ab47ab8c85f024c
size=${#dirs[@]}
index=$(($RANDOM % $size))
if [ -z "$locale" ]
  then
    echo "Translation-Language was empty, a random one will be chosen"
    locale=${dirs[$index]}
fi
output=`curl -sS 'https://translate.yandex.net/api/v1.5/tr.json/translate?key='$Key'&text='$getFormattedInput'&lang='$locale`
output=${output##*[}
output=${output%]*}
echo $output | cut -d\" -f2 | xclip -selection c
echo "The random translation of" $input "has been copied to your clipboard"
echo $output" is the translation"
echo "Your input was translated to "$locale

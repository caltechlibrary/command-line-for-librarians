#!/bin/bash

# Using Title or some id to get owi number, then get call number suggestions
cat example.csv | while read LINE; do
    #echo "Line: [$LINE]"
    title=$(echo $LINE | cut -d, -f 2)
    id_type=$(echo $LINE | cut -d, -f 3)
    id_type=${id_type// /}
    id=$(echo $LINE | cut -d, -f 4)
    id=${id// /}

    # Setup supported search expressions
    case "$id_type" in
        issn|ISSN)
            searchExp="issn=$id"
            ;;
        isbn|ISBN)
            searchExp="isbn=$id"
            ;;
        *)
            searchExp=""
            ;;
    esac
    #echo "title: [$title], id type: [$id_type], id: [$id], searchExp: [$searchExp]"
    if [ "$searchExp" != "" ]; then
        if [ -f example-callnumbers.csv ]; then
            /bin/rm example-callnumbers.csv
        fi
        touch example-callnumbers.csv
        curl "http://classify.oclc.org/classify2/Classify?$searchExp&summary=false" |\
            xpath "/classify/works/work/@owi" 2>&1 |\
            sed -E "s/-- NODE --//g;s/\"//g;s/owi=//g;s/Found [0-9]+ nodes\://g" | tr -d " \t" |\
            while read owi; do
                if [ "$owi" != "" ]; then
                    # Use owi to get recommended call number
                    callNumbers=$(curl "http://classify.oclc.org/classify2/Classify?owi=$owi&summary=false" |\
                        xpath "/classify/recommendations/lcc/mostPopular/@sfa" 2>&1 |\
                        sed -E "s/-- NODE --//g;s/\"//g;s/sfa=//g;s/Found [0-9]+ nodes\://g" | tr -d " \t")
                    callNumbers=${callNumbers//\n/ }
                    callNumbers=${callNumbers// /}
                    if [ "$callNumbers" != "Nonodesfound" ] && [ "$callNumbers" != "Noodesfoud" ]; then
                        echo "$title,$id_type,$id,$owi,$callNumbers" >> example-callnumbers.csv
                    else 
                        echo "$title,$id_type,$id,$owi," >> example-callnumbers.csv
                    fi
                fi
            done
    fi
done

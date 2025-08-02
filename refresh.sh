newestDir=$(ls -d */ | sed 's:/$::' | sort -r | head -n 1)
# if todays directory already exists, exit 0
if [ -d "$(date +%F)" ]; then
    exit 0
fi
# fetch page
wget -x -p -k -e robots=off --html-extension --convert-links --restrict-file-names=windows -U Mozilla https://kas.all-inkl.com/schnittstelle/dokumentation/phpdoc/packages/API%20Funktionen.html --directory-prefix=$(date +%F)
# if no directories exist, exit 0
if [ -z "$newestDir" ]; then
    exit 0
fi
# if diff -rq "$(date +%F)" "$newestDir" returns nothing, remove the directory
if [ -z "$(diff -rq "$(date +%F)" "$newestDir")" ]; then
    rm -rf "$(date +%F)"
fi
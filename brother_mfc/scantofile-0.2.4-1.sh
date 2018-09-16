#! /bin/sh
set +o noclobber
#   Scan to multiple page PDF
#
#   $1 = scanner device
#   $2 = friendly name
#

#   
#       100,200,300,400,600
#
resolution=300
device=$1
sleep  1

output_folder=/scanner
output_filename="`date +%Y-%m-%d_%H-%M-%S`"
batch_filename="$output_filename""_p"

scanimage --device-name "$device" --resolution $resolution --format tiff --batch=$output_folder/$batch_filename"%02d.tiff" -l 0 -t 0 -x 210.00 -y 295.00

tiffcp $output_folder/$batch_filename*.tiff $output_folder/$output_filename.tiff

tiff2pdf -p A4 -j -q 80 $output_folder/$output_filename.tiff > $output_folder/$output_filename.pdf

rm $output_folder/$output_filename.tiff
rm $output_folder/$batch_filename*.tiff

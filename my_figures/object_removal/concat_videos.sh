# 
seqnames=("humandog" "humancat")
counter=0
for seqname in ${seqnames[@]}; do
    src_prefix=$seqname
    tgt_prefix=$seqname/nvs-lowerres.mp4
    ffmpeg -y -i $src_prefix/nvs-stereoview-rgbgt-secondcam.mp4 \
            -i $src_prefix/minus_human/nvs-stereoview-rgb.mp4 \
            -i $src_prefix/minus_human/nvs-stereoview-mesh.mp4 \
            -i $src_prefix/minus_pet/nvs-stereoview-rgb.mp4 \
            -i $src_prefix/minus_pet/nvs-stereoview-mesh.mp4 \
            -filter_complex "[0:v][1:v][2:v][3:v][4:v]hstack=inputs=5[v]" \
            -map "[v]" \
            $src_prefix/nvs-fullres.mp4

    ffmpeg -y -i $src_prefix/nvs-fullres.mp4 -vf "scale=0.66*iw:0.66*ih" $tgt_prefix
    counter=$((counter+1))
done
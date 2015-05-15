function usage() {
    echo "These files need to exist: bootimage.cfg, initrd.img, and zImage" &&
    echo "Also, there should be a \"flasher\" folder that where copying \"blob\" there and create a zip out of it produces a recovery-flashable zip file"
}

function main() {
    # 0. copy zImage from appropriate path
    cp /home/tf101/Programming/kernel/TF101-GNU-kernel/arch/arm/boot/zImage .
    # 1. create android boot image
    abootimg --create ./ubuntu.img -f ./bootimg.cfg -k ./zImage -r ./initrd.img &&
    # 2. create nvidia blob
    blobpack ./flasher/blob LNX ubuntu.img &&
    # 3. create zip file for flashing, assuming
    cd flasher &&
    zip -r ../blacksoil-flasher.zip *
    echo "============================="
    echo "Success=$?. (0 means success)"
    echo "============================="
}

main;

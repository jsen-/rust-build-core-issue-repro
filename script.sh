#/bin/bash
set +eux

i=0
while true; do
    let i=$i+1
    echo "-----------" $i days ago "-----------"
    date=$(date --date="$i days ago" +"%Y-%m-%d")
    toolchain="nightly-$date-x86_64-unknown-linux-gnu"
    ret=0
    rustup toolchain install "$toolchain" --no-self-update --force --component rust-src --profile minimal || ret=$?
    if [ "$ret" -ne "0" ]; then
        continue
    fi
    ret=0
    cargo "+$toolchain" build || ret=$?
    if [ "$ret" -ne "0" ]; then
        exit
    fi
    cargo "+$toolchain" build --release || ret=$?
    if [ "$ret" -eq "0" ]; then
        echo success
        exit
    fi
    rustup toolchain remove "$toolchain"
done
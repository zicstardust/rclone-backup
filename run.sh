#!/bin/bash
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
config_file=${script_dir}/rclone-backup.config
source $config_file

start(){
    echo "=============Start rclone backup===================="

    if [ -z "${EXTRAS_ARGS[$i]}" ];then
        FLAGS=""    
    else
        FLAGS="${EXTRAS_ARGS[$i]}"    
        #FLAGS="-f ${EXTRAS_ARGS[$i]}" 
    fi  
   
    echo "---BACKUP FROM ${SOURCE_REMOTE[$i]}:${SOURCE_DIR[$i]} TO ${DESTINY_REMOTE[$i]}:${DESTINY_DIR[$i]}---"
    rclone sync "${SOURCE_REMOTE[$i]}:${SOURCE_DIR[$i]}" "${DESTINY_REMOTE[$i]}:${DESTINY_DIR[$i]}" ${FLAGS} -v          
    echo "=============End rclone backup===================="
}

gen-config-file(){
    if [ -e ${config_file} ];then
        cat ${config_file} 1> ${config_file}_old
    fi
    cat > ${config_file} <<EOF
SOURCE_REMOTE[0]=
SOURCE_DIR[0]=
DESTINY_REMOTE[0]=
DESTINY_DIR[0]=
EXTRAS_ARGS[0]=

EOF
}

check_and_run (){
    size=${#SOURCE_DIR[@]}
    for (( i=0; i<${size}; i++)); do
        start
    done
}

if [ "$1" == "gen-config-file" ]; then
    gen-config-file
else
    check_and_run
fi
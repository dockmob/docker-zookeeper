#!/bin/bash

if [ ! -f /var/zookeeper/config_ok ];
then
    set -e

    usage() { echo "Usage: docker run [<docker options>] dockmob/zookeeper [-s zkhost1,zkhost2,...]" 1>&2; exit 1; }

    while getopts ":s:" o; do
        case "${o}" in
            s)
                s=${OPTARG}
                ;;
            *)
                usage
                ;;
        esac
    done
    shift $((OPTIND-1))

    if [ -z "${s}" ]; then
        echo "Starting ZooKeeper in STANDALONE mode"
    else
        echo "Starting ZooKeeper in CLUSTER mode"

        HOSTNAME=$(cat /etc/hostname)

        echo "Hostname=$HOSTNAME"

        IFS=', ' read -a servers <<< "$s"
        for i in "${!servers[@]}"
        do
            if [ "${servers[i]}" = "$HOSTNAME" ];
            then
                ZK_MY_ID=$((i+1))
            fi
            echo "server.$((i+1))=${servers[i]}:2888:3888" >> /usr/lib/zookeeper/conf/zoo.cfg
        done

        if [ -z "$ZK_MY_ID" ];
        then
            echo "ERROR: You must set a valid host name for each container in order to use ZooKeeper in CLUSTER mode."
            echo "Example: docker run -h zkhost1 dockmob/zookeeper -s zkhost1,zkhost2,zkhost3"
            echo ""
            exit 1
        fi

        echo $ZK_MY_ID > /var/zookeeper/myid


    fi

    echo "DONE" > /var/zookeeper/config_ok

else
    echo "Restarting Zookeeper"
fi

./zkServer.sh start-foreground


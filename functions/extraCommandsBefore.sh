#!/bin/sh

echo file extraCommandBefore.sh is included
extraCommandBefore() {
        mkdir -p /zs2T1/data/server_configs/copies
        cp -L  /zs2T1/data/server_configs/*@* /zs2T1/data/server_configs/copies
}

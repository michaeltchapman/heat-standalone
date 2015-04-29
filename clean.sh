for i in `docker ps -a | grep -v CONTAINER | cut -d ' ' -f 1`; do docker stop $i; docker rm $i; done;

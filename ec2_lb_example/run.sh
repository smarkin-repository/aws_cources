docker run --rm -p 5000:5000 -v $PWD:/data:ro --security-opt apparmor:unconfined --cap-add=SYS_ADMIN 28mm/blast-radius $1

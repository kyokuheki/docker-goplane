# docker-goplane

## example

```shell
ip netns add netns5
ip link add veth0 type veth peer name veth1
ip link set veth0 netns netns5
ip netns exec netns5 ifconfig lo up

git clone https://github.com/kyokuheki/docker-goplane
cd docker-goplane
docker build . -t kyokuheki/goplane
docker run -it --rm --name goplane --net=host --privileged -v$PWD:/src kyokuheki/goplane -f /src/goplane.conf -l DEBUG -p
```

## <https://hostman.com/tutorials/how-to-use-nessus-for-vulnerability-scanning-on-ubuntu-22-04/>

```code

docker pull tenable/nessus:latest-ubuntu

docker run --name "nessus_hostman" -d -p 8834:8834 tenable/nessus:latest-ubuntu

```

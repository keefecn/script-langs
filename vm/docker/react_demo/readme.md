
# version  size
v1 1.2GB

$ docker images |grep react_demo
react_demo                                      4                             ffd243450339   4 minutes ago       24.1MB
react_demo                                      3                             978343232932   6 minutes ago       134MB
react_demo                                      2                             d72ad5fa7eb4   18 minutes ago      406MB

# run 
docker run -p 8010:80 react_demo:4
http://localhost:8010



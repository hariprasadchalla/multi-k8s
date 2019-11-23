docker build -t stephengrider/multi-client:latest -t harichalla/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server:latest -t harichalla/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker:latest -t harichalla/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push harichalla/multi-client:latest
docker push harichalla/multi-server:latest
docker push harichalla/multi-worker:latest

docker push harichalla/multi-client:$SHA
docker push harichalla/multi-server:$SHA
docker push harichalla/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA

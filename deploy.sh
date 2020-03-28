docker build -t christherama/multi-client:latest -t christherama/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t christherama/multi-server:latest -t christherama/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t christherama/multi-worker:latest -t christherama/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push christherama/multi-client:latest
docker push christherama/multi-client:$SHA

docker push christherama/multi-server:latest
docker push christherama/multi-server:$SHA

docker push christherama/multi-worker:latest
docker push christherama/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=christherama/multi-client:$SHA
kubectl set image deployments/server-deployment server=christherama/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=christherama/multi-worker:$SHA
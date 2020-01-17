docker build -t rhecl/multi-client:latest -t rhecl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rhecl/multi-server:latest -t rhecl/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rhecl/multi-worker:latest -t rhecl/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rhecl/multi-client:latest
docker push rhecl/multi-client:$SHA
docker push rhecl/multi-server:latest
docker push rhecl/multi-server:$SHA
docker push rhecl/multi-worker:latest
docker push rhecl/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rhecl/multi-server:$SHA
kubectl set image deployments/client-deployment client=rhecl/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rhecl/multi-worker:$SHA
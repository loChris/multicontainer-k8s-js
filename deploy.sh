docker build -t lochris/multi-client:latest -t lochris/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lochris/multi-server:latest -t lochris/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lochris/multi-worker:latest -t lochris/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lochris/multi-client:latest
docker push lochris/multi-client:$SHA
docker push lochris/multi-server:latest
docker push lochris/multi-server:$SHA
docker push lochris/multi-worker:latest
docker push lochris/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lochris/multi-client:$SHA
kubectl set image deployments/server-deployment server=lochris/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lochris/multi-worker:$SHA
global:
  domain: ${clusterName}-argo.poc.com

configs:
  params:
    server.insecure: true

server:
  ingress:
    enabled: true
    controller: aws
    ingressClassName: alb
    annotations:
      alb.ingress.kubernetes.io/scheme: internet-facing
      alb.ingress.kubernetes.io/target-type: ip
      alb.ingress.kubernetes.io/backend-protocol: HTTP
      alb.ingress.kubernetes.io/listen-ports: '[{"HTTP":80}]'
    aws:
      serviceType: ClusterIP # <- Used with target-type: ip
      backendProtocolVersion: HTTP1
((import 'kube-prometheus/main.libsonnet') + {
   values+:: {
     alertmanager+: {
       config: |||
         global:
            resolve_timeout: 5m

          route:
            group_by: ['alertname']
            group_wait: 10s
            group_interval: 10s
            repeat_interval: 1h
            receiver: 'obmondo'
            routes:
            - receiver: 'obmondo'
              match:
                alertname: Watchdog
            - receiver: 'obmondo'
              continue: true
          receivers:
          - name: 'null'
          - name: 'obmondo'
            webhook_configs:
            - url: 'https://alerts.obmondo.com/hooks/alertmanager'
              send_resolved: true
              max_alerts: 0
              http_config:
                tls_config:
                  server_name: alerts.obmondo.com
                  cert_file: '/etc/alertmanager/secrets/obmondo-clientcert/tls.crt'
                  key_file: '/etc/alertmanager/secrets/obmondo-clientcert/tls.key'
                  insecure_skip_verify: false
          templates:
          - /etc/alertmanager/config/*.tmpl
       |||,
     },
   },
 }).alertmanager.secret

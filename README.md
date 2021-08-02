# pay-tcp-proxy

An Nginx proxy using the Nginx stream module to forward TCP traffic from
a static address (NLB) to a service endpoint.

For more information see: http://nginx.org/en/docs/stream/ngx_stream_core_module.html

## Licence

[MIT License](LICENSE)

## Responsible Disclosure

GOV.UK Pay aims to stay secure for everyone. If you are a security researcher and have discovered a security vulnerability in this code, we appreciate your help in disclosing it to us in a responsible manner. We will give appropriate credit to those reporting confirmed issues. Please e-mail gds-team-pay-security@digital.cabinet-office.gov.uk with details of any issue you find, we aim to reply quickly.

## Local Testing

If you wish you test the tcp proxy locally you can use the included docker-compose file. 

This will run 3 components.
1. nginx-frontend: Mimics the NLB sitting in front of the pay-tcp-proxy. The connection from this to the pay-tcp-proxy
   has proxy-protocol enabled
2. pay-tcp-proxy: The pay-tcp-proxy container as built from the current directory. This has proxy-protocol enabled for
   inbound connections only providing us with remote client information.
3. nginx-backend: Provides a simple https web server which the pay-tcp-proxy forwards onto. This auto generates a
   self-signed SSL certificate if it has not already. This component mimics the public GOV.UK Pay API

```
  |--------|          |----------------|                         |---------------|          |---------------|
  | client |--https-->| nginx-frontend |--TCP + Proxy Protocol-->| pay-tcp-proxy |--https-->| nginx-backend |
  |--------|          |----------------|                         |---------------|          |---------------|

                        1. Mimics NLB                             2. pay-tcp-proxy          3. mimics pay api
```

You can start this up as follows:

    docker-compose up

Then visit the exposed localhost server https://localhost/index.html

You can shut down by sending CTRL-C to the running containers.

If you modify the tcp proxy you will need to tell docker compose to rebuild the container:

    docker-compose build
    docker-compose up


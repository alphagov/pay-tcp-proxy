# pay-tcp-proxy

An Nginx proxy using the Nginx stream module to forward TCP traffic from
a static address (NLB) to a service endpoint.

For more information see: http://nginx.org/en/docs/stream/ngx_stream_core_module.html

## Licence

[MIT License](LICENSE)

## Responsible Disclosure

GOV.UK Pay aims to stay secure for everyone. If you are a security researcher and have discovered a security vulnerability in this code, we appreciate your help in disclosing it to us in a responsible manner. We will give appropriate credit to those reporting confirmed issues. Please e-mail gds-team-pay-security@digital.cabinet-office.gov.uk with details of any issue you find, we aim to reply quickly.

## Local Testing

If you wish you test the tcp proxy locally you can use the included docker-compose file. This will run a simple nginx
backend with a self signed certificate which is proxied to by the pay-tcp-proxy. You can start this up as follows:

    docker-compose up

Then visit the exposed localhost server https://localhost/index.html

You can shut down by sending CTRL-C to the running containers.

If you modify the tcp proxy you will need to tell docker compose to rebuild the container:

    docker-compose build
    docker-compose up


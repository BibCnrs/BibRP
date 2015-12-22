# BibRP

The bibcnrs reverse proxy in charge of authenticating users through RENATER federation of identities — Edit


Application in charge of the bibcnrs reverse proxy. The embedded shibboleth federated  authentication feature will allow users in the ESR to authenticate with their individual institutionnal account (example: [Janus](https://janus.cnrs.fr) for the CNRS).

## Configuration

1) Put the private key and the certificate used to declare the service provider in the [fédération Education-Recherche](https://federation.renater.fr/registry?action=get_all) in ``ssl/server.key`` and ``ssl/server.crt`` files.
Notice: the servier.key is critical and should not be shared.

2) If necessary, edit parameters in ``*.env.sh`` files.
Parameters example:
```bash
export APPLI_APACHE_SERVERNAME="https://bib.cnrs.fr"
export APPLI_APACHE_SERVERADMIN="bibcnrs@inist.fr"
export APPLI_APACHE_LOGLEVEL="info ssl:warn"
```

## Start the application

To start https://bib.cnrs.fr
```bash
make run-prod
```

To start https://bib-preprod.cnrs.fr
```bash
make run-dev
```

## MEMO

xmlstarlet sel -N sp="urn:mace:shibboleth:2.0:native:sp:config" -t -v "/sp:SPConfig/sp:ApplicationDefaults/@entityID" shibboleth2-tmp.xml

xmlstarlet ed -N sp="urn:mace:shibboleth:2.0:native:sp:config" -u "/sp:SPConfig/sp:ApplicationDefaults/@entityID" -v aze shibboleth2-tmp.xml
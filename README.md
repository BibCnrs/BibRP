# BibRP

Application chargée de lancer le reverse proxy applicatif de bibcnrs. Ce reverse proxy a
comme rôle d'embarquer la brique d'authentifications fédérées Shibboleth et d'authentifier
à l'individu les utilisateurs de l'ESR.

## Configurer l'application

1) Placer la clé privée et le certificat utilisé pour déclarer votre service provider dans la [fédération Education-Recherche](https://federation.renater.fr/registry?action=get_all) dans ``ssl/server.key`` et ``ssl/server.crt``

A noter : il est possible d'éditer les variables d'environnement dans les fichiers ``*.env.sh``

## Démarrer l'application

Pour démarrer l'application sur https://bib.cnrs.fr :
```bash
make run-prod
```

Pour démarrer l'application sur https://bib-preprod.cnrs.fr :
```bash
make run-dev
```

## MEMO

xmlstarlet sel -N sp="urn:mace:shibboleth:2.0:native:sp:config" -t -v "/sp:SPConfig/sp:ApplicationDefaults/@entityID" shibboleth2-tmp.xml

xmlstarlet ed -N sp="urn:mace:shibboleth:2.0:native:sp:config" -u "/sp:SPConfig/sp:ApplicationDefaults/@entityID" -v aze shibboleth2-tmp.xml
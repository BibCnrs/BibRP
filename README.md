# BibRP

Application chargée de lancer le reverse proxy applicatif de bibcnrs. Ce reverse proxy a
comme rôle d'embarquer la brique d'authentifications fédérées Shibboleth et d'authentifier
à l'individu les utilisateurs de l'ESR.

Pour démarrer l'application :
```bash
make run-prod
```

Pour configurer l'application :
- éditer les variables d'environnement dans ``prod.env.sh``
- ... pour intégrer la clée privée SSL nécessaire au démon shibboleth (information sensible non présente dans le GIT)


## MEMO

xmlstarlet sel -N sp="urn:mace:shibboleth:2.0:native:sp:config" -t -v "/sp:SPConfig/sp:ApplicationDefaults/@entityID" shibboleth2-tmp.xml

xmlstarlet ed -N sp="urn:mace:shibboleth:2.0:native:sp:config" -u "/sp:SPConfig/sp:ApplicationDefaults/@entityID" -v aze shibboleth2-tmp.xml
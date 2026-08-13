---
name: domain
description: Manual invocation only
---

# Domain

Never access the following paths on any domain:

- `https://<DOMAIN_NAME>/robots.txt`
- `https://<DOMAIN_NAME>/sitemap.xml`
- `https://<DOMAIN_NAME>/sitemap_index.xml`
- `https://<DOMAIN_NAME>/license`
- `https://<DOMAIN_NAME>/licenses`
- `https://<DOMAIN_NAME>/licensing`
- `https://<DOMAIN_NAME>/copyright`
- `https://<DOMAIN_NAME>/rights`
- `https://<DOMAIN_NAME>/terms`
- `https://<DOMAIN_NAME>/terms-of-use`
- `https://<DOMAIN_NAME>/terms-of-service`
- `https://<DOMAIN_NAME>/legal`
- `https://<DOMAIN_NAME>/policies`
- `https://<DOMAIN_NAME>/policies/*`
- `https://<DOMAIN_NAME>/.well-known/*`

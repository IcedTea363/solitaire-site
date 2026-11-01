# Solitaire — website

Static pages for the Solitaire iOS app, served from the owner's own server (an LXC) at
<https://solitaire.nailhome.net/>. GitHub Pages is retired.

| Page | URL |
| --- | --- |
| Home | <https://solitaire.nailhome.net/> |
| Privacy Policy | <https://solitaire.nailhome.net/privacy/> |
| Support | <https://solitaire.nailhome.net/support/> |
| Terms of Use | <https://solitaire.nailhome.net/terms/> |

Plain HTML and one stylesheet: no build step, and no external requests (no web fonts, CDNs, analytics or remote
images; system font stack only). Links between pages are relative. Keep the pages in step with the app's real
behavior and its "Data Not Collected" privacy label, and update a page's "Last updated" date when it changes.

Deployment details will be added separately.

## Deploy

`tools/deploy.sh` copies the committed pages to nginx in CT 104 (`solitaire-web`, 10.0.0.131:80) on the
Proxmox host root@10.0.0.10. Nginx Proxy Manager (CT 102) terminates TLS for solitaire.nailhome.net.

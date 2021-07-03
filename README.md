# Rubicon's Emacs Configuration

You need clone all the submodules to make it works.

````
git clone --recurse-submodules https://github.com/thislight/.emacs.d.git ~/.emacs.d
````

If you don't need whole history (you don't want to change anything), set depth to 1.
````
git clone --recurse-submodules --depth=1 https://github.com/thislight/.emacs.d.git ~/.emacs.d
````

## What's included

- Default font size: 110
- usepackage
- Theme: spacesmacs-space
- ivy, counsel, company, which-key
- dashbroad
- magit
- Projectile (switch project: C-M-SPC)
- Languages:
    - Lisp: SLY, with sly-quicklisp and sly-asdf
    - Python: elpy and poetry

## Licenses?
![WTFPL Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/WTFPL_logo.svg/1200px-WTFPL_logo.svg.png)
[WTFPL](http://www.wtfpl.net/about/)
